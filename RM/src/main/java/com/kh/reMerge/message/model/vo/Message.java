package com.kh.reMerge.message.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Message {
	private String messageNo; 
	private int messageRoomNo;
	private String sendId;
	private String receiveId;
	private String sendTile;
	private String readTime;
	private String content;
	private String photo;
	private String readCheck;
	
	// 현재 사용자의 메세지 상대 nick을 담는다.
	private String other_nick;
	
	// 현재 사용자의 메세지 상대 profile을 담는다.
	private String profile;
	
	// 현재 사용자 nick
	private String nick;
	
	// 안읽은 메세지 갯수 
	private int unread;
}
