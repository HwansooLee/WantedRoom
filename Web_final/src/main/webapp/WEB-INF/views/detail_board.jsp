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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href = "././resources/css/detail_board.css"></link>
<style>
	#like-button:hover {
		cursor: pointer;
		color: red;
	}
	#like-button.not-liked {
		color: red;
	}
	#like-button.not-liked:hover {
		color: red;
	}
	#like-button.liked {
		color: red;
	}
	#like-button.liked-shaked {
		animation: shake 0.82s cubic-bezier(.36,.07,.19,.97) both;
		transform: translate3d(0, 0, 0) rotate(0deg);
		transform: rotate(0deg);
		backface-visibility: hidden;
		perspective: 1000px;
	}
	textarea{
		display: block;
		width: 100%;
		height: 100%;
		resize: none;
	}
	#contentText{
		border: none;
		padding: 10px 10px 10px 10px;
	}
	#replyCon{
		padding: 10px 10px 10px 10px;
	}
	.text-success{
		padding: 0;
		margin: 10px 10px 10px 10px;
	}
	#replyBtn{
		width: 10%;
		display: block;
		margin-left: 89%;
	}
	#pageArea{
		margin-bottom: 10px;
	}
</style>
<body>
	<jsp:include page="menuBar.jsp"/>
	<div class="card border-success mb-3" style = "margin: 0 auto; width: 80%;margin-top: 50px;">
		<div class="card-header">
			<table class = "table">
				<tr>
					<td>제목</td>
					<td colspan="5">${boardvo.title}</td>	
				</tr>
				<tr>
					<td width="10%">닉네임</td>
					<td width="25%">${boardvo.nickname}</td>
					<td width="10%">주소지</td>
					<td width="35%">${boardvo.addr}</td>
					<td width="10%">조회수</td>
					<td width="10%" style="text-align: right;">${boardvo.views}</td>
				</tr>
				<tr>
					<td>게시글번호</td>
					<td>${boardvo.boardNo}</td>
					<td>작성일</td>
					<td colspan="3">${boardvo.inDate}</td>
				</tr>
			</table>
		</div>
	 <div class="card-body text-success" style = "text-align: center;">
		<textarea id="contentText" readonly>${boardvo.content}</textarea>
	</div>
	<!-- 여기는 댓글 공간 -->
	<br>
	<!-- 댓글수는 비동기방식으로 받아오는 객체가 null이 아닌경우 삼항연산자로 업데이트 해줄것 -->
	<div id = "replyCnt" style = "margin-left: 20px;">댓글</div>
	<br>
	<!-- 댓글 작성 공간 먼저 댓글은 비동기 방식으로 전송 -->
	<div class="card-body text-success" style = "text-align: center;">
		<textarea rows="3" cols="115" id = "replyCon" placeholder="댓글을 입력하세요 :)"></textarea>
	</div>
	
	<input type = "button" value = "작성" id = "replyBtn">
	<!-- 달린 댓글들의 공간  좋아요 버튼 누르면 비동기 방식으로 업데이트 -->
	<input type = "hidden" value = "" id = "page">
	<div>
		<table class = "table">
			<thead>
				<tr>
					<td><strong>닉네임</strong></td>
					<td><strong>댓글</strong></td>
					<td><strong>작성일</strong></td>
					<td><strong>좋아요</strong></td>
				</tr>
			</thead>
			<tbody id = "replyTable"></tbody>
		</table>
	</div>
	<!-- pageArea -->
	<div id = pageArea class = "pagination justify-content-center"></div>
</div>
	<jsp:include page="footer.jsp"/>
