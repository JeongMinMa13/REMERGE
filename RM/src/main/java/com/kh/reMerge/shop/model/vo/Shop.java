package com.kh.reMerge.shop.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Shop {
	
	private int shopNo;
	private String shopStatus;
	private String brandNameList;
	private String brandList;
	private String brandSize;
	private int krw;
	private int inven;
	private String filePath;
	private String modelName;
	private String shopAddress;
	
}
