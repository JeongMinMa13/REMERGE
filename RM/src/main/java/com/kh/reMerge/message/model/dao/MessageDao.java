package com.kh.reMerge.message.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.message.model.vo.Message;

@Repository
public class MessageDao {

    public void saveMessage(SqlSessionTemplate sqlSession, Message message) {
        sqlSession.insert("messageMapper.saveMessage", message);
    }

    public List<Message> getChatHistory(SqlSessionTemplate sqlSession, int messageRoomNo) {
        return sqlSession.selectList("messageMapper.getChatHistory", messageRoomNo);
    }

    public Integer getMessageRoomNo(SqlSession sqlSession, String sendId, String receiveId) {
        Map<String, String> params = new HashMap<>();
        params.put("sendId", sendId);
        params.put("receiveId", receiveId);
        System.out.println("다오 확인" + params);
        return sqlSession.selectOne("messageMapper.getMessageRoomNo", params);
    }
    
    public int createChatRoom(SqlSession sqlSession, String sendId, String receiveId) {
        Map<String, String> params = new HashMap<>();
        params.put("sendId", sendId);
        params.put("receiveId", receiveId);
        return sqlSession.insert("messageMapper.createChatRoom", params);
    }
    
    
}