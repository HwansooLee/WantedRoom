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
<body>
<div>공인중개사 등록번호를 입력해주세요.</div>
<form action="regRealtorSave" method = "post" id = "frm">
	<input type = "text" id = "realtorNo" name = "realtorNo" placeholder="-도 같이 입력해주세요" maxlength="16">
	<input type = "button" id = "regBtn" value = "등록">
</form>
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