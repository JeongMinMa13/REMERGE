<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@include file="../user/loginHeader.jsp" %>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- 게시물 디테일 모달 -->
		<div class="modal fade" id="modal_detail_feed" tabindex="-1" role="dialog" aria-labelledby="modal_detail_feed" aria-hidden="true">
		    <div class="modal-dialog modal-xl" role="document">
		        <div class="modal-content">
		            <div class="modal-body d-flex p-0">
		                <div class="modal-image flex-fill">
		                    <img src="" id="feed_detail_img" class="w-100 h-100" style="object-fit: cover;">
		                </div>
		                <div class="modal-details flex-fill d-flex flex-column">
		                    <div class="modal-header">
		                        <div class="d-flex align-items-center">
		                            <img src="" id="feed_user_img" class="rounded-circle" alt="프로필 사진" style="width: 40px; height: 40px;">
		                            <div class="ml-2">
		                                <span class="username" id="feed_userId">사용자 이름</span>
		                                <div id="feed_location" class="text-muted" style="font-size: 12px;">위치 정보</div>
		                            </div>
		                        </div>
		                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                            <span aria-hidden="true">&times;</span>
		                        </button>
		                    </div>
		                    <div class="modal-body-content flex-fill p-3" style="overflow-y: auto;">
		                        <div id="feed_detail_content" class="mb-3"></div>
		                        <div id="feed_detail_replyList" class="comment-section"></div>
		                    </div>
		                    <div class="modal-footer border-top p-3 flex-column">
		                        <div id="feed_detail_like" class="mb-2 d-flex align-items-center w-100">
		                            <button id="likeButtonDetail" class="like-button btn p-0 mr-2">
		                                <i class="heart-icon far fa-heart" style="font-size: 24px; color: #FF5A5F;"></i>
		                            </button>
		                            <span id="likeCountDetail"></span>개
		                        </div>
		                        <div id="like_reply" class="w-100">
		                            <div class="form-group d-flex mb-0">
		                                <input type="text" name="content" id="content${feedNo}" class="form-control mr-2" placeholder="댓글을 입력해주세요.." style="height: 40px;">
		                                <button class="btn btn-primary" onclick="insertReply(${feedNo})">등록</button>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>

	<script type="text/javascript">
	
	function detailView(feedNo){
		$('#modal_detail_feed').modal('show');
		$.ajax({
			url : "detail.fe",
			type : "post",
			data :{
				feedNo : feedNo
			},
			success:function(result){
				console.log(result);
				 $('#feed_detail_img').attr('src', result.f.changeName);
		         $('#feed_userId').text(result.f.feedWriter);
		         $('#feed_location').text(result.f.feedLocation); 
		         $('#feed_detail_content').text(result.f.feedContent);
		         var str = "";
		         for(var i = 0; i<result.rList.length; i++){
		        	 var reply = result.rList[i];
		                str += '<div class="modal-body">';
		                str += '    <div id="feed_detail_replyList">';
		                str += '        <p><strong>' + reply.userId + ':</strong> ' + reply.reContent + '</p>';
		                str += '    </div>';
		                str += '</div>';

		         }
		         
		         $('#feed_detail_replyList').html(str);
		         
				 var reHtml = "";			        
				 reHtml += '<div>';
				 reHtml += '<input type="text" name="content" id="content'+result.f.feedNo+'" placeholder="댓글을 입력해주세요..">';
				 reHtml += '<label><button onclick="insertModal(this,'+result.f.feedNo+')">등록</button></label>'
				 reHtml += '</div>';

		         var content = $("#content"+feedNo).val();
		         console.log("content",content);
		         $('.form-group').html(reHtml);
		         
		         
			},
			error : function(){
				console.log("통신실패");	
			}
		});
	}
	
	function replyList(feedNo){
		$.ajax({
			url : "replyList.fe",
			data : {
				feedNo : feedNo
			},
			success : function(result){
				var str = "";
				if(result.rList.length > 0){
	                var reply = result.rList[0]; // 가장 최근 댓글 하나만 가져옴
	                str += '<div class="reply">';
	                str += '<p><strong>' + reply.userId + ':</strong> ' + reply.reContent + '</p>';
	                str += '</div>';
	            }
				  $("#replyList" + feedNo).html(str); // 댓글 리스트를 해당 게시물 div에 추가
				  
			},
			error : function(){
				console.log("통신오류");
			}
			
		});
	};
	
	<!-- 두번째 댓글 입력 -->
	function insertModal(el,feedNo){
		var content = $(el).parent().siblings().first().val();
		
		$.ajax({
			url : "insertModal.fe",
			type : "post",
			data : {
				feedNo : feedNo,
				userId : "${loginUser.userId}",
				reContent : content 
			},
			success : function(result){
				if(result>0){
					var newReply = '<div class="reply">';
	                newReply += '<p><strong>${loginUser.userId}:</strong> ' + content + '</p>';
	                newReply += '</div>';
	                
	                $('#feed_detail_replyList').append(newReply); // 댓글 리스트에 새로운 댓글 추가
	                $(el).parent().siblings().first().val(""); // 입력 필드 초기화
					alert("댓글 등록");
				}else{
					alert("댓글작성실패");
				}
			},
			error : function(){
				console.log("안 떠요");
			}
		});
	};
	</script>
</body>
</html>