package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.feed.model.dao.StoryDao;
import com.kh.reMerge.feed.model.vo.Story;

@Service
public class StoryServiceImpl implements StoryService {

	@Autowired
	private StoryDao storyDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertStory(Story s) {
		
		return storyDao.insertStory(sqlSession,s);
	}
	
	@Override
	public ArrayList<Story> selectStory(String userId) {

		return storyDao.selectStory(sqlSession,userId);
	}
}
