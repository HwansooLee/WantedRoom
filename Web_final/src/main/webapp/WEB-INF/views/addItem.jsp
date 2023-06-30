<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
	<!-- 홈페이지 로고 -->
	<nav>
		<a href="addItem">[매물 등록]</a>
		[리뷰]
		[로그인]
		[회원가입]
	</nav>
	<form action="" >
			<!-- 검색창 -->
	</form>
	<!-- add item -->
	<form action="" method="post" enctype="multipart/form-data">
		주소<input type="text" name="addr"><br>
		보증금<input type="text" name="deposit"><br>
		월세<input type="text" name="rent"><br>
		상세설명<input type="textarea" name="detail">

		<!-- upload multiple files -->
		<input type="file" name="file" multiple/><br>
		<input type="button" value="등록" id="addBtn">
	</form>

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>
		let fileInput = $("[name='file']");
		let fileList = [];

		fileInput.on('change', (e)=>{
			console.log('change');
			for (let i = 0; i < fileInput[0].files.length; i++) 
        		fileList.push(fileInput[0].files[i]);
		});
		$('#addBtn').on('click', ()=>{
			console.log( fileList.length );
			for(let f of fileList)
				console.log(f.name);
		});
	</script>
</html>