<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>로그인 화면</title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<jsp:include page="/WEB-INF/css/mainLoginCSS.jsp"></jsp:include>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Bootstrap JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Alertify.js CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css">

<!-- Alertify.js JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
<!-- google 리캡쳐 API -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<body>
	<br>
	<br>
	



	<table align="center">
		<tr>
			<td><img src="resources/Remergelogo.png"></td>
		</tr>
	</table>
	<h2 align="center">로그인</h2>
	
	 <form action="login.us" method="post" id="auto_form">
		<div align="center">
			<input type="text" id="userId" name="userId" placeholder="아이디"><br><br>
			<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호"><br><br>
			<div style="display:none" id="recaptcha-area" class="g-recaptcha"
			data-callback="recaptchaCallback"
			 data-sitekey="6LcfpgEqAAAAAER00cficVYpBUjK-P75pBJt3D56"></div><br><br>
			<button type="submit" id="loginBtn1" onclick="loginBtn1();"  name="loginBtn1">로그인</button>
		<br> <br>
		</div>
	</form>
<!-- 	<table align="center">
		<tr>
			<td><img alt="" src="https://sneakerbardetroit.com/wp-content/uploads/2024/07/YESEYESEE-New-Balance-610-ML610TYA.jpg"></td>
		</tr>
	</table> -->
	
			<br> <br>


			<h2 align="center">다른 계정으로 로그인!!!!!!!</h2>
			<br>

			<div class="social-login-buttons" align="center">
				<img class="naver-login-img" alt="네이버로그인"	style="width: 80px; height: 80px;"	
				src="<c:url value="resources/btnG_naver.png"/>"	onclick="location.href='<c:url value="/naver/login"/>';" role="button">
				 &nbsp;&nbsp; &nbsp;&nbsp; 
				<img class="google-login-img" alt="구글로그인"	style="width: 80px; height: 80px;"
				src="<c:url value="resources/btnG_google.png"/>" onclick="location.href='<c:url value="/google/login"/>';"  role="button">
			</div>
			<br>
	<img src="https://kream-phinf.pstatic.net/MjAyNDA2MjhfMjAx/MDAxNzE5NTUxMDY3Mzc3.uXj8I6krEJA20pBw2ZcLURf1SwTWZcux9dXN46qcZgIg.z3ZN2p-_N3EfJq5JsDjkWVtUulpS9AvML6-g9tpRXyIg.PNG/a_89aa88c47d7b45618834357739ac5431.png?type=l_webp"> 
	<br>
	<br>
	<br>
	<div class="find-area" align="center">
		<a href="forFindUser.us">아이디 및 비밀 번호 찾기</a>  &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; | &nbsp;&nbsp; &nbsp;&nbsp;
		<a href="insertEnrollForm.us">회원 가입!</a>
		<br><br><br><br><br><br>
	</div>
	


	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}" );
		</script>
		<c:remove var="alertMsg" />
	</c:if>



	<!-- 구글 리캡쳐 API 호출구문 -->
	
	<script>
	var loginCount = Number("${loginCount}");
	console.log(loginCount);
	if (loginCount >= 3) {
		$("#recaptcha-area").show();
	}

	$("#auto_form").submit(function(event) {
		if (loginCount >= 3) {
			event.preventDefault();  
			// 폼 제출 막기
			var recaptchaResponse = $(".g-recaptcha-response").val();
			if (!recaptchaResponse) {
				alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
				return;
			}
            	console.log(recaptchaResponse);
    			$.ajax({
    				url : "VerifyRecaptcha.us",
    				type : "post",
    				data : {
    					recaptcha : recaptchaResponse
    				},
    				success : function(res) {
    					console.log(res);
    						switch (res) {
    						case 0:
    							alert("자동 가입 및 매크로 방지 봇 통과");
    							$("#auto_form").off("submit").submit();  
    							// 폼 제출 재개
    							break;
    						case 1:
    							alert("자동 가입 및 매크로 방지 봇을 확인 한뒤 진행 해 주세요.");
    							break;
    						default:
    							alert("자동 가입 및 매크로 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : "+Number(data)+"]");
    							break;
    						}
    				},
    				error: function () {
    					console.log("에러 발생")	
    				}
    			});
            
		}
		});
   
   	function recaptchaCallback(response) {
       if (response.length !== 0) {
       	// 사용자가 체크박스를 체크했을 때
           $("#loginBtn1").show();
           alert("reCAPTCHA checked.");
    	}
	};
	$(function() {
		console.log
		("				__ __  ____   ______ ___     __  ___                  / //_/ / __ \ / ____//   |   /  |/  /                 / ,<   / /_/ // __/  / /| |  / /|_/ /                 / /| | / _, _// /___ / ___ | / /  / /                 /_/ |_|/_/ |_|/_____//_/  |_|/_/  /_/                                                                           Unlock Your Potential With KREAM                        https://recruit.kreamcorp.com/                                                                     ")
		                                                                   
 /*    __ __  ____   ______ ___     __  ___
   / //_/ / __ \ / ____//   |   /  |/  /
  / ,<   / /_/ // __/  / /| |  / /|_/ /
 / /| | / _, _// /___ / ___ | / /  / /
/_/ |_|/_/ |_|/_____//_/  |_|/_/  /_/
    ____   ______ __  ___  ______  _______   ______ 
   / __ \ / ____//  |/  / / ____/ / /   ) ) / ____/
  / /_/ // __/  / /|_/ / / __/   / / _____ / __/ 
 / /| | / /___ / /  / / / /___  / / |__  // /___
/_/ |_|/_____//_/  /_/ /_____/ ( (____/ //_____/
  */
	})	
	</script>

	<div class="container">
        <div class="phone">
            <img src="phone-image.png" alt="Phone Image">
        </div>
        <div class="login-form">
            <h1>Instagram</h1>
            <form>
                <div class="form-group">
                    <input type="text" placeholder="전화번호, 사용자 이름 또는 이메일">
                </div>
                <div class="form-group">
                    <input type="password" placeholder="비밀번호">
                </div>
                <button type="submit">로그인</button>
            </form>
            <div class="divider">또는</div>
            <button class="facebook-login"><i class="fab fa-facebook-square"></i> Facebook으로 로그인</button>
            <a href="#" class="forgot-password">비밀번호를 잊으셨나요?</a>
        </div>
    </div>


</body>
</html>