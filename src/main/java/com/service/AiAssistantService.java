package com.service;

import com.client.LlmClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class AiAssistantService {

    private static final Logger log = LoggerFactory.getLogger(AiAssistantService.class);

    @Autowired
    private LlmClient llmClient;

    /**
     * 简单会话缓存（内存版）：
     * - key: sessionKey（从前端传、或后端从 Token 解析；这里先支持从 req 里传 sessionKey，没传就用 "default"）
     * - value: 最近 N 轮对话（user/assistant）
     *
     * 说明：这只是本地开发/单机可用版。线上多实例应换成 Redis。
     */
    private static final Map<String, Deque<ChatTurn>> SESSION_HISTORY = new ConcurrentHashMap<>();

    /**
     * 记忆长度：建议稍微大一点，避免“感觉只能记一两句”
     * MAX_TURNS 表示“最近 N 轮对话”，每轮包含 user+assistant 两条消息
     */
    private static final int MAX_TURNS = 20;

    // ========== chat ==========
    public Map<String, Object> chat(Map<String, Object> req) {
        String message = req == null ? null : toStr(req.get("message"));
        if (message == null || message.trim().isEmpty()) {
            return respError("message 不能为空");
        }

        String sessionKey = getSessionKey(req);

        String systemPrompt = ""
                + "你是智���自习室的学习助手。\n"
                + "你要用中文回答。\n"
                + "你可以进行多轮对话，必须结合上下文回答用户。\n"
                + "如果用户只回复“1/2/3/继续/展开/好”等短句，你要结合上一条你的回答推断用户指的内容并继续。\n"
                + "如果用户让你制定学习计划，请给出可执行的步骤（按时间分段）。\n"
                + "不要编造用户数据，不要声称你已保存到数据库。\n";

        // 关键改动：先把用户输入写入历史，避免“失败/重启/异常导致上下文断档”
        appendTurn(sessionKey, "user", message);

        // 组装“带上下文”的 userPrompt（此时包含历史 + 本次用户输入）
        String userPrompt = buildPromptWithHistory(sessionKey, message);

        try {
            String reply = callWithRetry(systemPrompt, userPrompt);

            // 成功也写入 assistant
            appendTurn(sessionKey, "assistant", reply);

            Map<String, Object> data = new HashMap<>();
            data.put("reply", reply);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        } catch (Exception e) {
            log.warn("AI chat failed. sessionKey={}, message={}, err={}", sessionKey, message, e.toString(), e);

            // 降级：仍保持 reply 字段存在，前端可正常展示
            String fallbackReply = "我刚刚连接 AI 服务失败了（可能是网络/限流/超时）。你可以稍后重试；或者把你的目标（科目/时长/截止时间）再发一次，我先按模板给你一个学习计划。";

            // 关键改动：失败也写入 assistant，避免下一轮“像失忆”
            appendTurn(sessionKey, "assistant", fallbackReply);

            Map<String, Object> data = new HashMap<>();
            data.put("reply", fallbackReply);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ========== summary ==========
    public Map<String, Object> summary(Map<String, Object> req) {
        Double durationMinutes = toDouble(req == null ? null : req.get("durationMinutes"));
        String yuyuedanhao = req == null ? null : toStr(req.get("yuyuedanhao"));
        String todayGoal = req == null ? null : toStr(req.get("todayGoal"));

        if (durationMinutes == null) {
            return respError("durationMinutes 不能为空（MVP阶段请前端传入本次学习分钟数）");
        }

        String sessionKey = getSessionKey(req);

        String systemPrompt = ""
                + "你是智慧自习室的学习总结助手。\n"
                + "你只根据用户提供的数据生成总结，不要编造。\n"
                + "输出要求：用中文，分3段：1) 今日表现 2) 值得肯定 3) 明日建议。\n";

        StringBuilder userPrompt = new StringBuilder();
        userPrompt.append("请根据以下数据生成学习总结：\n");
        if (yuyuedanhao != null && !yuyuedanhao.isEmpty()) {
            userPrompt.append("- 预约单号：").append(yuyuedanhao).append("\n");
        }
        userPrompt.append("- 本次学习时长（分钟）：").append(durationMinutes).append("\n");
        if (todayGoal != null && !todayGoal.trim().isEmpty()) {
            userPrompt.append("- 今日目标：").append(todayGoal).append("\n");
        }

        // 关键改动：summary 也写入对话历史，这样用户后续在 chat 里追问“怎么改进”会更连贯
        String summaryUserMsg = "请帮我生成学习总结。本次学习时长：" + durationMinutes + " 分钟。"
                + (todayGoal != null && !todayGoal.trim().isEmpty() ? (" 今日目标：" + todayGoal) : "");
        appendTurn(sessionKey, "user", summaryUserMsg);

        try {
            String summaryText = callWithRetry(systemPrompt, userPrompt.toString());

            appendTurn(sessionKey, "assistant", summaryText);

            Map<String, Object> data = new HashMap<>();
            data.put("durationMinutes", durationMinutes);
            data.put("summaryText", summaryText);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        } catch (Exception e) {
            log.warn("AI summary failed. durationMinutes={}, err={}", durationMinutes, e.toString(), e);

            // 降级总结（模板）
            String fallbackSummary =
                    "今日表现：你本次完成了 " + durationMinutes + " 分钟的学习。\n"
                            + "值得肯定：能坚持完成计划很不错。\n"
                            + "明日建议：把任务拆成 25-30 分钟一组（番茄钟），每组休息 5 分钟，并在开始前写下本次要完成的 1-3 个小目标。";

            appendTurn(sessionKey, "assistant", fallbackSummary);

            Map<String, Object> data = new HashMap<>();
            data.put("durationMinutes", durationMinutes);
            data.put("summaryText", fallbackSummary);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ========== recommend ==========
    public Map<String, Object> recommend(Map<String, Object> req) {
        String sessionKey = getSessionKey(req);

        // 仍保留 MVP 策略建议（你后面要做“查 seats_XX + yuyuexinxi”我再带你升级）
        String systemPrompt = ""
                + "你是智慧自习室的选座推荐助手。\n"
                + "你要用中文回答。\n"
                + "MVP阶段你无法直接读取实时空位数据，因此只能给出选座策略建议。\n"
                + "如果用户追问“第1条/2条/3条是什么意思”，你要解释得具体可执行。\n"
                + "不要编造具体自习室编号或座位号。\n";

        String userPrompt = "请给我选择自习室/座位的建议：我想找空位多、尽量安静的地方。请用 1)2)3) 列出三条并解释原因。";

        // 关键改动：recommend 也写入历史，这样用户下一句在 chat 里输入“1/2/3”能接上
        String recommendUserMsg = "帮我推荐一个空位多的自习室/座位（如果暂时拿不到实时空位，就给我选座策略）。";
        appendTurn(sessionKey, "user", recommendUserMsg);

        try {
            String text = callWithRetry(systemPrompt, userPrompt);

            appendTurn(sessionKey, "assistant", text);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", text);
            data.put("mvp", true);
            data.put("sessionKey", sessionKey);
            data.put("fallback", false);
            return respOk(data);
        } catch (Exception e) {
            log.warn("AI recommend failed. err={}", e.toString(), e);

            String fallbackText = "建议优先选择：1）离门远、靠窗位置 2）避开走廊与饮水机附近 3）优先选择可预约区间更长的座位。";

            appendTurn(sessionKey, "assistant", fallbackText);

            Map<String, Object> data = new HashMap<>();
            data.put("recommendation", fallbackText);
            data.put("mvp", true);
            data.put("sessionKey", sessionKey);
            data.put("fallback", true);
            data.put("error", safeMsg(e));
            return respOk(data);
        }
    }

    // ---------- 会话上下文 helpers ----------
    private static class ChatTurn {
        String role; // "user" / "assistant"
        String content;

        ChatTurn(String role, String content) {
            this.role = role;
            this.content = content;
        }
    }

    private String getSessionKey(Map<String, Object> req) {
        String sessionKey = req == null ? null : toStr(req.get("sessionKey"));
        if (sessionKey == null || sessionKey.trim().isEmpty()) {
            sessionKey = "default";
        }
        return sessionKey;
    }

    private void appendTurn(String sessionKey, String role, String content) {
        if (sessionKey == null) return;
        if (content == null) content = "";

        Deque<ChatTurn> deque = SESSION_HISTORY.computeIfAbsent(sessionKey, k -> new ArrayDeque<>());
        synchronized (deque) {
            deque.addLast(new ChatTurn(role, content));
            // 控制最大轮数（turn=一条消息）
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

        // 这里仍然附上 currentUserMessage，方便模型聚焦最后一条
        sb.append("\n用户：").append(currentUserMessage).append("\n");
        sb.append("助手：");
        return sb.toString();
    }

    // ---------- 稳定性：超时/网络类错误重试一次 ----------
    private String callWithRetry(String systemPrompt, String userPrompt) {
        try {
            return llmClient.chat(systemPrompt, userPrompt);
        } catch (Exception first) {
            // 只重试一次（避免雪崩）
            log.warn("LLM call failed (first attempt), retrying once. err={}", first.toString());
            try {
                return llmClient.chat(systemPrompt, userPrompt);
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

    // ---------- 通用返回 ----------
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
}