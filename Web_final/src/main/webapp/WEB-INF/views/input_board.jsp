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
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href = "resources/css/input_board.css">
<!-- script for kakao postcode service -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>
<a href = "<%=request.getContextPath()%>/">
	<img src = "resources/image/logo.png" width = "300">
</a>
<section>
	<div class="card border border-success" style="width: 70%;height: 100%">
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
	<footer class="text-center text-lg-start bg-light text-muted">
		<hr>
		<!-- Section: Links  -->
		<section class="">
		<div class="container text-center text-md-start mt-5">
			<!-- Grid row -->
			<div class="row mt-3">
			<!-- Grid column -->
			<div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
				<!-- Content -->
				<h6 class="text-uppercase fw-bold mb-4">
				<i class="fas fa-gem me-3"></i>Wanted Room
				</h6>
				<p>
				</p>
			</div>
			<!-- Grid column -->
			<!-- <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
				<h6 class="text-uppercase fw-bold mb-4">Location</h6>
				<p>Human Education Center, 100, Jungbu-daero, Paldal-gu, Suwon-si, Gyeonggi-do, Republic of Korea</p>
			</div> -->
			<!-- Grid column -->
			<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
				<!-- Links -->
				<h6 class="text-uppercase fw-bold mb-4">Developers</h6>
				<p>Jaewan Song</p>
				<p>Hwansoo Lee</p>
			</div>
			<!-- Grid column -->
			<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
				<!-- Links -->
				<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
				<p>obliviat3@naver.com</p>
				<p>hwansu29@naver.com</p>
			</div>
			<!-- Grid column -->
			</div>
			<!-- Grid row -->
		</div>
		</section>
		<!-- Section: Links  -->
	</footer>
</body>
<script type="text/javascript">
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