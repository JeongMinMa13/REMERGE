package com.kh.reMerge.user.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
import com.kh.reMerge.user.model.vo.FollowList;
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
		// System.out.println(u.getUserPwd());
		// System.out.println(loginUser.getUserPwd());
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

		return "redirect:/";
	}

	@RequestMapping("insertEnrollForm.us")
	public String memberEnrollForm() {
		// System.out.println("왔나");
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

		if (count > 0) {
			result = "NNNNN";
		} else {
			result = "NNNNY";
		}
		// System.out.println(result);
		return result;
	}

	@ResponseBody
	@RequestMapping("checkPw.us")
	public String checkPw(String checkPw, String checkpwChk) {

		String resultPw = "";

		if (checkPw.equals(checkpwChk)) {
			resultPw = "NNNNY";
		} else {
			resultPw = "NNNNN";
		}
		// System.out.println(resultPw);
		return resultPw;
	}

	// 메시지용 - 중구
	@RequestMapping("userList.us")
	public String userList(Model model) {
		ArrayList<User> userList = userService.getAllUsers();
		model.addAttribute("userList", userList);

		for (User user : userList) {

		}

		return "user/userList";
	}

	@ResponseBody
	@RequestMapping("userListAjax.us")
	public ArrayList<User> getUserListAjax() {
		return userService.getAllUsers();
	}

	// 유저 검색
	@ResponseBody
	@GetMapping("searchUser.us")
	public ArrayList<User> searchUser(String searchStr) {

		return userService.searchUser(searchStr);
	}

	// 팔로우 신청
	@ResponseBody
	@PostMapping(value = "insertFollow.us")
	public int insertFollow(FollowList followList) {

		return userService.insertFollow(followList);
	}

	// 언팔로우
	@ResponseBody
	@PostMapping("deleteFollow.us")
	public int deleteFollow(FollowList followList) {

		return userService.deleteFollow(followList);
	}

	// 마이페이지로 이동
	@RequestMapping("myPage.us")
	public String myPage(String userId, HttpSession session) {

		boolean followFlag = false;// 팔로우 되어있는지 확인하기 위한 초기화
		String myId = ((User) session.getAttribute("loginUser")).getUserId();// 로그인된 유저 아이디 추출
		User u = userService.selectUser(userId);// 선택된 유저 정보 조회
		FollowList followList = new FollowList(userId, myId);// 팔로우 정보 조회하기 위해 담기
		int result = userService.selectFollow(followList);// 팔로우 되어있는지 확인하기 위한 조회
		if (result > 0) {// 팔로우 되어 있다면 true
			followFlag = true;
		}
		System.out.println(u);
		session.setAttribute("user", u);
		session.setAttribute("followFlag", followFlag);

		return "myPage/myPage";
	}

	// 프로필 편집 페이지로 이동
	@RequestMapping("updatePage.us")
	public String updatePage(User u, Model model) {
		model.addAttribute("User", u);

		return "myPage/updatePage";
	}

	@RequestMapping("update.us")
	public String updateUser(User u, Model model, HttpSession session, MultipartFile upfile) {
		String defaultProfile = u.getProfilePath(); // 파일 저장 경로와 변경파일명 담아놓을 변수 (디폴트값)

		

		int result = userService.updateUser(u);
		if (result > 0) {
			System.out.println(result);
			System.out.println(u);
//					User Us = userService.loginUser(u);
//					session.setAttribute("loginUser", updateUs);
			session.setAttribute("alertMsg", "정보 수정 성공");
			return "myPage/myPage";
		} else {
			model.addAttribute("alertMsg", "정보 수정 실패");
			return "myPage/updatePage";
		}

	}

	// 파일 업로드 처리
	public String saveFile(MultipartFile upfile, HttpSession session) {

		String originName = upfile.getOriginalFilename();

		String ext = originName.substring(originName.lastIndexOf("."));

		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		int ranNum = (int) (Math.random() * 90000 + 10000);

		String profileChangePath = currentTime + ranNum + ext;

		System.out.println(profileChangePath);

		String savePath = session.getServletContext().getRealPath("resources/profile/");

		try {

			upfile.transferTo(new File(savePath + profileChangePath));

		} catch (IllegalStateException | IOException e) {

			e.printStackTrace();
		}

		return profileChangePath;

	}

}
