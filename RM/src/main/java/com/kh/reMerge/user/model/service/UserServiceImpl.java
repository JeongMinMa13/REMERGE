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
	public User loginMember(User u) {
		User loginUser = userDao.loginMember(sqlSession, u);
		return loginUser;
	}

	@Override
	public int insertUser(User u) {
		int result = userDao.insertUser(sqlSession, u);

		return result;
	}

}
