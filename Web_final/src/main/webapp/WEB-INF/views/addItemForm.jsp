<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- script for kakao postcode service -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<style>
	.card{
        text-align: center;
        margin: 0 auto;
    }
	textarea{
		resize: none;
		border-radius: 4px;
		border: 1px solid gray;
		width: 100%;
	}
	input[name="addr"]{
		width: 100%;
	}
	#devInfo{
		margin-left: 10px;
	}
</style>
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
	</nav>
	<form action="" >
			<!-- 검색창 -->
	</form>
	<!-- add item -->
	<div class="card border border-success" style="width: 60%;height: 70%">
		<div class="card-body">
			<h3> 신규 매물 등록 </h3>
			<form action="addItem" method="post" enctype="multipart/form-data" id="form">
				<input type="hidden" name="bcode">
				<input type="text" name="id" value="${id}" readonly hidden><br>
				<table id="itemTable" class="table">
					<tr>
						<td style="width: 30%">주소</td>
						<td>
							<input type="text" name="addr" placeholder="주소검색 버튼을 눌러 주소를 입력하세요." readonly>
							<input type="button" value="주소검색" id="inputAddr">
						</td>
					</tr>
					<tr>
						<td>보증금</td>
						<td><input type="text" name="deposit" size="20"> 원</td>
					</tr>
					<tr>
						<td>월세</td>
						<td><input type="text" name="rent" size="20"> 원</td>
					</tr>
					<tr>
						<td>상세설명</td>
						<td><textarea name="detail" rows="2" cols="50" maxlength="50" placeholder="매물에 대한 상세 설명을 입력하세요."></textarea><td>
					</tr>
					<tr>
						<td>주차가능여부</td>
						<td>
							<input type="radio" id="canNotPark" name="parking" value="불가능" checked>
							<label for="canNotPark">불가능</label>
							<input type="radio" id="canPark" name="parking" value="가능">
							<label for="canPark">가능</label>
						</td>
					</tr>
					<tr>
						<td>엘리베이터여부</td>
						<td>
							<input type="radio" id="noElevator" name="elevator" value="없음" checked>
							<label for="noElevator">없음</label>
							<input type="radio" id="haveElevator" name="elevator" value="있음">
							<label for="haveElevator">있음</label>
						</td>
					</tr>
					<tr>
						<td>건물 종류</td>
						<td>
							<input type="radio" id="apartment" name="buildingType" value="아파트" checked>
							<label for="apartment">아파트</label>
							<input type="radio" id="villa" name="buildingType" value="빌라">
							<label for="villa">빌라</label>
							<input type="radio" id="oneroom" name="buildingType" value="원룸">
							<label for="oneroom">원룸</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">매물사진등록(최대 10개)</td>
					</tr>
				</table>
				<table id="fileList" class="table">
					<thead>
						<tr><th colspan="2"><input type="file" name="file" value="파일 추가" multiple="multiple"/></tr>
						<tr>
							<th class="fileNameRow">파일명</th>
							<th class="delAttachRow" style="width: 20%">첨부취소하기</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<input type="button" value="등록" id="addBtn">
			</form>
		</div>
	</div>
	<br>
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
	<script>
		// 주소 입력
		$('#inputAddr').on('click', ()=>{
			new daum.Postcode({
				oncomplete: function(data) {
					$('[name="addr"]').val(data.address);
					$('[name="bcode"]').val(data.bcode);
				}
			}).open();
		});
		// 상세설명
		let detail = $("[name='detail']");
		let isDetailEmpty = true;
		// 한글을 글자당 2 바이트로 계산하는 함수(JS 기본 함수는 3바이트로 취급함)
		String.prototype.getBytes = function() {
			const contents = this;
			let str_character;
			let int_char_count = 0;
			let int_contents_length = contents.length;
			for (k = 0; k < int_contents_length; k++) {
				str_character = contents.charAt(k);
				if (escape(str_character).length > 4)
					int_char_count += 2;
				else
					int_char_count++;
			}
			return int_char_count;
		}
		/**** 파일 선택 ****/
		const FILE_NUM_MAX = 10;
		const ALLOWED_EXT = ['jpg', 'jpeg', 'bmp'];
		const EXT_ERROR_MSG = '첨부파일은 ' + ALLOWED_EXT.join() + ' 형식만 가능합니다.';
		let fileInput = $("[name='file']");
		let fileList = [];
		// drag and drop
	
		// 선택한 파일 삭제
		function removeFile(index) {
			const dt = new DataTransfer();
			const { files } = fileInput[0];
			for (let i = 0; i < files.length; i++) {
				const file = files[i];
				if (index !== i)
				dt.items.add(file);
			}
			fileInput[0].files = dt.files;
		}
		const HEIGHT_PER_LINE = 5;
		let currentHeight = parseFloat($('.card')[0].style.height.replace('%', ''));
		const Type = {
			INCREASE: "increase",
			DECREASE: "decrease"
		};
		function setHeight(type){
			if(type == Type.INCREASE){
				currentHeight += HEIGHT_PER_LINE;
				console.log(currentHeight);
				$('.card')[0].style.height = String(currentHeight) + '%';
			}else if(type == Type.DECREASE){
				currentHeight -= HEIGHT_PER_LINE;
				console.log(currentHeight);
				$('.card')[0].style.height = String(currentHeight) + '%';
			}
		}
		function remove(elem){
			let rowNum = elem.parentNode.parentNode.rowIndex;
			removeFile(rowNum - 1);
			fileList.splice(rowNum - 1, 1);
			document.getElementById('fileList').deleteRow(rowNum);
			setHeight(Type.DECREASE);
		}
		fileInput.on('change', (e)=>{
			for (let i = 0; i < fileInput[0].files.length; i++){
				if( fileList.length < FILE_NUM_MAX ){
					let fileName = fileInput[0].files[i].name;
					let ext = fileName.split('.');
					ext = ext[ext.length - 1];
					if( !ALLOWED_EXT.includes(ext) ){
						alert(EXT_ERROR_MSG);
						continue;
					}
					fileList.push(fileInput[0].files[i]);
					let row = document.querySelectorAll('tbody')[1].insertRow();
					let cell1 = row.insertCell(0);
					let cell2 = row.insertCell(1);
					cell1.innerHTML = fileName;
					cell2.innerHTML = '<input type="button" value="취소" name="deleteBtn" onclick=remove(this)>';
					setHeight(Type.INCREASE);
				}else{
					alert('파일 첨부는 최대 10개까지 가능합니다.');
					break;
				}
			}
		});
		// 보증금 유효성 검사
		let deposit = $("[name='deposit']");
		deposit.on('change', ()=>{
			if( /[^0-9]+$/.test(deposit[0].value) ){
				alert('보증금은 숫자로 입력해주세요.');
				deposit[0].value = '';
			}				
		});
		// 월세 유효성 검사
		let rent = $("[name='rent']");
		rent.on('change', ()=>{
			if( /[^0-9]+$/.test(rent[0].value) ){
				alert('월세는 숫자로 입력해주세요.');
				rent[0].value = '';
			}
		});
		// 저장
		$('#addBtn').on('click', ()=>{
			if( $("[name='addr']").value == '' ){
				alert('매물의 주소를 입력하세요.');
				return;
			}else if( deposit[0].value == '' ){
				alert('보증금을 입력하세요.');
				return;
			}else if( rent[0].value == '' ){
				alert('월세를 입력하세요.');
				return;
			}else if( $('#fileList >tbody >tr').length == 0 ){
				alert('매물 사진을 1 장 이상 첨부하세요');
				return;
			}
			$('#form').submit();
			alert('등록을 완료하였습니다.');
		});
	</script>
</html>