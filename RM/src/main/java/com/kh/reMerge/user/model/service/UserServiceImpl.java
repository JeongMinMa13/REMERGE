package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.user.model.dao.UserDao;
import com.kh.reMerge.user.model.vo.User;

@Service
public class UserServiceImpl implements UserService {

	
	@Autowired
	private UserDao userDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public User loginUser(User u) {
		User loginUser = userDao.loginUser(sqlSession, u);
		return loginUser;
	}

	@Override
	public int insertUser(User u) {
		

		return userDao.insertUser(sqlSession, u);
	}

	@Override
	public int checkId(String checkId) {
		//System.out.println(checkId);
		//System.out.println(userDao.checkId(sqlSession, checkId));
		return userDao.checkId(sqlSession, checkId);
	}
	
	@Override
	public int updateUser(User u) {
		// TODO Auto-generated method stub
		return userDao.updateUser(sqlSession, u);
	}
	
	@Override
	public int updatePwd(User u) {
		// TODO Auto-generated method stub
		return userDao.updatePwd(sqlSession, u);
	}
	
	// 메시지용 - 중구
	@Override
	public ArrayList<User> getAllUsers() {
		return userDao.getAllUsers(sqlSession);
	}

	//유저 검색
	@Override
	public ArrayList<User> searchUser(String searchStr) {

		return userDao.searchUser(sqlSession,searchStr);
	}
	@Override
	public int deleteUser(String userPwd) {
		// TODO Auto-generated method stub
		return 0;
	}

}
