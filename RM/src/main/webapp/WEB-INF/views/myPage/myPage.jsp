
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
</head>
<style>
.container {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;;
	gap: 0px;
}

.button-link {
	display: inline-block;
	padding: 10px 15px;
	font-size: 15px;
	color: black;
	background-color: #dcdee0;
	text-decoration: none;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	text-align: center;
}
</style>

<body>
	 <%@include file="/WEB-INF/views/user/loginHeader.jsp" %>
	<div class="content">
		<br> <br>
		<div class="innerOuter">

			<br>
			<form action="mypage.us" method="post">
				<div class="form-group"> 
					 <img id="profile" src="${pageContext.request.contextPath}${loginUser.profilePath }" width="30" height="30" > &nbsp; ${loginUser.userId } &nbsp &nbsp &nbsp 게시물
					&nbsp; 팔로잉 &nbsp; 팔로워 &nbsp; &nbsp;
					<a href="updatePage.us" class="button-link">프로필 편집</a>
					<button type="button" id="shareProfile" class="button-link">프로필 공유</button>
				</div>
				<div>
					${loginUser.userMemo }
				</div>
			</form>
		</div>
		<br> <br>
		<div class="container">
			<form action="feed">
				<div align="center">
					<img src="resources/apps.png" width="20" id="apps">
				</div>
			</form>
			<form action="">
				<div align="center">
					<img src="resources/heart.png" width="20" id="heart">
				</div>
			</form>
			<form action="">
				<div align="center">
					<img src="resources/bookmark.png" width="20" id="bookmark">
				</div>
			</form>
		</div>
		</div>
		<hr>
</body>



<script>
	
</script>


</html>

