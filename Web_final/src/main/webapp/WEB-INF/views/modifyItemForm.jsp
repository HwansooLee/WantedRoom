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
	.card{
        text-align: center;
        margin: 0 auto;
    }
	#setSoldBtn{
		background-color: aquamarine;
	}
	input[type="button"]{
        border-radius: 4px;
        border: 1px solid black;
    }
	input[type="text"]:not(.inputSword){
        border-radius: 4px;
        border: 1px solid gray;
    }
	.readonlyBox{
		background-color: whitesmoke;
	}
	textarea{
		resize: none;
		border-radius: 4px;
        border: 1px solid gray;
	}
</style>
<body>
    <!-- 홈페이지 로고 -->
	<jsp:include page="menuBar.jsp"/>
	<!-- add item -->
	<div class="card border border-success" style="width: 70%;height: 70%">
		<div class="card-body">
			<h3> 매물 정보 수정 </h3>
			<form action="modifyItem" method="post" enctype="multipart/form-data" id="form">
				<table id="itemTable" class="table">
					<tr>
						<td style="width: 30%">매물번호</td>
						<td>
							<input class="readonlyBox" type="text" name="itemNo" value="${item.itemNo}" readonly>
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>
							<input class="readonlyBox" type="text" name="addr" value="${item.addr}" readonly>
						</td>
					</tr>
					<tr>
						<td>보증금</td>
						<td>
							<input type="text" name="deposit" value="${item.deposit}">
						</td>
					</tr>
					<tr>
						<td>월세</td>
						<td>
							<input type="text" name="rent" value="${item.rent}">
						</td>
					</tr>
					<tr>
						<td>상세설명</td>
						<td>
							<textarea name="detail" rows="2" cols="50" maxlength="50"
							placeholder="매물에 대한 상세 설명을 입력하세요.">${item.detail}</textarea>
						</td>
					</tr>
					<tr>
						<td>주차가능여부</td>
						<td>
							<input type="radio" id="canNotPark" name="parking" value="불가능"
								${item.parking == '불가능' ? 'checked' : ''}>
							<label for="canNotPark">불가능</label>
							<input type="radio" id="canPark" name="parking" value="가능" 
								${item.parking == '가능' ? 'checked' : ''}>
							<label for="canPark">가능</label>
						</td>
					</tr>
					<tr>
						<td>엘리베이터여부</td>
						<td>
							<input type="radio" id="noElevator" name="elevator" value="없음"
								${item.elevator == '없음' ? 'checked' : ''}>
							<label for="noElevator">없음</label>
							<input type="radio" id="haveElevator" name="elevator" value="있음"
								${item.elevator == '있음' ? 'checked' : ''}>
							<label for="haveElevator">있음</label>
						</td>
					</tr>
					<tr>
						<td>건물 종류</td>
						<td>
							<input type="radio" id="apartment" name="buildingType" value="아파트"
								${item.buildingType == '아파트' ? 'checked' : ''}>
							<label for="apartment">아파트</label>
							<input type="radio" id="villa" name="buildingType" value="빌라"
								${item.buildingType == '빌라' ? 'checked' : ''}>
							<label for="villa">빌라</label>
							<input type="radio" id="oneroom" name="buildingType" value="원룸"
								${item.buildingType == '원룸' ? 'checked' : ''}>
							<label for="oneroom">원룸</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">매물사진등록(최대 10개)</td>
					</tr>
				</table>	
				<!-- <input type="file" name="file" value="파일 추가" style="display: none;" multiple="multiple"/><br> -->
				<table id="fileList" class="table">
					<thead>
						<tr><th colspan="2"><input type="file" name="file" value="파일 추가" multiple="multiple"/></tr>
						<tr>
							<th>파일명 / 기존 첨부 이미지</th>
							<th style="width: 20%;">취소 / 삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="attach" items="${attachs}">
							<tr>
								<td><img src="download?fileName=${attach}" height="100"></td>
								<td>
									<input type="button" value="첨부파일삭제" 
										name="removeAttachBtn" onclick=addRemoveList(this)>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		
				<c:if test="${item.status == '계약가능'}">
					<input type="button" value="계약완료" id="setSoldBtn">
				</c:if>
				<input type="button" value="저장" id="addBtn">
			</form>


		</div>
	</div>

	<jsp:include page="footer.jsp"/>
</body>
	<script>
		$('head').append('<script src=\'././resources/script/linkAddItem.js\'><\/script>');
		$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
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
		const HEIGHT_PER_IMG = 15;
		let currentHeight = parseFloat($('.card')[0].style.height.replace('%', ''));
		const FILE_TABLE_HEADER_ROWS = 2;
		const INIT_ROW_CNT = $('#fileList tr').length;
		if( INIT_ROW_CNT > FILE_TABLE_HEADER_ROWS ){
			currentHeight += ( (INIT_ROW_CNT - FILE_TABLE_HEADER_ROWS) 
								* HEIGHT_PER_IMG );
			$('.card')[0].style.height = String(currentHeight) + '%';
		}
		const Type = {
			INCREASE: "increase",
			DECREASE: "decrease",
			REMOVE_IMG: "removeImg"
		};
		function setHeight(type){
			if(type == Type.INCREASE){
				currentHeight += HEIGHT_PER_LINE;
				$('.card')[0].style.height = String(currentHeight) + '%';
			}else if(type == Type.DECREASE){
				currentHeight -= HEIGHT_PER_LINE;
				$('.card')[0].style.height = String(currentHeight) + '%';
			}else if(type == Type.REMOVE_IMG){
				currentHeight -= HEIGHT_PER_IMG;
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
		let removeList = new Set();
		function addRemoveList(elem){
			let rowNum = elem.parentNode.parentNode.rowIndex;
			document.getElementById('fileList').deleteRow(rowNum);
			setHeight(Type.REMOVE_IMG);
			let attachNameVal = elem.parentNode.parentNode.childNodes[1].children[0].getAttribute('src');
			attachNameVal = attachNameVal.split('fileName=')[1];
			removeList.add(attachNameVal);
		}
		function removeAttach(removeList){
			for( fileName of removeList )
				$.post('deleteAttach', {attachName : fileName});
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

		// 계약완료로 설정
		const AGREE_MSG = '계약완료';
		$('#setSoldBtn').on('click', (e)=>{
			let checkResult = prompt('계약완료로 설정하면 되돌릴 수 없습니다. 계약완료로 설정하려면 계약완료라고 입력하세요.');
			let itemNoVal = $('[name="itemNo"]').val();
			if( checkResult == AGREE_MSG ){
				$.ajax({
					url: 'setItemSold',
					type: 'POST',
					data:{
						itemNo : itemNoVal
					},
					success: ()=>{
						alert('계약완료로 설정하였습니다.');
						$(e.target).css('display', 'none');
					}
				});	
			}else
				alert('계약완료 변경을 취소합니다.');
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
			removeAttach(removeList);
			$('#form').submit();
			alert('수정되었습니다');
		});
	</script>
</html>