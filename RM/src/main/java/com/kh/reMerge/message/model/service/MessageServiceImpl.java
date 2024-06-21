package com.kh.reMerge.message.model.service;

import java.util.ArrayList;

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
    
    
    public ArrayList<Message> getMessagesBetweenUsers(String sendId, String receiveId) {
        return messageDao.getMessagesBetweenUsers(sqlSession, sendId, receiveId);
    }
    
    public int saveMessage(Message message) {
        return messageDao.insertMessage(sqlSession, message);
    }
	
    @Override
    public boolean sendMessage(Message message) {
        int result = messageDao.sendMessage(sqlSession, message);
        return result > 0;
    }
}
