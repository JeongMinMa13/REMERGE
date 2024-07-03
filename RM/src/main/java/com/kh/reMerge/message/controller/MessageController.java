package com.kh.reMerge.message.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
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

        String sendId = loginUser.getUserId();
        
        // 메시지가 있는지 확인하여 채팅방 번호를 받아옴
        int messageRoomNo = messageService.getMessageRoomNo(sendId, receiveId);

        // 채팅방이 없으면 새로 생성
        if (messageRoomNo == 0) {
            messageRoomNo = messageService.createChatRoom(sendId, receiveId);
        }
        return messageRoomNo;
    }

    @GetMapping("/getChatHistory")
    @ResponseBody
    public ResponseEntity<List<Message>> getChatHistory(@RequestParam("messageRoomNo") int messageRoomNo) {
        List<Message> chatHistory = messageService.getChatHistory(messageRoomNo);
        return ResponseEntity.ok(chatHistory);
    }
    
    
    public String saveFile(MultipartFile upfile, HttpSession session) {
        String originName = upfile.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String ext = originName.substring(originName.lastIndexOf("."));
        int ranNum = (int)(Math.random()*90000 + 10000);
        String changeName = currentTime + ranNum + ext;
        String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");

        try {
            upfile.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }

        return changeName;
    }

}
