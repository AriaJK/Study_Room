package com.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Component
public class CurrentUserProvider {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public String getXuehao(HttpServletRequest request) {
        String token = extractToken(request);
        if (token == null || token.trim().isEmpty()) return null;

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                "SELECT username FROM token WHERE token = ? LIMIT 1",
                token.trim()
        );
        if (rows == null || rows.isEmpty()) return null;

        Object username = rows.get(0).get("username");
        if (username == null) return null;

        String xuehao = String.valueOf(username).trim();
        return xuehao.isEmpty() ? null : xuehao;
    }

    private String extractToken(HttpServletRequest request) {
        // ✅ 你截图里就是这个：Token: xxx
        String t = request.getHeader("Token");
        if (t != null && !t.trim().isEmpty()) return t.trim();

        // 兼容其它可能
        t = request.getHeader("token");
        if (t != null && !t.trim().isEmpty()) return t.trim();

        String auth = request.getHeader("Authorization");
        if (auth != null && !auth.trim().isEmpty()) {
            String a = auth.trim();
            if (a.toLowerCase().startsWith("bearer ")) {
                return a.substring(7).trim();
            }
            return a;
        }
        return null;
    }
}