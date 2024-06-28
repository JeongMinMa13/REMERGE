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
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.Tag;


@Controller
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	//메인페이지
	@GetMapping("feed.fe")
	public String feed() {
		
	return "feed/mainFeed";
	}
	
	//리스트 조회
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
	
	//게시글 넣기
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
	
	//댓글 목록 조회
	@ResponseBody
	@RequestMapping(value="replyList.fe",produces = "application/json;charset=UTF-8")
	public ArrayList<Reply> replyList(int feedNo,Model model){
		
		ArrayList<Reply> rList = feedService.replyList(feedNo);
		
		model.addAttribute("feedNo",feedNo);
		model.addAttribute("rList",rList);
		
		
		return rList;
		
	}
	
	//댓글 작성 메소드
	@ResponseBody
	@RequestMapping("insertReply.fe")
	public int insertReply(Reply r) {
		
		int result = feedService.insertReply(r);
		
		return result;
	}
	
	//게시물 디테일
	@ResponseBody
	@PostMapping("detail.fe")
	public Map<String, Object> feedDetail(int feedNo){
		
		Feed f = feedService.selectFeed(feedNo);
		
		ArrayList<Reply> replyList = feedService.replyList(feedNo);
		
		Map<String, Object> result = new HashMap<>();
	    result.put("f", f);
	    result.put("replyList", replyList);
	    
	    
	    return result;
		
		
	}
	
		
		
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//태그 검색
	@ResponseBody
	@GetMapping("searchTag.fe")
	public ArrayList<Tag> searchTag(Tag tag){
		tag.setTagContent(tag.getTagContent().replace("#",""));//#제거 하기 
		if(tag.getTagContent().length()>0) {
			return feedService.searchTag(tag);
		}else {
			return null;
		}
	}
	
	//태그 검색창에서 클릭 또는 게시글에서 태그 클릭시 해당하는 태그 리스트 보여주는 뷰로 이동
	@GetMapping("selectTag.fe")
	public String selectTag(Tag tag, HttpSession session) {
		ArrayList<Feed> tagList = feedService.selectTag(tag);
		
		session.setAttribute("tagList", tagList);
		session.setAttribute("tag", tag);
		
		return "/feed/tagDetail";
	}
	
	
	
	
}
