<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/modifyBoard.css">
<body>
	<jsp:include page="menuBar.jsp"/>
	<section>
		<div class="card border border-success"
			style="width: 70%; height: 100%">
			<div class="card-body">
				<h5 class="card-title">게시글 수정 폼</h5>
				<br>
				<h6 class="card-subtitle mb-2 text-muted">게시글 수정 폼입니다 :)</h6>
				<br>
				<form action="modifyBoardSave" method="post" id="frm">
					<input type="hidden" name="boardNo" value="${boardvo.boardNo}">
					<table class="table">
						<tr>
							<td>아이디</td>
							<td><input type="text" name="id" value="${boardvo.id}" readonly></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input type="text" name="title" value="${boardvo.title}"
						class="boardInput"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text"
						name="addr" value="${boardvo.addr}" class="boardInput" readonly></td>
						</tr>
					</table>
					내용<br>
					<textarea rows="20" cols="80" name="content" class="boardInput">${boardvo.content}</textarea>
					<br>
					<button type="button" class="btn btn-outline-success" id="saveBtn">게시글
						저장</button>
				</form>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
<script type="text/javascript">
	$('head').append('<script src=\'././resources/script/linkAddItem.js\'><\/script>');
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	var btn = $('#saveBtn');
	var input = $('.boardInput');
	var frm = $('#frm');
	btn.on('click',() => {
		for(i = 0; i < 3; i++){
			if(input[i].value == '') {
				return alert('공란이 있습니다.');
			}
		}
		return frm.submit();
	});
</script>
</html>