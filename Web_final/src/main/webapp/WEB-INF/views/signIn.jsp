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
<body>
	<form action="signInChk" method = "post" id = "frm">
		<div><font>아이디</font></div>
		<input type = "email" name = "id" id = "id">
		<div><font id = "idchk"></font></div>
		<div><font>비밀번호</font></div>
		<input type = "password" name = "pwd">
		<div style = "color:red">${wrongInfo}</div>
		<br>
		<div>
		<input type = "checkbox" id = "keepSignIn">
		<font color = 'blue' size="1">로그인 상태 유지</font>
		</div>
		<input type = "button" value = "Login" id = "submitBtn">
	</form>
	<a href = "signUp">[회원가입]</a>
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
		if(idFlag){
			$('#frm').submit();
		}else{
			alert('아이디를 확인해주세요');
		}
	});
</script>
</html>