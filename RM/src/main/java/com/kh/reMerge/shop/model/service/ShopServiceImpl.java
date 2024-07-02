package com.kh.reMerge.shop.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.shop.model.dao.ShopDao;
import com.kh.reMerge.shop.model.vo.Shop;

@Service
public class ShopServiceImpl implements ShopService{
	
	@Autowired
	private ShopDao shopDao;
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public int shopCreate(String userId) {
		return shopDao.shopCreate(sqlSession,userId);
		
		
	}

	@Override
	public ArrayList<Shop> shopList(Shop s) {
		
		return shopDao.shopList(sqlSession,s);
	}

}
