package com.controller;

import com.service.AiAssistantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@CrossOrigin(origins = "*", maxAge = 3600)
public class AiAssistantController {

    @Autowired
    private AiAssistantService aiAssistantService;

    @PostMapping("/chat")
    public Map<String, Object> chat(@RequestBody Map<String, Object> req, HttpServletRequest request) {
        return aiAssistantService.chat(req, request);
    }

    @PostMapping("/summary")
    public Map<String, Object> summary(@RequestBody Map<String, Object> req, HttpServletRequest request) {
        return aiAssistantService.summary(req, request);
    }

    @PostMapping("/recommend")
    public Map<String, Object> recommend(@RequestBody Map<String, Object> req, HttpServletRequest request) {
        return aiAssistantService.recommend(req, request);
    }
}