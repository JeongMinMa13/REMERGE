package com.kh.reMerge.feed.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.FeedLike;
import com.kh.reMerge.feed.model.vo.Reply;

@Repository
public class FeedDao {

	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("feedMapper.listCount");
	}
	
	//게시글 작성
	public int insertFeed(SqlSessionTemplate sqlSession,Feed f) {
		
		return sqlSession.insert("feedMapper.insertFeed",f);
	}
	
	//게시글 목록
	public ArrayList<Feed> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getFeedLimit();
		
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectList", null, rowBounds);
	}
	
	//댓글 목록
	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, int feedNo) {
		
		return (ArrayList)sqlSession.selectList("feedMapper.replyList",feedNo);
	}
	
	//댓글 작성
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		
		return sqlSession.insert("feedMapper.insertReply",r);
	}

	public Feed selectFeed(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.selectOne("feedMapper.selectFeed",feedNo);
	}

	public int insertLike(SqlSessionTemplate sqlSession, FeedLike fl) {
		
		return sqlSession.insert("feedMapper.insertLike", fl);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, FeedLike fl) {
		
		return sqlSession.delete("feedMapper.deleteLike",fl);
	}
	
	//좋아요 증가
	public int addCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.update("feedMapper.addCount",feedNo);
	}
	
	//좋아요 감소
	public int removeCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.update("feedMapper.removeCount",feedNo);
	}
	
	//좋아요 여부
	public int likeCheck(SqlSessionTemplate sqlSession, int feedNo,String userId) {
		Map<String, Object> params = new HashMap<>();
        params.put("feedNo", feedNo);
        params.put("userId", userId);
		
		return sqlSession.selectOne("feedMapper.likeCheck",params);
	}
	
	//좋아요 수 조회
	public int likeCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.selectOne("feedMapper.likeCount",feedNo);
	}
	
	
	
	

}
