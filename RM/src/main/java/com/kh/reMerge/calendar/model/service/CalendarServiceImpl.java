package com.kh.reMerge.calendar.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.calendar.model.dao.CalendarDao;
import com.kh.reMerge.calendar.model.vo.Schedule;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CalendarDao calendarDao;
	
	//일정 추가구문
	@Override
	public int insertSchedule(Schedule s) {
		
		return calendarDao.insertSchedule(sqlSession,s);
	}
	
	//일정 조회 구문
	@Override
	public ArrayList<Schedule> selectSchedule(String userId) {
		
		return calendarDao.selectSchedule(sqlSession,userId);
	}
	
	//일정 세부 조회 구문
	@Override
	public Schedule detailSchedule(int scheduleNo) {

		return calendarDao.detailSchedule(sqlSession,scheduleNo);
	}
}
