package com.kh.reMerge.calendar.model.service;

import java.util.ArrayList;

import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.user.model.vo.User;

public interface CalendarService {

	//일정 추가
	int insertSchedule(Schedule s);
	
	//내 일정 조회
	ArrayList<Schedule> selectSchedule(String userId);
	
	//일정 상세 조회
	Schedule detailSchedule(int scheduleNo);
	
	//일정 삭제
	int deleteSchedule(int scheduleNo);
	
	//일정 수정
	int updateSchedule(Schedule s);

	//팔로우 리스트로 이동하기 위한 팔로우 리스트 조회 
	ArrayList<User> followList(String userId);
	
	//공유 캘린더 조회
	ArrayList<Schedule> selectShareSchedule(String userId);

}
