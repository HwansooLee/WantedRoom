<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/menuBar.css">
<link rel="stylesheet" href="resources/css/itemList.css">
<link rel="stylesheet" href="resources/css/colorItemTag.css">
<style>
	button[type="submit"]{
		width: 100px;
	}

</style>
<body>
<!--nav-->
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
							class="inputSword"> 
						<input type="submit" value="검색" class="submitBtn btn-success">
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
	</nav>
	<div class="card-group">
		<c:forEach var="item" items="${itemList}">
			<div class="itemDiv">
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<p class="card-text">
							<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">
								<input type="button" value="${item.status}" class="statusBtn">
								<img src="download?fileName=${item.fileName}" class="itemImg">
								<table>
									<thead>
										<th style="width: 35%;"> </th>
                    					<th style="width: 65%;"> </th>
									</thead>
									<tr>
										<td><span>매물번호 : </span></td>
										<td><span id="itemNo">${item.itemNo}</span></td>
									</tr>
									<tr>
										<td><span>주소 : </span></td>
										<td rowspan="3"><span>${item.addr}</span></td>
									</tr>
									<tr></tr>
									<tr></tr>
									<tr>
										<td><span>보증금 :</span></td>
										<td><span>${item.deposit} 원</span></td>
									</tr>
									<tr>
										<td><span>월세 : </span></td>
										<td><span>${item.rent} 원</span></td>
									</tr>
									<tr>
										<td></td>
									</tr>
									<tr>
										<td>
											<input type="button" value="주차${item.parking}" class="parking">
										</td>
										<td>
											<input type="button" value="엘리베이터${item.elevator}" class="elevator">
										</td>
									</tr>
									<tr>
										<td>
											<input type="button" value="${item.buildingType}" class="buildingType">
										</td>
										<td></td>
									</tr>
								</table> 
							</a>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<br>
	<!-- paging -->
	<div class = "pageValue">
		<ul class="pagination justify-content-center">
			<li class="page-item ${pageVO.prev ? '' : 'disabled'}">
				<a class="page-link" href="searchItem?page=${pageVO.startPage -1}&sword=${pageVO.sword}">이전</a>
			</li>
			<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">
				<li class="page-item ${idx eq pageVO.page ? 'active' : ''}">
					<a class="page-link" href="searchItem?page=${idx}&sword=${pageVO.sword}">${idx}</a>
				</li>
			</c:forEach>
			<li class="page-item ${pageVO.next ? '' : 'disabled'}">
				<a class="page-link" href="searchItem?page=${pageVO.endPage +1}&sword=${pageVO.sword}">다음</a>
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
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	$('head').append('<script src=\'././resources/script/colorItemTag.js\'><\/script>');
	$('.statusBtn').each((i, obj)=>{
		if( $(obj).val() == '계약가능' )
			$(obj).closest('.card').addClass('border-success');
		else
			$(obj).closest('.card').addClass('border-dark');
	})

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