package com.kh.reMerge.feed.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.feed.model.vo.Story;

@Repository
public class StoryDao {

	//스토리 추가기능 메소드
	public int insertStory(SqlSessionTemplate sqlSession, Story s) {

		return sqlSession.insert("storyMapper.insertStory", s);
	}

	//스토리 조회 메소드
	public ArrayList<Story> selectStory(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("storyMapper.selectStory", userId);
	}

}
