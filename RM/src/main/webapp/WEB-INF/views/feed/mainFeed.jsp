<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main 페이지</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<%@include file="../user/loginHeader.jsp" %>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <div class="con_wrap">
    	<div class="conA">
    	</div>
      </div>
    <div class="body">
        <!--스토리 목록-->
            <div class="storys">
            	<div class="story" onclick="addStory();">
		      		<img class="story_img" src="resources/plusicon.jpeg">
		      		<span>스토리 추가하기</span>
		      	</div>
                <div class="story" id="newStory"></div>
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
		
		<!-- 스토리 추가 모달 -->
		<div class="modal fade" id="modal_create_story" tabindex="-1" role="dialog" aria-labelledby="modal_create_story" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal_create_story_title">스토리 만들기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="insertStory.fe" method="post" enctype="multipart/form-data">
							<div class="form-group">
								<input type="hidden" name="userId" value="${loginUser.userId }">
								<label for="storyFile">이미지 선택</label> 
								<input type="file" class="form-control-file" id="storyFile" name="storyFile">
							</div>
							<div id="thumbnailContainer">
								<img id="storyThumbnail" class="thumbnail" alt="Thumbnail">
							</div>
								<br>
								<label for="storyContent">한줄 내용 : </label>
								<input type="text" name="storyContent" style="width:300px;">
								<button type="submit" class="btn btn-primary">등록</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 스토리 뷰 모달 -->
		<div class="modal fade" id="modal_view_story" tabindex="-1" role="dialog" aria-labelledby="modal_view_story_title" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal_view_story_title">스토리</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="story_userId"></div>
						<img src="" id="story_view_img"><!-- 스토리 사진 영역 -->
						<div id="story_view_content"></div> <!-- 스토리 내용 영역 -->
					</div>
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
		
		</script>
		
	<script>
		<!-- 스토리 조회해오기 --> 
		$(function(){
			$.ajax({
				url:"selectStory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}"
				},
				success:function(data){
					//console.log(data); 데이터 확인
					var html = "";
					for(var i=0;i<data.length;i++){
						html +="<div class='story' onclick='storyView("+JSON.stringify(data[i])+");'>";
						html +="<img class='story_img' src='"+data[i].changeName+"'>";
						html +="<span>"+data[i].userId+"</span>";
						html +="</div>";
					}
					$("#newStory").html(html);
				},
				error:function(){
					console.log("통신 실패");
				}
		
			});
		});
		</script>
		<script>	
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
		<!-- 스토리 추가 스크립트 -->
		function addStory(){
			
			 $('#modal_create_story').modal('show');//모달 켜기
		}		
		
			var storyFile = document.getElementById('storyFile');//파일 인풋 요소 잡기
			var storyThumbnail = document.getElementById('storyThumbnail'); //미리보기요소 잡아주기
	
			//스토리 이미지 파일 선택시 미리보기
			storyFile.addEventListener('change', function(event) {//인풋요소에 파일이 들어오면
			     var file = event.target.files[0];//인풋요소 처음들어온 파일 잡고
			     if (file) {//들어온 파일이 있다면
			    	 document.getElementById('thumbnailContainer').style.display='block';//미리보기 감싸는 div숨겨놓고 사진 입력되면 보여주기
			         var storyFileReader = new FileReader();//파일 정보 읽어줄 객체 FileReader() 준비
			         storyFileReader.onload = function(e) {
			             storyThumbnail.setAttribute('src', e.target.result);//파일 읽어 src속성에 넣어주기
			         }
			         reader.readAsDataURL(file);
			     }
			 });
			
		}
		function storyView(data){
			$('#modal_view_story').modal('show');//스토리 div 누르면 view 보여주기
			$('#story_userId').val(data.userId);
		}
		const storyFile = document.getElementById('storyFile');//파일 인풋 요소 잡기
		const storyThumbnail = document.getElementById('storyThumbnail'); //미리보기요소 잡아주기
	
		storyFile.addEventListener('change', function(event) {//인풋요소에 파일이 들어오면
		     var file = storyFile.files[0];//인풋요소 처음들어온 파일 잡고
		     if (file) {//들어온 파일이 있다면
		    	 document.getElementById('thumbnailContainer').style.display='block';
		         var reader = new FileReader();//파일 정보 읽어줄 객체 FileReader() 준비
		         reader.onload = function(e) {
		             storyThumbnail.setAttribute('src', e.target.result);//파일 읽어 src속성에 넣어주기
		         }
		         reader.readAsDataURL(file);
		     }
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