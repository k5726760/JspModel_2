<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	.center{
		margin: auto;
		width: 60%;
		border: 2px solid;
		padding: 10px;
	}


</style>
</head>
<body>

<h2>회원가입</h2>


<div class="center">
<form action="member" method="post">
<input type="hidden" name="param" value="regiAf"/>
<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" size="20"/>
		<p id="idcheck" style="font-size: 8px"></p>
		<button type="button" id="id_chk_btn">id 확인</button>
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="text" name="pw" size="20"/>		
	</td>
</tr>
<tr>
	<th>이름</th>
	<td>
		<input type="text" name="name" size="20"/>
	</td>
</tr>
<tr>
	<th>이메일</th>
	<td>
		<input type="text" name="email" size="20"/>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="회원가입"/>
	</td>
</tr>

</table>
</form>


</div>

<script type="text/javascript">
	$(document).ready(function () {
		$("#id_chk_btn").click(function () {
			//alert("아이디 확인버튼 클릭");
			
			//빈칸인지 검사!
			
			$.ajax({
				"url" : "./member",
				"type" : "post",
				"data" : { param:"idcheck", id:$("#id").val()},
				
				success:function(data){
					//alert('success');
					//alert(data.trim());
					//alert(data.str);					
					
					if(data.str=="YES"){
						$("#idcheck").css("color","#0000ff");
						$("#idcheck").text("사용할 수 있는 아이디입니다.");
					}else{
						$("#idcheck").css("color","#ff0000");
						$("#idcheck").html("<b>사용중인 아이디입니다.</b>");
						$("#id").val("");
					}
					
				},
				error:function(){
					alert('error');
				}
				
			});
			
			
			
		});
	});





</script>

</body>
</html>