package com.kh.reMerge.user.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class MypageDao {
	
	public int updateUser(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updateUser",u);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updatePwd",u);
	}

	public int deleteUser(SqlSessionTemplate sqlSession, String userPwd) {
		
		return sqlSession.update("mypageMapper.deleteUser",userPwd);
	}

	public int updateProfile(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updateProfile",u);
	}

	public int countFollowing(SqlSessionTemplate sqlSession, String fromUser) {
		
		
		return sqlSession.selectOne("mypageMapper.countFollowing",fromUser);
	}

	public int countFollower(SqlSessionTemplate sqlSession, String toUser) {
		
		return sqlSession.selectOne("mypageMapper.countFollower",toUser);
	}

	public int countFeed(SqlSessionTemplate sqlSession, String feedWriter) {
		
		return sqlSession.selectOne("mypageMapper.countFeed",feedWriter);
	}

	public ArrayList<FollowList> followingList(SqlSessionTemplate sqlSession,String toUser) {
		
		return (ArrayList)sqlSession.selectList("mypageMapper.followingList",toUser);
	}

	
	

	

}
