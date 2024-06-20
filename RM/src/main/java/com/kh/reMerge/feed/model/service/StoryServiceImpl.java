package com.kh.reMerge.feed.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.reMerge.feed.model.dao.StoryDao;
import com.kh.reMerge.feed.model.vo.Story;

public class StoryServiceImpl implements StoryService {

	@Autowired
	private StoryDao storyDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertStory(Story s) {
		
		return storyDao.insertStory(sqlSession,s);
	}
}
