<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
 	request.setCharacterEncoding("utf-8");
 %>    
    
<%
 	int seq=Integer.parseInt(request.getParameter("seq"));
 
 	String id=request.getParameter("id");
 	String title=request.getParameter("title");
 	String content=request.getParameter("content");
 
 	BbsDao dao=BbsDao.getInstance();
 	
 	boolean isS = dao.Updatebbs(seq, title, content);
 	
 	if(isS){
  	%>  
	  <script>
	  alert("게시글이 수정되었습니다!");
	  location.href="bbslist.jsp";
	  </script>
  
  	<% 
 	} else{
  	%>
      <script>
	  alert("게시글 수정에 실패했습니다...");
	  location.href="bbsupdate.jsp?seq=<%=seq%>";
	  </script>
     
     <%
 	} 
     %>