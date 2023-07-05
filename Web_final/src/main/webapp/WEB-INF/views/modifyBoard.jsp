<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<form action="modifyBoardSave" method = "post" id = "frm">
	<input type = "hidden" name = "boardNo" value = "${boardvo.boardNo}">
	<input type = "text" name = "id" value = "${boardvo.id}" readonly><br>
	제목<br>
	<input type = "text" name = "title" value = "${boardvo.title}" class = "boardInput"><br>
	주소<br>
	<input type = "text" name = "addr" value = "${boardvo.addr}" class = "boardInput"><br>
	내용<br>
	<input type = "text" name = "content" value = "${boardvo.content}" class = "boardInput"><br>
	<input type = "button" value = "저장" id = "saveBtn">
</form>
</body>
<script type="text/javascript">
	var btn = $('#saveBtn');
	var input = $('.boardInput');
	var frm = $('#frm');
	btn.on('click',() => {
		for(i = 0; i < 3; i++){
			if(input[i].value == '') {
				return alert('공란이 있습니다.');
			}
		}
		return frm.submit();
	});
</script>
</html>