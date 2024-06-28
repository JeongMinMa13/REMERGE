package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.FeedLike;
import com.kh.reMerge.feed.model.vo.Reply;


public interface FeedService {
	
	//게시글 총 개수
	int listcount();
	
	//게시글 작성
	int insertFeed(Feed f);
	
	//게시글 목록 
	ArrayList<Feed> selectList(PageInfo pi);
	
	//댓글 목록조회
	ArrayList<Reply> replyList(int feedNo);
	
	//댓글 작성
	int insertReply(Reply r);
	
	//게시글 디테일
	Feed selectFeed(int feedNo);
	
	//게시글 좋아요
	int insertLike(FeedLike fl);
	
	//좋아요 취소
	int deleteLike(FeedLike fl);
	
	//좋아요 수 증가
	int addCount(int feedNo);
	
	//좋아요 감소
	int removeCount(int feedNo);
	
	//좋아요 여부
	int likeCheck(int feedNo,String userId);
	
	//좋아요 수 조회
	int likeCount(int feedNo);
	
	
	
	
}
