<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 댓글 관리 폼</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href = "resources/css/myReplyList.css">
<style>
	thead{
		background-color: #D1E7DD;
		font-weight: bold;
		border-color: black;
		border-bottom-width: 2px;
	}
	tbody{
		background-color: #D1E7DD;
		border-color: #ccc;
	}
	section{
		text-align: center;
	}
	.table{
		margin: 20px;
		width: calc(100% - 40px);
	}
</style>
</head>
<body>
	<jsp:include page="menuBar.jsp"/><br><br><br>
	<section>
		<h3><strong>내 댓글 목록</strong></h3>
	</section>
	<br><br>
<table border = "1" class = "table">
	<thead>
		<tr>
			<td>댓글 번호</td>
			<td>내용</td>
			<td>작성일</td>
			<td>좋아요수</td>
			<td>삭제</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "replyvo" items = "${rlist}">
			<tr>
				<td>${replyvo.replyNo}</td>
				<td>${replyvo.content}</td>
				<td>${replyvo.inDate}</td>
				<td>${replyvo.likes}</td>
				<td>
					<a href = "myReplyDel?replyNo=${replyvo.replyNo}">
						<img src = "resources/image/delete.png" width = "20">
					</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- 페이지 번호 들어갈 위치 -->
<div class = "pageValue">
	<ul class="pagination justify-content-center"> 
		<li class="page-item ${pagevo.prev ? '' : 'disabled'}">
			<a class="page-link" href = "myReplyList?page=${pagevo.startPage - 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">이전 페이지</a>
		</li>
		<c:forEach begin = "${pagevo.startPage}" end = "${pagevo.endPage}" var = "idx">
		<li class="page-item ${idx eq pagevo.page ? 'active' : ''}">
			<a class="page-link" href = "myReplyList?page=${idx}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">${idx}</a>
		</li>
		</c:forEach>
		<li class="page-item ${pagevo.next ? '' : 'disabled'}">
			<a class="page-link" href = "myReplyList?page=${pagevo.endPage + 1}&sword=${pagevo.sword}&sorted=${pagevo.sorted}">다음 페이지</a>
		</li>
	</ul>
</div>
	<jsp:include page="footer.jsp"/>
</body>
<script>
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
</script>
</html>