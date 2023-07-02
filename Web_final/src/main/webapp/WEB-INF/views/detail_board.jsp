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
<div>
	<table border = "1" width = "800" id = "replyTable">	
	</table>
</div>
<div id = pageArea>
</div>
</body>
<script type="text/javascript">
	var boardNo = ${boardvo.boardNo};
	var page = $('#page');
	
	$(document).ready(() =>{
		getReplyList(page.val());
	});
	
	function getReplyList(pageNum){ // 댓글 리스트 가져오는 함수.. 인자로 페이지 번호를 받는다.
		let replyTable = $('#replyTable');
		let pageArea = $('#pageArea');
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
				// console.log(data.pagevo.page); // pagevo 받아와서 사용하는 방법
				// console.log(data.rlist[1].content); // rlist 받아와서 사용하는 방법
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
					insertRow += item.likes;
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
					insertPageArea += '<a onclick = ' + "getReplyList(" + data.pagevo.endPage + 1 + ")" + '>  [다음페이지]  </a>';
				}
				pageArea.append(insertPageArea);
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
</script>
</html>