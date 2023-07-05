<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<style>
	.itemDiv{
		background-color: white;
		height: 400px;
		width: 50%;
		float: left;
	}
	a.fillDiv{
		display: block;
		height: 100%;
		width: 100%;
		text-decoration: none;
	}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
    <!-- 홈페이지 로고 -->
    <a href = "<%=request.getContextPath()%>/">
        <img src = "././resources/image/logo.png" width = "200">
    </a>
	<nav>
		<a href="addItemForm">[매물 등록]</a>
		<!-- 리뷰게시판은 세션확인을 통해 이용이 가능하게 한다. -->
		<a href="" id = "review">[리뷰]</a>
		[로그인]
		[회원가입]
	</nav>
	<!-- 검색창 -->
	<form action="searchItem" method="get">
		<input type="text" name="sword" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>

	<!-- 매물 리스트 -->
	<c:forEach var="item" items="${itemList}">
		<div class="itemDiv">
			<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">
				<input type="button" value="${item.status}"><br>
				<img src="download?fileName=${item.fileName}"><br>
				<span id="img">이미지 : ${item.fileName}</span><br>
				<span id="itemNo">매물번호 : ${item.itemNo}</span><br>
				<span>매물주소 : ${item.addr}</span><br>
				<span>보증금 : ${item.deposit}</span><br>
				<span>월세 : ${item.rent}</span><br>
				<input type="button" value="주차${item.parking}">
				<input type="button" value="엘리베이터${item.elevator}">
				<input type="button" value="${item.buildingType}">
			</a>
		</div>
	</c:forEach>
	<!-- paging -->
	<hr>
	<table>
		<tr>
			<c:if test="${pageVO.prev}">
				<a href="searchItem?page=${pageVO.startPage -1}&sword=${pageVO.sword}">[이전]</a>
			</c:if>&emsp;
			<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">
				<a href="searchItem?page=${idx}&sword=${pageVO.sword}">${idx}</a>&emsp;
			</c:forEach>
			<c:if test="${pageVO.next}">
				<a href="searchItem?page=${pageVO.endPage +1}&sword=${pageVO.sword}">[다음]</a>
			</c:if>
		</tr>
	</table>

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
</html>