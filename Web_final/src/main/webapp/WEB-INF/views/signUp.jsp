<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
  	/* Login container */
	#container{
		margin: auto;
		width: 28%;
		height: 75%;
		border: 1px solid #14A44D;
		border-radius: 5px;
		background: white;
		box-shadow: none;
		margin-bottom: 20px;
	}
	a{
		font-family: 'Open Sans Condensed', sans-serif;
		text-decoration: none;
		position: relative;
		width: 80%;
		display: block;
		margin: 9px auto;
		font-size: 17px;
		color: black;
		padding: 8px;
		border-radius: 6px;
		background: white;
		border: 1px solid #14A44D;
		-webkit-transition: all 2s ease-in-out;
		-moz-transition: all 2s ease-in-out;
		-o-transition: all 2s ease-in-out;
		transition: all 0.2s ease-in-out;
	}
	img{
		display: block;
		margin: auto;
		width: 100%;
		height: auto;
	}
	/* Inputs */
	input{
		font-family: 'Open Sans Condensed', sans-serif;
		text-decoration: none;
		position: relative;
		width: 80%;
		display: block;
		margin: 9px auto;
		font-size: 17px;
		color: black;
		padding: 8px;
		border-radius: 6px;
		background: white;
		border: 1px solid gray;
		-webkit-transition: all 2s ease-in-out;
		-moz-transition: all 2s ease-in-out;
		-o-transition: all 2s ease-in-out;
		transition: all 0.2s ease-in-out;
	}
	input:focus{
		outline: none;
		box-shadow: 3px 3px 10px #333;
		background: white;
		border: 1px solid #14A44D;
	}
	div.textFix{
		font-family: 'Open Sans Condensed', sans-serif;
		position: relative;
		margin-top: 0px;
		text-align: left;
		font-size: 18px;
		color: black;
		margin-left: 30px;
	}
	/* Placeholders */
	::-webkit-input-placeholder {
		color: gray;  }
	:-moz-placeholder { /* Firefox 18- */
		color: red;  }
	::-moz-placeholder {  /* Firefox 19+ */
		color: red;  }
	:-ms-input-placeholder {  
		color: #333;  }

	#logoArea{
		border: none;
		align-content: center;
	}
	#submitBtn{
		background-color: #14A44D;
	}
	#certification{
		background-color: #14A44D;
	}
	#submitBtn:hover, #certification:hover{
		box-shadow: 3px 3px 10px #333;
		opacity: 1;
	}
	#logoArea{
		display: block;
		width: 27%;
	}
	img{
	    display: block;
	    margin: auto;
	    width: 100%;
	    height: auto;
	}
</style>
<body>
	<a id="logoArea" href = "<%=request.getContextPath()%>/">
		<img src = "resources/image/logo.png">
	</a>
	<div id="container"><br>
        <form id = "frm" action = "signUp_save" method = "POST">
            <div class="textFix">아이디*</div>
            <div>
                <input type = "email" id = "id" name = "id" placeholder="Email" maxlength="30">
                <input type = "button" value = "메일인증" id = "certification">
                <div><font id = "idchk"></font></div>
                <div>
                    <input type = "text" id = "certiNumber" placeholder = "인증번호 6자리 입력" disabled = "disabled" maxlength = "6">
                    <font id = "mailChk" style="margin: 10px; margin-left: 30px;"></font>
                </div>
            </div>
            <div class="textFix">이름*</div> <!-- 중복체크 해야 한다 -->
            <input type = "text"  id = "name" name = "name" placeholder="이름입력" maxlength="20">
            <div class="textFix">닉네임*</div> <!-- 중복체크 해야 한다 -->
            <input type = "text"  id = "nickname" name = "nickname" placeholder="닉네임 입력" maxlength="12">
            <div><font id = "nicknameChk" style="margin: 10px; margin-left: 30px;"></font></div>
            <div class="textFix">비밀번호*</div>
            <input type = "password" id = "pwd" name = "pwd" placeholder="특문,영문대소문자 포함 8자리이상" maxlength="20">
            <div><font id = passChk style="margin: 10px; margin-left: 30px;"></font></div>
            <div class="textFix">*은 필수 입력 사항 입니다.</div><br>
            <input type = "button" id = "submitBtn" value = "회원가입">
        </form>
    </div>
	<jsp:include page="footer.jsp"/>
</body>
<script type="text/javascript">
	
	var idFlag = false;
	var nicknameFlag = false;
	var pwdFlag = false;
	var nameFlag = false;
	var codeFlag = false;
	var code = '';
	
	$('#certiNumber').keyup(function(){
		const mailFlag = $('#mailChk');
		if(code == $('#certiNumber').val() && code != 'false'){
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
		const mailFlag = $('#mailChk');
		const mailChk = $('#certiNumber');
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
			,success : function(nowdata){
				mailChk.attr('disabled',false);
				code = nowdata;
				if(!code){
					mailFlag.attr("color","red");
					mailFlag.html('이미 존재하는 아이디 입니다.');
				}else{
					alert('인증번호가 발송되었습니다.');
				}
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
	
	 // back to home
    $('.close-btn').click(() => {
        location.href = '/realtor';
    });

</script>
</html>