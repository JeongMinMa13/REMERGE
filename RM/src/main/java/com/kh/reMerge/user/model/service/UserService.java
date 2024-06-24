package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

public interface UserService {

	int insertUser(User u);

	int checkId(String checkId);

	User loginUser(User u);

	int updateUser(User u);

	int updatePwd(User u);
	
	int deleteUser(String userPwd);

	// 메시지용 - 중구
	ArrayList<User> getAllUsers();
	
	//유저 검색
	ArrayList<User> searchUser(String searchStr);

	//내가 아닌 다른 유저 프로필을 보기 위한 조회
	User selectUser(String userId);
	
	//팔로우 신청
	int insertFollow(FollowList followList);
	
	//팔로우 되어있는지 확인하기 위한 조회
	int selectFollow(FollowList followList);
	
	//언팔로우
	int deleteFollow(FollowList followList);
	
}
