package com.kh.reMerge.shop.model.service;

import java.util.ArrayList;

import com.kh.reMerge.shop.model.vo.Address;
import com.kh.reMerge.shop.model.vo.PaymentList;
import com.kh.reMerge.shop.model.vo.Shop;

public interface ShopService {

	int shopCreate(String userId);

	ArrayList<Shop> shopList(Shop s);

	int shopInsertFeed(String sListNo);

	ArrayList<Shop> shopSelectBr(Shop s);

	ArrayList<Shop> shopInfo(Shop s);

	Shop shopDetail(Shop s);

	ArrayList<Shop> selectSize(Shop result);

	Address addressSelect(Address ad);

	int insertOriAD(Address ad);

	ArrayList<Address> selectOriAD(String userId);

	int updateOriAD(Address ad);

	int insertPayment(PaymentList pm);

	ArrayList<PaymentList> PaymentList(String userId);

}
