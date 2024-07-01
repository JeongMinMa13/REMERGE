package com.kh.reMerge.shop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.reMerge.shop.model.service.ShopService;

@Controller
public class ShopController {
	
//	@Autowired
//	private ShopService shopService;
//	
	
	@RequestMapping("shopPage.sh")
	public String memberEnrollForm() {
		//System.out.println("왔나");
		return "shop/shopPage";
	}
	
	
	
	
}
