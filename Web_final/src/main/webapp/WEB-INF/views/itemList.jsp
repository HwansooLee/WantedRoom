<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href = "resources/css/itemList.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
	<!-- 검색창 -->
	<div class = "searchDiv">
		<form action="searchItem" method="get">
			<input type="text" name="sword" placeholder="검색할 주소 입력" class = "inputSword">
			<input type="submit" value="검색" class = "submitBtn">
		</form>
	</div>

	<!-- 매물 리스트 -->
<div class = "card-group">
	<c:forEach var="item" items="${itemList}" varStatus = "idx">
		<div class="itemDiv">
			<div class="card" style="width: 18rem;">
				<div class="card-body">
					<p class="card-text">
						<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">	
							<img src="download?fileName=${item.fileName}" class="card-img-top" style="height: 10rem;">
							<c:if test="${item.status == '계약가능'}">
								<input type="button" value="${item.status}"><br>
							</c:if>
							<c:if test="${item.status == '계약완료'}">
								<input type="button" value="${item.status}" class="soldBtn"><br>
							</c:if>
							
							<span id="itemNo">매물번호 : ${item.itemNo}</span><br>
							<span>매물주소 : ${item.addr}</span><br>
							<span>보증금 : ${item.deposit}</span><br>
							<span>월세 : ${item.rent}</span><br>
							<input type="button" value="#주차${item.parking}">
							<input type="button" value="#엘리베이터${item.elevator}">
							<input type="button" value="#${item.buildingType}">	
						</a>
					</p>
				</div>
			</div>
		</div>
<%-- 		<c:if test = "${idx.index%2 == 1}">
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</c:if> --%>
		<%-- <div class="itemDiv">
			<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">
				<input type="button" value="${item.status}"><br>
				<img src="download?fileName=${item.fileName}"><br>
				<span id="img">이미지 : ${item.fileName}</span><br>
				<span id="itemNo">매물번호 : ${item.itemNo}</span><br>
				<span>매물주소 : ${item.addr}</span><br>
				<span>보증금 : ${item.deposit}</span><br>
				<span>월세 : ${item.rent}</span><br>
				<input type="button" value="#주차${item.parking}">
				<input type="button" value="#엘리베이터${item.elevator}">
				<input type="button" value="#${item.buildingType}">
			</a>
		</div> --%>
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