<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<h3>회원가입</h3>
<hr>
<form id = "frm" action = "signUp_save" method = "POST">
	<div>아이디*</div>
	<input type = "email" id = "id" name = "id" placeholder="Email" maxlength="30">
	<div><font id = "idchk"></font></div>
	<div>닉네임*</div> <!-- 중복체크 해야 한다 -->
	<input type = "text"  id = "nickname" name = "nickname" placeholder="닉네임 입력" maxlength="12">
	<div><font id = "nicknameChk"></font></div>
	<div>비밀번호*</div>
	<input type = "password" id = "pwd" name = "pwd" placeholder="특문,영문대소문자 포함 8자리이상" maxlength="20">
	<div><font id = passChk></font></div>
	<div>공인중개사 등록번호</div>
	<input type = "text" id = "realtorNo" name = "realtorNo" oninput = "hypenRealtorNo(this)" maxlength="16">
	<div>*은 필수 입력 사항 입니다.</div>
	<input type = "button" id = "submitBtn" value = "회원가입">
</form>
</body>
<script type="text/javascript">
	
	var idFlag = false;
	var nicknameFlag = false;
	var pwdFlag = false;
	
	const hypenRealtorNo = (target) => { // 정규식으로 공인중개사 등록번호 입력제한
		target.value = target.value
      	.replace(/[^0-9]/g, '');
		if(target.value.length == 12){
			target.value = target.value
	      	.replace(/^(\d{8})(\d{4})$/, `$1-$2`);
		}
		if(target.value.length > 12){
			target.value = target.value
	      	.replace(/^(\d{5})(\d{4})(\d{5})$/, `$1-$2-$3`);
		}
	}
	
	$('#submitBtn').on('click', (e) => { // 회원가입 버튼 눌렀을 경우
		if(idFlag && nicknameFlag && pwdFlag){
			$('#frm').submit(); // 전송
		}
	});
	
	// 아이디 유효성 체크
	$('#id').keyup(function(){
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
	
	// 닉네임 중복검사 비동기 방식
	$('#nickname').keyup(function(){
		let nicknameChk = $('#nicknameChk');
		let data = {
			nickname : $('#nickname').val()
		}
		$.ajax({
			url : "nicknameChk"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(data)
			,contentType : "application/json"
			,success : function(data){
				if(data && $('#nickname').val() != ''){
					nicknameChk.html('사용가능한 닉네임 입니다.');
					nicknameChk.attr('color','green');
					nicknameFlag = true;
				}else{
					nicknameChk.html('사용불가능한 닉네임 입니다.');
					nicknameChk.attr('color','red');
					nicknameFlag = false;
				}
			}
			,error : function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	});
	
	//비밀번호 유효성 체크
	$('#pwd').keyup(function(){
		let strongPassword = new RegExp('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})');
		let pwd = $('#pwd');
		let pChk = $('#passChk');
		if(strongPassword.test(pwd.val())){
			pChk.html('사용가능한 비밀번호 입니다.');
			pChk.attr('color','green');
			pwdFlag = true;
		}else{
			pChk.html('사용 불가능한 비밀번호 입니다.');
			pChk.attr('color','red');
			pwdFlag = false;
		}
	});

</script>
</html>