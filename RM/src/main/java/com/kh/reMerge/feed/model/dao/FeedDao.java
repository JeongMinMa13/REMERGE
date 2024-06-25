package com.kh.reMerge.feed.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.Reply;

@Repository
public class FeedDao {

	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("feedMapper.listCount");
	}

	public int insertFeed(SqlSessionTemplate sqlSession,Feed f) {
		
		return sqlSession.insert("feedMapper.insertFeed",f);
	}

	public ArrayList<Feed> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getFeedLimit();
		
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectList", null, rowBounds);
	}

	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, int feedNo) {
		
		return (ArrayList)sqlSession.selectList("feedMapper.replyList",feedNo);
	}

}