</body>
<script type="text/javascript">
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	$(document).ready(() =>{
		getReplyList(page.val());
	});
	
	var boardNo = ${boardvo.boardNo};
	var page = $('#page');
	function getReplyList(pageNum){ // 댓글 리스트 가져오는 함수.. 인자로 페이지 번호를 받는다.
		let replyTable = $('#replyTable');
		let pageArea = $('#pageArea');
		let replyCnt = $('#replyCnt');
		let data = {
			"page" : (pageNum == '') ? 1 : pageNum,
			"boardNo" : boardNo
		}
		$.ajax({
			url : "replyList"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(data)
			,contentType : "application/json"
			,success : function(data){ // data가 의미하는것은 controller로부터 받아오는 response 객체를 의미한다.
				page.val(data.pagevo.page); // 댓글 페이지 번호 갱신
				replyTable.html(''); // 댓글이 중복되지 않도록 기존 댓글 비워주기
				$.each(data.rlist, function(idx,item){
					let insertRow = '<tr>';
					insertRow += '<td>';
					insertRow += item.nickname;
					insertRow += '</td>';
					insertRow += '<td>';
					insertRow += item.content;
					insertRow += '</td>';
					insertRow += '<td>';
					insertRow += item.inDate;
					insertRow += '</td>';
					insertRow += '<td>';
					if(item.nowUser != null){ // 이미 좋아요 누른 버튼의 경우
						insertRow += '<i id ="like-button" class="fa fa-2x liked fa-heart liked-shaked" onclick = "toggleButton(this,' + item.replyNo + ')"></i>' + item.likes;
					}else{
						insertRow += '<i id ="like-button" class="fa fa-2x fa-heart-o not-liked" onclick = "toggleButton(this,' + item.replyNo + ')"></i>' + item.likes;
					}	
					insertRow += '</td>';
					insertRow += '</tr>';
					replyTable.append(insertRow);
				});
				// 댓글 페이징 영역
				pageArea.html(''); // 기존 페이지 중복 되지 않게 지워주기
				let insertPageArea = '';
				if(data.pagevo.prev){	
					insertPageArea += '<a onclick = ' + "getReplyList(" + data.pagevo.startPage - 1 + ")" + '>  [이전페이지]  </a>';
				}
				for(i = data.pagevo.startPage; i <= data.pagevo.endPage; i++){
					insertPageArea += '<a onclick = ' + "getReplyList(" + i + ")" + '>' + i + '  </a>';
				}
				if(data.pagevo.next){
					insertPageArea += '<a onclick = ' + "getReplyList(" + data.pagevo.endPage + 1 + ")" + '>[다음페이지]</a>';
				}
				pageArea.append(insertPageArea);
				
				// 댓글수 업데이트
				replyCnt.html('');
				replyCnt.append('댓글 ' + data.pagevo.totalCount);
			}
			,error : function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}

	$('#replyBtn').on('click',(e) => { // 댓글 등록 부분
		let replyCon = $('#replyCon');
		
		// 유효성 체크 필요
		if(replyCon.value == ''){
			alert('내용을 입력해주세요.')
		}else{
			let data = {
				"content" : replyCon.val(),
				"boardNo" : boardNo,
				"id" : null // session으로 받아온다.
			};
			$.ajax({
				url : "inputReply"
				,type : "POST"
				,dataType : "JSON"
				,data : JSON.stringify(data) // 제대로 보내지는지 확인이 필요하다.
				,contentType : "application/json" // 여기까지는 서버로 전송
				,success : function(data){ // data가 의미하는것은 controller로부터 받아오는 response 객체
					// console.log(data); 데이터 확인용
					// 이곳에서 댓글리스트를 갱신해준다.
					getReplyList(page.val());
				}
				,error : function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
			replyCon.val('');
		}
	});
	
	//
	function toggleButton(button,info) {
		
		let likesInfo = { // json으로 보낼 객체
				"id" : null, // session에서 받는다
				"replyNo" : info,
				flag : false // default false
		}
		
    	button.classList.remove('liked-shaked');
    	button.classList.toggle('liked');
    	button.classList.toggle('not-liked');
    	button.classList.toggle('fa-heart-o');
    	button.classList.toggle('fa-heart');

    	if(button.classList.contains("liked")) { // 좋아요 취소
        	button.classList.add('liked-shaked');	
    	}
    	
    	if(button.classList.contains('liked-shaked')){ // 좋아요 눌렀을때 
    		// console.log(info); // info는 댓글 번호를 의미한다
    		likesInfo.flag = true;
    	}
    	
    	$.ajax({
    		url : "likes"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(likesInfo) // 제대로 보내지는지 확인이 필요하다.
			,contentType : "application/json" // 여기까지는 서버로 전송
			,success : function(data){ // data가 의미하는것은 controller로부터 받아오는 response 객체를 의미한다.
				getReplyList(page.val()); // 좋아요 정보도 갱신해주어야 한다.
			}
			,error : function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
    	});
	}
</script>
</html>