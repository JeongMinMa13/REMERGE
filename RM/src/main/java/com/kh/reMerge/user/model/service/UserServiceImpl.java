package com.kh.reMerge.user.model.service;

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

}
