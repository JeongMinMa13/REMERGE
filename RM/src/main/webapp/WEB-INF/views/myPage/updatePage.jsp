<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <meta charset="UTF-8">
    <title>프로필 편집</title>
    <style>
        .btn-left {
            float: right;
            margin-right: 10px;
        }

        .upfilebtn:hover {
            background-color: #c7c7c7;
            border-color: #f5e4f3;
        }
        
        .profileImg{
        
          
            padding: 20px;
             display: inline-block;
        }
        .deletebtn:hover{
         background-color: #c7c7c7;
            border-color: #f5e4f3;
        }
        
      
    </style>
</head>
<body>

<%@include file="/WEB-INF/views/user/loginHeader.jsp" %>
<div class="outer">
    <div class="content">
        <br><br>
        <div class="innerOuter" align="center">
            <br>
            <h3>프로필 편집</h3>
            <!-- 프로필 사진 업로드 -->
               <div class="profileImg">
                  <form action="updateProfile.us" method="post" enctype="multipart/form-data">
                   <input type="hidden" value="${loginUser.userId}" name="userId">
                   <b> ${loginUser.userId} </b> <br><br>
                    <!-- 프로필에 표시되는 이미지 -->
                    
	                 <c:choose> 
	                  	<c:when test="${loginUser.profileChangeName ne null }">  
						 	 <img id="profile-preview" src="${loginUser.profileChangeName}" width="100" height="100" style="border-radius:70%"> &nbsp;
						 </c:when>
						 <c:otherwise>
							 <img id="profile-preview" src="resources/unknown.jpg" width="100" height="100" > &nbsp;
						 </c:otherwise>
	                </c:choose>
                    <br><br>
                    <label for="upfile" class="upfilebtn" >사진 업로드</label>
                    <input type="file"   id="upfile" name="upfile" class="form-control-file border" style="display: none;"><br>
                    <label for="delete" class="deletebtn"style="color: red;" >사진 삭제</label>
                    <input type="submit" id="delete" class="form-control-file border" name="delete" style="display: none;">
                    <br>
                    <button type="submit">완료</button>
                   </form>
                </div> 
					
            <form id="update-form" action="update.us" method="post"
                enctype="multipart/form-data">
                 <input type="hidden" value="${loginUser.userId}" name="userId">
                <div>
                    <h4>소개</h4>
                    <textarea maxlength="150" id="userMemo" name="userMemo" class="form-control" style="resize: none; width: 50%;" cols="40" rows="2"
                        placeholder="150자까지 입력하세요.">${loginUser.userMemo}</textarea>
                        <span id="textLengthCheck">(0/150자)</span>
	                </div>
                <br><br>
                <div>
                    <h4>이메일 변경하기</h4>
                    <input type="email" id="email" name="email" class="form-control" value="${loginUser.email}" style="width: 50%;">
                </div>
                <br><br>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">완료</button>
                    <button type="reset" class="btn btn-danger">취소</button>
                </div>
                <br><br>
                <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#updatePwdForm">비밀번호 변경</button>
                <br><br>
            </form>
        </div>
    </div>

    <div>
        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteForm">회원탈퇴</button>
    </div>

    <!-- 비밀번호 변경 Modal -->
    <div class="modal" id="updatePwdForm">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">비밀번호 변경</h4>
                  
                </div>
                <div class="modal-body" align="center">
                    <form action="${pageContext.request.contextPath}/updatePwd.us" method="post">
                        <input type="hidden" name="userId" value="${loginUser.userId}">
                        <table>
                            <tr>
                                <td>현재 비밀번호</td>
                                <td><input type="password" name="userPwd" required></td>
                            </tr>
                            <tr>
                                <td>변경할 비밀번호</td>
                                <td><input type="password" name="updatePwd" required></td>
                            </tr>
                            <tr>
                                <td>변경할 비밀번호 확인</td>
                                <td><input type="password" id="chkPwd" required></td>
                            </tr>
                        </table>
                        <br>
                        <button type="submit" class="btn btn-secondary" onclick="return checkPwd();">비밀번호 변경</button>
                    </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script>
        function checkPwd() {
            var updatePwd = $("input[name=updatePwd]").val();
            var checkPwd = $("#chkPwd").val();
            var currentPwd =$("#userPwd").val();
            
            if(currentPwd!=currentPwd){
            	alert("현재 비밀번호가 일치하지 않습니다");
             if (updatePwd != checkPwd) {
                alert("변경할 비밀번호와 확인이 일치하지 않습니다.");
                return false;
            } else {
                return true;
            }
            }
        }
        $("#userMemo").keyup(function(e){
        	var content = $(this).val();
        	$("#textLengthCheck").text("(" + content.length + " / 최대 150자)");
        	
        })
    </script>
    
    <!-- 회원탈퇴 클릭시 사용될 모달영역 -->
	<div class="modal fade" id="deleteForm">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원탈퇴</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- 회원탈퇴 요청 처리할 form태그 -->
				<form action="delete.us" method="post">
					<!-- Modal body -->
					<div class="modal-body">
						<div align="center">
							탈퇴 후 복구가 불가능 합니다. <br>
							정말로 탈퇴하시겠습니까? <br>
						</div>
						
						<label for="userPwd">PASSWORD :</label>
						<input type="password" class="form-control mb-2 mr-sm-2" 
								placeholder="ENTER PASSWORD" id="userPwd" name="userPwd" required>
								
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">회원탈퇴</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
	$(function(){
	    $("#upfile").change(function() {
	        loadImg(this);
	    });

	    function loadImg(inputFile) {
	        if (inputFile.files && inputFile.files.length > 0) {
	            var reader = new FileReader();

	            reader.onload = function(e) {
	                // 읽어온 이미지의 URL을 미리보기 영역의 src에 설정
	                $('#profile-preview').attr('src', e.target.result);
	            };
	            reader.readAsDataURL(inputFile.files[0]);
	        }
	    }
	});
	
				
	</script>
</body>
</html>
