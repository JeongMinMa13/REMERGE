<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
<meta charset="UTF-8">
<title>로그인 화면</title>

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
	<h2 align="center">로그인</h2>
	<div align="center">
	<input type="text" placeholder="아이디">
	<input type="password" placeholder="비밀번호">
	
	</div>
	<button>로그인</button>
	
	<br><br><br>
	<h2 align="center">다른 계정으로 로그인!</h2>
	
	
	<br><br><br>
	<div class="find-area" align="center">
		<input type="button" class="btn btn-link" onclick="findId();" value="아이디 찾기">|
		<input type="button" class="btn btn-link" onclick="findPwd();" value="비밀번호 찾기">
	</div>
	
	
	
	
	
	
	
	
</body>
</html>