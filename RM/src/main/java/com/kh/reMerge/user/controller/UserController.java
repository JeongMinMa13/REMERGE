package com.kh.reMerge.user.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
			return "redirect:/feed.fe";
		}
		
		
		
	}
	
	@RequestMapping("logout.us")
	public String logoutMember(HttpSession session) {

		session.removeAttribute("loginUser");

		return "user/mainLogin";
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
			session.setAttribute("alertMsg", "회원 가입 성공!!");
			return "user/mainLogin";
		} else {
			session.setAttribute("alertMsg", "회원 가입 실패!!");

			return "user/userEnrollForm";
		}
	}
	
		@ResponseBody
		@RequestMapping("checkId.us")
		public String checkId(String checkId,HttpSession session) {
			
			int count = userService.checkId(checkId);
			
			
			String result = "";
			
			if(count>0) {
				session.setAttribute("alertMsg", "중복된 아이디가 있습니다. 실패!!");
				result = "NNNNN";
				
			}else {
				result = "NNNNY";
				session.setAttribute("alertMsg", "중복된 아이디가 없습니다.");
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
		
		// 마이페이지로 이동
		@RequestMapping("mypage.us")
		public String myPage() {
			return "myPage/myPage";
		}

		// 프로필 편집 페이지로 이동
		@RequestMapping("updatePage.us")
		public String updatePage() {
			return "myPage/updatePage";
		}

		@RequestMapping("update.us")
		public String updateUser(User u, Model model, HttpSession session) {

			System.out.println(u);
			int result = userService.updateUser(u);

			if (result > 0) {

				User updateUs = userService.loginUser(u);
				session.setAttribute("loginUser", updateUs);
				session.setAttribute("alertMsg", "정보 수정 성공");

				System.out.println(result);
				return "myPage/myPage";

			} else {
				model.addAttribute("alertMsg", "정보 수정 실패");
				return "myPage/updatePage";
			}
		}

		@PostMapping("updatePwd.us")
		public String updatePwd(User u, Model model,String updatePwd, HttpSession session) {
			String bcrPwd = bcryptPasswordEncoder.encode(updatePwd);
			u.setUserPwd(bcrPwd);
			int result = userService.updatePwd(u);
			
			if(result>0) {
				User updateUser = userService.loginUser(u);
				session.setAttribute("loginUser", updateUser);
				session.setAttribute("alertMsg", "비밀번호 변경 성공");
				
			}else {
				model.addAttribute("alertMsg","비밀번호 변경 실패");
			}
			
			return "user/mainLogin";
			
		}

		private String saveFile(MultipartFile upfile, HttpSession session) {
			String profilePath=upfile.getOriginalFilename();
			
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			
			return profilePath;
		}

		@RequestMapping("delete.us")
		public String deleteUser(String userPwd, HttpSession session, Model model) {
			User loginUser = ((User) session.getAttribute("loginUser"));
			String encPwd = loginUser.getUserPwd();
			String userId = loginUser.getUserId();

			int result = userService.deleteUser(userPwd);
			if (bcryptPasswordEncoder.matches(userPwd, encPwd)) {

				if (result > 0) {
					session.removeAttribute("loginUser"); // 로그인 정보 삭제
					session.setAttribute("alertMsg", "회원탈퇴가 완료되었습니다.");
					return "redirect:/";
				} else {
					// 탈퇴 실패시 - 에러페이지로 이동
					model.addAttribute("errorMsg", "회원 탈퇴 실패");
					return "myPage/myPage";
				}

			} else {// 비밀번호를 잘못 입력한 경우
				session.setAttribute("alertMsg", "비밀번호 입력 오류!");
				return "user/mainLogin";
			}

		}

		
		
		// 메시지용 - 중구
		@RequestMapping("userList.us")
		public String userList(Model model) {
		    ArrayList<User> userList = userService.getAllUsers();
		    model.addAttribute("userList", userList);
		    
		    for (User user : userList) {
		        System.out.println(user);
		    }
		    return "user/userList";
		}
		@ResponseBody
		@RequestMapping("userListAjax.us")
		public ArrayList<User> getUserListAjax() {
		    return userService.getAllUsers();
		}
		
		//유저 검색
		@ResponseBody
		@GetMapping("searchUser.us")
		public ArrayList<User> searchUser(String searchStr){
			
			return userService.searchUser(searchStr);
		}
			
		

}
