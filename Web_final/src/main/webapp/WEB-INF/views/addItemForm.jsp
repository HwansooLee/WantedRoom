<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>

</style>
<body>
    <!-- 홈페이지 로고 -->
    <a href = "<%=request.getContextPath()%>/">
        <img src = "././resources/image/logo.png" width = "200">
    </a>
	<nav>
		<a href="addItemForm">[매물 등록]</a>
		[리뷰]
		[로그인]
		[회원가입]
	</nav>
	<form action="" >
			<!-- 검색창 -->
	</form>
	<!-- add item -->
	<form action="addItem" method="post" enctype="multipart/form-data" id="form">
		아이디<input type="text" name="id" value="testUser1" readonly><br>
		주소<input type="text" name="addr"><br>
		보증금<input type="text" name="deposit"><br>
		월세<input type="text" name="rent"><br>
		상세설명<br><textarea name="detail" rows="2" cols="50" maxlength="50"
		placeholder="매물에 대한 상세 설명을 입력하세요."></textarea><br>

		주차가능여부<br> 
		<input type="radio" id="canNotPark" name="parking" value="불가능" checked>
		<label for="canNotPark">불가능</label>
		<input type="radio" id="canPark" name="parking" value="가능">
		<label for="canPark">가능</label><br>
		엘리베이터여부<br>
		<input type="radio" id="noElevator" name="elevator" value="없음" checked>
		<label for="noElevator">없음</label>
		<input type="radio" id="haveElevator" name="elevator" value="있음">
		<label for="haveElevator">있음</label><br>
		건물 종류<br>
		<input type="radio" id="apartment" name="buildingType" value="아파트" checked>
		<label for="apartment">아파트</label>
		<input type="radio" id="villa" name="buildingType" value="빌라">
		<label for="villa">빌라</label>
		<input type="radio" id="oneroom" name="buildingType" value="원룸">
		<label for="oneroom">원룸</label><br>

		<!-- upload multiple files -->
		매물사진등록(최대 10개)<br>

		<!-- <input type="file" name="file" value="파일 추가" style="display: none;" multiple="multiple"/><br> -->
		<input type="file" name="file" value="파일 추가" multiple="multiple"/><br>
		첨부 파일 리스트<br>
		<table border="1" id="fileList">
			<thead>
				<th width="500">파일명</th>
				<th>삭제하기</th>
			</thead>
			<tbody>
			</tbody>
		</table>

		<input type="button" value="등록" id="addBtn">
	</form>

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>
		// 상세설명
		let detail = $("[name='detail']");
		// const DEFAULT_MSG = "매물에 대한 상세 설명을 입력하세요.";
		// detail[0].value = DEFAULT_MSG;
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
		// detail.on('click', ()=>{
		// 	if( detail[0].value == DEFAULT_MSG )
		// 		detail[0].value = "";
		// })
		// detail.on('focusout', ()=>{
		// 	if( detail[0].value == "" )
		// 		detail[0].value = DEFAULT_MSG;
		// })
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
		function remove(elem){
			let rowNum = elem.parentNode.parentNode.rowIndex;
			removeFile(rowNum - 1);
			fileList.splice(rowNum - 1, 1);
			document.getElementById('fileList').deleteRow(rowNum);
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
					let row = document.getElementById('fileList').insertRow();
					let cell1 = row.insertCell(0);
					let cell2 = row.insertCell(1);
					cell1.innerHTML = fileName;
					cell2.innerHTML = '<input type="button" value="삭제" name="deleteBtn" onclick=remove(this)>';
				}else{
					alert('파일 첨부는 최대 10개까지 가능합니다.');
					break;
				}
			}

			// var files = document.getElementsByName("file")[0].files;
			// if (!files.length) {
			// 	return;
			// }
			// var file = files[0];
			// // Create a new one with the data but a new name
			// var newFile = new File([file], "replace.jpg", {
			// type: file.type,
			// });
			// // Build the FormData to send
			// var data = new FormData();
			// data.set("file", newFile);
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
			console.log( fileList.length );
			for(f of fileList)
				console.log(f.name);

			if( $("[name='addr']").value == '' ){
				alert('매물의 주소를 입력하세요.');
				return;
			}else if( deposit[0].value == '' ){
				alert('보증금을 입력하세요.');
				return;
			}else if( rent[0].value == '' ){
				alert('월세를 입력하세요.');
				return;
			}
			// if( $("[name='detail']")[0].value == DEFAULT_MSG )
			// 	$("[name='detail']")[0].value = '';
			$('#form').submit();
		});
	</script>
</html>