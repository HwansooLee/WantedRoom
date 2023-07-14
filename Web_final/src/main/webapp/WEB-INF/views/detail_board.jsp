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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href = "././resources/css/detail_board.css"></link>
<link rel="stylesheet" href="resources/css/menuBar.css">
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
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<!-- 홈페이지 로고 -->
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> <img
				class="logoImg" src="resources/image/logo.png">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="addItemForm" id="addItem">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
					<c:if test="${id eq null}">
						<li class="nav-item">
							<a class="nav-link" href="signIn">로그인</a>
                        </li>
                        <li class="nav-item">
                           	<a class="nav-link" href="signUp">회원가입</a>
                        </li> 
                    </c:if>
                    <c:if test="${id ne null}">
                       	<li class="nav-item">
                           	<a class="nav-link" href="myPage">${nickname}</a>
                       	</li>
                    </c:if>
				</ul>
				<div class="searchDiv border-success">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력"
							class="inputSword"> <input type="submit" value="검색"
							class="submitBtn btn-success">
					</form>
				</div>
				<c:if test="${id ne null}">
					<span class="navbar-text">
						<button type="button" class="btn btn-outline-secondary"
							id="logOutBtn">로그아웃</button>
					</span>
				</c:if>
			</div>
		</div>
	</nav>
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
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	var boardNo = ${boardvo.boardNo};
	var page = $('#page');
	
	$(document).ready(() =>{
		getReplyList(page.val());
	});
	
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