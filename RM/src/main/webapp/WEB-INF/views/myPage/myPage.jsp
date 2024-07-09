<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	ef="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
.container {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 0px;
}
.button-link {
	display: inline-block;
	padding: 10px 15px;
	font-size: 15px;
	color: black;
	background-color: #DCDEE0;
	text-decoration: none;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	text-align: center;
}
 .feedLike {
	display: none;
}
 .feedBlockImg {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }
 .feedBlockImg {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/feed/feedDetailModal.jsp" %>	
	<div class="outer">
		<br>
		<br>
		<div class="innerOuter">
			<br>
			<div class="form-group">
				<!-- null일때 -->
				<c:choose>
					<c:when test="${user.profileChangeName eq null }">
						<img id="profile" src="resources/unknown.jpg" width="100"
							height="100">
                    &nbsp; <b>${user.userId }</b> &nbsp; &nbsp; &nbsp; 게시물 <b>${feedCount}</b> &nbsp;
                    <button class="btn btn-light" onclick="following();" type="button" data-bs-toggle="modal"
							data-bs-target="#followingModal">팔로잉</button>
							
                   <b> ${followingCount }</b> <button class="btn btn-light" onclick="follower();" type="button" data-bs-toggle="modal" data-bs-target="#followerModal">팔로워</button> <b>${followerCount }</b> &nbsp; &nbsp;
                </c:when>
					<c:otherwise>
						<img style="border-radius: 70%" id="profile"
							src="${user.profileChangeName }" width="100" height="100">
							
                    &nbsp; ${user.userId } &nbsp; &nbsp; &nbsp;<b> ${feedCount }</b> 게시물  &nbsp;
                   <button class="btn btn-light" onclick="following();" type="button" data-bs-toggle="modal"
							data-bs-target="#followingModal">팔로잉</button>
                  <b>  ${followingCount }</b> 팔로워 <button class="btn btn-light" onclick="follower();" type="button" data-bs-toggle="modal" data-bs-target="#followerModal">팔로워</button><b> ${followerCount }</b> &nbsp; &nbsp;
                </c:otherwise>
				</c:choose>
				<!-- null 아닐때 -->
				<c:if test="${loginUser.userId eq user.userId }">
					<a href="updatePage.us" class="button-link">프로필 편집</a>
					<a href="storyArchive.us?userId=${loginUser.userId}" class="button-link">보관된 스토리 보기</a>
				</c:if>
				<c:if test="${loginUser.userId ne user.userId }">
					<c:choose>
						<c:when test="${followFlag eq false }">
							<button onclick="follow();" class="button-link">팔로우</button>
						</c:when>
						<c:otherwise>
							<button onclick="unFollow();" class="button-link">언팔로우</button>
						</c:otherwise>
					</c:choose>
					<a href="message/dm" class="button-link">메시지</a>
				</c:if>
			</div>
			<div>${user.userMemo }</div>
		</div>
		<br>
		<br>
		<hr>
		<div class="container">
				<div align="center">
					<a id="appsLink" href="#"><img src="resources/apps.png" width="20" id="apps"></a>
				</div>
				
				<div align="center">
					<a id="heartLink" href="#"><img src="resources/heart.png" width="20" id="heart"></a>
				</div>
			
				<div align="center">
					<a id="bookmarkLink" href="#"><img src="resources/bookmark.png" width="20" id="bookmark"></a>
				</div>
		</div>
		<div class="feedList">
		<c:choose>
				<c:when test="${user.userId eq null}">
					<div>조회된 게시글이 없습니다.</div>						
				</c:when>
				<c:otherwise>
						<div class="feedBox" style="width:1500px; height:450px;" >
							<c:forEach var="f" items="${myFeedlist }">
								<div class="feedBlock" onclick="detailView(${f.feedNo});">
									<img class="feedBlockImg" src="${f.changeName}" >
								</div>
							</c:forEach>		
						</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="feedLike">
		<c:choose>
				<c:when test="${empty myFeedlike }">
					<div>좋아요한 게시물이 없습니다.</div>						
				</c:when>
				<c:otherwise>
						<div class="feedBox" style="width:1500px; height:450px;" >
							<c:forEach var="f" items="${myFeedlike }">
								<div class="feedBlock" onclick="detailView(${f.feedNo});">
									<img class="feedBlockImg" src="${f.changeName}" >
								</div>
							</c:forEach>		
						</div>
				</c:otherwise>
			</c:choose>
		</div>
		</div>
	
				
	
	
	<!-- 팔로잉 목록 모달 -->
	<div class="modal fade" id="followingModal" tabindex="-1"
		aria-labelledby="followingModalLabel" aria-hidden="true">
		
		
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" >
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">팔로잉 목록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
				<div id="following" ></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
		</div>
		
		<!-- 팔로워 모달 -->
		<div class="modal fade" id="followerModal" tabindex="-1"
		aria-labelledby="followerModalLabel" aria-hidden="true">
		
		
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">팔로워 목록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
				<div id="follower" ></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
		</div>
	<script>
		function follow() {
			$.ajax({
				url : "insertFollow.us",
				type : "post",
				data : {
					fromUser : "${loginUser.userId}",
					toUser : "${user.userId}"
				},
				success : function(result) {
					if (result > 0) {
						alert('팔로우 추가!');
					} else {
						alert('팔로우가 추가되지 않았습니다. 관리자에게 문의하세요');
					}
					window.location.reload();
				},
				error : function() {
					console.log("통신 실패");
				}
			});
		}
		function unFollow() {
			$.ajax({
				url : "deleteFollow.us",
				type : "post",
				data : {
					fromUser : "${loginUser.userId}",
					toUser : "${user.userId}"
				},
				success : function(result) {
					if (result > 0) {
						alert('팔로우가 성공적으로 해제 되었습니다.');
					} else {
						alert('팔로우 해제가 되지 않았습니다. 관리자에게 문의하세요.');
					}
					window.location.reload();
				},
				error : function() {
					console.log('통신 실패');
				}
			});
		}
	</script>
	
	<script>
		function following(){
			$.ajax({
				url:"followingList.us",
				type: "GET",
				data : {
					userId : "${user.userId}"
				
				},
				success : function(followingList){
					console.log(followingList);
					 var str ="";
					 for(var i =0; i < followingList.length;i++){
					 var sfollowingList = followingList[i]
					 var profilePath = sfollowingList.profilePath;
					 var profileChangeName= sfollowingList.profileChangeName;
					 if(sfollowingList.profileChangeName){
					 str +="<ul>"
					 str += "<li><img src='" + profileChangeName + "' style='width: 30px; height: 30px; border-radius: 50%;'>"  + sfollowingList.userId + "</li>";
					 str +="</ul>"
					 }else{
						 str +="<ul>"
							 str += "<li><img src='" + profilePath + "' style='width: 30px; height: 30px; border-radius: 50%;'>"  + sfollowingList.userId + "</li>";
							 str +="</ul>"
					 }
					 }
					$("#following").html(str);
				},
				error : function(){
					console.log("zz");
				}
				
			});
		}
	</script>
	
	<script>
		function follower(){
			$.ajax({
				url:"followerList.us",
				type: "GET",
				data : {
					userId : "${user.userId}"
				
				},
				success : function(followerList){
					console.log(followerList);
					 var str ="";
					 for(var i =0; i < followerList.length;i++){
					 var sfollowerList = followerList[i]
					 var profilePath = sfollowerList.profilePath;
					 var profileChangeName= sfollowerList.profileChangeName;
					 if(sfollowerList.profileChangeName){
					 str +="<ul>"
					 str += "<li><img src='" + profileChangeName + "' style='width: 30px; height: 30px; border-radius: 50%;'>"  + sfollowerList.userId + "</li>";
					 str +="</ul>"
					 }else{
						 str +="<ul>"
							 str += "<li><img src='" + profilePath + "' style='width: 30px; height: 30px; border-radius: 50%;'>"  + sfollowerList.userId + "</li>";
							 str +="</ul>"
					 }
					 }
					$("#follower").html(str);
				},
				error : function(){
					console.log("zz");
				}
				
			});
		}
	</script>
	
	<script>
	$(document).ready(function() {
		$("#appsLink").click(function(e) {
			   var newImageUrl = "resources/bapps.png";
		        $("#apps").attr("src", newImageUrl);
		        var newImageUrl = "resources/heart.png";
		        $("#heart").attr("src", newImageUrl);
			e.preventDefault();
			$(".feedList").show();
			$(".feedLike").hide();
		});
		$("#heartLink").click(function(e) {
			 var originalImageUrl = "resources/apps.png";
			    $("#apps").attr("src", originalImageUrl);	
			   var newImageUrl = "resources/bheart.png";
		        $("#heart").attr("src", newImageUrl);
			e.preventDefault();
			$(".feedList").hide();
			$(".feedLike").show();
		});
	});
	</script>
</body>
</html>