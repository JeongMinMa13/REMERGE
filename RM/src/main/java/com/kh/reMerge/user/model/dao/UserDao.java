package com.kh.reMerge.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.user.model.vo.User;

@Repository
public class UserDao {

	public User loginMember(SqlSessionTemplate sqlSession, User u) {
		User loginUser = sqlSession.selectOne("userMapper.loginUser",u);
		
		return loginUser;
	}

	public int insertUser(SqlSessionTemplate sqlSession, User u) {
		int result = sqlSession.insert("userMapper.insertUser",u);

		return result;
	}

}
