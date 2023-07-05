<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<style>
	.itemOuterDiv{
		border: solid;
		border-width: 1px;
		border-color: purple;
		background-color: white;
		height: 400px;
		width: 49%;
		float: left;
	}
	.itemDiv{
		background-color: white;
		height: 90%;
		width: 100%;
		float: left;
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
	.deleteItemBtn{
		float: left;
		background-color: red;
	}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
	<!-- 홈페이지 로고 -->
	<a href = "<%=request.getContextPath()%>/">
		<img src = "././resources/image/logo.png" width = "200">
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
	<!-- 검색창 -->
	<form action="searchItem" method="get">
		<input type="text" name="sword" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>

	<!-- 매물 리스트 -->
	<c:forEach var="item" items="${itemList}">
		<div class="itemOuterDiv">
			<div class="itemDiv">
				<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">
					<input type="button" value="${item.status}"><br>
					<img src="download?fileName=${item.fileName}" class="itemImg"><br>
					<span id="img">이미지 : ${item.fileName}</span><br>
					<span id="itemNo">매물번호 : ${item.itemNo}</span><br>
					<span>매물주소 : ${item.addr}</span><br>
					<span>보증금 : ${item.deposit}</span><br>
					<span>월세 : ${item.rent}</span><br>
					<input type="button" value="주차${item.parking}">
					<input type="button" value="엘리베이터${item.elevator}">
					<input type="button" value="${item.buildingType}"><br>
				</a>
			</div><br>
			<form action="modifyItemForm" method="post">
				<input type="submit" value="수정" class="modifyItemBtn">
				<input type="text" name="itemNo" value="${item.itemNo}" hidden>
			</form>
			<form action="myItemList?sword=" class="deleteFrm">
				<input type="button" value="삭제" class="deleteItemBtn">
				<input type="hidden" value="${item.itemNo}">
			</form><br>
		</div>
	</c:forEach>
	<!-- paging -->
	<br><hr>
	<table>
		<tr>
			<c:if test="${pageVO.prev}">
				<a href="myItemList?page=${pageVO.startPage -1}&sword=${pageVO.sword}">[이전]</a>
			</c:if>&emsp;
			<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">
				<a href="myItemList?page=${idx}&sword=${pageVO.sword}">${idx}</a>&emsp;
			</c:forEach>
			<c:if test="${pageVO.next}">
				<a href="myItemList?page=${pageVO.endPage +1}&sword=${pageVO.sword}">[다음]</a>
			</c:if>
		</tr>
	</table><hr>

	<footer>
		<!-- 개발자 정보 -->
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
	</script>
</html>
