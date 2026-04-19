package com.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.dao.AiChatMessageDao;
import com.dao.AiChatSessionDao;
import com.entity.AiChatMessageEntity;
import com.entity.AiChatSessionEntity;
import com.service.AiChatHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AiChatHistoryServiceImpl implements AiChatHistoryService {

    @Autowired
    private AiChatSessionDao sessionDao;   // 确保 sessionDao 被注入
    @Autowired
    private AiChatMessageDao messageDao;

    @Override
    public AiChatSessionEntity createSession(String xuehao, String title) {
        AiChatSessionEntity session = new AiChatSessionEntity();
        session.setXuehao(xuehao);
        session.setTitle(title == null ? "New Chat" : title);
        session.setIsDeleted(0);
        session.setCreatedAt(new Date());
        session.setUpdatedAt(new Date());
        session.setLastMessageAt(new Date());
        sessionDao.insert(session);
        return session;
    }

    @Override
    public List<AiChatSessionEntity> listSessions(String xuehao) {
        return sessionDao.selectList(
                new EntityWrapper<AiChatSessionEntity>()
                        .eq("xuehao", xuehao)
                        .eq("is_deleted", 0)  // 仅查看未被删除的会话
                        .orderBy("last_message_at", false)
        );
    }

    @Override
    public List<AiChatMessageEntity> listMessages(String xuehao, Long sessionId, int limit) {
        if (limit <= 0) limit = 50;
        if (limit > 200) limit = 200;

        List<AiChatMessageEntity> all = messageDao.selectList(
                new EntityWrapper<AiChatMessageEntity>()
                        .eq("xuehao", xuehao) // 按学号限制用户范围
                        .eq("session_id", sessionId)
                        .orderBy("id", true)
        );

        // 如果消息条数过多，截取最后 limit 条
        return (all.size() <= limit) ? all : all.subList(all.size() - limit, all.size());
    }

    @Override
    public void appendMessage(String xuehao, Long sessionId, String role, String content) {
        AiChatMessageEntity message = new AiChatMessageEntity();
        message.setXuehao(xuehao);
        message.setSessionId(sessionId);
        message.setRole(role);
        message.setContent(content == null ? "" : content);
        message.setCreatedAt(new Date());
        messageDao.insert(message);
    }

    @Override
    public boolean deleteSession(String xuehao, Long sessionId) {
        // 查找会话，确认是当前学号的
        AiChatSessionEntity session = sessionDao.selectById(sessionId);
        if (session == null || !xuehao.equals(session.getXuehao())) {
            return false; // 没有权限或会话不存在
        }

        // 逻辑删除：只是设置 is_deleted 字段，而不是物理删除
        AiChatSessionEntity update = new AiChatSessionEntity();
        update.setId(sessionId);
        update.setIsDeleted(1);
        update.setUpdatedAt(new Date());
        sessionDao.updateById(update);

        return true;
    }

    @Override
    public void touchSession(String xuehao, Long sessionId) {
        AiChatSessionEntity session = sessionDao.selectById(sessionId);
        if (session == null || !xuehao.equals(session.getXuehao())) return;

        AiChatSessionEntity update = new AiChatSessionEntity();
        update.setId(sessionId);
        update.setLastMessageAt(new Date());
        sessionDao.updateById(update);
    }
}