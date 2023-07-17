<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel = "stylesheet" href = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/menuBar.css">
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
                    aria-current="page" href="" id="addItem">매물 등록</a></li>
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
<script>
    $('head').append('<script src=\'././resources/script/linkAddItem.js\'><\/script>');
</script>