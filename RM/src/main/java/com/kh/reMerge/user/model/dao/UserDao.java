package com.kh.reMerge.user.model.dao;

import java.util.ArrayList;

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
	
	public int updateUser(SqlSessionTemplate sqlSession, User u) {
		// TODO Auto-generated method stub
		return sqlSession.update("userMapper.updateUser",u);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("userMapper.updatePwd",u);
	}

	// 메시지용 - 중구
	public ArrayList<User> getAllUsers(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("userMapper.getAllUsers");
	}

	//유저 검색
	public ArrayList<User> searchUser(SqlSessionTemplate sqlSession, String searchStr) {

		return (ArrayList)sqlSession.selectList("userMapper.searchUser",searchStr);
	}
	
}
