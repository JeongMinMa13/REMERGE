package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import com.kh.reMerge.feed.model.vo.Story;

public interface StoryService {
	
	int insertStory(Story s);

	ArrayList<Story> selectStory(String userId);
}
