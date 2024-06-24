
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
	<div class="outer">
		<br> <br>
		<div class="innerOuter">

			<br>
			<!-- <form action="mypage.us" method="post"> -->
				<div class="form-group"> 
					 <img id="profile" src="${pageContext.request.contextPath}${loginUser.profilePath }" width="30" height="30" > &nbsp; ${user.userId } &nbsp &nbsp &nbsp 게시물
					&nbsp; 팔로잉 &nbsp; 팔로워 &nbsp; &nbsp;
					<a href="updatePage.us" class="button-link">프로필 편집</a>
					<button type="button" id="shareProfile" class="button-link">프로필 공유</button>
					<c:choose>
						<c:when test="${followFlag eq false }">
							<button onclick="follow();" class="button-link">팔로우</button>
						</c:when>
						<c:otherwise>
							<button onclick="unFollow();" class="button-link">언팔로우</button>
						</c:otherwise>
					</c:choose>					
				</div>
				<div>
					${user.userMemo }
				</div>
			<!-- </form> -->
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
	function follow(){
		$.ajax({
			url:"insertFollow.us",
			type:"post",
			data:{
				fromUser:"${loginUser.userId}",
				toUser:"${user.userId}"
			},
			success:function(result){
				//console.log(result); 결과 확인
				if(result>0){
					alert('팔로우 추가!');
				}else{
					alert('팔로우가 추가되지 않았습니다. 관리자에게 문의하세요');
				}
				 window.location.reload();//결과 확인 누르면 새로 고침
			},
			error:function(){
				console.log("통신 실패");
			}
		});
	}
	
	function unFollow(){
		$.ajax({
			url:"deleteFollow.us",
			type:"post",
			data:{
				fromUser:"${loginUser.userId}",
				toUser:"${user.userId}"
			},
			success:function(result){
				if(result>0){
					alert('팔로우가 성공적으로 해제 되었습니다.');
				}else{
					alert('팔로우 해제가 되지 않았습니다. 관리자에게 문의하세요.');
				}
				 window.location.reload();//결과 확인 누르면 새로 고침
			},
			error:function(){
				console.log('통신 실패');				
			}
		});
	}
	
</script>


</html>

