<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 댓글 관리 폼</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<a href = "<%=request.getContextPath()%>/">
		<img src = "resources/image/logo.png" width = "200">
	</a>
<table border = "1" width = "800">
	<tr>
		<td>댓글 번호</td>
		<td>내용</td>
		<td>작성일</td>
		<td>좋아요수</td>
		<td>삭제</td>
	</tr>
	<c:forEach var = "replyvo" items = "${rlist}">
		<tr>
			<td>${replyvo.replyNo}</td>
			<td>${replyvo.content}</td>
			<td>${replyvo.inDate}</td>
			<td>${replyvo.likes}</td>
			<td><a href = "myReplyDel?replyNo=${replyvo.replyNo}">del</a></td>
		</tr>
	</c:forEach>
</table>
<!-- 페이지 번호 들어갈 위치 -->
<div>
	<c:if test="${pagevo.prev}">
		<a href = "myReplyList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">[이전 페이지]</a>
	</c:if>
	<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
		<a href = "myReplyList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
	</c:forEach>
	<c:if test="${pagevo.next}">
		<a href = "myReplyList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">[다음 페이지]</a>
	</c:if>
</div>
</body>
</html>