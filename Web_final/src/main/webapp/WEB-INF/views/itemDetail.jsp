<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
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
		<input type="text" name="searchWord" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>

	<!-- 상세 보기 -->
    <input type="button" value="${item.status}">
    <img src="download?fileName=${item.fileName}"><br>
    <span>이미지 : ${item.fileName}</span><br>
    <span>매물번호 : ${item.itemNo}</span><br>
    <span>매물주소 : ${item.addr}</span><br>
    <span>보증금 : ${item.deposit}</span><br>
    <span>월세 : ${item.rent}</span><br>
    <span>상세설명</span><br>
    <span>${item.detail}</span><br>
    <span>옵션</span><br>
    <input type="button" value="주차${item.parking}">
    <input type="button" value="엘리베이터${item.elevator}">
    <input type="button" value="${item.buildingType}"><br>
    <span>매물사진</span><br>
    <c:forEach var="imgName" items="${fileNames}">
        <img src="download?fileName=${imgName}" height="300"><br>
    </c:forEach><br>
    <span>매물등록일 : ${item.inDate}</span><br>
    <a href="modifyItemForm?itemNo=${item.itemNo}">수정</a>
    <a href="deleteItem?itemNo=${item.itemNo}">삭제</a>

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>

	</script>
</html>
