package com.kh.reMerge.message.server;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.message.model.vo.Message;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MessageServer extends TextWebSocketHandler {

    private static Map<Integer, Set<WebSocketSession>> chatRooms = Collections.synchronizedMap(new HashMap<>());
    @Autowired
    private MessageService messageService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.debug("접속");
        log.debug("websocket session : {}", session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        log.debug("메세지 수신");
        log.debug("session : {}", session);
        log.debug("TextMessage : {}", textMessage);

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> messageData = objectMapper.readValue(textMessage.getPayload(), Map.class);

        String type = (String) messageData.get("type");
        
        if ("join".equals(type)) {
            int messageRoomNo = (int) messageData.get("messageRoomNo");
            joinChatRoom(messageRoomNo, session);
            return;
        }

        Message message = objectMapper.readValue(textMessage.getPayload(), Message.class);
        // 메시지를 데이터베이스에 저장
        messageService.saveMessage(message);
        System.out.println("메시지서버 메시지 확인 : "+message);
        // 채팅방 번호를 가져와서 해당 채팅방에 속한 세션들에 메시지를 전송
        int chatRoomNo = message.getMessageRoomNo();
        Set<WebSocketSession> sessions = chatRooms.get(chatRoomNo);

        if (sessions != null) {
            for (WebSocketSession s : sessions) {
                // 여기서 메시지를 한 번만 전송하도록 처리해야 함
                s.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.debug("접속 종료");
        log.debug("session : {}", session);
        log.debug("status : {}", status);

        for (Set<WebSocketSession> sessions : chatRooms.values()) {
            sessions.remove(session);
        }
    }

    // 채팅방에 세션을 추가하는 메서드
    public void joinChatRoom(int messageRoomNo, WebSocketSession session) {
        chatRooms.computeIfAbsent(messageRoomNo, k -> Collections.synchronizedSet(new HashSet<>())).add(session);
    }
}
	 