<%@page import="java.util.List"%>
<%@page import="com.mbc.project.dao.BbsDao"%>
<%@page import="com.mbc.project.dto.BbsDto"%>
<%@page import="com.mbc.project.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
   <%
   /* request.setCharacterEncoding("UTF-8");

   String sSeq = request.getParameter("seq");
   int seq = 0;
   if (sSeq != null && !sSeq.equals("")) {
       seq = Integer.parseInt(sSeq);
   }

   BbsDao dao = BbsDao.getInstance();
   
   dao.readcount(seq); //조회수
   
   List<BbsDto> list = dao.getBbsList(seq); //조회수 반영한 리스트
   
   BbsDto dto = null;
   if(list != null && list.size() > 0) {
       dto = list.get(0);
   } */
   
   BbsDto dto=(BbsDto)request.getAttribute("dto");
   MemberDto login = (MemberDto)session.getAttribute("login");
    
   %>
   
<%
    // 제목에서 따옴표를 &quot;로 치환
    String title = dto.getTitle();
    if (title != null) {
        title = title.replace("\"", "&quot;");
    }
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<style type="text/css">
	.center{
		margin: auto;
		width:  1000px;
		text-align: center;
	}
</style>
</head>
<body>
<h2 style="text-align: center;" > 내용 </h2>

<div class="center">
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
        <input type="text" name="wdate" style="width: 98%;" value="<%=wdate%>" readonly="readonly"/>
    </td>
	</tr>

	<tr>
		<td>제목</td>
		<td colspan="3"><input type="text" name="title" style="width: 98%;" value="<%=title%>" readonly="readonly"/></td>
	</tr>
	
	<tr>
		<td>내용</td>
		<td colspan="3"><textarea name="content" style="width: 98%;" rows="10" readonly="readonly"><%=dto.getContent()%></textarea></td>
	</tr>

</table>
<br/>
<%

if(login.getId().equals(dto.getId())){
%>
<button type="button" onclick="update(<%=dto.getSeq()%>)">수정</button>
<button type="button" onclick="del(<%=dto.getSeq()%>)">삭제</button>
<%
}
%>
<button type="button" onclick="answer(<%=dto.getSeq()%>)">답글작성</button>
</div>

<script type="text/javascript">
function answer(seq) {
	location.href="bbs?param=bbsanswer&seq="+seq;
}

function update(seq) {
	location.href="bbs?param=bbsupdate&seq="+seq;
}

function del(seq) {
	if(confirm("정말로 삭제하시겠습니까?")) {
        location.href = "bbs?param=bbsdeleteAf&seq=" + seq;
    }
}
</script>








</body>
</html>