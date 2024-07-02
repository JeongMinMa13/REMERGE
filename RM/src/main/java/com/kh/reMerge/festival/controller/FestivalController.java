package com.kh.reMerge.festival.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FestivalController {

	@GetMapping("festival.fs")
	public String festival() {
		
		return "festival/festival";
	}
	
	@ResponseBody
	@RequestMapping(value="selectFestival.fs",produces="application/json;charset=UTF-8")
	public String selectFestival(String pageNo) throws IOException {
		String serviceKey="Y0B1p%2B0YuGS5nmP6b8ZF3NnSUwiD%2FwI9kES%2BKWHwg5y7yKfsaJlepDAejDReXCfJ4pqr%2FvmZsNbjptGgjC5yng%3D%3D";
		String url="http://api.data.go.kr/openapi/tn_pubr_public_cltur_fstvl_api";
		url+="?serviceKey="+serviceKey;
		url+="&pageNo="+pageNo;
		url+="&numOfRows=10";
		url+="&type=json";
		URL requestUrl = new URL(url);
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		urlCon.setRequestMethod("GET");
		urlCon.setRequestProperty("Content-type", "application/json");
		//json type으로 응답받고 싶을 때는 아래 주석을 제거하시고 사용바랍니다.
		urlCon.setRequestProperty("Accept","application/json");
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		String str = "";
		
		String line;
		while((line=br.readLine())!=null) {
			str+=line;
		}
		
		br.close();
		urlCon.disconnect();
//		System.out.println(str);
		return str;
	}
}
