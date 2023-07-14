<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<html>
<head>
<title>Wanted Room</title>
</head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0a14867b453fb95c4b9fd54e4b68e47&libraries=services,clusterer,drawing"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href = "resources/css/home.css">
<style>
	a{
		color: black;
		text-decoration: none;
	}
	[type="checkbox"]:checked::before {
		background-color: white;
		left: 1em;
	}
	[type="checkbox"]:checked {
		background-color: #22af12;
		border-color: #22af12;
	}
</style>
<body>
	<!--nav-->
    <nav class="navbar bg-light fixed-top">
        <div class="container-fluid">
            <!--logo-->
            <a class="navbar-brand" href="<%=request.getContextPath()%>/">
                <img src="resources/image/logo.png" class="logoImg" style="width: 200px;display: block;	margin: -8px;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                aria-controls="offcanvasNavbar" style="background-color: lightgreen;">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
                aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                    <h4 class="offcanvas-title" id="offcanvasNavbarLabel">Menu</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                        <li class="nav-item">
                            <a href="" id="addItem">매물 등록</a>
                        </li>
                        <br>
                        <li class="nav-item">
                            <a href="boardList">리뷰</a>
                        </li>
                        <br>
                        <c:if test="${id eq null}">
                            <li class="nav-item">
                                <a href="signIn">로그인</a>
                            </li>
                            <br>
                            <li class="nav-item">
                                <a href="signUp">회원가입</a>
                            </li> 
                        </c:if>
                        <c:if test="${id ne null}">
                            <li class="nav-item">
                                <a href="myPage">${nickname}</a>
                            </li>
                            <br>
                            <li class="nav-item">
                                <a href="signOut">로그아웃</a>
                            </li>
                        </c:if>
                        <br>
                        <li>
                            <label>
                                <input role="switch" type="checkbox" id = "findNowLoc"/>
                                <span>현재 위치로 찾기</span>
                            </label>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </nav>
    <br><br><br><br><br><br><br>
    <!--search bar-->
	<div class = "searchDiv" style = "border: 2.5px solid green;width: 500px;height: 45px;border-radius: 15px;margin: auto;">
		<form action="searchItem" method="get" id = "searchItem">
			<input type="text" name="sword" placeholder="검색할 주소 입력" class = "inputSword" id = "centerAddr" style = "margin: 5px;border: 0;outline: none;width: 420px">
			<input type="button" value="검색" class = "submitBtn" id="custom-button" 
			style = "font-size: 15px;border: none;background-color: #22af12;width: 50px;height: 30px;border-radius: 15px;color: #fff;cursor: pointer;margin: 1px;margin-top: 5px;">
		</form>
	</div>
	<br>
	<!-- 지도 -->
	<section>
		<div class = "myMap" id="map" style="width:500px;height:400px;margin: 0 auto;margin-top: 100px;"></div>
	</section>

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
<script>

	//submit
	$('#custom-button').on('click', () => {
	    $('#searchItem').submit();
	});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(37.277244641634596, 127.02796900714566), // 지도의 중심좌표
			level: 5 // 지도의 확대 레벨
		};  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		
	allInOne();
		
	function allInOne(){
		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
					detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
					
					var content = '<div class="bAddr">' +
									'<span class="title">법정동 주소정보</span>' + 
									detailAddr + 
								'</div>';

					// 마커를 클릭한 위치에 표시합니다 
					marker.setPosition(mouseEvent.latLng);
					marker.setMap(map);

					// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
					infowindow.setContent(content);
					infowindow.open(map, marker);
				}   
			});
		});

		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
		
	}

	

	function searchAddrFromCoords(coords, callback) {
		// 좌표로 행정동 주소 정보를 요청합니다
		geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);       
	}

	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}

	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
 	function displayCenterInfo(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			var info = $('#centerAddr');

			for(var i = 0; i < result.length; i++) {
				// 행정동의 region_type 값은 'H' 이므로
				if (result[i].region_type === 'H') {
					info.val(result[i].region_2depth_name + result[i].region_3depth_name);
					break;
				}
			}
		}    
	}


	
	$('#addItem').on('click', () => {
		var authenticated = '${authenticated}';
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
		const geoData = await fetch('http://api.ipstack.com/' + nowIp
				+ '?access_key=1d043620c06ab6fd6949c2058e955df4&output=json')
			.then((r) => r.json())
			.then((r) => {
				return r;
			});
		// 중심위치 현재 위치로 재지정
		mapOption.center = new kakao.maps.LatLng(geoData.latitude, geoData.longitude);
		map = new kakao.maps.Map(mapContainer, mapOption);
		// 이벤트 재등록
		allInOne();
	}
	// 위치정보 동의를 사용자가 선택한 경우 함수 실행
	// 유료라 무료버젼키는 한달에 100번 밖에 사용 못함 아껴써야 함..
	// const temp = userGeoLocation();
	
	$('#findNowLoc').on('click', () => {
		if($('input:checkbox[id = "findNowLoc"]').is(":checked")){ // switch on
			// 테스트용 좌표
			let lat = 37.3939;
			let lon = 127.1250;
			mapOption.center = new kakao.maps.LatLng(lat, lon);
			map = new kakao.maps.Map(mapContainer, mapOption);
			allInOne();
			// 실제 서비스 구현
			// userGeoLocation(); 
		}else{ // switch off
			allInOne();
		}
	});

</script>
</html>
