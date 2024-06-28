package com.kh.reMerge.calendar.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.calendar.model.service.CalendarService;
import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.user.model.vo.User;


	@Controller
	public class CalendarController {
		
		@Autowired
		private CalendarService cs;
		
		//캘린더 페이지 이동
		@GetMapping("calendar.sc")
		public String calendar() {
			
			return "calendar/main";
		}
		
		//일정 추가
		@ResponseBody
		@PostMapping(value="insertSchedule.sc",produces="application/json;charset=UTF-8")
		public int insertSchedule(Schedule s) {
//			System.out.println(s);
			int result = cs.insertSchedule(s);
			return result;
		}
		
		//캘린더 페이지에서 일정 조회
		@ResponseBody
		@GetMapping(value="selectSchedule.sc",produces="application/json;charset=UTF-8")
		public ArrayList<Schedule> selectSchedule(String userId){

			return cs.selectSchedule(userId);
		}
		
		//일정 클릭시 상세 조회
		@ResponseBody
		@GetMapping(value="detailSchedule.sc",produces="application/json;charset=UTF-8")
		public Schedule detailSchedule(int scheduleNo) {
			
			return cs.detailSchedule(scheduleNo);
		}
	
		//일정 삭제
		@GetMapping("deleteSchedule.sc")
		public String deleteSchedule(int scheduleNo ,HttpSession session) {
			
//			System.out.println(scheduleNo); //넘어오는지 확인
			int result = cs.deleteSchedule(scheduleNo);
			if(result>0) {
				session.setAttribute("alertMsg", "성공적으로 삭제 되었습니다.");
				return "redirect:calendar.sc";
			}else{
				session.setAttribute("alertMsg", "삭제 되지 않았습니다. 관리자에게 문의하세요.");
				return "redirect:calendar.sc";
			}
		}
		
		//일정 수정
		@PostMapping("updateSchedule.sc")
		public String updateSchedule(Schedule s,HttpSession session) {
//			System.out.println(s);
			int result = cs.updateSchedule(s);
			if(result>0) {
				session.setAttribute("alertMsg", "성공적으로 수정 되었습니다.");
				return "redirect:calendar.sc";
			}else{
				session.setAttribute("alertMsg", "수정 되지 않았습니다. 관리자에게 문의하세요.");
				return "redirect:calendar.sc";
			}
			
		}
		
		//캘린더 팔로우 리스트 페이지로 이동
		@GetMapping("followList.sc")
		public String followList(String userId,HttpSession session) {
			
			ArrayList<User> followList = cs.followList(userId);
			session.setAttribute("followList", followList);
			
			return "/calendar/calendarFollowList";
		}
		
		//공유 캘린더 버튼 눌렸을때 팔로우된 유저 스케줄 조회해서 페이지 이동
		@GetMapping("shareCalendar.sc")
		public String shareCalendar(String userId,HttpSession session) {
			
			ArrayList<Schedule> list = cs.selectShareSchedule(userId);
			session.setAttribute("list", list);
			
			return "/calendar/shareCalendar";
		}
		
}
