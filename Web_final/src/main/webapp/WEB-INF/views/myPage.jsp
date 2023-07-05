<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
    	<!-- 홈페이지 로고 -->
	<a href = "<%=request.getContextPath()%>/">
		<img src = "resources/image/logo.png" width = "200">
	</a>
	<nav>
		<a href="addItemForm">[매물 등록]</a>
		<!-- 리뷰게시판은 세션확인을 통해 이용이 가능하게 한다. -->
		<a href="boardList">[리뷰]</a>
		<c:if test = "${id eq null}">
			<a href = "signIn">[로그인]</a>
			<a href = "signUp">[회원가입]</a>
		</c:if>
		<c:if test = "${id ne null}">
			<a href = "myPage">[${nickname}]</a>
			<a href = "signOut">[로그아웃]</a>
		</c:if>
	</nav><hr>
<c:if test = "${realtorNo eq null}">
	<a href = "registerRealtorNo">[공인중개사 등록번호 등록하기]</a>
</c:if>
<a href = "myBoardList">[리뷰 게시글 관리]</a> <!-- 리뷰말고 다른 표현 생각할 필요가 있어보임 -->
<a href = "myReplyList">[댓글관리]</a>
<!-- 등록번호인증된 회원만 세션으로 걸러서 나오게 한다 -->
<c:if test = "${realtorNo ne null}">
	<a href = "">[매물 게시글 관리]</a>
</c:if>
</body>
</html>