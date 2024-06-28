package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.Tag;


public interface FeedService {
	
	//게시글 총 개수
	int listcount();
	
	//게시글 작성
	int insertFeed(Feed f);
	
	//게시글 목록 
	ArrayList<Feed> selectList(PageInfo pi);
	
	//댓글 목록조회
	ArrayList<Reply> replyList(int feedNo);

	
	
	
	
	
	
	
	
	
	//태그 검색
	ArrayList<Tag> searchTag(Tag tag);

	//태그된 게시글 조회해오기
	ArrayList<Feed> selectTag(Tag tag);
	
	//댓글 작성
	int insertReply(Reply r);
	
	//게시글 디테일
	Feed selectFeed(int feedNo);
	
	
	
	
}
