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
	<input type = "text" id = "realtorNo" name = "realtorNo" maxlength="16">
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
	var rno = $('#realtorNo');
	$('#regBtn').on('click', () => {
		// 이곳에서 유효성체크를 한다.
		// 현재는 api를 사용하지 않으므로 길이체크만한다 12 또는 16
		if(rno.val().length == 13 || rno.val().length == 16){
			$('#frm').submit();
		}else{
			alert('등록번호를 확인해주세요.');
		}
	});
	
</script>
</html>