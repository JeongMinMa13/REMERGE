<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userEnrollForm</title>
</head>
<body>


	<div class="center">
		<h2 align="center" style="color: black;">회원가입</h2>
		<br><br>
		<form id="enroll-form" action="/insert.us"
			method="post">
			<table>
				
				<tr>
					<td>* 아이디</td>
					<td><input type="text" name="userId" id="userId" required
						placeholder="아이디를 입력해주세요."></td>
					<td>  &nbsp; &nbsp;</td>
					<td><button type="button" onclick="idCheck();"
							class="btn btn-outline-dark">중복확인</button></td>

					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>* 비밀번호</td>
						<td><input type="password" name="userPwd" id="userPwd"
							required></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>* 비밀번호확인</td>
						<td><input type="password" name="pwChk" id="pwChk" required></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>* 이름</td>
						<td><input type="text" name="userName" id="userName" required></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>*이메일</td>
						<td><input type="email" name="email" id="email"></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>*생년월일</td>
						<td><input type="text" name="birth" id="birth"
							placeholder="8자리를 입력하세요" maxlength="8" required></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td id="gender">성별</td>
						<td><input type="radio"
							style="width: 20px; height: 20px; border: 1px; accent-color: black;"
							name="gender" id="M" value="M" checked><label for="M">남자</label>
							<input type="radio" name="gender"
							style="width: 20px; height: 20px; border: 1px; accent-color: black;"
							id="F" value="F"> <label for="F">여자</label></td>
					</tr>
					<tr>
						<td colspan="3"><hr></td>
					</tr>
					<tr>
						<td>추천인</td>
						<td><input type="text" id="recommender" name="recommender">
						<button type="button" onclick="recomCheck();"
								class="btn btn-outline-dark">확 인</button>
						</td>
					</tr>
				</table>
				<br> <br>
				<div align="center">
					<button id="sign" type="submit"  class="gradient-btn"  disabled>회원가입</button>
					<button type="reset" class="gradient-btn">초기화</button>
				</div>
			<br> <br> <br><br>
			</form>

		</div>

</body>
</html>