package com.kh.reMerge.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class CalendarDao {

	//일정 추가
	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		
		return sqlSession.insert("calendarMapper.insertSchedule", s);
	}

	//일정 조회
	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("calendarMapper.selectSchedule",userId);
	}

	//일정 상세조회
	public Schedule detailSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {

		return sqlSession.selectOne("calendarMapper.detailSchedule",scheduleNo);
	}

	//일정 삭제
	public int deleteSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {

		return sqlSession.delete("calendarMapper.deleteSchedule", scheduleNo);
	}

	//일정 수정
	public int updateSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		
		return sqlSession.update("calendarMapper.updateSchedule",s);
	}
	
	//팔로우 리스트로 이동하기 위한 팔로우 리스트 조회 
	public ArrayList<User> followList(SqlSessionTemplate sqlSession, String userId) {
		
		return (ArrayList)sqlSession.selectList("calendarMapper.followList", userId);
	}

	//공유 캘린더 조회
	public ArrayList<Schedule> selectShareSchedule(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("calendarMapper.selectShareSchedule", userId);
	}


}
