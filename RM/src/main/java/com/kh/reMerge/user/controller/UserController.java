package com.kh.reMerge.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.User;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping("login.us")
	public String loginUser(User u, HttpSession session) {
		
		User loginUser = userService.loginUser(u);
		//System.out.println(u.getUserPwd());
		//System.out.println(loginUser.getUserPwd());
		if (loginUser == null || !bcryptPasswordEncoder.matches(u.getUserPwd(), loginUser.getUserPwd())) {
			session.setAttribute("alertMsg", "로그인 실패!");
			return "user/mainLogin";

		} else {
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 성공!");
			return "user/loginHeader";
		}
		
		
		
	}
	
	@RequestMapping("logout.us")
	public String logoutMember(HttpSession session) {

		session.removeAttribute("loginUser");

		return "redirect:/";
	}
	
	@RequestMapping("insertEnrollForm.us")
	public String memberEnrollForm() {
		//System.out.println("왔나");
		return "user/userEnrollForm";
	}
	
	@PostMapping("insert.us")
	public String insertUser(User u, HttpSession session) {
		String bcrPwd = bcryptPasswordEncoder.encode(u.getUserPwd());
		u.setUserPwd(bcrPwd);
		int result = userService.insertUser(u);
		
		if (result > 0) { 
			session.setAttribute("alertMsg", "회원 가입 성공!");
			return "user/mainLogin";
		} else {
			session.setAttribute("alertMsg", "회원 가입 실패!");

			return "user/userEnrollForm";
		}
	}
	
		@ResponseBody
		@RequestMapping("checkId.us")
		public String checkId(String checkId) {
			
			int count = userService.checkId(checkId);
			
			
			String result = "";
			
			if(count>0) {
				result = "NNNNN";
			}else {
				result = "NNNNY";
			}
			//System.out.println(result);
			return result;
		}
		
		@ResponseBody
		@RequestMapping("checkPw.us")
		public String checkPw(String checkPw,String checkpwChk) {

			String resultPw = "";
			
			if(checkPw.equals(checkpwChk) ) {
				resultPw = "NNNNY";
			}else {
				resultPw = "NNNNN";
			}
			//System.out.println(resultPw);
			return resultPw;
		}
		
		

}
