<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 리스트 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href = "resources/css/board_list.css">
<body>
<!--nav-->
    <nav class="navbar bg-light fixed-top">
        <div class="container-fluid">
            <!--logo-->
            <a class="navbar-brand" href="<%=request.getContextPath()%>/">
                <img src="resources/image/logo.png" width="300">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar" style="background-color: lightgreen;">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
                aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasNavbarLabel">menu</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                        <li class="nav-item">
                            <a href="" id="addItem">매물 등록</a>
                        </li>
                        <br>
                        <li class="nav-item">
                            <a href="boardList">리뷰</a>
                        </li>
                        <br>
                        <c:if test="${id eq null}">
                            <li class="nav-item">
                                <a href="signIn">로그인</a>
                            </li>
                            <br>
                            <li class="nav-item">
                                <a href="signUp">회원가입</a>
                            </li> 
                        </c:if>
                        <c:if test="${id ne null}">
                            <li class="nav-item">
                                <a href="myPage">${nickname}</a>
                            </li>
                            <br>
                            <li class="nav-item">
                                <a href="signOut">로그아웃</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
	<br><br><br><br><br><br><br>
	<section>
		<h3><strong>우리동네 게시판</strong></h3>
		<br>
	</section>
    
	
<form action="boardList" method = "get" id = "frm">
	<select id = "sel" name = "sorted">
		<option value="">==정렬기준==</option>
		<option value="nickname" ${pagevo.sorted eq "nickname" ? 'selected' : '' }>닉네임순</option>
		<option value="inDate" ${pagevo.sorted eq "inDate" ? 'selected' : '' }>등록일순</option>
		<option value="views" ${pagevo.sorted eq "views" ? 'selected' : '' }>조회순</option>
	</select>
</form>
<br>
<table class = "table table-success">
	<thead>
		<tr>
			<td><strong>게시글 번호</strong></td>
			<td><strong>닉네임</strong></td>
			<td><strong>제목</strong></td>
			<td><strong>주소</strong></td>
			<td><strong>조회수</strong></td>
			<td><strong>등록일</strong></td>
		</tr>
	</thead>
	<tbody class="table-group-divider">
		<c:forEach var = "boardvo" items = "${blist}">
			<tr>
				<td>${boardvo.boardNo}</td>
				<td>${boardvo.nickname}</td>
				<td><a href = "detailBoard?boardno=${boardvo.boardNo}">${boardvo.title}</a></td>
				<td>${boardvo.addr}</td>
				<td>${boardvo.views}</td>
				<td>${boardvo.inDate}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 게시글 작성 버튼 -->
<span class = "writeBtn">
	<button type="button" class="btn btn-outline-success" id = "writeBtn">게시글 작성</button>
</span>
<!-- 페이지 번호 들어갈 위치 -->
<div class = "pageValue">
	<ul class="pagination justify-content-center"> 
		<li class="page-item ${pagevo.prev ? '' : 'disabled'}">
			<a class="page-link" href = "boardList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">이전 페이지</a>
		</li>
		<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
		<li class="page-item ${idx eq pagevo.page ? 'active' : ''}">
			<a class="page-link" href = "boardList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
		</li>
		</c:forEach>
		<li class="page-item ${pagevo.next ? '' : 'disabled'}">
			<a class="page-link" href = "boardList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">다음 페이지</a>
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
	var frm = $('#frm');
	var sel = $('#sel');
	
	sel.on('change',(e) =>{
		frm.submit();
	});
	
	$('#writeBtn').on('click', () => {
		location.href = '/realtor/inputBoard';
	});
</script>
</html>