package com.client;

public interface LlmClient {
    /**
     * 发送对话请求，返回模型输出文本（MVP版：只返回纯文本）
     */
    String chat(String systemPrompt, String userPrompt);
}