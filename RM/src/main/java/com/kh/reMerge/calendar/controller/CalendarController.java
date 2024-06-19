package com.kh.reMerge.calendar.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.calendar.model.service.CalendarService;
import com.kh.reMerge.calendar.model.vo.Schedule;


	@Controller
	public class CalendarController {
		
		@Autowired
		private CalendarService cs;
		
		@ResponseBody
		@PostMapping(value="insertSchedule.sc",produces="application/json;charset=UTF-8")
		public int insertSchedule(Schedule s) {
			System.out.println(s);
			s.setUserId("admin");
			int result = cs.insertSchedule(s);
			return result;
		}
		
		@ResponseBody
		@GetMapping(value="selectSchedule.sc",produces="application/json;charset=UTF-8")
		public ArrayList<Schedule> selectSchedule(String userId){
			userId="admin";
			return cs.selectSchedule(userId);
		}
		
		@ResponseBody
		@GetMapping(value="detailSchedule.sc",produces="application/json;charset=UTF-8")
		public Schedule detailSchedule(int scheduleNo) {
			
			return cs.detailSchedule(scheduleNo);
		}
	
		@GetMapping("deleteSchedule.sc")
		public String deleteSchedule(int scheduleNo) {
			
			return "/calendar/main";
		}
}
