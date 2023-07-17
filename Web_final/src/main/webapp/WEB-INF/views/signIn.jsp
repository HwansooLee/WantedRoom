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
<style>
	#signUp{
		position: absolute;
		font-size: 13px;
		font-family: 'Hind', sans-serif;
		color: black;
		right: 0px;
		top: 8px;
		cursor: pointer;
		-webkit-transition: all 2s ease-in-out;
		-moz-transition: all 2s ease-in-out;
		-o-transition: all 2s ease-in-out;
		transition: all 0.2s ease-in-out;
	}
	#signUp:hover{
		color: blue;
		text-decoration: underline;
	}
	/* Login container */
	#container{
		margin: auto;
		width: 25%;
		height: 50%;
		border: 1px solid #14A44D;
		border-radius: 5px;
		background: white;
		box-shadow: none;
		/* display: none; */
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
	#remember{
		position: absolute;
		font-size: 13px;
		font-family: 'Hind', sans-serif;
		color: black;
		top: 7px;
		left: 20px;
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
	#submitBtn:hover{
		box-shadow: 3px 3px 10px #333;
		opacity: 1;
	}
</style>
<body>
    <div id="container">
		<a id="logoArea" href = "<%=request.getContextPath()%>/">
			<img src = "resources/image/logo.png" width = "200">
		</a><br>
		
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
                <span id="signUp">회원가입</span>
            </div>
        </form><br>
    </div>
	<jsp:include page="footer.jsp"/>
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
	
	$("#container").fadeIn();

    /* signUp */
    const url = '/realtor/signUp';
    $('#signUp').click(function () {
        location.href = url;
    });
    
    // back to home
    $('.close-btn').click(() => {
        console.log(1);
        location.href = '/realtor';
    });
</script>
</html>