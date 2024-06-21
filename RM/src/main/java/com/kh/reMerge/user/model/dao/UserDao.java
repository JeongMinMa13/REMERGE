package com.kh.reMerge.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.user.model.vo.User;

@Repository
public class UserDao {

	public User loginUser(SqlSessionTemplate sqlSession, User u) {
		User loginUser = sqlSession.selectOne("userMapper.loginUser",u);
		
		return loginUser;
	}

	public int insertUser(SqlSessionTemplate sqlSession, User u) {

		return sqlSession.insert("userMapper.insertUser",u);
	}

	public int checkId(SqlSessionTemplate sqlSession, String checkId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("userMapper.checkId",checkId);
	}
	
	


}
