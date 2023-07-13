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
<style>
	.logoImg{
		width: 200px;
		display: block;
		margin: -15px 0 -15px 0;
	}
	.card-img-top{
		display: block;
		margin: 10px auto;
		width: 30%;
	}
	a{
		text-decoration: none;
		color: black;
	}
	.card-title{
		text-align: center;
	}
	.card-text{
		text-align: center;
		margin: auto;
	}
	.myPageMenu{
		width: 30%;
		height: 100%;
		margin: 0 15px 0 15px;
	}
</style>
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="addItemForm">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
				</ul>
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
</body>
<script type="text/javascript">
	$('#logOutBtn').on('click', () => {
		location.href = "signOut";
	});
</script>
</html>