package com.client.impl;

import com.client.LlmClient;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Component
public class QwenLlmClient implements LlmClient {

    private final boolean enabled;
    private final String baseUrl;
    private final String apiKey;
    private final String model;

    private final int defaultMaxTokens;
    private final double defaultTemperature;
    private final double defaultTopP;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public QwenLlmClient(
            @Value("${ai.enabled:true}") boolean enabled,
            @Value("${ai.base-url}") String baseUrl,
            @Value("${ai.api-key}") String apiKey,
            @Value("${ai.model:qwen-plus}") String model,
            @Value("${ai.timeout-ms:8000}") int timeoutMs,
            @Value("${ai.max-tokens:1500}") int defaultMaxTokens,
            @Value("${ai.temperature:0.7}") double defaultTemperature,
            @Value("${ai.top-p:1.0}") double defaultTopP
    ) {
        this.enabled = enabled;
        this.baseUrl = baseUrl;
        this.apiKey = apiKey;
        this.model = model;

        this.defaultMaxTokens = defaultMaxTokens;
        this.defaultTemperature = defaultTemperature;
        this.defaultTopP = defaultTopP;

        // 让超时真正生效
        SimpleClientHttpRequestFactory f = new SimpleClientHttpRequestFactory();
        f.setConnectTimeout(timeoutMs);
        f.setReadTimeout(timeoutMs);
        this.restTemplate = new RestTemplate(f);
    }

    @Override
    public String chat(String systemPrompt, String userPrompt) {
        // 兼容旧调用：仍然使用默认 maxTokens/temperature
        return chat(systemPrompt, userPrompt, null, null);
    }

    @Override
    public String chat(String systemPrompt, String userPrompt, Integer maxTokens, Double temperature) {
        if (!enabled) {
            throw new RuntimeException("AI is disabled (ai.enabled=false)");
        }
        if (baseUrl == null || baseUrl.trim().isEmpty()) {
            throw new RuntimeException("ai.base-url is empty");
        }
        if (apiKey == null || apiKey.trim().isEmpty()) {
            throw new RuntimeException("ai.api-key is empty");
        }
        if (userPrompt == null || userPrompt.trim().isEmpty()) {
            throw new RuntimeException("userPrompt is empty");
        }

        String url = normalizeBaseUrl(baseUrl) + "/chat/completions";

        int finalMaxTokens = (maxTokens != null && maxTokens > 0) ? maxTokens : defaultMaxTokens;
        double finalTemperature = (temperature != null && temperature >= 0) ? temperature : defaultTemperature;

        // --- 请求体（OpenAI兼容）---
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("model", model);
        body.put("max_tokens", finalMaxTokens);

        List<Map<String, String>> messages = new ArrayList<>();
        if (systemPrompt != null && !systemPrompt.trim().isEmpty()) {
            messages.add(msg("system", systemPrompt));
        }
        messages.add(msg("user", userPrompt));
        body.put("messages", messages);

        body.put("temperature", finalTemperature);
        body.put("top_p", defaultTopP);

        // --- Header ---
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<byte[]> resp = restTemplate.exchange(url, HttpMethod.POST, entity, byte[].class);

            if (!resp.getStatusCode().is2xxSuccessful()) {
                String bodyStr = resp.getBody() == null ? "" : new String(resp.getBody(), java.nio.charset.StandardCharsets.UTF_8);
                throw new RuntimeException("LLM http status not ok: " + resp.getStatusCodeValue()
                        + ", body=" + safe(bodyStr));
            }

            byte[] bytes = resp.getBody();
            if (bytes == null || bytes.length == 0) {
                throw new RuntimeException("LLM empty response body");
            }

            String respBody = new String(bytes, java.nio.charset.StandardCharsets.UTF_8);
            if (respBody.trim().isEmpty()) {
                throw new RuntimeException("LLM empty response body");
            }

            // --- 解析响应：choices[0].message.content ---
            JsonNode root = objectMapper.readTree(respBody);
            JsonNode choices = root.path("choices");
            if (!choices.isArray() || choices.size() == 0) {
                throw new RuntimeException("LLM response missing choices, body=" + shorten(respBody));
            }

            JsonNode choice0 = choices.get(0);
            String text = null;

            JsonNode contentNode = choice0.path("message").path("content");
            if (!contentNode.isMissingNode() && !contentNode.isNull()) {
                text = contentNode.asText();
            }
            // 兼容部分实现：choices[0].text
            if (text == null || text.trim().isEmpty()) {
                JsonNode alt = choice0.path("text");
                if (!alt.isMissingNode() && !alt.isNull()) {
                    text = alt.asText();
                }
            }

            if (text == null || text.trim().isEmpty()) {
                throw new RuntimeException("LLM response missing content, body=" + shorten(respBody));
            }

            return text.trim();

        } catch (HttpStatusCodeException e) {
            String errBody = e.getResponseBodyAsString(java.nio.charset.StandardCharsets.UTF_8);
            throw new RuntimeException("Call Qwen failed: http=" + e.getStatusCode().value()
                    + ", body=" + safe(errBody), e);
        } catch (Exception e) {
            throw new RuntimeException("Call Qwen failed: " + e.getMessage(), e);
        }
    }

    private Map<String, String> msg(String role, String content) {
        Map<String, String> m = new LinkedHashMap<>();
        m.put("role", role);
        m.put("content", content);
        return m;
    }

    private String normalizeBaseUrl(String s) {
        String t = s.trim();
        while (t.endsWith("/")) t = t.substring(0, t.length() - 1);
        return t;
    }

    private String safe(String s) {
        return s == null ? "" : s;
    }

    private String shorten(String s) {
        if (s == null) return "";
        String t = s.replace("\n", " ").replace("\r", " ");
        return t.length() > 400 ? t.substring(0, 400) + "..." : t;
    }
}