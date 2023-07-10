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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0a14867b453fb95c4b9fd54e4b68e47&libraries=services,clusterer,drawing"></script>
<body>

	

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
<script>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(37.33202, 126.58432), // 지도의 중심좌표
			level: 1 // 지도의 확대 레벨
		};  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
	searchAddrFromCoords(map.getCenter(), displayCenterInfo);


	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', function() {
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
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
		};
	}
	// 위치정보 동의를 사용자가 선택한 경우 함수 실행
	// 유료라 무료버젼키는 한달에 100번 밖에 사용 못함 아껴써야 함..
	// const temp = userGeoLocation();

</script>
</html>
