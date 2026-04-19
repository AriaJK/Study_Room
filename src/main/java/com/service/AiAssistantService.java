package com.service;

import com.client.LlmClient;
import com.entity.AiChatSessionEntity;
import com.entity.YuyuexinxiEntity;
import com.entity.ZixishiEntity;
import com.utils.CurrentUserProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.servlet.http.HttpServletRequest;
import java.time.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class AiAssistantService {

    private static final Logger log = LoggerFactory.getLogger(AiAssistantService.class);

    @Autowired
    private LlmClient llmClient;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private YuyuexinxiService yuyuexinxiService;

    @Autowired
    private ZixishiService zixishiService;

    // ====== 新增：历史持久化 ======
    @Autowired
    private AiChatHistoryService aiChatHistoryService;

    @Autowired
    private CurrentUserProvider currentUserProvider;

    private static final Map<String, Deque<ChatTurn>> SESSION_HISTORY = new ConcurrentHashMap<>();

    private static final int MAX_TURNS = 20;

    private static final LocalTime OPEN_TIME = LocalTime.of(8, 0);
    private static final LocalTime CLOSE_TIME = LocalTime.of(22, 0);

    // ========== chat ==========
    public Map<String, Object> chat(Map<String, Object> req, HttpServletRequest request) {
        String message = req == null ? null : toStr(req.get("message"));
        if (message == null || message.trim().isEmpty()) {
            return respError("message 不能为空");
        }

        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) {
            return respError("未登录或无法识别学号（token无效/未传token）");
        }

        Long sessionId = toLong(req == null ? null : req.get("sessionId"));
        if (sessionId == null) {
            // 没传 sessionId：为该用户创建一个默认会话（也可以选择直接报错强制前端传）
            AiChatSessionEntity s = aiChatHistoryService.createSession(xuehao, "New Chat");
            sessionId = s.getId();
        }

        String sessionKey = "sid:" + sessionId;

        // 写入内存上下文
        appendTurn(sessionKey, "user", message);

        // 写入DB历史
        aiChatHistoryService.appendMessage(xuehao, sessionId, "user", message);
        aiChatHistoryService.touchSession(xuehao, sessionId);

        // 意图路由（保持你的逻辑）
        if (isSeatRecommendIntent(message) && !isFollowUpPickIntent(message)) {
            Map<String, Object> recReq = new HashMap<>();
            recReq.put("sessionId", sessionId);
            recReq.put("message", message);
            // 复用 recommend：并把 request 透传
            return recommend(recReq, request);
        }

        String systemPrompt = ""
                + "你是智慧自习室的学习助手。\n"
                + "你要用中文回答。\n"
                + "你可以进行多轮对话，必须结合上下文回答用户。\n"
                + "如果用户只回复“1/2/3/继续/展开/好”等短句，你要结合上一条你的回答推断用户指的内容并继续。\n"
                + "如果用户让你制定学习计划，请给出可执行的步骤（按时间分段）。\n"
                + "如果用户让你“从你刚才推荐的座位里选一个最佳”，你必须基于你刚才的候选与理由做选择，不要让用户重复提供自习室信息。\n"
                + "不要编造用户数据，不要声称你已保存到数据库。\n";

        String userPrompt = buildPromptWithHistory(sessionKey, message);

        try {
            // 方案B：按场景控制 tokens（保持你原值）
            String reply = callWithRetry(systemPrompt, userPrompt, 600, 0.7);

            appendTurn(sessionKey, "assistant", reply);

            // 写入DB历史
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", reply);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("reply", reply);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        } catch (Exception e) {
            log.warn("AI chat failed. xuehao={}, sessionId={}, err={}", xuehao, sessionId, e.toString(), e);

            String fallbackReply = "我刚刚连接 AI 服务失败了（可能是网络/限流/超时）。你可以稍后重试；或者把你的目标（科目/时长/截止时间）再发一遍，我也能用“离线模板”帮你拆解计划。";
            appendTurn(sessionKey, "assistant", fallbackReply);

            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", fallbackReply);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("reply", fallbackReply);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ========== summary ==========
    public Map<String, Object> summary(Map<String, Object> req, HttpServletRequest request) {
        Double durationMinutes = toDouble(req == null ? null : req.get("durationMinutes"));
        String yuyuedanhao = req == null ? null : toStr(req.get("yuyuedanhao"));
        String todayGoal = req == null ? null : toStr(req.get("todayGoal"));

        if (durationMinutes == null) {
            return respError("durationMinutes 不能为空（当前方案仍由前端传入本次学习分钟数）");
        }

        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) {
            return respError("未登录或无法识别学号（token无效/未传token）");
        }

        Long sessionId = toLong(req == null ? null : req.get("sessionId"));
        if (sessionId == null) {
            AiChatSessionEntity s = aiChatHistoryService.createSession(xuehao, "New Chat");
            sessionId = s.getId();
        }
        String sessionKey = "sid:" + sessionId;

        String systemPrompt = ""
                + "你是智慧自习室的学习总结助手。\n"
                + "你只根据用户提供的数据与对话内容生成总结，不要编造。\n"
                + "输出要求：用中文，分3段：1) 今日表现 2) 值得肯定 3) 明日建议。\n"
                + "尽量具体可执行，避免空泛。\n";

        StringBuilder userPrompt = new StringBuilder();
        userPrompt.append("请根据以下数据生成学习总结：\n");
        if (yuyuedanhao != null && !yuyuedanhao.isEmpty()) {
            userPrompt.append("- 预约单号：").append(yuyuedanhao).append("\n");
        }
        userPrompt.append("- 本次学习时长（分钟）：").append(durationMinutes).append("\n");
        if (todayGoal != null && !todayGoal.trim().isEmpty()) {
            userPrompt.append("- 今日目标：").append(todayGoal).append("\n");
        }

        String chatDigest = buildRecentChatDigest(sessionKey, 12, 1200);
        if (chatDigest != null && !chatDigest.trim().isEmpty()) {
            userPrompt.append("\n- 与AI对话要点（原始记录片段）：\n");
            userPrompt.append(chatDigest).append("\n");
        }

        String userMsg = "请帮我生成学习总结。本次学习时长：" + durationMinutes + " 分钟。";
        appendTurn(sessionKey, "user", userMsg);
        aiChatHistoryService.appendMessage(xuehao, sessionId, "user", userMsg);
        aiChatHistoryService.touchSession(xuehao, sessionId);

        try {
            String summaryText = callWithRetry(systemPrompt, userPrompt.toString(), 520, 0.6);

            appendTurn(sessionKey, "assistant", summaryText);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", summaryText);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("durationMinutes", durationMinutes);
            data.put("summaryText", summaryText);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        } catch (Exception e) {
            log.warn("AI summary failed. xuehao={}, sessionId={}, err={}", xuehao, sessionId, e.toString(), e);

            String fallbackSummary =
                    "今日表现：你本次完成了 " + durationMinutes + " 分钟的学习。\n"
                            + "值得肯定：能坚持完成计划很不错。\n"
                            + "明日建议：把任务拆成 25-30 分钟一组（番茄钟），每组休息 5 分钟，并在开始前写下本次要完成的 1-3 个小目标。";

            appendTurn(sessionKey, "assistant", fallbackSummary);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", fallbackSummary);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("durationMinutes", durationMinutes);
            data.put("summaryText", fallbackSummary);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ========== recommend ==========
    public Map<String, Object> recommend(Map<String, Object> req, HttpServletRequest request) {
        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) {
            return respError("未登录或无法识别学号（token无效/未传token）");
        }

        Long sessionId = toLong(req == null ? null : req.get("sessionId"));
        if (sessionId == null) {
            AiChatSessionEntity s = aiChatHistoryService.createSession(xuehao, "New Chat");
            sessionId = s.getId();
        }
        String sessionKey = "sid:" + sessionId;

        String message = req == null ? null : toStr(req.get("message"));

        // 如果是从 chat 路由过来的 message，先落库（保持你原行为：chat 已经写过 user 消息，这里避免重复写）
        // 这里做一个简单保护：只有当 req 显式标记 fromChat=false 才写；目前默认不写
        // 你后续如果希望 recommend 直接按钮调用也记录用户话术，可在前端传 fromChat=true/false
        // 为了不改变现有行为，这里不额外 append user turn。

        Double minHours = toDouble(req == null ? null : req.get("minHours"));
        if (minHours == null) minHours = parseMinHoursFromMessage(message);
        if (minHours == null) minHours = 0.0;
        long minMinutes = Math.round(minHours * 60.0);

        Integer zixishiid = toInt(req == null ? null : req.get("zixishiid"));
        ZixishiEntity zixishi = null;

        if (zixishiid != null) {
            zixishi = zixishiService.selectById(Long.valueOf(zixishiid));
        } else {
            zixishi = resolveZixishiByMessage(message);
            if (zixishi != null && zixishi.getId() != null) {
                zixishiid = zixishi.getId().intValue();
            }
        }

        if (zixishiid == null) {
            String tips = "我没识别出你要推荐的自习室。\n"
                    + "你可以这样说：\n"
                    + "“帮我推荐 图书馆 一个能连续学习3小时的座位”\n"
                    + "或从下面清单选择一个自习室名称/id：\n\n"
                    + buildZixishiOptionsText();

            appendTurn(sessionKey, "assistant", tips);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", tips);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", tips);
            data.put("needZixishi", true);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            return respOk(data);
        }

        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        ZonedDateTime nowZdt = ZonedDateTime.now(zoneId);
        LocalDate today = nowZdt.toLocalDate();

        ZonedDateTime openZdt = ZonedDateTime.of(today, OPEN_TIME, zoneId);
        ZonedDateTime closeZdt = ZonedDateTime.of(today, CLOSE_TIME, zoneId);

        ZonedDateTime windowStart = nowZdt.isAfter(openZdt) ? nowZdt : openZdt;
        ZonedDateTime windowEnd = closeZdt;

        if (!windowStart.isBefore(windowEnd)) {
            String msg = "当前已超过闭馆时间（22:00），无法推荐今日可约座位。建议明天再试。";
            appendTurn(sessionKey, "assistant", msg);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", msg);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", msg);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        }

        try {
            List<SeatRecommendItem> top = computeTopSeatsByLongestContinuousFree(
                    zixishiid,
                    Date.from(windowStart.toInstant()),
                    Date.from(windowEnd.toInstant()),
                    10
            );

            if (minMinutes > 0) {
                top.removeIf(item -> item.freeMinutes < minMinutes);
            }

            if (top.isEmpty()) {
                String zName = zixishiNameOrDefault(zixishi, zixishiid);
                String noSeat = "在【" + zName + "】里，"
                        + (minMinutes > 0 ? ("今天剩余时间没有满足“连续可约≥" + minHours + "小时”的座位。\n") : "今天剩余时间没有可推荐的连续可约座位。\n")
                        + "你可以：\n"
                        + "1) 放宽时长要求（例如 2 小时 / 1 小时）\n"
                        + "2) 换一个自习室再试\n"
                        + "3) 选择更晚的开始时间（避开高峰）\n\n"
                        + "自习室清单：\n" + buildZixishiOptionsText();

                appendTurn(sessionKey, "assistant", noSeat);
                aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", noSeat);
                aiChatHistoryService.touchSession(xuehao, sessionId);

                Map<String, Object> data = new HashMap<>();
                data.put("recommendation", noSeat);
                data.put("sessionId", sessionId);
                data.put("sessionKey", sessionKey);
                data.put("zixishiid", zixishiid);
                data.put("fallback", false);
                return respOk(data);
            }

            if (top.size() > 5) top = new ArrayList<>(top.subList(0, 5));

            String zName = zixishiNameOrDefault(zixishi, zixishiid);

            StringBuilder facts = new StringBuilder();
            facts.append("自习室：").append(zName).append("（id=").append(zixishiid).append("）\n");
            Integer totalSeats = (zixishi != null ? zixishi.getZuowei() : null);
            facts.append("座位编号规则：座位号是纯数字（例如 12），范围 1..")
                    .append(totalSeats != null ? totalSeats : "N").append("\n");
            facts.append("时间窗口：").append(fmt(windowStart)).append(" ~ ").append(fmt(windowEnd)).append("\n");
            if (minMinutes > 0) {
                facts.append("用户约束：希望连续可约 ≥ ").append(minHours).append(" 小时\n");
            }
            facts.append("\n候选座位（按连续可约时长从长到短，单位=分钟）：\n");
            for (SeatRecommendItem item : top) {
                facts.append("- 座位 ").append(item.seatId)
                        .append("：连续可约 ").append(item.freeMinutes).append(" 分钟")
                        .append("（可约到 ").append(fmt(item.freeUntilZdt)).append("）\n");
            }

            String systemPrompt = ""
                    + "你是智慧自习室的选座推荐助手。\n"
                    + "你必须只根据我提供的【事实数据】回答，禁止编造。\n"
                    + "重要规则：\n"
                    + "1) 你输出的座位号必须是【纯数字】（例如 12），且必须来自我给你的候选座位列表。\n"
                    + "2) 禁止输出任何系统不存在的座位编码（例如 B3-308、3F窗边座 等）。\n"
                    + "3) 禁止编造“有双电源/人体工学椅/噪音xx dB”等硬件信息（除非事实数据里提供）。\n"
                    + "输出格式：\n"
                    + "1) 推荐座位（前3个，按优先级，写出座位号）\n"
                    + "2) 推荐理由（说明连续可约时长、为什么适合长时间学习）\n"
                    + "3) 备选建议（2条，告诉用户如何提高抢到的概率）\n";

            String userPrompt = "请根据以下事实数据给出推荐：\n\n" + facts;

            String text = callWithRetry(systemPrompt, userPrompt, 380, 0.6);

            appendTurn(sessionKey, "assistant", text);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", text);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", text);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("zixishiid", zixishiid);
            data.put("zixishiName", zName);
            data.put("minHours", minHours);
            data.put("topSeats", top);
            data.put("fallback", false);
            return respOk(data);

        } catch (Exception e) {
            log.warn("AI recommend failed. xuehao={}, sessionId={}, err={}", xuehao, sessionId, e.toString(), e);

            String fallback = "推荐失败（可能是数据库/AI服务异常）。你可以稍后再试。\n错误：" + safeMsg(e);
            appendTurn(sessionKey, "assistant", fallback);
            aiChatHistoryService.appendMessage(xuehao, sessionId, "assistant", fallback);
            aiChatHistoryService.touchSession(xuehao, sessionId);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", fallback);
            data.put("sessionId", sessionId);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ---------- 会话上下文 helpers ----------
    private static class ChatTurn {
        String role;
        String content;

        ChatTurn(String role, String content) {
            this.role = role;
            this.content = content;
        }
    }

    private void appendTurn(String sessionKey, String role, String content) {
        if (sessionKey == null) return;
        if (content == null) content = "";

        Deque<ChatTurn> deque = SESSION_HISTORY.computeIfAbsent(sessionKey, k -> new ArrayDeque<>());
        synchronized (deque) {
            deque.addLast(new ChatTurn(role, content));
            while (deque.size() > MAX_TURNS * 2) {
                deque.removeFirst();
            }
        }
    }

    private String buildPromptWithHistory(String sessionKey, String currentUserMessage) {
        Deque<ChatTurn> deque = SESSION_HISTORY.get(sessionKey);
        StringBuilder sb = new StringBuilder();
        sb.append("下面是历史对话（可能为空），请结合历史回答最后一条用户消息。\n\n");

        if (deque != null) {
            synchronized (deque) {
                for (ChatTurn t : deque) {
                    sb.append("user".equals(t.role) ? "用户：" : "助手：")
                            .append(t.content)
                            .append("\n");
                }
            }
        }

        sb.append("\n用户：").append(currentUserMessage).append("\n");
        sb.append("助手：");
        return sb.toString();
    }

    private String buildRecentChatDigest(String sessionKey, int maxTurns, int maxChars) {
        Deque<ChatTurn> deque = SESSION_HISTORY.get(sessionKey);
        if (deque == null) return null;

        List<ChatTurn> turns = new ArrayList<>();
        synchronized (deque) {
            Iterator<ChatTurn> it = deque.descendingIterator();
            while (it.hasNext() && turns.size() < maxTurns) {
                turns.add(it.next());
            }
        }
        Collections.reverse(turns);

        StringBuilder sb = new StringBuilder();
        for (ChatTurn t : turns) {
            sb.append("user".equals(t.role) ? "用户：" : "助手：")
                    .append(t.content)
                    .append("\n");
            if (sb.length() >= maxChars) break;
        }
        if (sb.length() > maxChars) return sb.substring(0, maxChars);
        return sb.toString();
    }

    // ---------- 稳定性：超时/网络类错误重试一次 ----------
    private String callWithRetry(String systemPrompt, String userPrompt, Integer maxTokens, Double temperature) {
        try {
            return llmClient.chat(systemPrompt, userPrompt, maxTokens, temperature);
        } catch (Exception first) {
            log.warn("LLM call failed (first attempt), retrying once. err={}", first.toString());
            try {
                return llmClient.chat(systemPrompt, userPrompt, maxTokens, temperature);
            } catch (Exception second) {
                throw second;
            }
        }
    }

    private String safeMsg(Exception e) {
        if (e == null) return null;
        String m = e.getMessage();
        if (m == null) return e.toString();
        return m.length() > 500 ? m.substring(0, 500) : m;
    }

    private Map<String, Object> respOk(Object data) {
        Map<String, Object> r = new HashMap<>();
        r.put("code", 0);
        r.put("msg", "ok");
        r.put("data", data);
        return r;
    }

    private Map<String, Object> respError(String msg) {
        Map<String, Object> r = new HashMap<>();
        r.put("code", 1);
        r.put("msg", msg);
        r.put("data", null);
        return r;
    }

    private String toStr(Object o) {
        return o == null ? null : String.valueOf(o);
    }

    private Double toDouble(Object o) {
        if (o == null) return null;
        try {
            return Double.parseDouble(String.valueOf(o));
        } catch (Exception e) {
            return null;
        }
    }

    private Integer toInt(Object o) {
        if (o == null) return null;
        try {
            return Integer.parseInt(String.valueOf(o));
        } catch (Exception e) {
            return null;
        }
    }

    private Long toLong(Object o) {
        if (o == null) return null;
        try {
            return Long.parseLong(String.valueOf(o));
        } catch (Exception e) {
            return null;
        }
    }

    private String fmt(ZonedDateTime zdt) {
        if (zdt == null) return "";
        return zdt.withZoneSameInstant(ZoneId.of("Asia/Shanghai"))
                .toLocalDateTime()
                .toString()
                .replace("T", " ");
    }

    // =========================
    // 推荐计算 + 解析逻辑（与你原来一致）
    // =========================

    private static class SeatRecommendItem {
        public int seatId;
        public long freeMinutes;
        public ZonedDateTime freeUntilZdt;

        public SeatRecommendItem(int seatId, long freeMinutes, ZonedDateTime freeUntilZdt) {
            this.seatId = seatId;
            this.freeMinutes = freeMinutes;
            this.freeUntilZdt = freeUntilZdt;
        }
    }

    private List<SeatRecommendItem> computeTopSeatsByLongestContinuousFree(Integer zixishiid, Date windowStart, Date windowEnd, int topN) {
        String tableName = "seats_" + zixishiid;
        if (!tableName.matches("seats_\\d+")) {
            throw new IllegalArgumentException("非法的自习室ID，表名不合法");
        }

        List<Integer> seatIds = jdbcTemplate.query(
                "SELECT id FROM " + tableName + " WHERE status = 1 ORDER BY id",
                (rs, rowNum) -> rs.getInt("id")
        );
        if (seatIds == null || seatIds.isEmpty()) return Collections.emptyList();

        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        ZonedDateTime startZdt = ZonedDateTime.ofInstant(windowStart.toInstant(), zoneId);
        ZonedDateTime endZdt = ZonedDateTime.ofInstant(windowEnd.toInstant(), zoneId);

        List<SeatRecommendItem> items = new ArrayList<>();

        for (Integer seatId : seatIds) {
            ZonedDateTime nextBookingStart = findNextBookingStart(zixishiid, seatId, startZdt, endZdt);

            ZonedDateTime freeUntil = (nextBookingStart != null && nextBookingStart.isBefore(endZdt))
                    ? nextBookingStart
                    : endZdt;

            if (!freeUntil.isAfter(startZdt)) continue;

            long minutes = Duration.between(startZdt, freeUntil).toMinutes();
            items.add(new SeatRecommendItem(seatId, minutes, freeUntil));
        }

        items.sort((a, b) -> Long.compare(b.freeMinutes, a.freeMinutes));
        if (items.size() > topN) return new ArrayList<>(items.subList(0, topN));
        return items;
    }

    private ZonedDateTime findNextBookingStart(Integer zixishiid, Integer seatId, ZonedDateTime startZdt, ZonedDateTime endZdt) {
        List<YuyuexinxiEntity> list = yuyuexinxiService.getSeatYuyueList(zixishiid, seatId);
        if (list == null || list.isEmpty()) return null;

        ZoneId zoneId = ZoneId.of("Asia/Shanghai");
        ZonedDateTime next = null;

        for (YuyuexinxiEntity y : list) {
            Date s = y.getYuyueStart();
            Date e = y.getYuyueEnd();
            if (s == null || e == null) continue;

            ZonedDateTime sZdt = ZonedDateTime.ofInstant(s.toInstant(), zoneId);
            ZonedDateTime eZdt = ZonedDateTime.ofInstant(e.toInstant(), zoneId);

            if (!eZdt.isAfter(startZdt)) continue;
            if (!sZdt.isBefore(endZdt)) continue;

            boolean startInside = sZdt.isBefore(startZdt) && eZdt.isAfter(startZdt);
            if (startInside) return startZdt;

            if (sZdt.isAfter(startZdt) || sZdt.isEqual(startZdt)) {
                if (next == null || sZdt.isBefore(next)) next = sZdt;
            }
        }
        return next;
    }

    private boolean isSeatRecommendIntent(String msg) {
        if (msg == null) return false;
        String s = msg.replaceAll("\\s+", "");
        String[] keywords = new String[]{
                "推荐", "座位", "空位", "可约", "预约", "自习室",
                "图书馆", "北区", "机房", "多媒体", "宿舍楼", "大自习室", "s2s"
        };
        for (String k : keywords) {
            if (s.contains(k)) return true;
        }
        return false;
    }

    private boolean isFollowUpPickIntent(String msg) {
        if (msg == null) return false;
        String s = msg.replaceAll("\\s+", "");
        String[] patterns = new String[]{
                "从你推荐的座位中", "从你推荐的", "从推荐的",
                "选一个最佳", "选择一个最佳", "选一个最好的", "哪个最好", "哪个更好",
                "帮我挑一个", "帮我选一个", "就选一个", "你觉得哪个",
                "选择你推荐的", "从你推荐的座位里选", "在你推荐的座位中选"
        };
        for (String p : patterns) {
            if (s.contains(p)) return true;
        }
        return false;
    }

    private Double parseMinHoursFromMessage(String msg) {
        if (msg == null) return null;
        java.util.regex.Matcher m = java.util.regex.Pattern
                .compile("([0-9]+(\\.[0-9]+)?)\\s*小?时")
                .matcher(msg);
        if (m.find()) {
            try {
                return Double.parseDouble(m.group(1));
            } catch (Exception ignore) {
            }
        }
        return null;
    }

    private ZixishiEntity resolveZixishiByMessage(String message) {
        if (message == null) return null;
        String s = message.replaceAll("\\s+", "");
        List<ZixishiEntity> all = zixishiService.selectList(null);
        if (all == null || all.isEmpty()) return null;

        for (ZixishiEntity z : all) {
            if (z == null || z.getMingcheng() == null) continue;
            String name = z.getMingcheng().replaceAll("\\s+", "");
            if (!name.isEmpty() && s.contains(name)) {
                return z;
            }
        }

        String lower = s.toLowerCase();
        for (ZixishiEntity z : all) {
            if (z == null || z.getMingcheng() == null) continue;
            String name = z.getMingcheng().replaceAll("\\s+", "");
            String nameLower = name.toLowerCase();

            if (lower.contains("s2s") && nameLower.contains("s2s")) return z;
            if (lower.contains("图书馆") && name.contains("图书馆")) return z;
            if (lower.contains("北区三号楼") && name.contains("北区三号楼")) return z;
            if (lower.contains("北区二号楼") && name.contains("北区2号楼")) return z;
            if (lower.contains("北区2号楼") && name.contains("北区2号楼")) return z;
            if (lower.contains("多媒体") && name.contains("多媒体")) return z;
            if (lower.contains("机房") && name.contains("机房")) return z;
            if (lower.contains("宿舍楼") && name.contains("宿舍楼")) return z;
            if (lower.contains("大自习室") && name.contains("大自习室")) return z;
        }

        return null;
    }

    private String buildZixishiOptionsText() {
        List<ZixishiEntity> all = zixishiService.selectList(null);
        if (all == null || all.isEmpty()) return "(系统暂无自习室数据)";
        StringBuilder sb = new StringBuilder();
        for (ZixishiEntity z : all) {
            sb.append("- ").append(z.getMingcheng())
                    .append("（id=").append(z.getId()).append("）");
            if (z.getWeizhi() != null && !z.getWeizhi().trim().isEmpty()) {
                sb.append("，位置：").append(z.getWeizhi());
            }
            sb.append("\n");
        }
        return sb.toString();
    }

    private String zixishiNameOrDefault(ZixishiEntity zixishi, Integer zixishiid) {
        if (zixishi != null && zixishi.getMingcheng() != null && !zixishi.getMingcheng().trim().isEmpty()) {
            return zixishi.getMingcheng().trim();
        }
        return "自习室" + zixishiid;
    }
}