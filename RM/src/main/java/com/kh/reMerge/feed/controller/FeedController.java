package com.kh.reMerge.feed.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.common.template.Pagination;
import com.kh.reMerge.feed.model.service.FeedService;
import com.kh.reMerge.feed.model.vo.Feed;


@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	@GetMapping("feed.fe")
	public String feed() {
		
	return "feed/mainFeed";
	}
	
	@ResponseBody
	@PostMapping("feedList.fe")
	public Map<String, Object> feedlist(@RequestParam(value="currentPage",defaultValue = "1")int currentPage) {
		
		int listCount = feedService.listcount();
		int feedLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, feedLimit);
		
		ArrayList<Feed> list = feedService.selectList(pi);
		
		Map<String, Object> result = new HashMap<>();
		result.put("pi", pi);
		result.put("list", list);
		
		
		return result;
	}
	
	
		
	
	
	
	

	@PostMapping("insert.fe")
	public String insertFeed(Feed f, @RequestPart MultipartFile upfile, HttpSession session) {
		
		if (!upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upfile,session);
			f.setOriginName(upfile.getOriginalFilename());
			f.setChangeName("resources/uploadFiles/"+changeName);
		}
		
		int result = feedService.insertFeed(f);
		
		if (result > 0) {// 게시글 작성 성공
			session.setAttribute("alertMsg", "게시글이 등록 되었습니다.");
			return "redirect:feed.fe";
		} else {
			session.setAttribute("alertMsg", "게시글 등록이 실패했습니다.");
			
			return "redirect:feed.fe";
		}
	
		
	}
	
	//파일 업로드 처리 메소드(재활용)
		public String saveFile(MultipartFile upfile,HttpSession session) {
			
			// 파일명 수정작업하기
			// 1.원본파일명 추출
			String originName = upfile.getOriginalFilename();

			// 2.시간형식 문자열로 만들기
			// 20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

			// 3.확장자 추출하기 . 찾아서 뒤로 잘라내기
			String ext = originName.substring(originName.lastIndexOf("."));

			// 4.랜덤값 5자리 뽑기
			int ranNum = (int)(Math.random()*90000 + 10000);

			// 5.하나로 합쳐주기
			String changeName = currentTime+ranNum+ext;

			// 6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");

			// 7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
			try {
				upfile.transferTo(new File(savePath + changeName));

			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return changeName;
		}
		
		
	
	

	
}
