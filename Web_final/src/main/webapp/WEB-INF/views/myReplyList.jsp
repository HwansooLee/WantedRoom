<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 댓글 관리 폼</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/menuBar.css">
<link rel="stylesheet" href = "resources/css/myReplyList.css">
<style>
	thead{
		background-color: #D1E7DD;
		font-weight: bold;
		border-color: black;
		border-bottom-width: 2px;
	}
	tbody{
		background-color: #D1E7DD;
		border-color: #ccc;
	}
	section{
		text-align: center;
	}
</style>
</head>
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
					<c:if test="${id eq null}">
						<li class="nav-item">
							<a class="nav-link" href="signIn">로그인</a>
                        </li>
                        <li class="nav-item">
                           	<a class="nav-link" href="signUp">회원가입</a>
                        </li> 
                    </c:if>
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
				<c:if test="${id ne null}">
					<span class="navbar-text">
						<button type="button" class="btn btn-outline-secondary"
							id="logOutBtn">로그아웃</button>
					</span>
				</c:if>
			</div>
		</div>
	</nav><br><br><br>
	<section>
		<h3><strong>내 댓글 목록</strong></h3>
	</section>
	<br><br>
<table border = "1" class = "table">
	<thead>
		<tr>
			<td>댓글 번호</td>
			<td>내용</td>
			<td>작성일</td>
			<td>좋아요수</td>
			<td>삭제</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "replyvo" items = "${rlist}">
			<tr>
				<td>${replyvo.replyNo}</td>
				<td>${replyvo.content}</td>
				<td>${replyvo.inDate}</td>
				<td>${replyvo.likes}</td>
				<td>
					<a href = "myReplyDel?replyNo=${replyvo.replyNo}">
						<img src = "resources/image/delete.png" width = "20">
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 페이지 번호 들어갈 위치 -->
<div class = "pageValue">
	<ul class="pagination justify-content-center"> 
		<li class="page-item ${pagevo.prev ? '' : 'disabled'}">
			<a class="page-link" href = "myReplyList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">이전 페이지</a>
		</li>
		<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
		<li class="page-item ${idx eq pagevo.page ? 'active' : ''}">
			<a class="page-link" href = "myReplyList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
		</li>
		</c:forEach>
		<li class="page-item ${pagevo.next ? '' : 'disabled'}">
			<a class="page-link" href = "myReplyList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">다음 페이지</a>
		</li>
	</ul>
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
<script>
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
</script>
</html>