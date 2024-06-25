package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.feed.model.dao.StoryDao;
import com.kh.reMerge.feed.model.vo.History;
import com.kh.reMerge.feed.model.vo.Story;

@Service
public class StoryServiceImpl implements StoryService {

	@Autowired
	private StoryDao storyDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//타이머 작동을 위한 스토리 추가 전 순번 조회해오기 
	@Override
	public int selectSequnece() {
		
		return storyDao.selectSequence(sqlSession);
	}
	
	//스토리 추가
	@Override
	public int insertStory(Story story) {
		
		return storyDao.insertStory(sqlSession,story);
	}
	
	//스토리 조회해오기
	@Override
	public ArrayList<Story> selectStory(String userId) {

		return storyDao.selectStory(sqlSession,userId);
	}
	
	//24시간 후 자동 비활성화
	@Override
	public int updateStoryStatus(Story story) {

		return storyDao.updateStoryStatus(sqlSession,story);
	}
	
	//스토리 시청 기록 넣기
	@Override
	public int insertHistory(History history) {

		return storyDao.insertHistory(sqlSession,history);
	}
	
}
