package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

public interface MyPageService {
	//정보 수정
	int updateUser(User u);
	//비밀번호 변경
	int updatePwd(User u);
	//프로필 사진 수정
	int updateProfile(User u);
	//회원 탈퇴
	int deleteUser(String userId);
	//팔로잉 수
	int countFollowing(String fromUser);
	//팔로워 수
	int countFollower(String toUser);
	//피드 수
	int countFeed(String feedWriter);
	//팔로잉 목록
	ArrayList<FollowList> followingList(String toUser);
	
	
	

}
