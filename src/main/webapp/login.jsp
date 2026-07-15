<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<style type="text/css">
	.center{
		margin: auto;
		width: 60%;
		border: 2px solid;
		padding: 10px;
	}


</style>
<title>login</title>
</head>
<body>
<h2>login</h2>

<div class="center">

<form id="loginform" action="loginAf.jsp" method="post">
<table border="1">
<tr>
	<th>ID</th>
	<td>
		<input type="text" id="id" name="id" size="20"/><br/>
		<input type="checkbox" id="chk_save_id"/>id 저장
	</td>
</tr>
<tr>
	<th>Password</th>
	<td>
		<input type="password" name="pw" size="20"/>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit"  value="log-in"/>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="regi.jsp">회원가입</a>
	</td>

</tr>



</table>
</form>
</div>

<script type="text/javascript">
	/*
	 	session : 저장공간, object를 저장 <-server 예)login한 정보 저장
	 	cookie :  저장공간, String만 저장 <-client(웹 브라우저) id
	 
	 */
	let user_id=$.cookie("user_id"); //cookie에서 저장된 id산출
	if(user_id!=null){ //id가 있는경우
		$("#id").val(user_id);
		$("#chk_save_id").prop("checked",true);
	} 
	
	$("#chk_save_id").click(function () {		
		if($("#chk_save_id").is(":checked")==true){ //체크박스 on
			//id 저장
			if($("#id").val().trim()===""){
				alert('아이디를 입력해 주십시오');
				$("#chk_save_id").prop("checked",false); //체크박스 off
			}else{ //cookie에 저장
				$.cookie("user_id",$("#id").val().trim(),{expires:7, path:'/'});
				
			}
			
		}else{ //체크박스 off
			//id 삭제
			$.removeCookie("user_id",{path:'/'});
		}
		
	});

</script>
</body>
</html>