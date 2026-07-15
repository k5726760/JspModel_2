<%@page import="com.mbc.project.dao.BbsDao"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");  //한글깨짐 방지

	//id, title, content 
	String id=request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	//db접속 추가 dao->bbswrite (Bbsdto)
	BbsDto dto=new BbsDto(id, title, content);
	
	BbsDao dao = BbsDao.getInstance();
    boolean isSuccess = dao.bbswrite(dto);
	
    if (isSuccess) {
    	%>
    	        <script>
    	        alert("글이 작성되었습니다.");
  	          	location.href = "bbs?param=bbslist";
    	        </script>
    	<%
    	    } else {
    	%>
    	        <script>
    	            alert("글 작성에 실패했습니다.");
    	            location.href="bbswrite.jsp";
    	        </script>
    	<%
    	    }
    	%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbswiterAf</title>
</head>
<body>

</body>
</html>