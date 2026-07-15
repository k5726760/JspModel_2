<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
/* int seq=Integer.parseInt(request.getParameter("seq"));

BbsDao dao=BbsDao.getInstance();
List<BbsDto> list = dao.getBbsList(seq);

BbsDto dto = null;
if (list != null && list.size() > 0) {
    dto = list.get(0); // 데이터가 있을 때만 담음
} */
BbsDto dto=(BbsDto)request.getAttribute("dto");
MemberDto login = (MemberDto)session.getAttribute("login");

%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
<h1 align="center"> 게시글 수정</h1>

<% 
%>

<form action="bbs" method="post">
<!-- 기본글의 sequence 전송 -->
<input type="hidden" name="param" value="bbsupdateAf"/>
<input type="hidden" name="seq" value="<%=dto.getSeq() %>"/>

<div align="center">
<table border="1">
<col width="80"/><col width="100"/>
	<tr>
		<td>작성자</td>
		<td><input type="text" name="id" size="50" value="<%=dto.getId()%>" readonly="readonly"/></td>
		
		<td>조회수</td>
        <td><input type="text" name="hit" size="20" value="<%=dto.getReadcount()%>" readonly="readonly"/></td>
	</tr>
	
	<tr>
    <td>작성일</td>
    <td colspan="3">
    <%
        String wdate = dto.getWdate(); // 예: 2026-07-13 14:46:43.0
        if (wdate != null && wdate.length() > 19) {
            wdate = wdate.substring(0, 19); // 0번째부터 19번째 글자까지만 표시
        }
    %>
    
        <input type="text" name="wdate" style="width: 98%;" 
               value="<%=wdate%>" readonly="readonly"/>
    </td>
	</tr>

	<tr>
		<td>제목</td>
		<td colspan="3"><input type="text" name="title" style="width: 98%;" value="<%=dto.getTitle()%>"/></td>
	</tr>
		
	<tr>
		<td>내용</td>
		<td colspan="3"><textarea name="content" style="width: 98%;" rows="10" ><%=dto.getContent()%></textarea></td>
	</tr>

</table>
<br/>

<input type="submit" value="수정완료"/>

</div>

</form>


</body>
</html>