package com.kh.reMerge.message.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.message.model.vo.Message;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @GetMapping("/dm")
    public String basic(Model model) {
        return "message/chat";
    }

    @GetMapping("/messages")
    public ResponseEntity<ArrayList<Message>> getMessages(@RequestParam String sendId, @RequestParam String receiveId) {
        ArrayList<Message> messages = messageService.getMessagesBetweenUsers(sendId, receiveId);
        return ResponseEntity.ok(messages);
    }
    
    @PostMapping("/send")
    public ResponseEntity<String> sendMessage(@RequestBody Message message) {
        boolean result = messageService.sendMessage(message);
        
        if (result) {
            return ResponseEntity.ok("Message sent successfully");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send message");
        }
    }

}
