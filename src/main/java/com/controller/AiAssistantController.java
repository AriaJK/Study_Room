package com.controller;

import com.service.AiAssistantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@CrossOrigin(origins = "*", maxAge = 3600)
public class AiAssistantController {

    @Autowired
    private AiAssistantService aiAssistantService;

    @PostMapping("/chat")
    public Map<String, Object> chat(@RequestBody Map<String, Object> req) {
        return aiAssistantService.chat(req);
    }

    @PostMapping("/summary")
    public Map<String, Object> summary(@RequestBody Map<String, Object> req) {
        return aiAssistantService.summary(req);
    }

    @PostMapping("/recommend")
    public Map<String, Object> recommend(@RequestBody Map<String, Object> req) {
        return aiAssistantService.recommend(req);
    }
}