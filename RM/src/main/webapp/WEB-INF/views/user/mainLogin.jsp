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
	

	
	<table align="center">
		<tr>
			<td><img src="resources/Remergelogo.png"></td>
		</tr>
	</table>
	<h2 align="center">로그인</h2>
	<form action="login.us" method="post"> 
	<div align="center">
		<input type="text" id="userId" name="userId" placeholder="아이디">
		<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호">
		<button type="submit">로그인 </button>
	<h2 align="center">다른 계정으로 로그인!!!!!!!</h2>
	<!-- <a href="login">네이버로 로그인</a> -->
	<br>
		
		<!-- 네이버 로그인 창으로 이동 -->
		<div id="naver_id_login" style="text-align: center;">
    		<a id="naverLoginLink"  ><img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
		</div>
		<br>
	</div>
	</form>
	
	<br><br><br>
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
    $(function () {
        if (!sessionStorage.getItem('naverAuthUrlLoaded')) {
            naverAPIload();
            sessionStorage.setItem('naverAuthUrlLoaded', 'true');
        } else {
            $("#naverLoginLink").attr("href", "${naverAuthUrl}");
        }
    });

    function naverAPIload(){
        $.ajax({
            url: "naverlogin.us",
            success: function(data){
                console.log(data);
                $("#naverLoginLink").attr("href", "${naverAuthUrl}");
            },
            error: function(){
                console.log("통신 오류");
	            }
	        });
	    }
	    
	   
	</script>


	
	
	
	
	
	
	
</body>
</html>