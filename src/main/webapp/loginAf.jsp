<%@page import="com.mbc.project.dto.MemberDto"%>
<%@page import="com.mbc.project.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	System.out.println(id + " " + pw);
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.login(new MemberDto(id, pw, null, null, 0));
	
	if(dto != null){
		
		// session에 저장
		session.setAttribute("login", dto);
	//	session.setMaxInactiveInterval(60 * 60 * 24);
		%>    
		<script type="text/javascript">
		alert('환영합니다');
		location.href="bbslist.jsp";
		</script>
		<%
	}else{	
		%>
		<script type="text/javascript">
		alert('아이디나 패스워드를 확인하십시오');
		location.href = "login.jsp";
		</script>
		<%
	}
%>
