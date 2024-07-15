<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="feedDetailModal.jsp" %>
	<div class="outer">
		<div class="feedBox">
			<c:forEach var="f" items="${feedExplore}">
				<div class="feedBlock" onclick="detailView(${f.feedNo});">
					<img class="feedBlockImg" src="${f.changeName}">
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>