<%@page import="com.mbc.project.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    BbsDao dao = BbsDao.getInstance();
    
    boolean isS = dao.deletebbs(seq); 
    
    if(isS){
%>
        <script>
            alert("게시글이 삭제되었습니다.");
            location.href = "bbslist.jsp";
        </script>
<%
    } else {
%>
        <script>
            alert("삭제에 실패했습니다.");
            location.href = "bbsdetail.jsp?seq=<%=seq%>";
        </script>
<%
    }
%>