<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/modifyBoard.css">
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="addItemForm">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
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
	<section>
		<div class="card border border-success"
			style="width: 70%; height: 100%">
			<div class="card-body">
				<h5 class="card-title">게시글 수정 폼</h5>
				<br>
				<h6 class="card-subtitle mb-2 text-muted">게시글 수정 폼입니다 :)</h6>
				<br>
				<form action="modifyBoardSave" method="post" id="frm">
					<input type="hidden" name="boardNo" value="${boardvo.boardNo}">
					<table class="table">
						<tr>
							<td>아이디</td>
							<td><input type="text" name="id" value="${boardvo.id}" readonly></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input type="text" name="title" value="${boardvo.title}"
						class="boardInput"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text"
						name="addr" value="${boardvo.addr}" class="boardInput" readonly></td>
						</tr>
					</table>
					내용<br>
					<textarea rows="20" cols="80" name="content" class="boardInput">${boardvo.content}</textarea>
					<br>
					<button type="button" class="btn btn-outline-success" id="saveBtn">게시글
						저장</button>
				</form>
			</div>
		</div>
	</section>
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
						<p></p>
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
	var btn = $('#saveBtn');
	var input = $('.boardInput');
	var frm = $('#frm');
	btn.on('click',() => {
		for(i = 0; i < 3; i++){
			if(input[i].value == '') {
				return alert('공란이 있습니다.');
			}
		}
		return frm.submit();
	});
</script>
</html>