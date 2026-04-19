package com.client;

public interface LlmClient {
    /**
     * 发送对话请求，返回模型输出文本（兼容旧调用）
     */
    String chat(String systemPrompt, String userPrompt);

    /**
     * 按场景控制生成长度与随机性，以提升速度与稳定性
     */
    String chat(String systemPrompt, String userPrompt, Integer maxTokens, Double temperature);
}