<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공인중개사 등록번호 등록폼</title>
</head>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href = "resources/css/myPage.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	/* apply for all section exclude footerSec */
	section:not(.footerSec){ 
		width: 100%; 
        height: 60vh; 
        display: -webkit-box; 
        display: -moz-box;
        display: -ms-flexbox; 
        display: flex; 
 
        -webkit-box-align: center; 
        -moz-box-align: center;
        -ms-flex-align: center;
        align-items: center; /* 수직 정렬 */
 
        -webkit-box-pack: center;
        -moz-box-pack: center; 
        -ms-flex-pack: center; 
        justify-content: center; /* 수평 정렬 */
	}	
	#regBtn{
		color: white;
		background-color: #198754;
		border: 1px solid black;
		border-radius: 4px;
	}
	body{
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	footer{
		margin-top: auto;
	}
</style>
<body>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<!-- 홈페이지 로고 -->
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> <img
				class="logoImg" src="resources/image/logo.png">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="addItem" id="addItem">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
					<c:if test="${id ne null}">
						<li class="nav-item">
							<a class="nav-link" href="myPage">${nickname}</a>
						</li>
				 	</c:if>
				</ul>
				<div class="searchDiv border-success">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력"
							class="inputSword"> <input type="submit" value="검색"
							class="submitBtn btn-success">
					</form>
				</div>
				<span class="navbar-text">
					<button type="button" class="btn btn-outline-secondary"
						id="logOutBtn">로그아웃</button>
				</span>
			</div>
		</div>
	</nav>
	<!-- 공인중개사번호 입력 공간 -->
	<section>
		<div class="card border border-success" style = "width: 30%;height:20%;">
			<div class="card-body">
			<div class="card-title">공인중개사 등록번호를 입력해주세요.</div>
				<form class="card-text" action="regRealtorSave" method = "post" id = "frm">
					<input type = "text" id = "realtorNo" name = "realtorNo" placeholder="-도 같이 입력해주세요" maxlength="16">
					<input type = "button" id = "regBtn" value = "등록">
				</form>
			</div>
		</div>
	</section>

	<footer class="text-center text-lg-start bg-light text-muted">
		<hr>
		<!-- Section: Links  -->
		<section class="footerSec">
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
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
/* 	const hypenRealtorNo = (target) => { // 정규식으로 공인중개사 등록번호 입력제한
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
	*/
	
	// 유효성 체크 : api 사용
	
	const userName = '${userName}';
	var rno = $('#realtorNo');
	$('#regBtn').on('click', () => {
		// 비동기로 membervo 객체를 파라미터로 전달
		// json으로 리턴 받는다.
		let memberVO = {
				name : userName,
				realtorNo : rno.val()
		};
		$.ajax({
			url : "getRealtorInfo"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(memberVO)
			,contentType : "application/json"
			,success : function(data){
				if(data.EBBrokers.totalCount == '1'){ // 존재하는 데이터라면 전송
                	$('#frm').submit(); 
                }else{ // 존재하는 데이터가 아닌경우
                	alert('유효한 등록번호가 아닙니다');
                }
			}
			,error : function(){
				console.log('error');
			}
		});
	});
</script>
</html>