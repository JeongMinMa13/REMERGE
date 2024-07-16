<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
* {
	box-sizing: border-box;
	font-family: "Noto Sans CJK KR";
	font-style: normal;
}

body {
	display: flex;
	flex-direction: row;
	justify-content: center;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 670px;
	height: 900px;
	margin-top: 30px;
	margin-bottom: 30px;
	background: #ffffff;
	border: 1px solid #aacdff;
	box-shadow: 7px 7px 39px rgba(0, 104, 255, 0.25);
	border-radius: 20px;
}


.member-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 470px;
	height: 818px;
	margin-top: 72px;
	margin-bottom: 70px;
}

.header {
	width: 466px;
	height: 94px;
	font-weight: 700;
	font-size: 32px;
	line-height: 47px;
}

.user-info {
	margin-top: 39px;
}

.user-info div {
	margin-top: 21px;
}

.user-info input {
	font-weight: 400;
	font-size: 16px;
	line-height: 24px;
	color: #797979;
	border: none;
	border-bottom: 1px solid #cfcfcf;
	width: 466px;
	margin-top: 21px;
}
.modal-body input{
	font-weight: 400;
	font-size: 16px;
	line-height: 24px;
	color: #797979;
	border: none;
	border-bottom: 1px solid #cfcfcf;
	width: 466px;
	margin-top: 21px;
}
.user-info-email input {
	border-bottom: 1px solid #0068ff;
}

.gender {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 140px;
	height: 23.94px;
	margin-top: 50px;
}

.gender input {
	width: 20px;
	height: 19.95px;
	background: #ebebeb;
	border: 1px solid #d2d2d2;
}

.gender label {
	font-weight: 400;
	font-size: 16px;
	line-height: 24px;
}

.agree-check {
	width: 454px;
	height: 21.06px;
	margin-top: 52.05px;
	font-weight: 400;
	font-size: 14px;
	line-height: 21px;
	color: #000000;
}

.btn2 {
	display: flex;
	flex-direction: column;
	margin-top: 30px;
	width: 470px;
	height: 106px;
}

button {
	margin-top: 15px;
	width: 470px;
	height: 75px;
	font-weight: 400;
	font-size: 18px;
	line-height: 27px;
	text-align: center;
	color: #0068ff;
	background: #ffffff;
	border: 1px solid #0068ff;
	border-radius: 10px;
	cursor: pointer;
}
</style>

</head>

