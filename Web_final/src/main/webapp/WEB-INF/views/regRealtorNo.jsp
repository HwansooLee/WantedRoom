<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공인중개사 등록번호 등록폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<style>
	body{
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	footer{
		margin-top: auto;
	}
</style>
<body>
<div>공인중개사 등록번호를 입력해주세요.</div>
<form action="regRealtorSave" method = "post" id = "frm">
	<input type = "text" id = "realtorNo" name = "realtorNo" placeholder="-도 같이 입력해주세요" maxlength="16">
	<input type = "button" id = "regBtn" value = "등록">
</form>
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
	var xhr = new XMLHttpRequest();
	var HttpUrl = "http://openapi.nsdi.go.kr/nsdi/EstateBrkpgService/attr/getEBBrokerInfo"; /*URL*/
	var parameter = '?' + encodeURIComponent("authkey") +"="+encodeURIComponent("f8abae3d8b09d06f647fe2"); /*authkey Key*/
	var data = '';
	var rno = $('#realtorNo');
	$('#regBtn').on('click', () => {
		// 이곳에서 유효성체크를 한다.
		parameter += "&" + encodeURIComponent("brkrNm") + "=" + encodeURIComponent(userName); /* 중개업자명 */  
    	parameter += "&" + encodeURIComponent("jurirno") + "=" + encodeURIComponent(rno.val()); /* 법인등록번호 */  
    	parameter += "&" + encodeURIComponent("format") + "=" + encodeURIComponent("json"); /* 응답결과 형식(xml 또는 json) */
    	xhr.open('GET', HttpUrl + parameter);
    	xhr.send('');
    	xhr.onreadystatechange = function () {     
            if (this.readyState == 4) {
            	//console.log(' Body: '+this.responseText); 받아오는 데이터 확인
            	//console.log(typeof(this.response)) 타입 확인
            	data = this.response;
            	data = JSON.parse(data); // json으로 형변환
                //console.log(data.EBBrokers.totalCount);
                if(data.EBBrokers.totalCount == '1'){ // 존재하는 데이터라면 전송
                	$('#frm').submit(); 
                }else{ // 존재하는 데이터가 아닌경우
                	alert('유효한 등록번호가 아닙니다');
                }
            }  
        };
	});
</script>
</html>