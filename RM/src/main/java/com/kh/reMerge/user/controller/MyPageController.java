package com.kh.reMerge.user.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;
@Controller
public class MyPageController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;



//마이페이지로 이동
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
	
	//비밀번호 변경
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
	//프로필 사진 제외한 정보 수정
	@RequestMapping("update.us")
	public String updateUser(User u, Model model, HttpSession session) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		 if (loginUser != null) {
		        u.setProfileOriginName(loginUser.getProfileOriginName());
		        u.setProfileChangePath(loginUser.getProfileChangePath());
		    }


		int result = userService.updateUser(u);
		if (result > 0) {
			
			User updateUs = userService.loginUser(u);
			session.setAttribute("loginUser", updateUs);
			session.setAttribute("alertMsg", "정보 수정 성공");
			return "myPage/myPage";
		} else {
			model.addAttribute("alertMsg", "정보 수정 실패");
			return "myPage/updatePage";
		}

	}
	//프로필 사진 정보 수정
		@RequestMapping("updateProfile.us")
		public String updateProfile(User u,HttpSession session, MultipartFile upfile) {
			String defaultProfile = "";
			
			if (!upfile.getOriginalFilename().equals("")) {
				if (u.getProfileOriginName() != null) { // 원래 파일이 비어있지 않은 경우
	
					defaultProfile = u.getProfileChangePath(); // 프로필 경로로 설정
				} else {
					String profileChangePath = saveFile(upfile, session);
					System.out.println(profileChangePath);
					// 새 사진 등록
					u.setProfileOriginName(upfile.getOriginalFilename());
					u.setProfileChangePath("resources/profile/" + profileChangePath);
	
				}
			}
			System.out.println(u);
	
				int result = userService.updateProfile(u);
				System.out.println(result);
				if (result > 0) {
					User updateProfile = userService.loginUser(u);
					session.setAttribute("loginUser", updateProfile);
					session.setAttribute("alertMsg", "사진 수정 성공");
					
					return "myPage/myPage";
				} else {
					session.setAttribute("alertMsg", "사진 수정 실패");
					return "myPage/updatePage";
				
			}
			
		}

		//파일 업로드 처리 메소드(재활용)
		public String saveFile(MultipartFile upfile
							  ,HttpSession session) {
			
			//파일명 수정작업하기 
			//1.원본파일명 추출
			String profileOriginName = upfile.getOriginalFilename();
			
			//2.시간형식 문자열로 만들기 
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기 
			String ext = profileOriginName.substring(profileOriginName.lastIndexOf("."));
			
			//4.랜덤값 5자리 뽑기 
			int ranNum = (int)(Math.random()*90000+10000);
			
			//5.하나로 합쳐주기 
			String profileChangePath = currentTime+ranNum+ext;
			
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/profile/");
			
			try {
				//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
				upfile.transferTo(new File(savePath+profileChangePath));
				System.out.println(savePath);
				
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return profileChangePath;
			
			
		}
}