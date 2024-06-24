<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main 페이지</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
</head>
<body>
	<%@include file="../user/loginHeader.jsp" %>
    <div class="con_wrap">
    	<div class="conA">
    	</div>
      </div>
    <div class="body">
        <!--스토리 목록-->
            <div class="storys">
            	<div class="story" onclick="addStory()">
		      		<img class="story_img" src="resources/plusicon.jpeg">
		      		<span>스토리 추가하기</span>
		      	</div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="story">
                    <img class="story_img" src="">
                    <span>junhyung_ing</span>
                </div>
                <div class="next_icon">
                    <i class="fas fa-angle-right"></i>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="profile-header">
                <img src="./CSS/img/라쿤.jpg" alt="Your Profile Picture">
                <div class="profile-info">
                    <span class="username">junhyung_ing</span>
                    <span class="subtext">신준형</span>
                </div>
            </div>
            <div class="suggestions-header">
                <span>인기 팔로워</span>
                <a href="#">모두보기</a>
            </div>
            <div class="suggestion">
                <div class="suggestion-info">
                    <img src="./CSS/img/라쿤.jpg" alt="Profile Picture">
                    <div>
                        <div class="name">junhyung_ing</div>
                        <div class="subtext">신준형</div>
                    </div>
                </div>
                <button class="follow-btn">팔로우</button>
            </div>
            <div class="suggestion">
                <div class="suggestion-info">
                    <img src="./CSS/img/라쿤.jpg" alt="Profile Picture">
                    <div>
                        <div class="name">junhyung_ing</div>
                        <div class="subtext">신준형</div>
                    </div>
                </div>
                <button class="follow-btn">팔로우</button>
            </div>
            <div class="suggestion">
                <div class="suggestion-info">
                    <img src="./CSS/img/라쿤.jpg" alt="Profile Picture">
                    <div>
                        <div class="name">junhyung_ing</div>
                        <div class="subtext">신준형</div>
                    </div>
                </div>
                <button class="follow-btn">팔로우</button>
            </div>
        </div>
        <div class="footer">
            <div>
                <a href="#">소개</a>
                <a href="#">도움말</a>
                <a href="#">홍보 센터</a>
                <a href="#">API</a>
                <a href="#">채용 정보</a>
                <a href="#">개인정보처리방침</a>
                <a href="#">약관</a>
                <a href="#">위치</a>
                <a href="#">언어</a>
            </div>
            <div>
                © 2024 ReMERGE FROM KH정보교육원 4조
            </div>
        </div>

		<!-- 첫 번째 모달: 이미지 업로드 -->
		<div class="modal fade" id="modal_create" tabindex="-1" role="dialog"
			aria-labelledby="modal_create_title" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal_create_title">이미지 업로드</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="file">이미지 선택</label> <input type="file" class="form-control-file" id="file" name="upfile">
						</div>
						<div id="thumbnailFeed">
							<img id="thumbnail" class="thumbnail" src="#" alt="Thumbnail">
						</div>
						<button id="confirm_button" class="btn btn-primary">다음</button>	
					</div>
				</div>
			</div>
		</div>

		<!-- 두 번째 모달: 게시물 작성 -->
		<div class="modal fade" id="modal_second" tabindex="-1" role="dialog"
			aria-labelledby="modal_second_title" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal_second_title">게시물 작성</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form  id="uploadForm" action="insert.fe" method="post" enctype="multipart/form-data">
					<input type="hidden" value="${loginUser.userId}" name="feedWriter">	
						<div class="modal-body">
							<div class="thumbnail-container">
								<img id="selectedThumbnail" class="thumbnail" src="#" alt="Selected Thumbnail">
								<input type="hidden" id="hiddenFile" name="upfile">
							</div>
							<div class="form-group">
								<label for="post_text">게시물 내용</label>
								<textarea class="form-control" id="post_text" rows="3"
									name="feedContent" placeholder="게시물 내용을 입력하세요..."></textarea>
							</div>
							<div class="form-group">
								<label for="location">위치</label> <input type="text"
									class="form-control" id="location" name="feedLocation" placeholder="위치를 입력하세요">
							</div>
							<button type="submit" id="submit_post_button"
								class="btn btn-primary">게시</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<script>
		<!-- 게시물 등록 스크립트 -->
		 <!--썸네일 만들기-->
		 $(document).ready(function() {
				feedList();

			    const fileInput = document.getElementById('file');
			    const thumbnail = document.getElementById('thumbnail');
			    const secondThumbnail = document.querySelector('#modal_second #selectedThumbnail'); // 두 번째 모달 썸네일
			    let selectedFile = null;

			    fileInput.addEventListener('change', function() {
			        const file = fileInput.files[0];
			        if (file) {
			            selectedFile = file;
			            $('#thumbnailFeed').css('display', 'block');
			            const objectURL = window.URL.createObjectURL(file);
			            thumbnail.setAttribute('src', objectURL);
			        }
			    });
			    
			    $('#confirm_button').click(function() {
			        $('#modal_create').modal('hide');
			        const objectURL = window.URL.createObjectURL(selectedFile);
			        secondThumbnail.setAttribute('src', objectURL); // 두 번째 모달 썸네일 설정
			        $('#modal_second').modal('show');
			    });
			    
			    $('#uploadForm').submit(function(event) {
			        event.preventDefault();
			        const formData = new FormData();
			        formData.append('upfile', selectedFile);
			        formData.append('feedWriter', $('[name="feedWriter"]').val());
			        formData.append('feedContent', $('#post_text').val());
			        formData.append('feedLocation', $('#location').val());
			        

			        $.ajax({
			            url: 'insert.fe',
			            type: 'POST',
			            data: formData,
			            processData: false,
			            contentType: false,
			            success: function(response) {
			                // 성공 시 로직 추가
			                alert('게시물이 성공적으로 업로드되었습니다.');
			                location.reload();
			            },
			            error: function(jqXHR, textStatus, errorThrown) {
			                // 실패 시 로직 추가
			                alert('게시물 업로드에 실패했습니다.');
			            }
			        });
			    });
			});

			    // 첫 번째 모달 열기
			    $('#create').click(function() {
			        $('#modal_create').modal('show');
			    });

			    // 첫 번째 모달 확인 버튼 클릭 시 두 번째 모달 열기
			    $('#confirm_button').click(function() {
			        $('#modal_create').modal('hide');
			        $('#modal_second').modal('show');
			        console.log($('#file'));
			    });


		 // 두 번째 모달 닫기
		 $('#close_second_modal_button').click(function() {
		   $('#modal_second').modal('hide');
		 });
		
	
		
		<!-- 게시글 리스트 목록 -->
		
		function feedList(){
			  $.ajax({
				  url: 'feedList.fe',
				  type: 'POST',
				  dataType: 'json',
				  success : function(response){
					  console.log(response)
					 var str = "";
				for (var i = 0; i < response.list.length; i++){
					var feed = response.list[i];
					 /*str += '<div class="conA">';*/
	                    str += '    <div class="con">';
	                    str += '        <div class="title">';
	                    str += '            <img src="" alt="" class="img">';
	                    str += '            <p>' +  feed.feedWriter + '</p>'; // 작성자 예시
	                    str += '        </div>';
	                    str += '        <img src="' + feed.changeName + '" alt="" class="con_img">'; // 이미지 예시
	                    str += '        <div class="logos">';
	                    str += '            <div class="logos_left">';
	                    str += '                <img src="./style.css/free-icon-heart-1077035.png" alt="" class="logo_img">';
	                    str += '                <img src="./style.css/free-icon-chat-552850.png" alt="" class="logo_img">';
	                    str += '                <img src="./style.css/free-icon-direct-instagram-6165369.png" alt="" class="logo_img">';
	                    str += '            </div>';
	                    str += '            <div class="logos_right">';
	                    str += '                <img src="images/bookmark.svg" alt="" class="logo_img">';
	                    str += '            </div>';
	                    str += '        </div>';
	                    str += '        <div class="content">';
	                    str += '            <p><b>좋아요 32개</b></p>';
	                    str += '            <p>' + feed.feedContent + '</p>'; // 내용 예시
	                    str += '            <p><a href="www.naver.com"></a>#하잉 #하잉 #하용</p>'; // 해시태그 예시
	                    str += '            <input type="text" name="" id="" value="댓글달기">';
	                    str += '        </div>';
	                    str += '    </div>';
	                    /*str += '</div>';*/
					
				}
					 $(".conA").html(str); // 생성된 게시물 목록을 feed-container에 추가
					
						 
		          },
		          error: function() {
		          	alert('게시물 로딩에 실패했습니다.');
		          }
       		 });
    	}
		</script>
		
		
		
		
		<script>
			function addStory(){
				 const modal = document.getElementById("modal_createStory");
				 modal.style.display = "flex";
			}
		</script>
</body>
</html>