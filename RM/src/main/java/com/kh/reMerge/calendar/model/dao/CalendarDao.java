package com.kh.reMerge.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.calendar.model.vo.Schedule;

@Repository
public class CalendarDao {

	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		
		return sqlSession.insert("calendarMapper.insertSchedule", s);
	}

	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("calendarMapper.selectSchedule",userId);
	}

	public Schedule detailSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {

		return sqlSession.selectOne("calendarMapper.detailSchedule",scheduleNo);
	}

}
