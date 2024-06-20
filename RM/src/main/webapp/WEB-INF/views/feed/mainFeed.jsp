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
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<%@include file="../user/loginHeader.jsp" %>
    
    <div class="con_wrap">
        <div class="conA">
            <!-- 하나의 게시물을 만들어줍니다. -->
            <div class="con">
                <div class="title">
                    <img src="./CSS/img/라쿤.jpg" alt="" class="img">
                    <p>junhyung_ing</p>
                </div>
                <img src="./CSS/img/라쿤.jpg" alt="" class="con_img">
                <div class="logos">
                    <div class="logos_left">
                        <img src="./style.css/free-icon-heart-1077035.png" alt="" class="logo_img">
                        <img src="./style.css/free-icon-chat-552850.png" alt="" class="logo_img">
                        <img src="./style.css/free-icon-direct-instagram-6165369.png" alt="" class="logo_img">
                    </div>
                    <div class="logos_right">
                        <img src="images/bookmark.svg" alt="" class="logo_img">
 
                </div>
                </div>
                <div class="content">
                    <p><b>좋아요 32개</b></p>
                    <p><a href="www.naver.com"></a>#하잉 #하잉 #하용</p>
                    <input type="text" name="" id="" value="댓글달기">
                </div>
            </div>
        </div>
  
        

    <div class="body">
        <!--스토리 목록-->
            <div class="storys">
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
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="file">이미지 선택</label> <input type="file"
								class="form-control-file" id="file">
						</div>
						<div class="thumbnail-container">
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
					<div class="modal-body">
						<div class="thumbnail-container">
							<img id="selectedThumbnail" class="thumbnail" src="#"
								alt="Selected Thumbnail">
						</div>
						<div class="form-group">
							<label for="post_text">게시물 내용</label>
							<textarea class="form-control" id="post_text" rows="3"
								placeholder="게시물 내용을 입력하세요..."></textarea>
						</div>
						<div class="form-group">
							<label for="location">위치</label> <input type="text"
								class="form-control" id="location" placeholder="위치를 입력하세요">
						</div>
						<button id="submit_post_button" class="btn btn-primary">게시</button>
					</div>
				</div>
			</div>
		</div>


		<!-- 게시물 등록 스크립트 -->
		<script>
		 <!--썸네일 만들기-->
		 const fileInput = document.getElementById('file');
		 const thumbnail = document.getElementById('thumbnail');
		 const secondThumbnail = document.querySelector('#modal_second #selectedThumbnail'); // 두 번째 모달 썸네일
		    
		 fileInput.addEventListener('change', function() {
		     const file = fileInput.files[0];
		     if (file) {
		         const reader = new FileReader();
		         reader.onload = function(e) {
		             thumbnail.setAttribute('src', e.target.result);
		             secondThumbnail.setAttribute('src', e.target.result); // 두 번째 모달 썸네일 설정
		         }
		         reader.readAsDataURL(file);
		     }
		 });
		 
		
		    
		// 첫 번째 모달 열기
		 $('#create').click(function() {
		   $('#modal_create').modal('show');
		 });

		 // 첫 번째 모달 확인 버튼 클릭 시 두 번째 모달 열기
		 $('#confirm_button').click(function() {
		   $('#modal_create').modal('hide');
		   $('#modal_second').modal('show');
		 });

		 // 두 번째 모달 닫기
		 $('#close_second_modal_button').click(function() {
		   $('#modal_second').modal('hide');
		 });
		 
		 document.getElementById('imageUpload').addEventListener('change', function(event) {
			    var file = event.target.files[0]; // 선택된 파일
			    var reader = new FileReader(); // 파일 리더 객체 생성

			    // 파일 리더 로드 완료 후
			    reader.onload = function(e) {
			        document.getElementById('thumbnail').setAttribute('src', e.target.result); // 썸네일 이미지 소스 설정
			    };

			    // 파일 리더로 파일 읽기
			    reader.readAsDataURL(file);
			});
		 
		</script>
		
		            
    <script src="scripts.js">
        document.querySelectorAll('.menu-item').forEach(item => {
        item.addEventListener('click', () => {
        console.log(`${item.id} 메뉴 클릭됨`);
        // 페이지 이동 처리 
    });
});
    </script>
</body>
</html>