package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
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
	
	
	
	
}
