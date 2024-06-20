package com.kh.reMerge.feed.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class FeedController {
	
	@GetMapping("feed.fe")
	public String feed() {
		
		return "feed/mainFeed";
	}

	
}
