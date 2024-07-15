package com.kh.reMerge.shop.model.vo;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentList {
	private String userId; // 유저아이디
	private String pg; // pg : 'html5_inicis',
	private String mcUid; // merchant_uid: "IMP"+makeMerchantUid, 주문번호
	private String productName; // name : productName, 상품이름
	private int amount;// amount : totalPrice, 가격
	private int quantity;// amount : totalPrice, 상품번호
	private String buyerName;// buyer_name : userName 구매자 이름
	private String buyerAddr;// buyer_addr : address 구매자 주소
	private String filePath;  // 상품이미지 주소
}
