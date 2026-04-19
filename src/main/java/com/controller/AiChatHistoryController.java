package com.controller;

import com.entity.AiChatMessageEntity;
import com.entity.AiChatSessionEntity;
import com.service.AiChatHistoryService;
import com.utils.CurrentUserProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RestController
@RequestMapping("/api/ai")
@CrossOrigin(origins = "*", maxAge = 3600)
public class AiChatHistoryController {

    @Autowired
    private AiChatHistoryService historyService;

    @Autowired
    private CurrentUserProvider currentUserProvider;

    @GetMapping("/sessions")
    public Map<String, Object> sessions(HttpServletRequest request) {
        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) return respError("未登录或无法识别学号");

        List<AiChatSessionEntity> list = historyService.listSessions(xuehao);

        Map<String, Object> data = new HashMap<>();
        data.put("sessions", list);
        return respOk(data);
    }

    @PostMapping("/sessions")
    public Map<String, Object> createSession(@RequestBody(required = false) Map<String, Object> body,
                                             HttpServletRequest request) {
        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) return respError("未登录或无法识别学号");

        String title = body == null ? null : String.valueOf(body.get("title"));
        AiChatSessionEntity s = historyService.createSession(xuehao, title);

        Map<String, Object> data = new HashMap<>();
        data.put("session", s);
        return respOk(data);
    }

    @GetMapping("/sessions/{id}/messages")
    public Map<String, Object> messages(@PathVariable("id") Long sessionId,
                                        @RequestParam(name = "limit", required = false, defaultValue = "50") int limit,
                                        HttpServletRequest request) {
        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) return respError("未登录或无法识别学号");

        List<AiChatMessageEntity> list = historyService.listMessages(xuehao, sessionId, limit);

        Map<String, Object> data = new HashMap<>();
        data.put("messages", list);
        data.put("sessionId", sessionId);
        return respOk(data);
    }

    @DeleteMapping("/sessions/{id}")
    public Map<String, Object> deleteSession(@PathVariable("id") Long id, HttpServletRequest request) {
        String xuehao = currentUserProvider.getXuehao(request);
        if (xuehao == null) {
            return respError("未登录或无法识别学号");
        }

        try {
            boolean success = historyService.deleteSession(xuehao, id);
            if (!success) {
                return respError("无法删除会话：会话不存在或无权限");
            }
            return respOk("会话已删除");
        } catch (Exception e) {
            return respError("删除会话失败：" + e.getMessage());
        }
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
}