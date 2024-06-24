<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 헤더 구현하지않음 아직 세션만가져오기 가능</title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
</head>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>	
	<header>
        <div class="sidebar">
            <div class="logo">
                <img src="resources/Remergelogo.png" alt="Remerge logo">
            </div>
            <nav class="menu">
                <ul>
                    <li><div class="menu-item" id="home"><img src="resources/home.png">홈</div></li>
                    <li><div class="menu-item" id="search"><img src="resources/search.png">검색</div></li>
                    <li><div class="menu-item" id="explore"><img src="resources/explore.png">탐색</div></li>
                    <li><div class="menu-item" id="messages"><img src="resources/messages.png">메시지</div></li>
                    <li><div class="menu-item" id="notifications"><img src="resources/notifications.png">알림</div></li>
                    <li><div class="menu-item" id="create"><img src="resources/create.png">만들기</div></li>
                    <li><div class="menu-item" id="store"><img src="resources/store.png">스토어</div></li>
                    <li><div class="menu-item" id="profile"><img src="">프로필</div></li>
                    <li><div class="menu-item" id="profile"><img src=""><a href="calendar.sc">캘린더</a></div></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>