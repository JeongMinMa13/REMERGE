package com.kh.reMerge.message.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
	private int messageNo;			//	MESSAGE_NO NUMBER PRIMARY KEY,
	private int messageRoomNo;			//    MESSAGEROOM_NO NUMBER NOT NULL,
	private String sendId;			//    SEND_ID VARCHAR2(30) NOT NULL,
	private String receiveId;			//    RECEIVE_ID VARCHAR2(30) NOT NULL,
	private Date sendTime;			//    SEND_TIME DATE NOT NULL,
	private Date readTime;			//    READ_TIME DATE,
	private String content;			//    CONTENT VARCHAR2(200) NOT NULL,
	private String photo;			//    PHOTO VARCHAR2(200),
	private int readCheck;			//    READ_CHECK NUMBER(1) NOT NULL,
}