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
 	//update -> ref번호가 같고 step이 큰 글들은 step을 +1
 	dao.answerUpdate(seq);
 	
 	
 	//insert -> step을 +1, depth를 +1로 처리
 	boolean isS=dao.answerInsert(seq, new BbsDto(id,title,content));
 	if(isS){
  	%>  
	  <script>
	  alert("답글이 입력되었습니다!");
	  location.href="bbslist.jsp";
	  </script>
  
  	<% 
 	} else{
  	%>
      <script>
	  alert("답글입력에 실패했습니다...");
	  location.href="bbsanswer.jsp?seq=<%=seq%>";
	  </script>
     
     <%
 	} 
     %>
    
