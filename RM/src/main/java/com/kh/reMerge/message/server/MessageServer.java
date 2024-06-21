package com.kh.reMerge.message.server;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
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
    
    private static Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());

    @Autowired
    private MessageService messageService;
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.debug("접속");
        log.debug("websocket session : {}", session);

        sessions.add(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.debug("메세지 수신");
        log.debug("session : {}", session);
        log.debug("TextMessage : {}", message);

        Message msg = objectMapper.readValue(message.getPayload(), Message.class);

        messageService.saveMessage(msg);

        sendMessageToChatRoom(msg);
    }

    private void sendMessageToChatRoom(Message message) throws IOException {
        String sendId = message.getSendId();
        String receiveId = message.getReceiveId();

        for (WebSocketSession session : sessions) {
            String sessionId = (String) session.getAttributes().get("userId");
            if (sessionId != null && (sessionId.equals(sendId) || sessionId.equals(receiveId))) {
                session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.debug("접속 종료");
        log.debug("session : {}", session);
        log.debug("status : {}", status);

        sessions.remove(session);
    }
}
