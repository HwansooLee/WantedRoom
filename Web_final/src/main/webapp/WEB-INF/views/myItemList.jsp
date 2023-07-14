<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
<title>myitemList form</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/myPage.css">
<style>
	.itemDiv {
		margin: 0 auto;
		height: 90%;
		width: 25%;
		float: left;
		/* diplay: flex; */
	}
	a.fillDiv{
		display: block;
		height: 100%;
		width: 100%;
		text-decoration: none;
	}
	.itemImg{
		height: 180px;
	}
	.modifyItemBtn{
		float: left;
	}
	.deleteItemBtn {
		float: left;
	}
	body{
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	footer{
		margin-top: auto;
	}
	.submitBtn {
		font-size: 15px;
		border: none;
		background-color: #198754;
		width: 50px;
		height: 30px;
		border-radius: 15px;
		color: #fff;
		cursor: pointer;
		margin: 1px;
		margin-top: 5px;
		margin-left: 9px;
	}
	.searchDiv {
		margin: 20px;
		border: 1.5px solid;
		width: 260px;
		height: 45px;
		border-radius: 15px;
		margin-left: 50px;
		background-color: none;
	}
	.inputSword {
		margin: -3;
		margin-left: 5px;
		border: 0;
		outline: none;
		height: 100%;
		background-color: transparent;
	}
	.page-item.active .page-link {
		z-index: 1;
		color : #198754;
		font-weight:bold;
		background-color: rgb(177, 245, 171);
		border-color: #ccc;
	}
	.page-link {
		color:#198754; 
		background-color: #fff;
		font-weight:bold;
		border: 1px solid #ccc; 
	}
	input[type=button]{
		border:none;
		/*border-radius:4px 가능 */
	}
	button{
		border-radius:4px;
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="" id="addItem">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
				</ul>
				<div class="searchDiv border-success">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력"
							class="inputSword"> <input type="submit" value="검색"
							class="submitBtn btn-success">
					</form>
				</div>
				<span class="navbar-text">
					<button type="button" class="btn btn-outline-secondary"
						id="logOutBtn">로그아웃</button>
				</span>
			</div>
		</div>
	</nav>

	<!-- 매물 리스트 -->
	<div class="card-group">
		<c:forEach var="item" items="${itemList}">
			<div class="itemDiv">
				<div class="card border-success" style="width: 18rem;">
					<div class="card-body">
						<p class="card-text">
							<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv"> <input
								type="button" value="${item.status}"><br> <img
								src="download?fileName=${item.fileName}" class="itemImg"><br> 
								<span id="itemNo">매물번호 : ${item.itemNo}</span><br>
								<span>매물주소 : ${item.addr}</span><br> <span>보증금 : ${item.deposit}</span><br>
								<span>월세 : ${item.rent}</span><br>
								<input type="button" value="주차${item.parking}">
								<input type="button" value="엘리베이터${item.elevator}">
								<input type="button" value="${item.buildingType}"><br>
							</a>
							<table>
								<tr>
									<td>
										<form action="modifyItemForm" method="post">
											<input type="hidden" name="itemNo" value="${item.itemNo}">
											<button type="submit" class="modifyItemBtn">
												<img src = "resources/image/modify.png" width = "20">
											</button>								
										</form>
									</td>
									<td>
										<form action="myItemList?sword=" class="deleteFrm">
											<button type="button" value="삭제" class="deleteItemBtn">
												<img src = "resources/image/delete.png" width = "20">
											</button> 
											<input type="hidden" value="${item.itemNo}">
										</form>
									</td>
								</tr>
							</table>	
					</div>	
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- paging -->
	<br>
	<div class = "pageValue">
		<ul class="pagination justify-content-center">
			<li class="page-item ${pageVO.prev ? '' : 'disabled'}">
				<a class="page-link" href="myItemList?page=${pageVO.startPage -1}&sword=${pageVO.sword}">이전</a>
			</li>
			<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">
				<li class="page-item ${idx eq pageVO.page ? 'active' : ''}">
					<a class="page-link" href="myItemList?page=${idx}&sword=${pageVO.sword}">${idx}</a>
				</li>
			</c:forEach>
			<li class="page-item ${pageVO.next ? '' : 'disabled'}">
				<a class="page-link" href="myItemList?page=${pageVO.endPage +1}&sword=${pageVO.sword}">다음</a>
			</li>
		</ul>
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
						<p></p>
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
		const DELETE_CONFIRM_WORD = '삭제';
		$('.deleteItemBtn').on('click',(e)=>{
			let checkResult = prompt('정말 해당 매물을 삭제하시겠습니까? 삭제하려면 삭제를 입력하세요.');
			if( checkResult == DELETE_CONFIRM_WORD ){
				let itemNoVal = $(e.target).next().val();
				$.ajax({
						url: 'deleteItem',
						type: 'POST',
						data:{
							itemNo : itemNoVal
						},
						success: ()=>{
							alert('삭제 완료하였습니다.');
							$(e.target).parent().submit();
						}
					});	
			}				
			else
				alert('삭제 취소하였습니다.');
		});
		
		$('#logOutBtn').on('click', () => {
			location.href = "signOut";
		});
		
		$('#addItem').on('click', () => {
			var authenticated = '${authenticated}';
			if(authenticated == 'false'){
				alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다.');
			}else{
				$('#addItem').attr('href','addItemForm');
			}
		});
	</script>
</html>
