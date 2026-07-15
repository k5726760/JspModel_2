<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- Bootstrap 5.3.8 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js"></script>

<style>
body{
    background: linear-gradient(135deg,#74ebd5,#9face6);
    height:100vh;
}

.login-card{
    width:420px;
    border:none;
    border-radius:20px;
}

.card-header{
    border-radius:20px 20px 0 0 !important;
}

.form-control{
    border-radius:10px;
}

.btn-login{
    border-radius:10px;
}

a{
    text-decoration:none;
}
</style>

</head>

<body>

<div class="container h-100">
    <div class="row justify-content-center align-items-center h-100">

        <div class="card shadow-lg login-card">

            <div class="card-header bg-primary text-white text-center py-4">
                <h2>
                    <i class="bi bi-person-circle"></i>
                    Login
                </h2>
            </div>

            <div class="card-body p-4">

                <form id="loginform" action="member" method="post">
					<input type="hidden" name="param" value="loginAf">
                    <!-- ID -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            <i class="bi bi-person-fill"></i> ID
                        </label>

                        <input type="text"
                               class="form-control"
                               id="id"
                               name="id"
                               placeholder="아이디를 입력하세요">
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <label class="form-label fw-bold">
                            <i class="bi bi-lock-fill"></i> Password
                        </label>

                        <input type="password"
                               class="form-control"
                               name="pw"
                               placeholder="비밀번호를 입력하세요">
                    </div>

                    <!-- Save ID -->
                    <div class="form-check mb-4">
                        <input class="form-check-input"
                               type="checkbox"
                               id="chk_save_id">

                        <label class="form-check-label" for="chk_save_id">
                            아이디 저장
                        </label>
                    </div>

                    <!-- Buttons -->
                    <div class="d-grid gap-2">

                        <button type="submit"
                                class="btn btn-primary btn-lg btn-login">
                            <i class="bi bi-box-arrow-in-right"></i>
                            로그인
                        </button>

                        <a href="member?param=regi"
                           class="btn btn-outline-secondary">
                            <i class="bi bi-person-plus-fill"></i>
                            회원가입
                        </a>

                    </div>

                </form>

            </div>

        </div>

    </div>
</div>

<script>

    /*
        session : 서버 저장
        cookie : 브라우저 저장
    */

    let user_id = $.cookie("user_id");

    if(user_id != null){
        $("#id").val(user_id);
        $("#chk_save_id").prop("checked",true);
    }

    $("#chk_save_id").click(function(){

        if($(this).is(":checked")){

            if($("#id").val().trim() === ""){

                alert("아이디를 입력해 주세요.");

                $(this).prop("checked",false);

            }else{

                $.cookie(
                    "user_id",
                    $("#id").val().trim(),
                    {
                        expires:7,
                        path:'/'
                    }
                );

            }

        }else{

            $.removeCookie(
                "user_id",
                {
                    path:'/'
                }
            );

        }

    });

</script>

</body>
</html>