<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 헤더 구현하지않음 아직 세션만가져오기 가능</title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
</head>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>	
	<h2>로그인헤더(loginUser session으로 값넘김)</h2>
	<h4>${sessionId}</h4>
	<%-- <h4>${loginUser.userId}</h4>
	<h4>${loginUser.userPwd}</h4>
	<h4>${loginUser.email}</h4>
	<h4>${loginUser.joinDate}</h4>
	<h4>${loginUser.profilePath}</h4>
	<h4>${loginUser.status}</h4>
	<h4>${loginUser.shopBrandChek}</h4>
	<h4>${loginUser.userMemo}</h4> --%>
	
	<a href="logout.us">로그아웃</a>
</body>
</html>