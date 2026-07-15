package com.mbc.project.util;

public class util {

	//제목이 길 경우 ...으로 출력하는 함수
	public static String dot3(String title) {
		String str=" ";
		
		if(title.length()>=30) {
			str=title.substring(0,30);
			str += "...";
		}else {
			str=title.trim();
		}
	return str;
	}
	
	//답글의 화살표(arrow)와 공백을 추가하는 함수
	public static String  arrow(int depth) {
		String rs="<img src='./arrow.png' whith='20px' height='20px'/>";
		String nbsp="&nbsp;&nbsp;&nbsp;&nbsp; ";
		
		String ts="";
		for (int i = 0; i < depth; i++) {
			ts +=nbsp;
		}
		return depth==0?"":ts+rs;
	}
}