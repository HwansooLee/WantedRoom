<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href = "resources/css/input_board.css">
<link rel="stylesheet" href = "resources/css/home.css">
<!-- script for kakao postcode service -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>
	<jsp:include page="menuBar.jsp"/>
	<section>
		<div class="card border border-success" style="width: 70%;height: 100%;text-align: center;">
		<div class="card-body">
			<h5 class="card-title">게시글 작성 폼</h5>
			<br>
			<h6 class="card-subtitle mb-2 text-muted">당신의 동네 이야기를 들려주세요 :)</h6>
			<br>
			<form action="inputBoardSave" method = "post" id = "frm">
				<input type = hidden name = "bcode">
				<table class = "table">
					<tr>
						<td>아이디</td>
						<td><input type = "text" name = "id" value = "${id}" readonly size = "40"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type = "text" name = "title" class = "boardInput" size = "40"></td>
					</tr>
					<tr>
						<td><input type="button" value="주소검색" id="inputAddr"></td>
						<td><input type = "text" name = "addr" class = "boardInput" size = "40" placeholder="주소검색 버튼을 눌러 주소를 입력하세요." readonly></td>
					</tr>
				</table>
				내용<br>
				<textarea rows="20" cols="80" name = "content" class = "boardInput"></textarea><br>
				<button type="button" class="btn btn-outline-success" id = "saveBtn">게시글 저장</button>
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
	// 여기서는 유효성 체크를 한다
	// 제목이 비어있는가
	// 유효한 주소인가 >> v2.0
	// 내용이 비어있는가
	btn.on('click',() => {
		for(i = 0; i < 3; i++){
			if(input[i].value == '') {
				return alert('공란이 있습니다.');
			}
		}
		return frm.submit();
	});
	
	// 주소 입력
	$('#inputAddr').on('click', ()=>{
		new daum.Postcode({
			oncomplete: function(data) {
				$('[name="addr"]').val(data.address);
				$('[name="bcode"]').val(data.bcode);
				console.log(data.bcode);
			}
		}).open();
	});
</script>
</html>