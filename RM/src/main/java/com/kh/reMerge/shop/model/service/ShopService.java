package com.kh.reMerge.shop.model.service;

import java.util.ArrayList;

import com.kh.reMerge.shop.model.vo.Shop;

public interface ShopService {

	int shopCreate(String userId);

	ArrayList<Shop> shopList(Shop s);

}
