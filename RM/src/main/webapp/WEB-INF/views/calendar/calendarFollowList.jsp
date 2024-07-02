<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 정보</title>
<jsp:include page="/WEB-INF/css/followListCSS.jsp"/>
</head>
<body>
	<%@include file = "../user/loginHeader.jsp" %>
	<div class="outer">
		<div class="followListTitle"><h1>팔로우 목록</h1></div>
		<div class="followListContent">
			<c:choose>
				<c:when test="${followList ne null }">
					<ul>
						<c:forEach var='u' items='${followList}'>
							<li class="followUser" onclick="selectId('${u.userId}');">
								<c:choose>
									<c:when test="${u.profileChangeName eq null} ">
										<span class="profileImage"><img src="resources/unknown.jpg"></span>
									</c:when>
									<c:otherwise>
										<span class="profileImage"><img src="${u.profileChangeName }"></span>
									</c:otherwise>
								</c:choose>
								<p>
									<strong class="userId">${u.userId }</strong>
									<span class="memo">${u.userMemo }</span>
								</p>
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					<div>조회된 팔로우가 없습니다.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<script type="text/javascript">
		function selectId(data){//팔로우된 사용자 클릭시 캘린더로 이동
			location.href="shareCalendar.sc?userId="+data; 
		}
	</script>

</body>
</html>