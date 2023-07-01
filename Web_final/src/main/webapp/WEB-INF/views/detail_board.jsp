<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<table border = "1" width = "800">
	<tr>
		<td>게시글번호</td>
		<td>${boardvo.boardNo}</td>
		<td>닉네임</td>
		<td>${boardvo.nickname}</td>
		<td>주소지</td>
		<td>${boardvo.addr}</td>
		<td>작성일</td>
		<td>${boardvo.inDate}</td>
		<td>조회수</td>
		<td>${boardvo.views}</td>	
	</tr>
	<tr>
		<td>제목</td>
		<td colspan = "700">${boardvo.title}</td>	
	</tr>
</table>
<textarea rows = "30" cols = "115" readonly>
	${boardvo.content}
</textarea>
<!-- 여기는 댓글 공간 -->
<!-- 댓글 작성 공간 먼저 -->
<form action="" method = "post">
	<textarea rows="5" cols="115" name = "content"></textarea>
	<input type = "submit" value = "작성">
</form>
<!-- 달린 댓글들의 공간  좋아요 버튼 누르면 비동기 방식으로 업데이트 -->

</body>
</html>