package com.kh.reMerge.message.model.service;

import java.util.ArrayList;

import com.kh.reMerge.message.model.vo.Message;

public interface MessageService {
    ArrayList<Message> getMessagesBetweenUsers(String sendId, String receiveId);
    
    int saveMessage(Message message);
    
    boolean sendMessage(Message message);
}
