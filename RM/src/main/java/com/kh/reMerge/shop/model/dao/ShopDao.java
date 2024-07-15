package com.kh.reMerge.shop.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.shop.model.vo.Address;
import com.kh.reMerge.shop.model.vo.PaymentList;
import com.kh.reMerge.shop.model.vo.Shop;

@Repository
public class ShopDao {

	public int shopCreate(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("shopMapper.UpdateStatus",userId);
	}

	public ArrayList<Shop> shopList(SqlSessionTemplate sqlSession, Shop s) {
		return (ArrayList)sqlSession.selectList("shopMapper.shopList",s);
	}

	public int shopInsertFeed(SqlSessionTemplate sqlSession, String sListNo) {
		return sqlSession.update("shopMapper.shopInsertFeed",sListNo);
	}

	public ArrayList<Shop> shopSelectBr(SqlSessionTemplate sqlSession, Shop s) {
		return (ArrayList)sqlSession.selectList("shopMapper.shopSelectBr",s);
	}

	public ArrayList<Shop> shopInfo(SqlSessionTemplate sqlSession, Shop s) {
		return (ArrayList)sqlSession.selectList("shopMapper.shopInfo",s);
	}

	public Shop shopDetail(SqlSessionTemplate sqlSession, Shop s) {
		return sqlSession.selectOne("shopMapper.shopDetail",s);
	}

	public ArrayList<Shop> selectSize(SqlSessionTemplate sqlSession, Shop result) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectSize",result);
	}

	public Address addressSelect(SqlSessionTemplate sqlSession, Address ad) {
		return sqlSession.selectOne("shopMapper.addressSelect",ad);
	}

	public int insertOriAD(SqlSessionTemplate sqlSession, Address ad) {
		return sqlSession.insert("shopMapper.insertOriAD",ad);
	}

	public ArrayList<Address> selectOriAD(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectOriAD",userId);
	}

	public int updateOriAD(SqlSessionTemplate sqlSession, Address ad) {
		return sqlSession.update("shopMapper.updateOriAD",ad);
	}

	public int insertPayment(SqlSessionTemplate sqlSession, PaymentList pm) {
		return sqlSession.insert("shopMapper.insertPayment",pm);
	}

	public ArrayList<PaymentList> PaymentList(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("shopMapper.PaymentList",userId);
	}

	
}
