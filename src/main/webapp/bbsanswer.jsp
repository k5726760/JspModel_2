<%@page import="java.util.List"%>
<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
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

if (login == null) {
%>    
    <script type="text/javascript">
            alert("로그인이 필요한 페이지입니다.");
            location.href = "login.jsp"; 
       </script>
<%
        return; 
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> 기본글</h1>

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
		<td>제목</td>
		<td colspan="3"><input type="text" name="title" size="50" value="<%=dto.getTitle()%>" readonly="readonly"/></td>
	</tr>
	
	<tr>
		<td>내용</td>
		<td colspan="3"><textarea name="content" cols="52" rows="10" readonly="readonly"><%=dto.getContent()%></textarea></td>
	</tr>

</table>

<h1>답글</h1>

<% 

%>
<form action="bbs" method="post">
<input type="hidden" name="param" value="bbsanswerAf"/>
<!-- 기본글의 sequence 전송 -->
<input type="hidden" name="seq" value="<%=dto.getSeq() %>"/>

<table border="1">
<col width="200"/><col width="400"/>

<!-- id, title, content -->
<tr>
	<th>ID</th>
	<td>
		<input type="text" name="id" size="50px" value="<%=login.getId() %>" readonly="readonly"/>
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

<input type="submit" value="답글 작성완료"/>
</form>

</div>

</body>
</html>