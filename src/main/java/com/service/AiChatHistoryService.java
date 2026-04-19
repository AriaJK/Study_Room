package com.service;

import com.entity.AiChatMessageEntity;
import com.entity.AiChatSessionEntity;

import java.util.List;

public interface AiChatHistoryService {

    AiChatSessionEntity createSession(String xuehao, String title);

    List<AiChatSessionEntity> listSessions(String xuehao);

    List<AiChatMessageEntity> listMessages(String xuehao, Long sessionId, int limit);

    void appendMessage(String xuehao, Long sessionId, String role, String content);

    void touchSession(String xuehao, Long sessionId);

    /**
     * 逻辑删除会话
     *
     * @param xuehao 用户学号
     * @param sessionId 会话 ID
     * @return 是否成功删除
     */
    boolean deleteSession(String xuehao, Long sessionId);
}