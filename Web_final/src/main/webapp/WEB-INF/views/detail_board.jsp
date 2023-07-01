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
<body>
<table border = "1" width = "800">
	<tr>
		<td>게시글번호</td>
		<td>${boardvo.boardNo}</td>
		<td>닉네임</td>
		<td>${boardvo.nickname}</td>
		<td>주소지</td>
		<td>${boardvo.addr}</td>
		<td>작성일</td>
		<td>${boardvo.inDate}</td>
		<td>조회수</td>
		<td>${boardvo.views}</td>	
	</tr>
	<tr>
		<td>제목</td>
		<td colspan = "700">${boardvo.title}</td>	
	</tr>
</table>
<textarea rows = "30" cols = "115" readonly>
	${boardvo.content}
</textarea>
<!-- 여기는 댓글 공간 -->
<br>
<!-- 댓글수는 비동기방식으로 받아오는 객체가 null이 아닌경우 삼항연산자로 업데이트 해줄것 -->
<div>댓글   ${replyCnt}</div>
<br>
<!-- 댓글 작성 공간 먼저 댓글은 비동기 방식으로 전송 -->
<textarea rows="5" cols="115" id = "replyCon" placeholder="댓글을 입력하세요 :)"></textarea>
<input type = "button" value = "작성" id = "replyBtn">
<!-- 달린 댓글들의 공간  좋아요 버튼 누르면 비동기 방식으로 업데이트 -->
<input type = "hidden" value = "" id = "page">
<table border = "1" width = "800" id = "replyTable">	
</table>
</body>
<script type="text/javascript">
	var boardNo = ${boardvo.boardNo};
	var page = $('#page');
	
	$(document).ready(() =>{
		getReplyList();
	});
	
	function getReplyList(){ // 댓글 리스트 가져오는 함수
		let replyTable = $('#replyTable');
		
		let data = {
				"page" : (page.val() == '') ? 1 : page.val(),
				"boardNo" : boardNo
		}
		$.ajax({
			url : "replyList"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(data)
			,contentType : "application/json"
			,success : function(data){ // data가 의미하는것은 controller로부터 받아오는 response 객체를 의미한다.
				console.log(data.pagevo.page);
				console.log(data.rlist[0].content); // 아니 ㅅㅂ 이거까지 된다고?
			}
			,error : function(jqXHR,textStatus,errorThrown){
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}

	$('#replyBtn').on('click',(e) =>{ // 댓글 등록 부분
		let replyCon = $('#replyCon');
		
		// 유효성 체크 필요
		if(replyCon.value == ''){
			alert('내용을 입력해주세요.')
		}else{
			let data = {
					"content" : replyCon.val(),
					"boardNo" : boardNo,
					"id" : "testid" // 임시로 테스트 아이디로 작성 session으로 받아오는걸로 수정해야 한다.
			};
			$.ajax({
				url : "inputReply"
				,type : "POST"
				,dataType : "JSON"
				,data : JSON.stringify(data) // 제대로 보내지는지 확인이 필요하다.
				,contentType : "application/json" // 여기까지는 서버로 전송
				,success : function(data){ // data가 의미하는것은 controller로부터 받아오는 response 객체를 의미한다.
					console.log(data);
					// 이곳에서 댓글리스트를 갱신해준다.
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
</script>
</html>