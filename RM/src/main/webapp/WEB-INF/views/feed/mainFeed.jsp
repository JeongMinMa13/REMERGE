<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main 페이지</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
  <jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 스와이퍼 css,cdn -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<style>
        .shopIcon {
            width: 100px;
            height: 120px;
            overflow: hidden;
            text-align: center;
            border: 1px solid #ccc;
            margin: 10px;
            cursor: pointer;
            position: relative;
            user-select: none;
        }
        .shopIcon img {
            width: 100%;
            height: auto;
        }
        .shopIcon p {
            margin: 0;
            font-size: 14px;
        }
        .shopIcon:hover {
            opacity: 0.5;
        }
        .shopIcon-soldout {
            width: 100px;
            height: 120px;
            overflow: hidden;
            text-align: center;
            border: 1px solid #ccc;
            margin: 10px;
            cursor: pointer;
            position: relative;
        }
        .shopIcon-soldout img {
            width: 100%;
            height: auto;
        }
        .shopIcon-soldout p {
            margin: 0;
            font-size: 14px;
        }
        .shopIcon-soldout:hover {
            opacity: 0.5;
        }
        .shopIcon-soldout:hover::after {
            content: 'SOLD OUT';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 16px;
            color: red; /* 원하는 색상으로 변경 가능 */
            background: rgba(255, 255, 255, 0.8); /* 배경 색상 및 투명도 조절 가능 */
            padding: 5px;
            border-radius: 5px;
        }
        .shopIcon.checked::after {
            content: '✔';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 24px;
            color: green; /* 체크 표시 색상 */
            background: rgba(255, 255, 255, 0.8); /* 배경 색상 및 투명도 조절 가능 */
            padding: 5px;
            border-radius: 50%; /* 원형 배경 */
        }
