<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글 리스트 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<a href = "<%=request.getContextPath()%>/">
	<img src = "resources/image/logo.png" width = "200">
</a>
<a href = "inputBoard">
	<input type = "button" value = "게시글 작성">
</a>
<table border = "1" width = "800">
	<tr>
		<td>게시글 번호</td>
		<td>제목</td>
		<td>주소</td>
		<td>조회수</td>
		<td>등록일</td>
		<td>수정/삭제</td>
	</tr>
	<c:forEach var = "boardvo" items = "${blist}">
		<tr>
			<td>${boardvo.boardNo}</td>
			<td>${boardvo.title}</td>
			<td>${boardvo.addr}</td>
			<td>${boardvo.views}</td>
			<td>${boardvo.inDate}</td>
			<td><a href = "myBoardModify?boardNo=${boardvo.boardNo}">mod</a>/
			<a href = "myboardDel?boardNo=${boardvo.boardNo}">del</a></td>
		</tr>
	</c:forEach>
</table>
<!-- 페이지 번호 들어갈 위치 -->
<div>
	<c:if test="${pagevo.prev}">
		<a href = "myBoardList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">[이전 페이지]</a>
	</c:if>
	<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
		<a href = "myBoardList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
	</c:forEach>
	<c:if test="${pagevo.next}">
		<a href = "myBoardList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">[다음 페이지]</a>
	</c:if>
</div>

</body>
<script type="text/javascript">
</script>
</html>