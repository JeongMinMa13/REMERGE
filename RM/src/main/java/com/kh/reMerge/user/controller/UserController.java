package com.kh.reMerge.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public ModelAndView loginMember(User u, ModelAndView mv, HttpSession session) {
		
		User loginUser = userService.loginMember(u);
		
		if (loginUser == null || !bcryptPasswordEncoder.matches(u.getUserPwd(), loginUser.getUserPwd())) {

			mv.addObject("errorMsg", "로그인 실패");
			mv.setViewName("redirect:/");

		} else {
			session.setAttribute("alertMsg", "로그인 성공!");
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("common/loginHeader");
		}
		
		
		return mv;
		
	}
	
	@RequestMapping("logout.us")
	public String logoutMember(HttpSession session) {

		session.removeAttribute("loginUser");

		return "redirect:/";
	}
	
	@RequestMapping("insertEnrollForm.us")
	public String memberEnrollForm() {
		System.out.println("왔나");
		return "user/userEnrollForm";
	}
	
	@PostMapping("insert.us")
	public String insertUser(User u, HttpSession session, ModelAndView mv) {
		String encPwd = bcryptPasswordEncoder.encode(u.getUserPwd());
		u.setUserPwd(encPwd);
		int result = userService.insertUser(u);
		
		if (result > 0) { 
			session.setAttribute("alertMsg", "회원 가입 성공!");
			return "redirect:/";
		} else {
			mv.addObject("errorMsg", "회원 가입 실패");

			return "common/errorPage";
		}
	}
}
