package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.Story;
import com.kh.reMerge.user.model.dao.MypageDao;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	private MypageDao mypageDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 정보 수정
	@Override
	public int updateUser(User u) {

		return mypageDao.updateUser(sqlSession, u);
	}

	// 비밀번호 변경
	@Override
	public int updatePwd(User u) {
		// TODO Auto-generated method stub
		return mypageDao.updatePwd(sqlSession, u);
	}

	// 사진 수정
	@Override
	public int updateProfile(User u) {

		return mypageDao.updateProfile(sqlSession, u);
	}

	// 회원 탈퇴
	@Override
	public int deleteUser(String userPwd) {

		return mypageDao.deleteUser(sqlSession, userPwd);
	}

	@Override
	public int countFollowing(String fromUser) {
		
		return mypageDao.countFollowing(sqlSession, fromUser);
	}

	@Override
	public int countFollower(String toUser) {
		
		return mypageDao.countFollower(sqlSession,toUser);
	}

	@Override
	public int countFeed(String feedWriter) {
		
		return mypageDao.countFeed(sqlSession,feedWriter);
	}

	@Override
	public ArrayList<User> followingList(String userId) {
		
		return mypageDao.followingList(sqlSession,userId);
		
	}

	@Override
	public ArrayList<User> followerList(String userId) {
		
		return mypageDao.followerList(sqlSession,userId);
	}

	@Override
	public ArrayList<Feed> myFeedlist(String userId) {
		
		return mypageDao.myFeedlist(sqlSession,userId);
	}

	@Override
	public ArrayList<Feed> myFeedlike(String userId) {
		
		return mypageDao.myFeedlike(sqlSession,userId);
	}

	@Override
	public ArrayList<Feed> myFeedsave(String userId) {
		// TODO Auto-generated method stub
		return mypageDao.myFeedsave(sqlSession,userId);
		
	}
	@Override
	public ArrayList<Story> storyArchive(String userId) {
		
		return mypageDao.storyArchive(sqlSession,userId);
	}

	
	

	



	
}
