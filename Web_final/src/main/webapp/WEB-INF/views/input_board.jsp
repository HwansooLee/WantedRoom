<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성 폼</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<a href = "<%=request.getContextPath()%>/">
	<img src = "resources/image/logo.png" width = "200">
</a>
<form action="inputBoardSave" method = "post" id = "frm">
	<input type = "text" name = "id" value = "${id}" readonly><br>
	제목<br>
	<input type = "text" name = "title" class = "boardInput"><br>
	주소<br>
	<input type = "text" name = "addr" class = "boardInput"><br>
	내용<br>
	<input type = "text" name = "content" class = "boardInput"><br>
	<input type = "button" value = "저장" id = "saveBtn">
</form>
</body>
<script type="text/javascript">
	var btn = $('#saveBtn');
	var input = $('.boardInput');
	var frm = $('#frm');
	// 여기서는 유효성 체크를 한다
	// 제목이 비어있는가
	// 유효한 주소인가 >> v2.0
	// 내용이 비어있는가
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