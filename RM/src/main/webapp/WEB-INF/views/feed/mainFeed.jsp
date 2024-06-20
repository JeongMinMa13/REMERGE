<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main 페이지</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
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

        <!--모달-->
		<div class="modal_overlay" id="modal_create">
			<div class="modal_window">
				<div class="modal_title">
					<div class="modal_title_side"></div>
					<div>새 게시물</div>
					<div class="modal_title_side">
						<span id="close_modal" class="material-icons-outlined">close </span>
					</div>
				</div>
				 <div class="modal_image_upload">		 		
				 		<img id="thumbnail" src="#" alt="Thumbnail">
				 		<input type="file" id="file" class="form-control-file border" name="file">
						<span style="text-align: center"> 사진을 여기에 끌어다 놓으세요. </span>
				</div>
				<div>
					<button class="confirm_button">확인</button>
				</div>
			</div>
		</div>
		
		<!-- 사진 후 2번째 모달 -->
		<div class="modal_overlay" id="modal_second">
    <div class="modal_window">
        <div class="modal_title">
            <div class="modal_title_side"></div>
            <div>새 게시물 작성</div>
            <div class="modal_title_side">
                <span id="close_modal_second" class="material-icons-outlined">close</span>
            </div>
        </div>
        <div class="modal_content">
            <!-- 좌측: 이미지 썸네일 영역 -->
            <div class="modal_image_upload">
                <img id="thumbnail" src="#" alt="Thumbnail">
            </div>
            <!-- 우측: 유저 프로필 및 게시물 입력 -->
            <div class="modal_side_content">
                <div class="user_profile">
                    <img src="user_profile.jpg" alt="User Profile">
                    <div class="username">사용자 아이디</div>
                </div>
                <div class="post_content">
                    <textarea id="post_text" placeholder="글을 작성하세요"></textarea>
                </div>
                <div class="location_input">
                    <label for="location">위치:</label>
                    <input type="text" id="location" name="location" placeholder="위치를 입력하세요">
                </div>
                <button id="submit" type="button">게시</button>
            </div>
        </div>
    </div>
</div>
		
	
		<!-- 게시물 등록 스크립트 -->
		<script>
		 const modal = document.getElementById("modal_create");
		 const buttonCreate = document.getElementById("create");
		    buttonCreate.addEventListener("click", e => {
		    	modal.style.top = window.pageYOffset + 'px';
		        modal.style.display = "flex";
		        document.body.style.overflowY = "hidden"; // 스크롤 없애기
		    });
		    
		    const buttonCloseModal = document.getElementById("close_modal");
		    buttonCloseModal.addEventListener("click", e => {
		        modal.style.display = "none";
		        document.body.style.overflowY = "visible";
		    });
		    
		 <!--썸네일 만들기-->
		 const fileInput = document.getElementById('file');
		 const thumbnail = document.getElementById('thumbnail');
		    
		    fileInput.addEventListener('change', function() {
		        const file = fileInput.files[0];
		        if (file) {
		            const reader = new FileReader();
		            reader.onload = function(e) {
		            thumbnail.setAttribute('src', e.target.result);
		            }
		            reader.readAsDataURL(file);
		        }
		    });
		    
		    // 첫 번째 모달 확인 버튼 클릭 이벤트 처리
		   	document.getElementById('confirm_button').addEventListener('click', function() {
		    document.getElementById('modal_create').style.display = 'none'; // 첫 번째 모달 숨기기
		    document.getElementById('modal_second').style.display = 'flex'; // 두 번째 모달 보이기
		    }); 
		    
		    // 두 번째 모달 닫기 버튼 클릭 이벤트 처리
		    document.getElementById('close_modal_second').addEventListener('click', function() {
		    document.getElementById('modal_second').style.display = 'none'; // 두 번째 모달 숨기기
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