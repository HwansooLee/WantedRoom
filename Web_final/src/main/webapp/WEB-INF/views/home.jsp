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
	<!--nav for home-->
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
	<jsp:include page="footer.jsp"/>
</body>
<script>
	$('head').append('<script src=\'././resources/script/linkAddItem.js\'><\/script>');
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
		// 서버로 비동기로 요청 보내는 방식으로 변경
		$.ajax({
			url : "getIPToCoords?IP=" + nowIp
			,type : "GET"
			,dataType : "JSON"
			,success : function(data){
				mapOption.center = new kakao.maps.LatLng(data[0], data[1]);
				map = new kakao.maps.Map(mapContainer, mapOption);
				allInOne();
			}
			,error : function(){
				console.log(2);
			}
		});
	}
	// 위치정보 동의를 사용자가 선택한 경우 함수 실행
	// 유료라 무료버젼키는 한달에 100번 밖에 사용 못함 아껴써야 함..
	// const temp = userGeoLocation();
	
	$('#findNowLoc').on('click', () => {
		if($('input:checkbox[id = "findNowLoc"]').is(":checked")){ // switch on
			// 테스트용 좌표
			/* let lat = 37.3939;
			let lon = 127.1250;
			mapOption.center = new kakao.maps.LatLng(lat, lon);
			map = new kakao.maps.Map(mapContainer, mapOption);
			allInOne(); */
			// 실제 서비스 구현
			userGeoLocation(); 
		}else{ // switch off
			allInOne();
		}
	});

</script>
</html>
