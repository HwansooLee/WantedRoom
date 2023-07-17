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
<link rel="stylesheet" href="resources/css/itemList.css">
<link rel="stylesheet" href="resources/css/colorItemTag.css">
<style>
	.itemDiv{
		margin-top: 20px;
		margin-left: 10px;
		width: 24%
	}
	button{
		border: 1px solid rgba(0, 0, 0, 0.733);
		border-radius: 4px;
	}
</style>
<body>
	<jsp:include page="menuBar.jsp"/><br><br><br>
	<section>
		<h3><strong>내 매물 목록</strong></h3>
	</section><br><br>

	<!-- 매물 리스트 -->
	<div class="card-group">
		<c:forEach var="item" items="${itemList}">
			<div class="itemDiv">
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<p class="card-text">
							<a href="itemDetail?itemNo=${item.itemNo}" class="fillDiv">
								<input type="button" value="${item.status}" class="statusBtn">
								<img src="download?fileName=${item.fileName}" class="itemImg">
								<table>
									<thead>
										<th style="width: 35%;"> </th>
                    					<th style="width: 65%;"> </th>
									</thead>
									<tr>
										<td><span>매물번호 : </span></td>
										<td><span id="itemNo">${item.itemNo}</span></td>
									</tr>
									<tr>
										<td><span>주소 : </span></td>
										<td rowspan="3"><span>${item.addr}</span></td>
									</tr>
									<tr></tr>
									<tr></tr>
									<tr>
										<td><span>보증금 :</span></td>
										<td><span>${item.deposit} 원</span></td>
									</tr>
									<tr>
										<td><span>월세 : </span></td>
										<td><span>${item.rent} 원</span></td>
									</tr>
									<tr>
										<td></td>
									</tr>
									<tr>
										<td>
											<input type="button" value="주차${item.parking}" class="parking">
										</td>
										<td>
											<input type="button" value="엘리베이터${item.elevator}" class="elevator">
										</td>
									</tr>
									<tr>
										<td>
											<input type="button" value="${item.buildingType}" class="buildingType">
										</td>
										<td></td>
									</tr>
								</table> 
							</a>
							<br>
							<table>
								<tr>
									<td>
										<c:if test="${item.status == '계약가능'}">
											<form action="modifyItemForm" method="post">
												<input type="hidden" name="itemNo" value="${item.itemNo}">
												<button type="submit" class="modifyItemBtn">
													<img src="resources/image/modify.png" width = "20">
												</button>								
											</form>
										</c:if>
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
						</p>
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
	<jsp:include page="footer.jsp"/>
</body>
<script>
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
	$('head').append('<script src=\'././resources/script/colorItemTag.js\'><\/script>');
	$('.statusBtn').each((i, obj)=>{
		if( $(obj).val() == '계약가능' )
			$(obj).closest('.card').addClass('border-success');
		else
			$(obj).closest('.card').addClass('border-dark');
	})
	// increase height by 50 px for include modify and delete buttons in border
	let itemHeight = $('.itemDiv').css('height').replace('px', '');
	$('.itemDiv').css('height', parseInt(itemHeight) + 50);

	const DELETE_CONFIRM_WORD = '삭제';
	$('.deleteItemBtn').on('click',(e)=>{
		let checkResult = prompt('정말 해당 매물을 삭제하시겠습니까? 삭제하려면 삭제를 입력하세요.');
		if( checkResult == DELETE_CONFIRM_WORD ){
			let itemNoVal = $(e.target).parent().next().val();
			$.ajax({
					url: 'deleteItem',
					type: 'POST',
					data:{
						itemNo : itemNoVal
					},
					success: ()=>{
						alert('삭제 완료하였습니다.');
						$(e.target).parent().parent().submit();
					}
				});	
		}				
		else
			alert('삭제 취소하였습니다.');
	});
	
	$('#logOutBtn').on('click', () => {
		location.href = "signOut";
	});
</script>
</html>
