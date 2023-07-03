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
		<a href = "signUp">[회원가입]</a>
	</nav>
	<!-- 검색창 -->
	<form action="searchItem" method="get">
		<input type="text" name="searchWord" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>

	<!-- 매물 리스트 -->
	
	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>

	</script>
</html>
