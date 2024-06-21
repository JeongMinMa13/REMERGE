package com.kh.reMerge.attachment.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class At {
	private int FileNo;
	private int refAno;
	private String filePath;
	private int fileLevel;
	private String originName;
	private String changeName;
	private String thumbnailPath;
	private String status;
}
