package com.kh.reMerge.message.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.WebSocketSession;

import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.message.model.vo.Message;
import com.kh.reMerge.message.server.MessageServer;
import com.kh.reMerge.user.model.vo.User;

@Controller
@RequestMapping("/message")
public class MessageController {
    @Autowired
    private MessageService messageService;
    @Autowired
    private MessageServer messageServer;

    @GetMapping("/dm")
    public String basic(Model model) {
        return "chat/chat";
    }
    
    @GetMapping("/getChatRoom")
    @ResponseBody
    public int getChatRoom(HttpSession session, @RequestParam("receiveId") String receiveId) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            throw new IllegalArgumentException("로그인 정보가 없습니다.");
        }

        String sendId = loginUser.getUserId();
//        System.out.println("겟챗룸 센드아이디 확인: " + sendId);
//        System.out.println("겟챗룸 리시브아이디 확인: " + receiveId);
        
        // 메시지가 있는지 확인하여 채팅방 번호를 받아옴
        int messageRoomNo = messageService.getMessageRoomNo(sendId, receiveId);
        System.out.println("기존 채팅방이 있을때: " + messageRoomNo);

        // 채팅방이 없으면 새로 생성
        if (messageRoomNo == 0) {
            messageRoomNo = messageService.createChatRoom(sendId, receiveId);
            System.out.println("새로운 채팅방 생성 : " + messageRoomNo);
        }
        return messageRoomNo;
    }

    @GetMapping("/getChatHistory")
    @ResponseBody
    public ResponseEntity<List<Message>> getChatHistory(@RequestParam("messageRoomNo") int messageRoomNo) {
        List<Message> chatHistory = messageService.getChatHistory(messageRoomNo);
        return ResponseEntity.ok(chatHistory);
    }
    
    
}
