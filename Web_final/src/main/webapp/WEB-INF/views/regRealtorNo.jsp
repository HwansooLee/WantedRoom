<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공인중개사 등록번호 등록폼</title>
</head>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href = "resources/css/myPage.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	/* apply for all section exclude footerSec */
	section:not(.footerSec){ 
		width: 100%; 
        height: 60vh; 
        display: -webkit-box; 
        display: -moz-box;
        display: -ms-flexbox; 
        display: flex; 
 
        -webkit-box-align: center; 
        -moz-box-align: center;
        -ms-flex-align: center;
        align-items: center; /* 수직 정렬 */
 
        -webkit-box-pack: center;
        -moz-box-pack: center; 
        -ms-flex-pack: center; 
        justify-content: center; /* 수평 정렬 */
	}	
	#regBtn{
		color: white;
		background-color: #198754;
		border: 1px solid black;
		border-radius: 4px;
	}
</style>
<body>
	<jsp:include page="menuBar.jsp"/>
	<!-- 공인중개사번호 입력 공간 -->
	<section>
		<div class="card border border-success" style = "width: 30%;height:20%;">
			<div class="card-body">
			<div class="card-title">공인중개사 등록번호를 입력해주세요.</div>
				<form class="card-text" action="regRealtorSave" method = "post" id = "frm">
					<input type = "text" id = "realtorNo" name = "realtorNo" placeholder="-도 같이 입력해주세요" maxlength="16">
					<input type = "button" id = "regBtn" value = "등록">
				</form>
			</div>
		</div>
	</section>
	<jsp:include page="footer.jsp"/>
</body>
<script type="text/javascript">
	$('head').append('<script src=\'././resources/script/linkAddItem.js\'><\/script>');
	$('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
/* 	const hypenRealtorNo = (target) => { // 정규식으로 공인중개사 등록번호 입력제한
		target.value = target.value
	  	.replace(/[^0-9]/g, '');
		if(target.value.length == 12){
			target.value = target.value
	      	.replace(/^(\d{8})(\d{4})$/, `$1-$2`);
		}
		if(target.value.length > 12){
			target.value = target.value
	      	.replace(/^(\d{5})(\d{4})(\d{5})$/, `$1-$2-$3`);
		}
	} 
	*/
	
	// 유효성 체크 : api 사용
	
	const userName = '${userName}';
	var rno = $('#realtorNo');
	$('#regBtn').on('click', () => {
		// 비동기로 membervo 객체를 파라미터로 전달
		// json으로 리턴 받는다.
		let memberVO = {
				name : userName,
				realtorNo : rno.val()
		};
		$.ajax({
			url : "getRealtorInfo"
			,type : "POST"
			,dataType : "JSON"
			,data : JSON.stringify(memberVO)
			,contentType : "application/json"
			,success : function(data){
				if(data.EBBrokers.totalCount == '1'){ // 존재하는 데이터라면 전송
                	$('#frm').submit(); 
                }else{ // 존재하는 데이터가 아닌경우
                	alert('유효한 등록번호가 아닙니다');
                }
			}
			,error : function(){
				console.log('error');
			}
		});
	});
</script>
</html>