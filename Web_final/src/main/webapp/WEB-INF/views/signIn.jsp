<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href = "resources/css/signIn.css">
<body>
	<div id="login-button">
        <img src="https://dqcgrsy5v35b9.cloudfront.net/cruiseplanner/assets/img/icons/login-w-icon.png">
    </div>
    <div id="container">
        <h1>Log In</h1>
        <span class="close-btn">
            <img src="https://cdn4.iconfinder.com/data/icons/miu/22/circle_close_delete_-128.png"></img>
        </span>

        <form action="signInChk" method="post" id="frm">
            <input type="email" name="id" id="id" placeholder="e-mail">
            <div style="margin: 30px">
                <font id="idchk"></font>
            </div>
            <input type="password" name="pwd" placeholder="password">
            <div style="margin: 30px; color : red">${wrongInfo}</div>
            <a id="submitBtn">Login</a>
            <div id="remember-container">
                <input type="checkbox" id="keepSignIn" class="checkbox" checked="checked">
                <span id="remember">Remember me</span>
                <span id="forgotten">회원가입</span>
            </div>

        </form>
    </div>
</body>
<script type="text/javascript">
	var idFlag = false;

	$('#id').keyup(function(){ // 아이디 유효성 체크
		let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
		let idchk = $('#idchk');
		if(!regex.test($('#id').val())){
			idchk.html('올바른 이메일 형식이 아닙니다.');
			idchk.attr('color',"red");
			idFlag = false;
		}else{		
			idchk.html('');
			idFlag = true;
		}
	});
	
	$('#submitBtn').on('click', () => { // 전송
		console.log(1);
		if(idFlag){
			$('#frm').submit();
		}else{
			alert('아이디를 확인해주세요');
		}
	});
	
	
	$('#login-button').click(function () {
        $('#login-button').fadeOut("slow", function () {
            $("#container").fadeIn();
        });
    });

    /* signUp */
    const url = '/realtor/signUp';
    $('#forgotten').click(function () {
        location.href = url;
    });
    
    // back to home
    $('.close-btn').click(() => {
        console.log(1);
        location.href = '/realtor';
    });
</script>
</html>