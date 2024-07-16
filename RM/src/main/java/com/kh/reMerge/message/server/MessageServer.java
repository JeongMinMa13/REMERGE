package com.kh.reMerge.message.server;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.message.model.vo.Message;
import com.kh.reMerge.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.util.*;

@Slf4j
@Component
public class MessageServer extends TextWebSocketHandler {
    private static final Map<Integer, Set<WebSocketSession>> chatRooms = Collections.synchronizedMap(new HashMap<>());
    private final Set<WebSocketSession> users = Collections.synchronizedSet(new HashSet<>());
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private WebSocketHandler webSocketHandler;

    @Autowired
    private MessageService messageService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        users.add(session);
        User loginUser = (User) session.getAttributes().get("loginUser");

        // 읽음처리 하기위한 방번호 구하기
        List<Integer> chatRoomNumbers = messageService.getChatRoomNumbers(loginUser.getUserId());

        // 채팅방 접속하자마자 읽음 처리
        for (Integer chatRoomNo : chatRoomNumbers) {
            messageService.markAsRead(chatRoomNo, loginUser.getUserId());
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage textMessage) throws Exception {
        // JSON 문자열을 Map으로 변환
        Map<String, Object> messageData = objectMapper.readValue(textMessage.getPayload(), Map.class);
        String type = (String) messageData.get("type");

        if ("join".equals(type)) {
            int messageRoomNo = (int) messageData.get("messageRoomNo");
            joinChatRoom(messageRoomNo, session);
            return;
        }

        // Message 객체로 변환
        Message message = objectMapper.readValue(textMessage.getPayload(), Message.class);
        // 메시지를 데이터베이스에 저장
        messageService.saveMessage(message);

        User loginUser = (User) session.getAttributes().get("loginUser");
        String receiveId = message.getReceiveId();

        // 채팅방 번호를 가져와서 해당 채팅방에 메시지 보내기
        int chatRoomNo = message.getMessageRoomNo();
        Set<WebSocketSession> sessions = chatRooms.get(chatRoomNo);

        if (sessions != null) {
            for (WebSocketSession s : sessions) {
                s.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
            }
        }

        if (sessions.size() == 2) { // 채팅방에 두명 모두 있을 때
            if (!loginUser.getUserId().equals(receiveId)) {
                messageService.markAsRead(chatRoomNo, receiveId);
            }
        }
        if (sessions.size() == 1) { // 채팅방에 발신자만 있을 때 
            if (!loginUser.getUserId().equals(receiveId)) {
                webSocketHandler.updateUnreadMessageCount(receiveId);
                webSocketHandler.sendNotifications(session, receiveId);
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        for (Map.Entry<Integer, Set<WebSocketSession>> entry : chatRooms.entrySet()) {
            int chatRoomNo = entry.getKey();
            Set<WebSocketSession> sessions = entry.getValue();

            sessions.remove(session);

            if (sessions.isEmpty()) {
                chatRooms.remove(chatRoomNo);
            } else if (sessions.size() == 1) {
                WebSocketSession remainingSession = sessions.iterator().next();
                User remainingUser = (User) remainingSession.getAttributes().get("loginUser");
                messageService.markAsUnRead(chatRoomNo, remainingUser.getUserId());
            }
        }
        webSocketHandler.afterConnectionEstablished(session);
    }

    public void joinChatRoom(int messageRoomNo, WebSocketSession session) {
        chatRooms.computeIfAbsent(messageRoomNo, k -> Collections.synchronizedSet(new HashSet<>())).add(session);
    }
}
