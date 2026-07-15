<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	String id=(String)request.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
<h2 style="text-align: center;">글쓰기</h2>
<div align="center">

<form action="bbs" method="post">
<input type="hidden" name="param" value="bbswriteAf"/>


<table border="1">
<col width="200"/><col width="400"/>

<!-- id, title, content -->
<tr>
	<th>ID</th>
	<td>
		<input type="text" name="id" size="50px" value="<%=id %>" readonly="readonly"/>
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px"/>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50px" name="content" placeholder="내용을 기입"></textarea>
	</td>
</tr>

</table>
<br/>

<input type="submit" value="작성완료"/>
</form>
</div>
</body>
</html>