<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- include kakao map API with clusterer, services, drawing libraries -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0a14867b453fb95c4b9fd54e4b68e47&libraries=services,clusterer,drawing"></script>
<script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 구글 차트 호출을 위한 js 파일 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<link rel="stylesheet" href="resources/css/menuBar.css">
<link rel="stylesheet" href="resources/css/colorItemTag.css">
<style>
    #slider{
        height: 300px;
        width: 400px;
    }
    .card{
        text-align: center;
        margin: 20px auto;
    }
    form{
        display: inline-block;
    }

    input[type="button"]{
        border-radius: 4px;
        border: 1px solid black;
    }
    .modifyItemBtn{
        border-radius: 4px;
        border: 1px solid black;
    }
    .itemLocDiv{
        width: 150px;
        text-align: center;
        padding: 6px 0;
    }
    .statusBtn, #rentType{
        display: block;
        margin: auto;
    }
    .itemDetailText{
        width: 100%;
        border: none;
        resize: none;
    }
    .titleText{
        margin-left: 30%;
    }
    #map{
        width: 400px;
        height: 320px;
    }
    .carousel-inner{
        position: relative;
        top: 50%;
        transform: translateY(-50%);
    }
    .carousel-item{
        height: 100%;
    }
    .carousel-item img{
        position: absolute; 
        top: 0px;
        bottom: 0px;
        left: 0px;
        right: 0px;
        margin: auto;
    }
