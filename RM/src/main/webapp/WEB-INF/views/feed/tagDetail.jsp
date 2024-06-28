<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>#${tag.tagContent }</title>
</head>
<body>
	<%@include file="../user/loginHeader.jsp" %>
	
	<div class="outer">
		<div class="tagListTitle">
			<div class="tagInfo">
				<span>#${tag.tagContent }</span>
				<span>총 게시글 수 : ${fn:length(list) }</span>
			</div>
		</div>
		<hr>
		<div class="tagListContent">
			<c:choose>
				<c:when test="${tagList eq null}">
					<div>조회된 게시글이 없습니다.</div>						
				</c:when>
				<c:otherwise>
					<c:forEach var="f" items="${tagList }">
						<div class="feedBlock">
							<img src="${tagList.changeName}">
						</div>
					</c:forEach>		
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>