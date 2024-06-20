package com.kh.reMerge.feed.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attachment {
	private int fileNo; 
	private int refAno;
	private String filePath;
	private int fileLevel;
	private String originName;
	private String changeName;
	private String status;
}
