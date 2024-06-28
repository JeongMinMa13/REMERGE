package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.dao.FeedDao;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.Tag;

@Service
public class FeedServiceImpl implements FeedService {
	
	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int listcount() {
		return feedDao.listCount(sqlSession);
	}

	@Override
	public int insertFeed(Feed f) {
		return feedDao.insertFeed(sqlSession,f);
	}

	@Override
	public ArrayList<Feed> selectList(PageInfo pi) {
		
		return feedDao.selectList(sqlSession,pi);
	}

	@Override
	public ArrayList<Reply> replyList(int feedNo) {
	
		return feedDao.replyList(sqlSession,feedNo);
	}

	@Override
	public int insertReply(Reply r) {
		
		return feedDao.insertReply(sqlSession,r);
	}

	@Override
	public Feed selectFeed(int feedNo) {
		
		return feedDao.selectFeed(sqlSession,feedNo);
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	//태그 검색
	@Override
	public ArrayList<Tag> searchTag(Tag tag) {

		return feedDao.searchTag(sqlSession,tag);
	}
	
	//태그된 게시글들 조회해오기
	@Override
	public ArrayList<Feed> selectTag(Tag tag) {

		return feedDao.selectTag(sqlSession,tag);
	}

}
