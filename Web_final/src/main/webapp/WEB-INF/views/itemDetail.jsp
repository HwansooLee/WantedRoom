<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- include kakao map API with clusterer, services, drawing libraries -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0a14867b453fb95c4b9fd54e4b68e47&libraries=services,clusterer,drawing"></script>
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

	<!-- 상세 보기 -->
    <input type="button" value="${item.status}"><br>
    <img src="download?fileName=${item.fileName}"><br>
    <span>매물번호 : ${item.itemNo}</span><br>
    매물주소<input type="text" name="addr" value="${item.addr}" readonly><br>
    <div id="map" style="width:500px;height:400px;"></div>

    <span>보증금 : ${item.deposit}</span><br>
    <span>월세 : ${item.rent}</span><br>
    <span>상세설명</span><br>
    <span>${item.detail}</span><br>
    <span>옵션</span><br>
    <input type="button" value="주차${item.parking}">
    <input type="button" value="엘리베이터${item.elevator}">
    <input type="button" value="${item.buildingType}"><br>
    <span>매물사진</span><br>
    <c:forEach var="imgName" items="${fileNames}">
        <img src="download?fileName=${imgName}" height="300"><br>
    </c:forEach><br>
    <span>매물등록일 : ${item.inDate}</span><br>
    <a href="modifyItemForm?itemNo=${item.itemNo}">수정</a>
    <form action="myItemList?sword=" id="frm">
        <input type="button" value="삭제" id="modifyItemBtn">
        <input type="hidden" value="${item.itemNo}">
    </form>

	<footer>
		<!-- 개발자 정보 -->
	</footer>
</body>
	<script>
        var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);
        var geocoder = new kakao.maps.services.Geocoder();
        let addr = $('[name="addr"]')[0].value;
        geocoder.addressSearch(addr, function(result, status) {
        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">매물위치</div>'
            });
            infowindow.open(map, marker);
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
        });  
        $('#modifyItemBtn').on('click', (e)=>{
            let itemNoVal = $(e.target).next().val();
            $.ajax({
					url: 'deleteItem',
					type: 'POST',
					data:{
						itemNo : itemNoVal
					},
					success: ()=>{
						alert('삭제완료하였습니다.');
                        $('#frm').submit();
					}
				});	
        })
	</script>
</html>
