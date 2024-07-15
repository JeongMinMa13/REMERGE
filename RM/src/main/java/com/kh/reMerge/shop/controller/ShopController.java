package com.kh.reMerge.shop.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.shop.model.service.ShopService;
import com.kh.reMerge.shop.model.vo.Address;
import com.kh.reMerge.shop.model.vo.PaymentList;
import com.kh.reMerge.shop.model.vo.Shop;

@Controller
public class ShopController {

	@Autowired
	private ShopService shopService;

	@RequestMapping("storeHome.sh")
	public String storeHome() {
		return "shop/shopPage";
	}

	@RequestMapping("detailShop.sh")
	public String detailShop() {

		return "shop/detailShop";
	}

	@ResponseBody
	@RequestMapping("shopCreate.sh")
	public int shopCreate(String userId) {
		int result = 0;
		return result = shopService.shopCreate(userId);
	}

	@ResponseBody
	@RequestMapping("shopList.sh")
	public ArrayList<Shop> shopList(String brandList, String brandNameList) {
		// System.out.println("brandList : "+ brandList);
		// System.out.println("brandNameList : "+ brandNameList);

		Shop s = new Shop();
		s.setBrandList(brandList);
		s.setBrandNameList(brandNameList);

		// System.out.println("S : "+s);
		ArrayList<Shop> sList = shopService.shopList(s);
		// System.out.println("sList : "+sList);

		return sList;
	}

	@ResponseBody
	@RequestMapping("shopInfo.sh")
	public ArrayList<Shop> shopInfo(int shopNo) {
		// System.out.println("brandList : "+ brandList);
		// System.out.println("brandNameList : "+ brandNameList);

		Shop s = new Shop();
		s.setShopNo(shopNo);

		// System.out.println("S : "+s);

		ArrayList<Shop> sList = shopService.shopInfo(s);
		// System.out.println("sList : "+sList);

		return sList;
	}
	
	@ResponseBody
	@RequestMapping("shopDetail.sh")
	public Shop shopDetail(int shopNo, HttpSession session) {
		//System.out.println("샵디테일홈");
		//System.out.println("shopNo :" +shopNo);
		session.setAttribute("shNo", shopNo);
		Shop s = new Shop();
		s.setShopNo(shopNo);
		//System.out.println("s :" +s);
		Shop result = shopService.shopDetail(s);
		
		ArrayList<Shop> brName = shopService.selectSize(result);
		session.setAttribute("br", brName);
		session.setAttribute("sh", result);
		//System.out.println("brName : "+brName); 해당 상품 사이즈만 가져옴
		//System.out.println("result : "+result); 이유를 모르겠지만 shopNo를 가져오지는 않음 왜??
		return result; //shopNo로 따른 전체 정보
	}

	@ResponseBody
	@RequestMapping("shopSelectBr.sh")
	public ArrayList<Shop> shopSelectBr(int sListNo) {
		//System.out.println("shopSelectBr에서 sListNo : " + sListNo);
		//System.out.println("sListNo :" +sListNo);
		Shop s = new Shop();
		s.setShopNo(sListNo);
		//System.out.println("s :" +s);
		ArrayList<Shop> result = shopService.shopSelectBr(s);
		//System.out.println("result :" +result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("addressSelect.sh")
	public Address addressSelect(String userId , HttpSession session) {
		Address ad = new Address();
		ad.setUserId(userId);
		//System.out.println("ad 값 : "+ad);
		
		Address result = shopService.addressSelect(ad);
		//System.out.println("ad 값 :"+result);
		session.setAttribute("ad", result);
		return result; 
	}
	

	@ResponseBody
	@RequestMapping("insertOriAD.sh")
	public int insertOriAD(String userId , String addressOri, String addressOride) {
		Address ad = new Address();
		ad.setUserId(userId);
		ad.setAddressOri(addressOri);
		ad.setAddressOriDetail(addressOride);
		
		//System.out.println("ad :" +ad);
		int result = shopService.insertOriAD(ad);
		
		
		return result; 
	}
	
	@ResponseBody
	@RequestMapping("selectOriAD.sh")
	public ArrayList<Address> selectOriAD(String userId, HttpSession session, Model model) {
		//System.out.println(userId);
		ArrayList<Address> result = shopService.selectOriAD(userId);
		session.setAttribute("adre", result);
		model.addAttribute("adre2", result);
		//System.out.println("selectresult : "+ result);
		
		
		return result; 
	}
	
	@ResponseBody
	@RequestMapping("updateOriAD.sh")
	public int updateOriAD(String userId , String addressOri, String addressOride) {
		Address ad = new Address();
		ad.setUserId(userId);
		ad.setAddressOri(addressOri);
		ad.setAddressOriDetail(addressOride);
		
		//System.out.println("ad :" +ad);
		int result = shopService.updateOriAD(ad);
		//System.out.println("update ad : "+ad);
		
		return result; 
	}
	
	@ResponseBody
	@RequestMapping("insertPayment.sh")
	public int insertPayment(String userId , String pg, String mcUid,
							String productName , int amount, int quantity,String buyerName, String buyerAddr ,String filePath ) {
		PaymentList pm = PaymentList.builder()
					.userId(userId)
					.pg(pg)
					.mcUid(mcUid)
					.productName(productName)
					.amount(amount)
					.quantity(quantity)
					.buyerName(buyerName)
					.buyerAddr(buyerAddr)
					.filePath(filePath)
					.build();
		//System.out.println(pm);
		int result = shopService.insertPayment(pm);
		//System.out.println(result);
		
		return result; 
	}
	
	@RequestMapping("callPaymentList.sh")
	public String callPaymentList() {

		return "shop/PaymentList";
	}

	
	@ResponseBody
	@RequestMapping("PaymentList.sh")
	public ArrayList<PaymentList> PaymentList(String userId, HttpSession session) {
		System.out.println(userId);
		ArrayList<PaymentList> result = shopService.PaymentList(userId);
		session.setAttribute("pl", result);
		System.out.println("PaymentListresult : "+ result);
		
		
		return result; 
	}
}
