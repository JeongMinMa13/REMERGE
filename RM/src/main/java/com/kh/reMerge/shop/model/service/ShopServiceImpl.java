package com.kh.reMerge.shop.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.shop.model.dao.ShopDao;
import com.kh.reMerge.shop.model.vo.Address;
import com.kh.reMerge.shop.model.vo.PaymentList;
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
		// TODO Auto-generated method stub
		return shopDao.shopList(sqlSession, s);
	}

	@Override
	public int shopInsertFeed(String sListNo) {
		// TODO Auto-generated method stub
		return shopDao.shopInsertFeed(sqlSession,sListNo);
	}

	@Override
	public ArrayList<Shop> shopSelectBr(Shop s) {
		// TODO Auto-generated method stub
		return shopDao.shopSelectBr(sqlSession,s);
	}

	@Override
	public ArrayList<Shop> shopInfo(Shop s) {
		return shopDao.shopInfo(sqlSession, s);
	}

	@Override
	public Shop shopDetail(Shop s) {
		// TODO Auto-generated method stub
		return shopDao.shopDetail(sqlSession, s);
	}

	@Override
	public ArrayList<Shop> selectSize(Shop result) {
		// TODO Auto-generated method stub
		return shopDao.selectSize(sqlSession, result);
	}

	@Override
	public Address addressSelect(Address ad) {
		// TODO Auto-generated method stub
		return shopDao.addressSelect(sqlSession, ad);
	}

	@Override
	public int insertOriAD(Address ad) {
		// TODO Auto-generated method stub
		return shopDao.insertOriAD(sqlSession, ad);
	}

	@Override
	public ArrayList<Address> selectOriAD(String userId) {
		// TODO Auto-generated method stub
		return shopDao.selectOriAD(sqlSession, userId);
	}

	@Override
	public int updateOriAD(Address ad) {
		// TODO Auto-generated method stub
		return shopDao.updateOriAD(sqlSession, ad);
	}

	@Override
	public int insertPayment(PaymentList pm) {
		// TODO Auto-generated method stub
		return shopDao.insertPayment(sqlSession, pm);
	}

	@Override
	public ArrayList<PaymentList> PaymentList(String userId) {
		// TODO Auto-generated method stub
		return shopDao.PaymentList(sqlSession, userId);
	}



}
