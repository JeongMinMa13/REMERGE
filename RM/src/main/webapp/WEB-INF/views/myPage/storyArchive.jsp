<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
 .storyBlock {
    height: 22.7vw;
    flex: 0 0 30%;
    box-sizing: border-box;
    margin: 16px;
    border-radius: 5%;
    overflow: hidden;
    position: relative;
        }
.storyBox{
	display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}
.storyBlock::before {content:''; position:absolute; top:0; left:0; bottom:0; right:0; background-color:#000; opacity:0;}
.storyBlock:hover::before{opacity:0.3;}
.storyBlock img {width:100%; height:100%;}

.modal-img {
    max-width: 100%;
    height: auto;
}



</style>
<body>
<%@include file="../user/loginHeader.jsp"%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<h1 align="center">보관된 스토리 보기</h1>
	<div class="outer">
		<c:choose>
					<c:when test="${empty storyArchive}">
						<div>올린 스토리가 없습니다.</div>						
					</c:when>
					<c:otherwise>
							<div class="storyBox">
								<c:forEach var="s" items="${storyArchive }">
									<div class="storyBlock" onclick="storyDetailView(${s.storyNo});">
										<img class="storyBlockImg" src="${s.changeName}" >
									</div>
								</c:forEach>		
							</div>
					</c:otherwise>
				</c:choose>
				
<div class="modal fade" id="modal_view_story" tabindex="-1"
		role="dialog" aria-labelledby="modal_view_story_title"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_view_story_title">스토리</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" onclick="storyClose();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<img src="" id="story_view_img" class="modal-img">
					<!-- 스토리 사진 영역 -->
					<div id="story_view_content"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
	function storyDetailView(storyNo){ 
		
		
		$.ajax({
			url:"storyDetail.us",
			type:"post",
			data:{
				storyNo:storyNo
			},
			success:function(result){
				$("#story_view_img").attr("src",result.changeName);
				$("#story_view_content").text(result.storyContent);
				
			},
			error:function(){
				console.log("통신 실패");
			}
			
		});
		
		$('#modal_view_story').modal('show');
	}
	</script>
	</div>
	
</body>
</html>