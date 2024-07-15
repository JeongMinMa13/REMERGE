package com.kh.reMerge.feed.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Feed {
	private int feedNo;
	private String feedContent;
	private String feedWriter;
	private Date createDate;
	private String status;
	private int likeCount;
	private String feedLocation;
	private String changeName;
	private int shopNo;
	private List<String> tags;
	private User userProfile;
	private List<FollowList> followList;
	private List<User> userList;
	private List<FeedImg> feedImg;
}
