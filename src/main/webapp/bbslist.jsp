<%@page import="java.util.ArrayList"%>
<%@page import="com.mbc.project.util.util"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
/* String category=request.getParameter("category");
String keyword=request.getParameter("keyword");
if(category == null){
	category="";
}

if(keyword == null){
	keyword="";
}

BbsDao dao = BbsDao.getInstance();

String sPageNumber=request.getParameter("pageNumber");

//페이지넘버
int pageNumber=0;
if(sPageNumber!=null&& sPageNumber.equals("")==false){ //넘어온 값이 있을때
	pageNumber=Integer.parseInt(sPageNumber);
}

List<BbsDto> list =dao.getBbsList(category,keyword,pageNumber);

//글의 총수
int count = dao.getAllBbs(category, keyword);

//페이지수 계산
int pageBbs=count/10;
if((count%10)>0){
	pageBbs += 1;
} */
%> 

<% 
//짐 풀기 (안전한 형변환 및 null 처리)
Object listObj = request.getAttribute("list");
List<BbsDto> list = (listObj != null) ? (List<BbsDto>)listObj : new ArrayList<BbsDto>();

Object pageBbsObj = request.getAttribute("pageBbs");
int pageBbs = (pageBbsObj != null) ? (Integer)pageBbsObj : 0;

Object pageNumObj = request.getAttribute("pageNumber");
int pageNumber = (pageNumObj != null) ? (Integer)pageNumObj : 0;

String category = (String)request.getAttribute("category");
if(category == null) category = "title"; // 기본값 설정

String keyword = (String)request.getAttribute("keyword");
if(keyword == null) keyword = ""; // 기본값 설정
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>게시판</title>
<style type="text/css">
	.center{
		margin: auto;
		width:  1000px;
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	let select = document.getElementById("category");
	select.value ="<%=category %>";
});
</script>
</head>
<body>

<h1 style="text-align: center;">게시판</h1>

<div class="center">

<table border="1">
<col width="70"/><col width="600"/><col width="100"/><col width="150"/>
<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성자</th>
	</tr>
</thead>

<tbody>
<% 
	if(list == null || list.size()==0){
		%>
		<tr>
			<td colspan="4">등록된 게시글이 없습니다.</td>
		</tr>
		<% 
	}else{
		for(int i=0; i<list.size();i++){
			BbsDto dto = list.get(i);	
            // 수정: 페이지 번호를 반영한 순번 계산
            int listNumber = (pageNumber * 10) + (i + 1);
		%>
		<tr>
			<td><%= listNumber %></td>
			<td style="text-align: left;"> &nbsp; &nbsp;
				<%=util.arrow(dto.getDepth()) %>
				<a href="bbs?param=bbsdetail&seq=<%=dto.getSeq()%>">
				<%=util.dot3(dto.getTitle()) %>
				</a>
			</td>
			<td><%=dto.getReadcount() %></td>
			<td><%=dto.getId() %></td>
		</tr>
		<% 
		}
	}
%>
</tbody>
</table>
<br/>

<% 
	// 페이징
	for(int i=0; i<pageBbs; i++){
		if(pageNumber == i){ // 현재 페이지 강조
			%>
			<span style="font-size: 15pt; color: blue; font-weight: bold;" ><%=i+1 %></span>
			<% 
		}else{  // 그 외 페이지
			%>
			<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
				style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
				</a>
			<% 
		}
	}
%>
<br/><br/>

<select id="category">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>
<input type="text" id="keyword" size="20" value="<%=keyword %>"/>
<button type="button" onclick="searchBtn()">검색</button>
<br/><br/>
<a href="bbs?param=bbswrite">글쓰기</a>

</div>
<script type="text/javascript">
	function searchBtn() {
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;
		location.href="bbs?param=bbslist&category="+category+"&keyword="+keyword;		
	}
	
	function goPage(pageNum) {
		let category = document.getElementById("category").value;
		let keyword = document.getElementById("keyword").value;
		location.href="bbs?param=bbslist&category="+category+"&keyword="+keyword+"&pageNumber="+pageNum;	
	}
</script>

</body>
</html>