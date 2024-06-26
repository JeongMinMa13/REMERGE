package com.kh.reMerge.common.template;

import com.kh.reMerge.common.model.vo.PageInfo;

public class Pagination {
	public static PageInfo getPageInfo(int listCount,int currentPage,int feedLimit ) {
		
		int maxPage = (int)Math.ceil((double)listCount/feedLimit);
		
		//처리된 데이터 객체에 담아주기
		PageInfo pi = new PageInfo(listCount,currentPage,feedLimit,maxPage);
		
		return pi; //페이징 정보 반환
	  }
}
