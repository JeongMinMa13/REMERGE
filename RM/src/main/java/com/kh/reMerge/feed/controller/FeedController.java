 package com.kh.reMerge.feed.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
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
import com.kh.reMerge.feed.model.vo.FeedKeep;
import com.kh.reMerge.feed.model.vo.FeedLike;
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.ReplyLike;
import com.kh.reMerge.feed.model.vo.Tag;
import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

import oracle.jdbc.proxy.annotation.Post;


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
	public Map<String, Object> feedlist(@RequestParam(value="currentPage",defaultValue = "1")int currentPage,String userId) {
		int listCount = feedService.listcount();
		int feedLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, feedLimit);
		
		ArrayList<Feed> list = feedService.selectList(pi,userId);
		  for (Feed feed : list) {
		        List<String> tags = feedService.getTagsByFeedNo(feed.getFeedNo());
		        feed.setTags(tags);
		        
		        User userProfile = feedService.getUserProfile(feed.getFeedWriter()); // 사용자 프로필 정보 가져오기
		        feed.setUserProfile(userProfile);
		        
		    }
		  
		Map<String, Object> result = new HashMap<>();
		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}
	
	//게시글 넣기
	@PostMapping("insert.fe")
	public String insertFeed(Feed f, @RequestPart MultipartFile upfile, HttpSession session, @RequestParam(value="tags", required=false) String tags) {
		if (!upfile.getOriginalFilename().equals("")) {
			String changeName = saveFile(upfile,session);
			f.setOriginName(upfile.getOriginalFilename());
			f.setChangeName("resources/uploadFiles/"+changeName);
		}
		
		int result = feedService.insertFeed(f);
		
		if (result > 0) {// 게시글 작성 성공
			int feedNo = feedService.selectFeedNo();
			f.setFeedNo(feedNo);
			
			if (tags != null && !tags.isEmpty()) {
	            String[] tagArray = tags.split(",");
	            List<Tag> tagList = new ArrayList<>();
	            for (String tagContent : tagArray) {
	                Tag tag = new Tag();
	                tag.setTagContent(tagContent.trim()); //앞 뒤 공백을 제거해준대요
	                tag.setRefFno(f.getFeedNo());
	                tagList.add(tag);
	                feedService.insertTag(tag);
	            }
	        }
			
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
	@RequestMapping("replyList.fe")
	public Map<String, Object> replyList(@RequestParam("feedNo") int feedNo){
		
		ArrayList<Reply> rList = feedService.replyList(feedNo);
		
		 Map<String, Object> map = new HashMap<>();
		 map.put("rList", rList);
		
		return map;
		
	}
	
	//댓글 작성 메소드
	@ResponseBody
	@PostMapping("insertReply.fe")
	public int insertReply(Reply r) {
		int result = feedService.insertReply(r);
		
		return result;
	}
	
	//두번째 댓글 작성 메소드
	@ResponseBody
	@PostMapping("insertModal.fe")
	public int insertModal(Reply r) {
		System.out.println(r);
		int result = feedService.insertReply(r);
		
		return result;
	}
	
	//게시물 디테일
	@ResponseBody
	@PostMapping("detail.fe")
	public Map<String, Object> feedDetail(int feedNo){
		
		Feed f = feedService.selectFeed(feedNo);
		
		ArrayList<Reply> rList = feedService.replyList(feedNo);
		
		Map<String, Object> result = new HashMap<>();
	    result.put("f", f);
	    result.put("rList", rList);
	    
	    return result;
		
	}
	
	//게시물 좋아요
	@ResponseBody
	@PostMapping("feedLike.fe")
	 public Map<String, Object> likeFeed(@RequestParam int feedNo, @RequestParam String userId) {
		FeedLike fl = new FeedLike();
		
		fl.setFeedNo(feedNo);
        fl.setUserId(userId);
        
        int likeCheck = feedService.likeCheck(feedNo, userId);
        Map<String, Object> result = new HashMap<>();
        
        if (likeCheck > 0) {
            feedService.deleteLike(fl);
            feedService.removeCount(feedNo);
            result.put("status", "unliked");
        } else {
            feedService.insertLike(fl);
            feedService.addCount(feedNo);
            result.put("status", "liked");
        }
		
        int likeCount = feedService.likeCount(feedNo);
        result.put("likeCount", likeCount);

		return result;
	}
	
	//좋아요 상태 확인
	@ResponseBody
	@RequestMapping("likeStatus.fe")
		public Map<String,Object> likeStatus(@RequestParam int feedNo, @RequestParam String userId){
			Map<String, Object> result = new HashMap<>();
		    try {
		        int likeCheck = feedService.likeCheck(feedNo, userId);
		        result.put("status", likeCheck > 0 ? "liked" : "unliked"); //좋아요 됐고 안 됐고 반별
	
		        int likeCount = feedService.likeCount(feedNo);
		        result.put("likeCount", likeCount);
		    } catch (Exception e) {
		        result.put("error", e.getMessage());
		    }
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
	

	
	//게시글 삭제
	@PostMapping("delete.fe")
	public String deleteFeed(int feedNo,String filePath,HttpSession session) {
		
		int result = feedService.deleteFeed(feedNo);
		
		if(result>0) {
			if(!filePath.equals("")) {//넘어온 파일정보가 빈문자열이 아닐때(즉,있을때)
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
				session.setAttribute("alertMsg", "게시글 삭제 성공!");
		}else {
				session.setAttribute("alertMsg", "게시글 삭제 실패");
		}
		return "redirect:feed.fe";
	}
	
	//댓글 좋아요
	@ResponseBody
	@PostMapping("replyLike.fe")
	public Map<String, Object> likeReply(@RequestParam int replyNo, @RequestParam String userId) {
	    ReplyLike rl = new ReplyLike();
	    rl.setReplyNo(replyNo);
	    rl.setUserId(userId);

	    int likeCheck = feedService.checkReplyLike(replyNo, userId);
	    Map<String, Object> result = new HashMap<>();

	    if (likeCheck > 0) {
	        feedService.deleteReplyLike(rl);
	        result.put("status", "unliked");
	    } else {
	        feedService.insertReplyLike(rl);
	        result.put("status", "liked");
	    }

	    int likeCount = feedService.countReplyLikes(replyNo);
	    result.put("likeCount", likeCount);

	    return result; 
	
	}
	
	//댓글 좋아요 상태 확인
	@ResponseBody
	@GetMapping("replyLikeStatus.fe")
	public Map<String,Object> replyLikeStatus(@RequestParam int replyNo, @RequestParam String userId){
		Map<String, Object> result = new HashMap<>();
	    try {
	        int likeCheck = feedService.checkReplyLike(replyNo, userId);
	        result.put("status", likeCheck > 0 ? "liked" : "unliked"); //좋아요 됐고 안 됐고 반별

	        int likeCount = feedService.likeCount(replyNo);
	        result.put("likeCount", likeCount);
	    } catch (Exception e) {
	        result.put("error", e.getMessage());
	    }
	    return result;
	
	}
	
	//게시물 저장
	@ResponseBody
	@PostMapping("saveFeed.fe")
	public Map<String,Object> saveFeed(@RequestParam int feedNo, @RequestParam String userId){
		FeedKeep feedKeep = new FeedKeep(feedNo,userId);
		
		int saveCheck = feedService.checkFeedSave(feedNo,userId);
		Map<String,Object> result = new HashMap<>();
		
		 if (saveCheck > 0) {
		        feedService.unsaveFeed(feedKeep);
		        result.put("status", "unsaved");
		    } else {
		        feedService.saveFeed(feedKeep);
		        result.put("status", "saved");
		    }

		    return result;
	}
	
	//게시물 저장 상태 확인
	@ResponseBody
    @RequestMapping("saveStatus.fe")
    public Map<String, Object> saveStatus(@RequestParam int feedNo, @RequestParam String userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            int saveCheck = feedService.checkFeedSave(feedNo, userId);
            result.put("status", saveCheck > 0 ? "saved" : "unsaved");
        } catch (Exception e) {
            result.put("error", e.getMessage());
        }
        return result;
	}
	
	//팔로우 안 한 리스트 뽑아주기
	@ResponseBody
	@RequestMapping("recommend.fe")
	public List<User> recommend(@RequestParam String userId){
		
		System.out.println(userId);
		List<User> recommend = feedService.getRecommend(userId, 5); //5명만 추천
		
		System.out.println(recommend);
		
		return recommend;
	}
	
	//팔로우 하기

	
	
	
	
}
	
	
	
	

