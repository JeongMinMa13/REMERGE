package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.reMerge.feed.model.vo.Feed;
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
	ArrayList<User> followingList(String userId);
	//팔로워 목록
	ArrayList<User> followerList(String userId);
	//내 게시물 조회
	ArrayList<Feed> myFeedlist(String userId);
	//내가 누른 좋아요 조회
	ArrayList<Feed> myFeedlike(String userId);
	

	
	
	
	
	

}
