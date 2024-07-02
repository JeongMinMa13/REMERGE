package com.kh.reMerge.message.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.reMerge.message.model.vo.Message;

public interface MessageService {
    void saveMessage(Message message);
    
    List<Message> getChatHistory(int messageRoomNo);
    
    int getMessageRoomNo(String sendId, String receiveId);
    
    int createChatRoom(String sendId, String receiveId);
    
    
}