</style>
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
		<!-- <div class="swiper"> -->
            <div class="storys">
            	<div class="story" onclick="addStory();">
		      		<img class="story_img" src="resources/plusicon.jpeg">
		      		<span>스토리 추가하기</span>
		      	</div>
                <!-- <div class="swiper-button-prev"></div>
  				<div class="swiper-button-next"></div> -->
            </div>
        </div>
       <!--  </div> -->
        <div class="container">
            <div class="profile-header">
                <img src="" alt="Your Profile Picture">
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
                    <img src="" alt="Profile Picture">
                    <div>
                        <div class="name">junhyung_ing</div>
                        <div class="subtext">신준형</div>
                    </div>
                </div>
                <button class="follow-btn">팔로우</button>
            </div>
            <div class="suggestion">
                <div class="suggestion-info">
                    <img src="" alt="Profile Picture">
                    <div>
                        <div class="name">junhyung_ing</div>
                        <div class="subtext">신준형</div>
                    </div>
                </div>
                <button class="follow-btn">팔로우</button>
            </div>
            <div class="suggestion">
                <div class="suggestion-info">
                    <img src="" alt="Profile Picture">
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
		            <form id="uploadForm" action="insert.fe" method="post" enctype="multipart/form-data">
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
		                    <details>
    	    					<summary style="font-size:1.5em;font-weight:bold;">상 품 추 가</summary>
    	    					<div id="shopList-area">
						            <input class="single-listCheckbox" style="font-size:1.5em;font-weight:bold;"  type="radio"
						            id="brandList" name="brandList" value="상의">
									<label for="brandList">상 의</label>
						            <input class="single-listCheckbox" style="font-size:1.5em;font-weight:bold;" type="radio"
						            id="brandList" name="brandList" value="하의">
						            <label for="brandList">하 의</label>
						            <input class="single-listCheckbox" style="font-size:1.5em;font-weight:bold;" type="radio"
						            id="brandList" name="brandList" value="신발">
							    	<label for="brandList">신 발</label> <br>
						    		<input class="single-checkbox" style="font-size:1.5em;font-weight:bold;"  type="radio"
						    		id="brandNameList" name="brandNameList" value="나이키">
									<label for="brandNameList">나이키</label>
						            <input class="single-checkbox" style="font-size:1.5em;font-weight:bold;" type="radio"
						            id="brandNameList" name="brandNameList" value="뉴발란스">
						            <label for="brandNameList">뉴발란스</label>
						            <input class="single-checkbox" style="font-size:1.5em;font-weight:bold;" type="radio"
						            id="brandNameList" name="brandNameList" value="아디다스">
							    	<label for="brandNameList">아디다스</label>
							    </div>
							    <div class="shopSelectList"></div>
						    </details>   <br>
		                    <div class="hashTag">
		                        <label for="tag">태그</label>
		                        <input type="text" class="tag-control" id="tags" name="tags" placeholder="태그를 입력해주세요">
		                        <div id="tagSuggestions" class="list-group"></div> <!-- 태그 제안 리스트 -->
		                    </div>
		                    <div class="form-group">
		                        <label for="location">위치</label> <input type="text"
		                            class="form-control" id="location" name="feedLocation" placeholder="위치를 입력하세요">
		                    </div>
		                    <button type="submit" id="submit_post_button" class="btn btn-primary">게시</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		
		<!-- 게시물 디테일 모달 -->
		<div class="modal fade" id="modal_detail_feed" tabindex="-1" role="dialog" aria-labelledby="modal_detail_feed" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="modal_detail_feed_title">게시물</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
		                    <span aria-hidden="true">&times;</span>                        
		                </button>
		            </div>
		            <div class="modal-body">
		                <img src="" id="feed_detail_img"> <!-- 게시글 디테일 이미지 -->
		                <div id="feed_userId"></div>
		                <div id="feed_location"></div>
		                <div id="feed_detail_content"></div>
		                <div id="feed_detail_replyList"></div> <!-- 댓글 리스트 영역 -->
		                <div id="like_reply">
		                    <div class="mb-3">
		                        <button id="like_button">
		                            <i class="fas fa-heart mr-1"></i>
		                        </button>
		                    </div>
		                    <!-- 댓글 작성 폼 -->
		                    <div class="form-group">
		                        <input type="text" name="content" id="content${feedNo}" placeholder="댓글을 입력해주세요..">
		                        <label>
		                            <button onclick="insertModal(this, ${feedNo})">등록</button>
		                        </label>    
		                    </div>
		                </div>
		            </div>
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
					<div class="modal-body" id="storyModalBody">
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
						<img src="" id="story_view_img"><!-- 스토리 사진 영역 -->
						<div id="story_view_content"></div> <!-- 스토리 내용 영역 -->
						<button id="nextStory">next</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 상품추가 구문 1개만 체크될수있도록 -->
		<script>
            $('input.single-checkbox').on('change', function() {
                $('input.single-checkbox').not(this).prop('checked', false);
            });
            $('input.single-listCheckbox').on('change', function() {
                $('input.single-listCheckbox').not(this).prop('checked', false);
            });
	        
			
	        <!-- 체크된 상품 List불러오기 -->
	        $("#shopList-area").click(function() {
				var brandList = $("#brandList:checked").val();
				var brandNameList = $("#brandNameList:checked").val();
				console.log(brandList);
				console.log(brandNameList);

				$.ajax({
					url : "shopList.sh",
					data : {
						brandList : brandList,
						brandNameList : brandNameList
					},
					error : function() {
						console.log("처리 실패");
					},
					success : function(result) {
						console.log(result);
						   $(".shopSelectList").empty();
						for (var i = 0; i < result.length; i++){
							var str = "";
							var sList = result[i];
						/* div안에 사진, 가격, 썸네일 넣고 클릭하면 체크되고 체크된 sList.shopNo feedInsert구문으로 가져가야함 구현 */
							if(sList.inven>0){ //재고가 있다면
							var sListNo = sList.shopNo;
							str += '    <div class="shopIcon" onclick="shopIconSelect('+sListNo+');" id="' + sList.shopNo + '">';
							str += '         <p>No.' + sList.shopNo + '</p>'; // 상품번호 
							str += '        <img src="' + sList.filePath + '" alt="상품사진">'; // 이미지
							str += '         <br>  <p>' + sList.modelName + '</p>'; // 모델명 
							str += '    </div>';
							shopIconSelect(sListNo);
							} else{ //재고가 없다면
								str += '    <div class="shopIcon-soldout" onclick="shopNoDetail();" id="' + sList.shopNo + '">';
								str += '         <p>No.' + sList.shopNo + '</p>'; // 상품번호 
								str += '        <img src="' + sList.filePath + '" alt="상품사진">'; // 이미지
								str += '         <br>  <p>' + sList.modelName + '</p>'; // 모델명 
								str += '    </div>';	
							}
							$(".shopSelectList").append(str);//작성된 html 넣어주기
							
						}
					}
				});
			});

	        
	       
	        function shopIconSelect(sListNo) {
	        	console.log(sListNo);
	        	$.ajax({
	        		url : "shopInsertFeed.sh",
	        		data :{
	        			sListNo : sListNo
	        		},
	        		error  : function ()  {
	        			console.log("오류 발생");
	        		},
	        		succese : function (result)  {
	        			if(result>0){ //상태값변경 성공
	        					console.log("상태값변경");
	        			}
	        			console.log("상태값변경실패");
	        		}
	        		
	        	});	
	        	
	        	
	         }
	        
			
	        function shopNoDetail() {
				alert("재고가 없습니다. 해당 상품 재입고 후 선택이 가능합니다.")
			}
	        
	        
	        
	        
		</script>
		
		<script>
		
		<!-- 태그 -->
		$(document).ready(function() {
		    $('#uploadForm').submit(function(event) {
		        var tags = $('#tag').val();
		        if (tags) {
		            tags = tags.split(' ').join(','); // 공백으로 구분된 태그를 쉼표로 구분
		            $('#tag').val(tags);
		        }
		    });
		});
		
		<!-- 게시물 등록 스크립트 -->
		<!--썸네일 만들기-->
		 $(document).ready(function() {
			feedList();
			loadAllLikes();
			
			$(window).scroll(function() {
	            if ($(window).scrollTop() == $(document).height() - $(window).height()) {
	                // 현재 페이지 수를 가져와서 다음 페이지를 로드합니다.
	                const currentPage = Math.ceil($('.con').length / 6) + 1; // 예시: 현재 보여지는 게시물 갯수로 대체
	                feedList(currentPage);
	            }
	        });
			 
	
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
			        formData.append('tags',$('#tags').val());
			        
				<!-- 게시글 등록 ajax -->
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
		 
		 	function loadAllLikes() {
			    $('.con').each(function() {
			        var feedNo = $(this).data('feed-no');
			        var userId = '${loginUser.userId}';
			        loadLikeStatus(feedNo, userId);
			    });
			}

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
		 
		 //게시물 모달 열기
		
		 
		 //게시물 모달 닫기
		 $('#close_createDetail_button').click(function() {
		   $('#createDetail').modal('hide');
		 });
		
		</script>
		
	<!-- 스토리 조회해오기 --> 
	<script>
		// 전역 변수 선언
	    var currentStoryIndex = 0;
	    var storiesData = [];
	    var history = []; //스토리 시청 기록을 사용하기 위한 전역 변수

		$(function(){
			$.ajax({
				url:"selectHistory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}"
				},
				success:function(history){
					history=history;
					console.log(history);
				},
				error:function(){
					console.log("통신 실패");
				}
			});
			
			$.ajax({
				url:"selectStory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}"
				},
				success:function(data){
					// 스토리 데이터를 전역 변수에 저장
	                storiesData = data;
					//console.log(data); 데이터 확인
					//스토리 기능은 한명이 작성한 글은 하나의 글로 확인 가능하고
					//상세페이지를 조회한다면 다른 글도 조회할수 있기 때문에 view페이지에서 한 유저의 스토리들은 하나로만 보여야 함
					//그에 따라 처리된 아이디를 저장하고 저장된 아이디와 비교하며 html 생성
					var seenStory = false;
					var html = "";
					const processedUserIds = new Set();// 생성된 스토리 html 아이디를 저장할 집합
					for(var i=0;i<data.length;i++){
						if(!processedUserIds.has(data[i].userId)){//저장된 집합에 이름이 있는지 확인
							
							html +="<div class='story' onclick='storyView("+i+");'>";
							html +="<input type='hidden' class='storyNoCheck' value='"+data[i].storyNo+"'>";
							html +="<img class='story_img' src='"+data[i].changeName+"'>";
							html +="<span>"+data[i].userId+"</span>";
							html +="</div>";
							processedUserIds.add(data[i].userId);//처리된 아이디 집합에 넣기
						}
					}
					$(".storys").append(html);//작성된 html 넣어주기
				},
				error:function(){
					console.log("통신 실패");
				}
			});
		});	
		

		<!-- 게시글 detail 불러오기 -->
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

		function storyView(index){ 
			currentStoryIndex = index; // 현재 스토리 인덱스 업데이트
	        var data = storiesData[index]; 
			$('#modal_view_story_title').html(data.userId);
			$('#story_view_img').attr('src',data.changeName);
			$('#story_view_content').html(data.storyContent);
			$('#modal_view_story').modal('show');//스토리 div 누르면 view 보여주기
			
			$.ajax({//시청 기록 넣기
				url:"insertHistory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					storyNo:data.storyNo
				},
				success:function(result){
					//console.log(result);//시청 기록 추가 확인
				},
				error:function(){
					console.log("통신 실패");
				}
				
			});
			
		}
		
		// 다음 스토리를 보여주는 함수
	    function showNextStory(){
	        if(currentStoryIndex < storiesData.length - 1){ //조회해왔던 data 길이 -1 과 비교후 작을때만 
	            storyView(currentStoryIndex + 1);
	        } else {
	            alert("마지막 스토리입니다.");
	        }
	    }

	    // nextStory 버튼 클릭 이벤트
	    $('#nextStory').click(function(){
	        showNextStory();
	    });
	    

		</script>
		
		<script>
		<!-- 게시글 리스트 목록 -->
		function feedList(currentPage){
			  $.ajax({
				  url: 'feedList.fe',
				  type: 'POST',
				  dataType: 'json',
				  data:{currentPage:currentPage},
				  success : function(response){
					 var str = "";
				for (var i = 0; i < response.list.length; i++){
					var feed = response.list[i];
					 /*str += '<div class="conA">';*/
						str += '    <div class="con" data-feed-no="' + feed.feedNo + '">';
						str += '        <div class="title">';
						str += '            <img src="" alt="" class="img">';
						str += '        </div>';
						str += '        <img src="' + feed.changeName + '" alt="" class="con_img">'; // 이미지 예시
						str += '        <div class="logos">';            <p>' + feed.feedWriter + '</p>'; // 작성자 예시
						str += '
						str += '            <div class="logos_left">';
						str += '            <button id="likeButton' + feed.feedNo + '" class="like-button" data-feed-no="' + feed.feedNo + '" data-user-id="' + '${loginUser.userId}' + '" onclick="toggleLike(' + feed.feedNo + ', \'' + '${loginUser.userId}' + '\')">';
						str += '                <i class="heart-icon far fa-heart" style="font-size: 30px; color: #ff5a5f;"></i>';
						str += '            </button>';
						str += '                <img src="resources/chat.png" class="logo_img" onclick="detailView('+feed.feedNo+')" >';
						str += '                <img src="resources/direct.png" alt="" class="logo_img">';
						str += '            </div>';
						str += '            <div class="logos_right">';
						str += '                <img src="" alt="" class="logo_img">';
						str += '            </div>';
						str += '        </div>';
						str += '        <div class="content">';
						str += '               <p><b>좋아요 <span class="like-count" data-feed-no="'+feed.feedNo+'">'+feed.likeCount+'</span>개</b></p>';
						str += '            <p>' + feed.feedContent + '</p>';
						str += '            <div id="replyList'+feed.feedNo+'"></div>'; // 댓글 리스트를 표시할 부분
										  // 태그 추가 부분
						                if (feed.tags && feed.tags.length > 0) {
						                    str += '            <p>';
						                    for (var j = 0; j < feed.tags.length; j++) {
						                        str += '<a href="selectTag.fe?tagContent=' + encodeURIComponent(feed.tags[j]) + '">#' + feed.tags[j] + '</a> ';
						                    }
						                    str += '            </p>';
						                }
						str += '            <input type="text" name="reContent" id="reContent'+feed.feedNo+'" placeholder="댓글을 입력해주세요..">';
						str += '            <label><button onclick="insertReply('+feed.feedNo+')">등록</button></label>';
						str += '        </div>';
						str += '    </div>';
	                    /*str += '</div>';*/
	                    
	                    replyList(feed.feedNo);
				}
					 $(".conA").append(str); //게시물 밑으로 추가
					 if (currentPage >= response.pi.maxPage) {
		                    $(window).unbind('scroll'); // 스크롤 이벤트 해제
		                }
					 loadAllLikes();
		          },
		          error: function() {
		          	alert('게시물 로딩에 실패했습니다.');
		          }
       		 });
    	};
		</script>
		
		<!-- 댓글 리스트 -->
		<script>
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
			
			<!-- 댓글 입력 -->
			
				
			function insertReply(feedNo){
				var reContent =$("#reContent" + feedNo).val();
				
				console.log(reContent);
				console.log("${loginUser.userId}");
				$.ajax({	
					url : "insertReply.fe",
					type : "post",
					data : {
						feedNo : feedNo,
						userId : "${loginUser.userId}",
						reContent: reContent
					},
					success : function(result){
						if(result>0){
							replyList(feedNo); //추가된 댓글 정보까지 다시 조회
							$("#reContent"+feedNo).val("");
							
							alert("댓글등록");
						}else{
							alert("댓글작성실패");
						}
					},
					error : function(){
						console.log("안 뜸");
					}
				});
			};
