<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Alertify.js CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css">

<!-- Alertify.js JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
</head>
<body>
<br><br><br><br><br><br><br>
	
	<table align="center" id="resources/Remergelogo.png">
		<tr>
			<td><img src=""></td>
		</tr>
	</table>
	<h2 align="center">로그인</h2>
	<form action="login.us" method="post"> 
	<div align="center">
		<input type="text" id="userId" name="userId" placeholder="아이디">
		<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호">
		<button type="submit">로그인 </button>
	</div>
	</form>
	
	<br><br><br>
	<h2 align="center">다른 계정으로 로그인!!!!!!!</h2>
	<!-- 네이버 로그인 버튼 노출 영역 -->
	<div id="naver_id_login"><img src="resources/btnG_naver.png"></div>
	<!-- //네이버 로그인 버튼 노출 영역 -->
	
	<!-- 네이버아디디로로그인 초기화 Script -->
	<script>
		var naver_id_login = new naver_id_login("QtBQWMlKTonQr2ENTX3U", "http://remerge.com:8878/reMerge/callback");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("white", 2,40);
		naver_id_login.setDomain(".service.com");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
	
	<!-- // 네이버 로그인 초기화 Script -->
	<script type="text/javascript">
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		// naver_id_login.getProfileData('프로필항목명');
		// 프로필 항목은 개발가이드를 참고하시기 바랍니다.
		alert(naver_id_login.getProfileData('email'));
		alert(naver_id_login.getProfileData('nickname'));
		alert(naver_id_login.getProfileData('age'));
	}


	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	</script>
	<!-- //네이버아디디로로그인 Callback페이지 처리 Script -->
	
	<br><br><br>
	<div class="find-area" align="center">
		<input type="button" class="btn btn-link" onclick="findId();" value="아이디 찾기">|
		<input type="button" class="btn btn-link" onclick="findPwd();" value="비밀번호 찾기">| &nbsp;&nbsp;   
		<a href="insertEnrollForm.us">회원 가입</a>
	</div>
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>	
	
	
	<script>
	
	
	</script>
	
	
	
	
</body>
</html>