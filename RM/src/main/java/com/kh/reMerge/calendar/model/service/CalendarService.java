package com.kh.reMerge.calendar.model.service;

import java.util.ArrayList;

import com.kh.reMerge.calendar.model.vo.Schedule;

public interface CalendarService {

	int insertSchedule(Schedule s);
	
	ArrayList<Schedule> selectSchedule(String userId);
	
	Schedule detailSchedule(int scheduleNo);
}
