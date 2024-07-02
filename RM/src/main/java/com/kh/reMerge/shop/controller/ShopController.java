package com.kh.reMerge.shop.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.shop.model.service.ShopService;
import com.kh.reMerge.shop.model.vo.Shop;

@Controller
public class ShopController {
	
	@Autowired
	private ShopService shopService;
	
	@RequestMapping("storeHome.sh")
	public String storeHome() {
		//System.out.println("샵홈");
		
		return "shop/shopPage";
	}
	@ResponseBody
	@RequestMapping("shopCreate.sh")
	public int shopCreate(String userId) {
		int result = 0;
		return result = shopService.shopCreate(userId);
	}
	
	@ResponseBody
	@RequestMapping("shopList.sh")
	public ArrayList<Shop> shopList(String brandList,String brandNameList) {
		
		Shop s = new Shop();
		s.setBrandList(brandList);
		s.setBrandNameList(brandNameList);
		
		ArrayList<Shop> sList = shopService.shopList(s);
		
		return sList;
	}
	
}
