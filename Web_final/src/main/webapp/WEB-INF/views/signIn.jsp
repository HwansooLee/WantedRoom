<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
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
    <footer class="text-center text-lg-start bg-light text-muted">
		<hr>
		<!-- Section: Links  -->
		<section class="">
		<div class="container text-center text-md-start mt-5">
			<!-- Grid row -->
			<div class="row mt-3">
			<!-- Grid column -->
			<div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
				<!-- Content -->
				<h6 class="text-uppercase fw-bold mb-4">
				<i class="fas fa-gem me-3"></i>Wanted Room
				</h6>
				<p>
				</p>
			</div>
			<!-- Grid column -->
			<!-- <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
				<h6 class="text-uppercase fw-bold mb-4">Location</h6>
				<p>Human Education Center, 100, Jungbu-daero, Paldal-gu, Suwon-si, Gyeonggi-do, Republic of Korea</p>
			</div> -->
			<!-- Grid column -->
			<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
				<!-- Links -->
				<h6 class="text-uppercase fw-bold mb-4">Developers</h6>
				<p>Jaewan Song</p>
				<p>Hwansoo Lee</p>
			</div>
			<!-- Grid column -->
			<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
				<!-- Links -->
				<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
				<p>obliviat3@naver.com</p>
				<p>hwansu29@naver.com</p>
			</div>
			<!-- Grid column -->
			</div>
			<!-- Grid row -->
		</div>
		</section>
		<!-- Section: Links  -->
	</footer>
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