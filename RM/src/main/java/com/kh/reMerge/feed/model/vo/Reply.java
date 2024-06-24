package com.kh.reMerge.feed.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	
	private int replyNo;
	private String reContent;
	private int feedNo;
	private String userId;
	private Date createDate;
	private String status;
}
