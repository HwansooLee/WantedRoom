<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 폼</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href = "resources/css/myPage.css">
<body>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<!-- 홈페이지 로고 -->
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">
				<img class="logoImg" src="resources/image/logo.png">
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
						aria-current="page" href = "" id = "addItem">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
				</ul>
				<div class = "searchDiv border-success">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력" class = "inputSword">
						<input type="submit" value="검색" class = "submitBtn btn-success">
					</form>
				</div>
				<span class = "navbar-text">
					<button type="button" class="btn btn-outline-secondary" id = "logOutBtn">로그아웃</button>
				</span>
			</div>
		</div>
	</nav>
	<!-- 등록번호인증된 회원만 세션으로 걸러서 나오게 한다 -->

	<div class="card border border-success"
		style="width: 83%; height: 100%; margin: 0 auto; margin-top: 100px">
		<div class="card-body">
			<div class="card-group">
				<c:if test="${realtorNo eq null}">
					<a href="registerRealtorNo" class="myPageMenu">
						<div class="card">
							<img src="resources/image/certification.png" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">공인중개사 등록번호 등록하기</h5>
								<p class="card-text">매물등록을 하고싶다면<br>공인중개사 등록번호를<br> 인증해주세요</p>
							</div>
						</div>
					</a>
				</c:if>
				<c:if test="${realtorNo ne null}">
					<a href="myItemList" class="myPageMenu">
						<div class="card">
							<img src="resources/image/itemAd.png" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">매물 게시글 관리</h5>
								<p class="card-text">내가 올린 매물을 관리 할 수 있어요<br><br><br></p>
							</div>
						</div>
					</a>
				</c:if>
				<a href="myBoardList" class="myPageMenu">
					<div class="card">
						<img src="resources/image/boardAd.png" class="card-img-top">
						<div class="card-body">
							<h5 class="card-title">리뷰 게시글 관리</h5>
							<p class="card-text">내 리뷰를 수정 및 삭제 <br> 할 수 있어요<br><br></p>
						</div>	
					</div>
				</a>
				<a href="myReplyList" class="myPageMenu">
					<div class="card">
						<img src="resources/image/replyAd.png" class="card-img-top">
						<div class="card-body">
							<h5 class="card-title">댓글관리</h5>
							<p class="card-text">내 댓글을 삭제할 수 있어요<br><br><br></p>
						</div>
					</div>
				</a>
			</div>
		</div>
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
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	$('#logOutBtn').on('click', () => {
		location.href = "signOut";
	});
	
	$('#addItem').on('click', () => {
		var authenticated = '${authenticated}';
		if(authenticated == 'false'){
			alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다.');
		}else{
			$('#addItem').attr('href','addItemForm');
		}
	});
</script>
</html>