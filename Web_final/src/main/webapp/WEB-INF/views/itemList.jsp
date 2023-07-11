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
<style>
	.itemDiv{
		margin: 0 auto;
		height: 400px;
 		width: 25%;
 		height: 30%;
 		diplay: flex;	
	}
 	a.fillDiv{
		display: block;
		height: 100%;
		width: 100%;
		text-decoration: none;
	}
	.page-item.active .page-link {
		 z-index: 1;
		 color : green;
		 font-weight:bold;
		 background-color: rgb(177, 245, 171);
		 border-color: #ccc;
	 
	}
	
	.page-link {
		 color: green; 
		 background-color: #fff;
		 font-weight:bold;
		 border: 1px solid #ccc; 
	}
</style>
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
	<form action="searchItem" method="get">
		<input type="text" name="sword" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>

	<!-- 매물 리스트 -->
<div class = "card-group">
	<c:forEach var="item" items="${itemList}" varStatus = "idx">
		<div class="itemDiv">
			<div class="card" style="width: 18rem;">
				<div class="card-body">
					<p class="card-text">
						<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">	
							<img src="download?fileName=${item.fileName}" class="card-img-top" style="height: 10rem;">
							<input type="button" value="${item.status}"><br>
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
	<footer>
		<!-- 개발자 정보 -->
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