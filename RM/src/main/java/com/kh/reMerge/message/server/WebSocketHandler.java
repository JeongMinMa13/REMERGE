package com.kh.reMerge.message.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.user.model.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class WebSocketHandler extends TextWebSocketHandler {
    private final Set<WebSocketSession> users = Collections.synchronizedSet(new HashSet<>());
    private final Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private MessageService messageService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        users.add(session);
        User loginUser = (User) session.getAttributes().get("loginUser");

        handleNewSession(session);

        // 안 읽은 메시지 개수 업데이트
        updateUnreadMessageCount(loginUser.getUserId());
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        User loginUser = (User) session.getAttributes().get("loginUser");

        if (loginUser != null) {
            String receivedMessage = message.getPayload();

            sendNotificationOnMessageReceived(session, loginUser.getUserId(), receivedMessage);
        }
    }

    protected void sendNotificationOnMessageReceived(WebSocketSession session, String userId, String messageContent) {
        try {
            Map<String, Object> message = new HashMap<>();
            message.put("type", "notification");
            message.put("fromUserId", userId);
            message.put("content", "새 메세지: " + messageContent);

            String jsonMessage = objectMapper.writeValueAsString(message);
            session.sendMessage(new TextMessage(jsonMessage));
        } catch (IOException e) {
            log.error("알림 안감 : {}", e.getMessage());
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        users.remove(session);

        User loginUser = (User) session.getAttributes().get("loginUser");
        if (loginUser != null) {
            userSessions.remove(loginUser.getUserId());
            // 안 읽은 메시지 개수 업데이트
            updateUnreadMessageCount(loginUser.getUserId());
        }
    }

    private void handleNewSession(WebSocketSession session) {
        User loginUser = (User) session.getAttributes().get("loginUser");
        String userId = loginUser.getUserId();

        if (isUserInChatRoom(userId)) {
            try {
                // 안 읽은 메시지 개수 가져오기
                int unreadMessageCount = messageService.getUnreadMessageCount(userId);
                sendUnreadMessageCount(session, unreadMessageCount);

                // 알림 메시지 전송
                sendNotifications(session, userId);
            } catch (IOException e) {
                log.error("알림 안 감: {}", e.getMessage());
            }
        }

        userSessions.put(userId, session);
    }

    protected void sendUnreadMessageCount(WebSocketSession session, int unreadMessageCount) throws IOException {
        Map<String, Object> countMessage = new HashMap<>();
        countMessage.put("type", "unreadMessageCount");
        countMessage.put("count", unreadMessageCount);

        String jsonCountMessage = objectMapper.writeValueAsString(countMessage);
        session.sendMessage(new TextMessage(jsonCountMessage));
    }

    protected void sendNotifications(WebSocketSession session, String userId) throws IOException {
        ArrayList<String> notifications = messageService.getNotificationsForUser(userId);

        if (notifications != null && !notifications.isEmpty()) {
            for (String notification : notifications) {
                Map<String, Object> message = new HashMap<>();
                message.put("type", "notification");
                message.put("fromUserId", userId);
                message.put("content", notification);

                String jsonMessage = objectMapper.writeValueAsString(message);
                session.sendMessage(new TextMessage(jsonMessage));
            }
        }
    }

    protected void updateUnreadMessageCount(String userId) throws IOException {
        WebSocketSession session = userSessions.get(userId);

        if (session != null && session.isOpen()) {
            int unreadMessageCount = messageService.getUnreadMessageCount(userId);
            sendUnreadMessageCount(session, unreadMessageCount);
        }
    }

    private boolean isUserInChatRoom(String userId) {
        return true;
    }
}
