package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

public interface UserService {

	int insertUser(User u);

	int checkId(String checkId);

	User loginUser(User u);


	// 메시지용 - 중구
	ArrayList<User> getAllUsers();
	
	//유저 검색
	ArrayList<User> searchUser(String searchStr);

	
	//팔로우 신청
	int insertFollow(FollowList followList);
	
	
	//언팔로우
	int deleteFollow(FollowList followList);
	//내가 아닌 유저 정보 조회해오기
	User selectUser(String userId);
	//팔로우 목록
	int selectFollow(FollowList followList);





	
	
	
}
