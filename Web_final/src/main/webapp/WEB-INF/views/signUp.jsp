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
	<div>
		<input type = "email" id = "id" name = "id" placeholder="Email" maxlength="30">
		<input type = "button" value = "본인인증" id = "certification">
		<div><font id = "idchk"></font></div>
		<div>
			<input type = "text" id = "certiNumber" placeholder = "인증번호 6자리를 입력해주세요." disabled = "disabled" maxlength = "6">
			<font id = "mailChk"></font>
		</div>
	</div>
	<div>이름*</div> <!-- 중복체크 해야 한다 -->
	<input type = "text"  id = "name" name = "name" placeholder="이름입력" maxlength="20">
	<div>닉네임*</div> <!-- 중복체크 해야 한다 -->
	<input type = "text"  id = "nickname" name = "nickname" placeholder="닉네임 입력" maxlength="12">
	<div><font id = "nicknameChk"></font></div>
	<div>비밀번호*</div>
	<input type = "password" id = "pwd" name = "pwd" placeholder="특문,영문대소문자 포함 8자리이상" maxlength="20">
	<div><font id = passChk></font></div>
	<div>*은 필수 입력 사항 입니다.</div>
	<input type = "button" id = "submitBtn" value = "회원가입">
</form>
</body>
<script type="text/javascript">
	
	var idFlag = false;
	var nicknameFlag = false;
	var pwdFlag = false;
	var nameFlag = false;
	var codeFlag = false;
	var code = '';
	
	$('#certiNumber').keyup(function(){
		const mailFlag = $(mailChk);
		if(code == $('#certiNumber').val()){
			mailFlag.attr("color","green");
			mailFlag.html('일치합니다.');
			codeFlag = true;
		}else{
			mailFlag.attr("color","red");
			mailFlag.html('불일치합니다.');
			codeFlag = false;
		}
	});
	
	$('#certification').on('click', () => {
		let email = $('#id').val(); // 사용자가 입력한 이메일 가져옴
		const mailChk = $('#certiNumber');
		console.log(email);
		// 비동기 방식으로 본인인증을 진행한다.
		let maildata = {
				"id" : email
		};
		$.ajax({
			url : "mailChk"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(maildata)
			,contentType : "application/json"
			,success : function(nowdata){ // data는 인증번호를 의미한다.
				mailChk.attr('disabled',false);
				alert('인증번호가 발송되었습니다.');
				code = nowdata;
				console.log(nowdata);
			}
			,error : function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	});
	
	$('#submitBtn').on('click', (e) => { // 회원가입 버튼 눌렀을 경우
		if(idFlag && nicknameFlag && pwdFlag && nameFlag && codeFlag){
			$('#frm').submit(); // 전송
		}else{
			alert('필수 입력항목을 확인해주세요.')
		}
	});
	
	// 이름 유효성 체크
	$('#name').keyup(function(){
		if($('#name').val() != ''){
			nameFlag = true;
		}else{
			nameFlag = false;
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