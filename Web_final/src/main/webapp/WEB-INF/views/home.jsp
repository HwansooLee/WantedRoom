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
	<a href = "<%=request.getContextPath()%>/">
		<img src = "resources/image/logo.png" width = "200">
	</a>
	<nav>
		<a href="" id = "addItem">[매물 등록]</a>
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
	
	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>
	
	$(document).ready(() => {
		console.log(1);
		getLocation();
	});
	
		$('#addItem').on('click', () => {
			var authenticated = '${authenticated}';
			console.log(authenticated);
            if(authenticated == 'false'){
            	alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다.');
            }else{
            	$('#addItem').attr('href','addItemForm');
            }
		});
	    
	    function success({ coords, timestamps}){
	    	console.log(3);
	    	const latitude = coords.latitude;
	    	const longitude = coords.longitude;
	    	console.log('위도 : ' + latitude + ' 경도 : ' + longitude);
	    }
	    
	    function getLocation(){
	    	console.log(2);
	    	if(navigator.geolocation){
	    		console.log(4);
	    		navigator.geolocation.getCurrentPosition(success);
	    	}
	    }

	</script>
</html>
