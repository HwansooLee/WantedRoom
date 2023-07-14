<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글 리스트 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
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
<body>
	<a href = "<%=request.getContextPath()%>/">
		<img src = "resources/image/logo.png" width = "200">
	</a>
	<br><br><br><br><br><br><br>
	<section>
		<h3><strong>내 리뷰 목록</strong></h3>
	</section>
	<br><br>
	<table border = "1" class = "table">
		<thead>
			<tr>
				<td>게시글 번호</td>
				<td>제목</td>
				<td>주소</td>
				<td>조회수</td>
				<td>등록일</td>
				<td>수정</td>
				<td>삭제</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var = "boardvo" items = "${blist}">
				<tr>
					<td>${boardvo.boardNo}</td>
					<td>${boardvo.title}</td>
					<td>${boardvo.addr}</td>
					<td>${boardvo.views}</td>
					<td>${boardvo.inDate}</td>
					<td>
						<a href = "myBoardModify?boardNo=${boardvo.boardNo}">
							<img src = "resources/image/modify.png" width = "20">
						</a>
					</td>
					<td>
						<a href = "myboardDel?boardNo=${boardvo.boardNo}">
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
				<a class="page-link" href = "myBoardList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">이전 페이지</a>
			</li>
			<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
				<li class="page-item ${idx eq pagevo.page ? 'active' : ''}">
					<a class="page-link" href = "myBoardList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
				</li>
			</c:forEach>
			<li class="page-item ${pagevo.next ? '' : 'disabled'}">
				<a class="page-link" href = "myBoardList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">다음 페이지</a>
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
<script type="text/javascript">
</script>
</html>