</style>
<body>
    <nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<!-- 홈페이지 로고 -->
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> <img
				class="logoImg" src="resources/image/logo.png">
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="addItemForm" id="addItem">매물 등록</a></li>
					<li class="nav-item"><a class="nav-link" href="boardList">리뷰게시판</a>
					</li>
					<c:if test="${id eq null}">
						<li class="nav-item">
							<a class="nav-link" href="signIn">로그인</a>
                        </li>
                        <li class="nav-item">
                           	<a class="nav-link" href="signUp">회원가입</a>
                        </li> 
                    </c:if>
                    <c:if test="${id ne null}">
                       	<li class="nav-item">
                           	<a class="nav-link" href="myPage">${nickname}</a>
                       	</li>
                    </c:if>
				</ul>
				<div class="searchDiv border-success">
					<form action="searchItem" method="get">
						<input type="text" name="sword" placeholder="검색할 주소 입력"
							class="inputSword"> <input type="submit" value="검색"
							class="submitBtn btn-success">
					</form>
				</div>
				<c:if test="${id ne null}">
					<span class="navbar-text">
						<button type="button" class="btn btn-outline-secondary"
							id="logOutBtn">로그아웃</button>
					</span>
				</c:if>
			</div>
		</div>
	</nav>
    <div class="card border border-success" style="width: 76%;height: 140%">
		<div class="card-body" style="width: 100%;height: 100%">
            <table id="itemTable" class="table" style="width: 100%;height: 100%">
                <thead hidden>
                    <th style="width: 18%;"></th>
                    <th style="width: 35%;"></th>
                    <th style="width: 18%;"></th>
                    <th style="width: 35%;"></th>
                </thead>
                <tr>
                    <td>
                        <input type="button" value="${item.status}" class="statusBtn">
                    </td>
                    <td colspan="3" class="titleTd">
                        <h3 class="titleText">매물 상세 정보</h3>
                    </td>
                </tr>
                <tr>
                    <td>매물주소</td>
                    <td><span name="addr">${item.addr}</span></td>
                    <td>매물번호</td>
                    <td><span>${item.itemNo}</span></td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="5">
                        <div id="map"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" value="월세" id="rentType"></td>
                </tr>
                <tr>
                    <td><span>보증금</span></td>
                    <td><span>${item.deposit} 원</span></td>
                </tr>
                <tr>
                    <td><span>월세</span></td>
                    <td><span id="rentText">${item.rent} 원</span></td>
                </tr>
                <tr>
                    <td><span>옵션</span></td>
                    <td>
                        <input type="button" value="주차${item.parking}" class="parking"><br>
                        <input type="button" value="엘리베이터${item.elevator}" class="elevator"><br>
                        <input type="button" value="${item.buildingType}" class="buildingType"><br>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2">
                        <span>매물사진</span><br><br>
                        <div id="slider" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner" >
                                <c:forEach var="imgName" items="${fileNames}" varStatus="status">
                                    <c:if test="${status.index == 0}">
                                        <div class="carousel-item active">
                                            <img class="d-block w-100" src="download?fileName=${imgName}">
                                        </div>
                                    </c:if>
                                    <c:if test="${status.index > 0}">
                                        <div class="carousel-item">
                                            <img class="d-block w-100" src="download?fileName=${imgName}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#slider" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#slider" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span>상세설명</span><br><br>
                        <textarea class="itemDetailText" readonly>${item.detail}</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span>동네 평가</span><br>
                        <div id="chart_div"></div>
                    </td>
                    <td>등록일</span></td>
                    <td><span>${item.inDate}</span></td>
                </tr>
                <c:if test="${id eq item.id}">
                    <tr>
                        <td colspan="4">
                            <c:if test="${item.status == '계약가능'}">
                                <form action="modifyItemForm" method="post">
                                    <input type="submit" value="수정" class="modifyItemBtn">
                                    <input type="text" name="itemNo" value="${item.itemNo}" hidden>
                                </form>
                            </c:if>
                            <form action="myItemList?sword=" id="frm">
                                <input type="button" value="삭제" class="deleteItemBtn">
                                <input type="hidden" value="${item.itemNo}">
                            </form>
                        </td>
                    </tr>
                </c:if>
            </table>
        </div>
    </div>
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
        $('head').append('<script src=\'././resources/script/logout.js\'><\/script>');
        $('head').append('<script src=\'././resources/script/colorItemTag.js\'><\/script>');
        let rentTextVal = $('#rentText').text().replace(' 원', '');
        if( rentTextVal == '0' )
            $('#rentType').val('전세');

        var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.277244641634596, 127.02796900714566),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);
        var geocoder = new kakao.maps.services.Geocoder();
        let addr = $('[name="addr"]').text();
        geocoder.addressSearch(addr, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div class="itemLocDiv"><span class="itemLocText">매물위치</span></div>'
                });
                infowindow.open(map, marker);
                map.setCenter(coords);
                getMartInfo(coords);
            } 
        });
        $("#map").on('mousewheel', (e)=>{
            getMartInfo(map.getCenter());
        });
        kakao.maps.event.addListener(map, 'dragend', function() {
            getMartInfo(map.getCenter());
        });

        function getMartInfo(coords){
            let bounds = map.getBounds();
            let data = {
                upperLat : bounds.pa,
                upperLon : bounds.oa,
                lowerLat : bounds.qa,
                lowerLon : bounds.ha
		    };
            $.ajax({
                url: 'getMartInfo',
                type: 'POST',
                data: data,
                success: (martInfo)=>{
                    displayMartInfo(martInfo);
                }
            });            
        }
        const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png';
        const imageSize = new kakao.maps.Size(24, 35);
        const imageOption = {
            spriteSize : new kakao.maps.Size(72, 208),
            spriteOrigin : new kakao.maps.Point(46, 36),
            offset: new kakao.maps.Point(11, 28)
        }
        const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
        function displayMartInfo(martInfo){
            for(mart of martInfo){
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(mart.lat, mart.lon),
                    title : mart.name,
                    image : markerImage
                });
            }
        }

		const DELETE_CONFIRM_WORD = '삭제';
		$('.deleteItemBtn').on('click',(e)=>{
			let checkResult = prompt('정말 해당 매물을 삭제하시겠습니까? 삭제하려면 삭제를 입력하세요.');
			if( checkResult == DELETE_CONFIRM_WORD ){
				let itemNoVal = $(e.target).next().val();
				$.ajax({
						url: 'deleteItem',
						type: 'POST',
						data:{
							itemNo : itemNoVal
						},
						success: ()=>{
							alert('삭제 완료하였습니다.');
							$(e.target).parent().submit();
						}
					});	
			}				
			else
				alert('삭제 취소하였습니다.');
		});
        
        var itemNo = '${item.itemNo}';
        
        //구글 차트 라이브러리 로딩
		google.load('visualization','1',{
		    'packages' : ['corechart']
		});
        
        // 라이브러리 로딩이 완료되면 drawChart 함수를 호출한다.
        google.setOnLoadCallback(drawChart);
        function drawChart(){
        	let itemdata = {
        		"itemNo" : itemNo
        	};
        	var jsonData = $.ajax({
        		url : "getChartData",
        		dataType : "JSON",
        		type: "POST",
        		data : JSON.stringify(itemdata),
        		contentType : "application/json",
        		async : false
        	}).responseText;
        	// 데이터 테이블 생성
        	// json 형식의 데이터를 구글의 테이블 형식으로 변환한다.
        	var data = new google.visualization.DataTable(jsonData);
        	var chart = new google.visualization.PieChart(document.getElementById('chart_div')); // 원형 그래프로 생성
        	var option = {
            	width : 400,
            	height : 300,
            	colors : ['#1c53ca','coral','gray']
        	}        	
        	chart.draw(data, option);
        }            
	</script>
</html>