<body>

	<div class="container">
		<div class="member-container">
			<div class="header">
				<div>아 이 디 찾 기</div>
			</div>
			<div class="user-info">
				<div class="user-info-email">
					<label for="idForFindEmail">* 이메일</label><br> <input
						type="email" name="idForFindEmail" id="idForFindEmail"><br>
				</div>
			</div>
			<div class="btn2">
				<button id=idForFindEmail type="button" onclick="idForFindEmail();">아이디
					찾기</button>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="member-container">
			<div class="header">
				<div>이메일을 이용한 비밀번호 변경</div>
			</div>
			<div class="user-info">
				<div class="user-info-name">
					<label for="pwForId">* 아이디</label><br> <input type="text"
						name="pwForId" id="pwForId"><br>
				</div>

				<div class="user-info-email">
					<label for="pwForEmail">* 이메일</label><br> <input type="email"
						name="pwForEmail" id="pwForEmail">
				</div>
				<div class="user-info-pw">
					<div id="mailOn" style="display: none;">
						<label for="numAccInput">* 인증번호 입력</label><br> <input
							type="text" name="numAccInput" id="numAccInput">
							<div class="btn">
						<button id="numAcc" name="numAcc" type="button"
							onclick="accNum();">인 증</button>
							</div>
					</div>
				</div>
			</div>
				<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#changePw" id="mailCheckOn" style="display: none">
				비밀번호 변경</button>
			<div class="btn2">
				<button id="accEmail" type="button" onclick="accEmail();">이메일
					보내기</button>
			</div>
		</div>
	</div>
	<!-- <div class="center"> 
	<div class="center">
		<h2 align="center" style="color: black;">아이디 찾기</h2>
		<br> <br>
			<hr>
			<br> 
			<label for="idForFindEmail">* 이메일</label><br> 
			<input type="email" name="idForFindEmail" id="idForFindEmail"><br>
			<hr>
			<br>
			<button id=idForFindEmail type="button" onclick="idForFindEmail();">아이디 찾기</button>
		<br> <br> <br> <br>
	</div> -->



	<!-- <div class="center">
		<h2 align="center" style="color: black;">이메일을 이용한 비밀번호 변경</h2>
		<br> <br>
		<hr>
		<br> <label for="pwForId">* 아이디</label><br> <input
			type="text" name="pwForId" id="pwForId"><br>
		<hr>
		<br> <label for="pwForEmail">* 이메일</label><br> <input
			type="email" name="pwForEmail" id="pwForEmail">
		<button id="accEmail" type="button" onclick="accEmail();">이메일
			보내기</button>
		<br>
		<hr>
		<br>
		<div id="mailOn" style="display: none;">
			<label for="numAccInput">* 인증번호 입력</label><br> <input
				type="text" name="numAccInput" id="numAccInput">
			<button id="numAcc" name="numAcc" type="button" onclick="accNum();">인
				증</button>
		</div>
		<div align="center">
			Button to Open the Modal
			<br> <br>
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#changePw" id="mailCheckOn" style="display: none">
				비밀번호 변경</button>
		</div>
		<br> <br> <br> <br>
	</div> -->



	<!-- The Modal -->
	<div class="modal" id="changePw">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">비밀번호 변경하기</h4>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<label for="changePwd">변경할 비밀번호</label> <br> <input
						type="password" name="changePwd"> <br>
					<br> <label for="cheChangePwd">변경할 비밀번호 확인</label> <br> <input
						type="password" name="cheChangePwd"> <br>
					<br>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" onclick="checkPwandChange();"
						 data-dismiss="modal">변경하기</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">취
						소</button>
				</div>
			</div>
		</div>
	</div>




	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg" />
	</c:if>


	<script>
		function idForFindEmail() {
			var idForFindEmail = $("#idForFindEmail");
			//console.log(idForFindEmail.val())
			$.ajax({
				url : "findId.us",
				data : {
					idForFindEmail : idForFindEmail.val()
				},
				success : function(findId) {
					//console.log(findId);
					if (findId == null) {
						alert("등록된 아이디가 없습니다.");
					} else {
						alert("회원님의 아이디는" + findId + "입니다.");
					}

				},
				error : function() {
					console.log("통신 오류");
				}
			});

		}

		function checkPwandChange() {
			var userId = $("input[name=pwForId]").val();
			var changePwd = $("input[name=changePwd]").val();
			var cheChangePwd = $("input[name=cheChangePwd]").val();
			//console.log(changePwd);
			//console.log(cheChangePwd);
			if (changePwd != cheChangePwd) {
				alert("변경할 비밀번호와 변경할 비밀번호 확인이 일치하지 않습니다.");

			} else {
				$.ajax({
					url : "checkPwandChange.us",
					data : {
						changePwd : changePwd,
						cheChangePwd : cheChangePwd,
						userId : userId
					},
					success : function(result) {
						//console.log(result);
						if (result == "NNNNY") {
							alert("비밀번호 변경완료!!");
							location.href = "/reMerge"
						} else if (result == "NNNNN1") {
							alert("비밀번호 가 같지 않습니다!!");
						} else {
							alert("비밀번호 변경실패!!");
						}
					},
					error : function() {
						console.log("통신 오류");
					}
				});
			}
		}

		//이메일 인증 난수 메일 전송
		function accEmail() {
			var userId = $("input[name=pwForId]").val();
			var pwForEmail = $("input[name=pwForEmail]").val();
			$.ajax({
				url : "accEmail.us",
				data : {
					userId : userId,
					pwForEmail : pwForEmail
				},
				success : function(res) {
					console.log(res);
					if (res.status) {
						$("#mailOn").show();
						alert(userId + "회원님의 이메일로 인증번호 전송했습니다.")
					} else {
						alert("이메일로 인증번호 전송 실패 했습니다.")
					}
				},
				error : function() {
					console.log("통신 오류");
				}
			});
		}

		//인증받은 난수 같은지 확인
		function accNum() {
			var numAccInput = $("input[name=numAccInput]").val();
			//console.log(numAccInput);
			$.ajax({
				url : "numAcc.us",
				data : {
					numAccInput : numAccInput,
				},
				success : function(result) {
					//console.log(result);
					if (result > 0) {
						alert("이메일 인증에 성공하셧습니다. 비밀번호를 변경해주세요!");
						$("#mailCheckOn").show();
					} else {
						alert("이메일 인증 실패!! 이메일 인증을 재시도 하세요");
						$("#mailOn").hide();
					}

				},
				error : function() {
					console.log("통신 오류");
					alert("이메일 인증 오류!! 이메일 인증을 재시도 하세요");
				}
			});
		}
	</script>
</body>
</html>