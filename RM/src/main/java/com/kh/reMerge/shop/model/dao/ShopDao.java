package com.kh.reMerge.shop.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.shop.model.vo.Shop;

@Repository
public class ShopDao {

	public int shopCreate(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.update("shopMapper.UpdateStatus",userId);
	}


	public ArrayList<Shop> shopList(SqlSessionTemplate sqlSession, Shop s) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectAllShop",s);
	}

	
}
