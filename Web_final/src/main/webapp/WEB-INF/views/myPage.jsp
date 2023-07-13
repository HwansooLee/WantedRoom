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
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> <img
				src="resources/image/logo.png" width="200">
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
				<div class = "searchDiv">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력" class = "inputSword">
						<input type="submit" value="검색" class = "submitBtn">
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
		style="width: 70%; height: 100%; margin: 0 auto; margin-top: 100px">
		<div class="card-body">
			<div class="card-group">
				<c:if test="${realtorNo eq null}">
					<div class="card">
						<img src="resources/image/certification.png" class="card-img-top"
							height="50%">
						<div class="card-body">
							<h5 class="card-title">
								<a href="registerRealtorNo">공인중개사 등록번호 등록하기</a>
							</h5>
							<p class="card-text">매물등록을 하고싶다면 공인중개사 등록번호를 인증해주세요</p>
						</div>
					</div>
				</c:if>
				<c:if test="${realtorNo ne null}">
					<div class="card">
						<img src="resources/image/itemAd.png" class="card-img-top"
							height="50%">
						<div class="card-body">
							<h5 class="card-title">
								<a href="myItemList">매물 게시글 관리</a>
							</h5>
							<p class="card-text">자신이 올린 매물을 관리 할수 있습니다</p>
						</div>
					</div>
				</c:if>
				<div class="card">
					<img src="resources/image/boardAd.png" class="card-img-top"
						height="50%">
					<div class="card-body">
						<h5 class="card-title">
							<a href="myBoardList">리뷰 게시글 관리</a>
						</h5>
						<p class="card-text">자신의 리뷰를 수정 및 삭제 할수 있습니다</p>
					</div>
				</div>
				<div class="card">
					<img src="resources/image/replyAd.png" class="card-img-top"
						height="50%">
					<div class="card-body">
						<h5 class="card-title">
							<a href="myReplyList">댓글관리</a>
						</h5>
						<p class="card-text">자신의 댓글을 삭제할수 있습니다</p>
					</div>
				</div>
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