package com.kh.reMerge.feed.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.feed.model.service.StoryService;
import com.kh.reMerge.feed.model.vo.Story;

//@Controller
//public class StoryController {
//	
//	@Autowired
//	private StoryService storyService;
//
//	@ResponseBody
//	@PostMapping("insertStory.fe")
//	public int insertStory(Story s) {
//		
//		return storyService.insertStory(s);
//	}
//	
//	
//}
