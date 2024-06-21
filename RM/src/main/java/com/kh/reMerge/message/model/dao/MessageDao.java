package com.kh.reMerge.message.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.message.model.vo.Message;

@Repository
public class MessageDao {

    public ArrayList<Message> getMessagesBetweenUsers(SqlSessionTemplate sqlSession, String sendId, String receiveId) {
        Map<String, String> params = new HashMap<>();
        params.put("sendId", sendId);
        params.put("receiveId", receiveId);

        return (ArrayList)sqlSession.selectList("message-Mapper.getMessagesBetweenUsers", params);
    }

    public int insertMessage(SqlSessionTemplate sqlSession, Message message) {
        return sqlSession.insert("message-Mapper.insertMessage", message);
    }

	public int sendMessage(SqlSessionTemplate sqlSession, Message message) {
        int result = 0;
        try {
            result = sqlSession.insert("messageMapper.sendMessage", message);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    
}
