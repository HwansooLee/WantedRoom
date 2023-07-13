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
<style>
    .soldBtn{
		background-color:lightcoral;
	}
    #slider{
        height: 300px;
        width: 300px;
    }
    .card{
        text-align: center;
        margin: 0 auto;
    }
    .positiveTag{
        background-color: aquamarine;
    }
    .negativeTag{
        background-color: lightcoral;
    }
    form{
        display: inline-block;
    }
    input[type="button"]{
        border-radius: 4px;
        border: 1px solid black;
    }
    input[type="submit"]{
        border-radius: 4px;
        border: 1px solid black;
    }
    .itemLocDiv{
        width: 150px;
        text-align: center;
        padding: 6px 0;
    }
    .statusBtn{
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
</style>
<body>
    <!-- 홈페이지 로고 -->
    <a href = "<%=request.getContextPath()%>/">
        <img src = "resources/image/logo.png" width = "200">
    </a>
	<nav>
		<a href="addItemForm">[매물 등록]</a>
		<!-- 리뷰게시판은 세션확인을 통해 이용이 가능하게 한다. -->
		<a href="" id = "review">[리뷰]</a>
		[로그인]
		[회원가입]
	</nav>
	<!-- 검색창 -->
	<form action="searchItem" method="get">
		<input type="text" name="searchWord" placeholder="검색할 주소 입력">
		<input type="submit" value="검색">
	</form>
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
                        <c:if test="${item.status == '계약가능'}">
                            <input type="button" value="${item.status}" class="statusBtn">
                        </c:if>
                        <c:if test="${item.status == '계약완료'}">
                            <input type="button" value="${item.status}" class="statusBtn soldBtn">
                        </c:if>
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
                    <td colspan="2" rowspan="4">
                        <div id="map" style="width:400px;height:320px;"></div>
                    </td>
                </tr>
                <tr>
                    <td><span>보증금</span></td>
                    <td><span>${item.deposit} 원</span></td>
                </tr>
                <tr>
                    <td><span>월세</span></td>
                    <td><span>${item.rent} 원</span></td>
                </tr>
                <tr>
                    <td><span>옵션</span></td>
                    <td>
                        <input type="button" value="주차${item.parking}" id="parking"><br>
                        <input type="button" value="엘리베이터${item.elevator}" id="elevator"><br>
                        <input type="button" value="${item.buildingType}" id="buildingType"><br>
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
                                            <img class="d-block w-100" src="download?fileName=${imgName}" width="400 px">
                                        </div>
                                    </c:if>
                                    <c:if test="${status.index > 0}">
                                        <div class="carousel-item">
                                            <img class="d-block w-100" src="download?fileName=${imgName}" width="400 px">
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
                            <form action="modifyItemForm" method="post">
                                <input type="submit" value="수정" class="modifyItemBtn">
                                <input type="text" name="itemNo" value="${item.itemNo}" hidden>
                            </form>
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
	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>
        let parkTag = $('#parking').val() == '주차가능' ? 'positiveTag' : 'negativeTag';
        $('#parking').addClass(parkTag);
        let elevatorTag = $('#elevator').val() == '엘리베이터있음' ? 'positiveTag' : 'negativeTag';
        $('#elevator').addClass(elevatorTag);

        var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
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