// 			$(document).on("click","#modal_detail_feed label>button",function(){
				
// 				console.log($(this).parent().siblings().first().attr("id"));
// 			});
			
			
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
		
		<!-- 좋아요 상태 확인 -->
		<script>
		function loadLikeStatus(feedNo, userId) {
		    $.ajax({
		        url: "likeStatus.fe",
		        type: "get",
		        data: {
		            feedNo: feedNo,
		            userId: userId
		        },
		        success: function(response) {
		            var likeButton = $("#likeButton" + feedNo);
		            var heartIcon = likeButton.find(".heart-icon");
		            var likeCountElement = $(".like-count[data-feed-no='" + feedNo + "']");

		            if (response.status === "liked") {
		                likeButton.addClass("liked");
		                heartIcon.removeClass("far fa-heart");
		                heartIcon.addClass("fas fa-heart");
		            } else {
		                likeButton.removeClass("liked");
		                heartIcon.removeClass("fas fa-heart");
		                heartIcon.addClass("far fa-heart");
		            }

		            likeCountElement.text(response.likeCount);
		        },
		        error: function() {
		            alert("게시물 정보를 가져오는데 실패했습니다.");
		        }
		    });
		}

	            function toggleLike(feedNo, userId) {
	                $.ajax({
	                    url: "feedLike.fe",
	                    type: "post",
	                    data: {
	                        feedNo: feedNo,
	                        userId: userId
	                    },
	                    success: function(response) {
	                        var likeButton = $("#likeButton" + feedNo);
	                        var heartIcon = likeButton.find(".heart-icon");

	                        if (response.status === "liked") {
	                            likeButton.addClass("liked");
	                            heartIcon.removeClass("far fa-heart");
	                            heartIcon.addClass("fas fa-heart");
	                        } else {
	                            likeButton.removeClass("liked");
	                            heartIcon.removeClass("fas fa-heart");
	                            heartIcon.addClass("far fa-heart");
	                        }

	                        $(".like-count[data-feed-no='" + feedNo + "']").text(response.likeCount);
	                    },
	                    error: function() {
	                        alert("좋아요 실패");
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
		         storyFileReader.readAsDataURL(file);
		     }
		 });

		</script>
</body>
</html>