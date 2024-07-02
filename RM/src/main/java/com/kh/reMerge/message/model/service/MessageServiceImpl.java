package com.kh.reMerge.message.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.message.model.dao.MessageDao;
import com.kh.reMerge.message.model.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private MessageDao messageDao;

    @Override
    public void saveMessage(Message message) {
        messageDao.saveMessage(sqlSession, message);
    }

    @Override
    public List<Message> getChatHistory(int messageRoomNo) {
        return messageDao.getChatHistory(sqlSession, messageRoomNo);
    }

    @Override
    public int getMessageRoomNo(String sendId, String receiveId) {
        Integer messageRoomNo = messageDao.getMessageRoomNo(sqlSession, sendId, receiveId);
        return (messageRoomNo != null) ? messageRoomNo : 0;
    }
    
    @Override
    public int createChatRoom(String sendId, String receiveId) {
        int messageRoomNo = messageDao.createChatRoom(sqlSession, sendId, receiveId);
        return messageRoomNo;
    }
    
    
}