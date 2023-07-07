<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
<title>Home</title>
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
	<!-- 홈페이지 로고 -->
	<a href="<%=request.getContextPath()%>/"> <img
		src="resources/image/logo.png" width="200">
	</a>
	<nav>
		<a href="" id="addItem">[매물 등록]</a>
		<!-- 리뷰게시판은 세션확인을 통해 이용이 가능하게 한다. -->
		<a href="boardList">[리뷰]</a>
		<c:if test="${id eq null}">
			<a href="signIn">[로그인]</a>
			<a href="signUp">[회원가입]</a>
		</c:if>
		<c:if test="${id ne null}">
			<a href="myPage">[${nickname}]</a>
			<a href="signOut">[로그아웃]</a>
		</c:if>
	</nav>
	<!-- 검색창 -->
	<form action="searchItem" method="get">
		<input type="text" name="sword" placeholder="검색할 주소 입력"> <input
			type="submit" value="검색">
	</form>

	<!-- 매물 리스트 -->

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
<script>
	
	$('#addItem').on('click', () => {
		var authenticated = '${authenticated}';
		console.log(authenticated);
		if(authenticated == 'false'){
			alert('부동산 중개업자 인증한 사용자만 매물 등록이 가능합니다.');
		}else{
			$('#addItem').attr('href','addItemForm');
		}
	});
	
	const res = () => { // IP받아오는 함수
		return fetch('http://geolocation-db.com/json/')
		.then((res) => res.json())
		.then(res => res["IPv4"]);
	};
	
	const userGeoLocation = () => {
		return getLocation();
	}
	
	const getLocation = async () => { // 좌표 받아오는 함수
		const nowIp = await res();
		console.log(nowIp);
		const geoData = await fetch('http://api.ipstack.com/' + nowIp
				+ '?access_key=1d043620c06ab6fd6949c2058e955df4&output=json')
			.then((r) => r.json())
			.then((r) => {
				console.log(r);
				return r;
			});
		const latitude = geoData.latitude;
		const longitude = geoData.longitude;
		console.log(latitude);
		console.log(longitude);
		return {
			lat : latitude,
			lon : longitude
		}
	}
	// 위치정보 동의를 사용자가 선택한 경우 함수 실행
	// 유료라 무료버젼키는 한달에 100번 밖에 사용 못함 아껴써야 함..
	// const temp = userGeoLocation();

</script>
</html>
