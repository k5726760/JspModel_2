<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	//회원가입
	String message =(String)request.getAttribute("message");

	if(message !=null && message.equals("")==false){
		if(message.equals("MEMBER_OK")){
		%>

		<script type="text/javascript">
		alert("회원가입에 성공했습니다");
		location.href="./member?param=login";
		</script>
	<% 		
	}else{
	%>

		<script type="text/javascript">
		alert("회원가입이 되지않았습니다 다시 입력해 주세요");
		location.href="./member?param=regi";		
		</script>
	<% 		
		}
	}
	%>
	
	
<% 
	//로그인
	String login=(String)request.getAttribute("login");
	if(login !=null && login.equals("")==false){
		if(login.equals("SUCCESS")){
		%>

		<script type="text/javascript">
		alert("환영합니다");
		location.href="./bbs?param=bbslist";
		</script>
	<% 		
	}else{
	%>

		<script type="text/javascript">
		alert("아이디나 패스워드를 확인하십시오");
		location.href="./member?param=login";		
		</script>
	<% 		
		}
	}
	%>
	
	
	<%
	//글쓰기
    String msg = (String)request.getAttribute("write");
    if(msg != null && msg.equals("LOGIN_REQUIRED")) {
	%>
    <script>
        alert("로그인이 필요한 서비스입니다.");
        location.href = "./member?param=login";
    </script>
	<%
    }
	%>
	
	<%
		//bbswriteAf	
		String bbsWriteMsg=(String)request.getAttribute("bbsWriteMsg");
	if(bbsWriteMsg!=null&&!bbsWriteMsg.equals("")){
		if(bbsWriteMsg.equals("BBSWRITE_SUCCESS")){
			%>
			<script type="text/javascript">
			alert('글작성완료');
			location.href = "./bbs?param=bbslist";
			</script>
			<%		
		}else{
			%>
			<script type="text/javascript">
			alert('다시 작성해 주십시오');
			location.href = "./bbs?param=bbswrite";
			</script>
			<%			
		}	
	}
	%>	


	<%
    // bbsAnswerAf
    String bbsAnsMsg = (String)request.getAttribute("bbsAnsMsg");
    String url = (String)request.getAttribute("url");
	%>

	<% if(bbsAnsMsg != null && !bbsAnsMsg.equals("")) { %>
	    <script type="text/javascript">
	        <% if(bbsAnsMsg.equals("BBSANSMSG_SUCCESS")) { %>
	            alert('답글 작성완료');
	        <% } else { %>
	            alert('다시 답글을 작성해 주십시오');
	        <% } %>
	        // 컨트롤러에서 전달한 url로 이동합니다
	        location.href = "<%=url%>"; 
	    </script>
	<% } %>
	
	<%
    // bbsUpdateAf
    String bbsUpdateMsg = (String)request.getAttribute("bbsUpdateMsg");
    String urlupdate = (String)request.getAttribute("url");
	%>

	<% if(bbsUpdateMsg != null && !bbsUpdateMsg.equals("")) { %>
	    <script type="text/javascript">
	        <% if(bbsUpdateMsg.equals("BBSUPDATE_SUCCESS")) { %>
	            alert('수정이 완료되었습니다.');
	        <% } else { %>
	            alert('수정에 실패하였습니다 다시 시도해 주세요.);
	        <% } %>
	        // 컨트롤러에서 전달한 url로 이동합니다
	        location.href = "<%=urlupdate%>"; 
	    </script>
	<% } %>
	
	<%
    // bbsUpdateAf
    String bbsDeleteMsg = (String)request.getAttribute("bbsDeleteMsg");
    String urldelete = (String)request.getAttribute("url");
	%>

	<% if(bbsDeleteMsg != null && !bbsDeleteMsg.equals("")) { %>
	    <script type="text/javascript">
	        <% if(bbsDeleteMsg.equals("BBSDELETE_SUCCESS")) { %>
	            alert('글이 삭제되었습니다.');
	        <% } else { %>
	            alert('삭제에 실패했습니다 다시 시도해 주세요.);
	        <% } %>
	        // 컨트롤러에서 전달한 url로 이동합니다
	        location.href = "<%=urlupdate%>"; 
	    </script>
	<% } %>
	
	
