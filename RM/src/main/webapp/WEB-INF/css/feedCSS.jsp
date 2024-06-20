<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	height: auto;
	margin: 0;
	padding: 0;
	background-color: #fafafa;
	font-family: 'Arial', sans-serif;
}

header {
	display: flex;
	height: 100px;
}

.sidebar {
	width: 250px;
	background-color: #ffffff;
	border-right: 1px solid #dbdbdb;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 20px;
}

.logo img {
	width: 120px;
	margin-bottom: 30px;
	margin-right: 120px;
}

.menu {
	width: 100%;
}

.menu ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.menu ul li {
	width: 100%;
	margin-bottom: 20px;
}

.menu-item {
	display: flex;
	align-items: center;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
	font-weight: 500;
}

.menu-item img {
	width: 24px;
	height: 24px;
	margin-right: 15px;
}

.menu-item:hover {
	background-color: #f0f0f0;
	border-radius: 10px;
}

.body {
	flex: 1;
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	align-items: flex-start; /* 맨 위 정렬 */
	padding: 20px;
	overflow-y: auto; /* 스토리 영역이 넘칠 경우 스크롤 가능하도록 */
}

.storys {
	width: 50%; /* 스토리 컨테이너 너비 */
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	align-items: flex-start; /* 맨 위 정렬 */
	flex-wrap: wrap; /* 스토리가 넘칠 경우 여러 줄로 배치 */
	position: fixed; /* 페이지 스크롤과 상관없이 고정 */
	top: 0; /* 화면 맨 위에 고정 */
	left: 50%; /* 가운데 정렬을 위한 위치 조정 */
	transform: translateX(-50%); /* 가운데 정렬을 위한 위치 조정 */
	padding: 10px; /* 내부 패딩 추가 */
	z-index: 1000; /* 다른 요소 위에 표시되도록 z-index 설정 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

.story {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 10px;
}

.story_img {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	border: 3px solid #f42664;
}

.story span {
	margin-top: 5px;
	font-size: 12px;
	text-align: center;
}

.profile {
	display: flex;
	margin: 10px 0;
	justify-content: flex-end;
	padding-right: 250px;
}

.profile p {
	margin: 5px 15px;
	font-size: 20px;
}

.con_wrap {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	margin-top: 50px;
}

.conA {
	flex: 2;
	margin: 10px 50px 30px 200px;
	display: flex;
	justify-content: center;
}

.conA .con {
	width: 500px;
	height: 630px;
	margin-bottom: 50px;
	margin-left: 500px;
	border: 1px solid #DBDBDB;
	border-radius: 3px;
	background-color: #ffffff;
}

.title {
	display: flex; /* 프로필사진과 User이름이 옆으로 쌓이게 하기 위함. */
	margin: 10px;
}

.title p {
	margin: 5px 15px;
	font-size: 20px;
}

.con_img {
	width: 500px;
}

.img {
	width: 50px;
	height: 50px;
	border-radius: 50%;
}

.logos {
	display: flex; /* logo들이 옆으로 쌓이게 하기 위함. */
	justify-content: space-between;
	/* logos_left와 logos_right를 양 끝으로 배치시킴. */
	padding: 0 10px;
}

.content {
	padding: 10px;
}

.content input {
	width: 100%;
	height: 45px;
	border: none;
	border-top: 1px solid #DBDBDB;
	color: #999999;
	font-size: 16px;
}

.content input:focus {
	outline: none;
}

.container {
	position: relative;
	bottom: 100px;
	width: 300px;
	left: 50px;
	background-color: white;
	border: 1px solid #dbdbdb;
	border-radius: 10px;
	padding: 20px;
}

.profile-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.profile-header img {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin-right: 15px;
}

.profile-header .profile-info {
	display: flex;
	flex-direction: column;
}

.profile-header .username {
	font-weight: bold;
}

.suggestions-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.suggestions-header span {
	color: #8e8e8e;
	font-size: 14px;
}

.suggestions-header a {
	color: #0095f6;
	font-size: 14px;
	text-decoration: none;
}

.suggestion {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 15px;
}

.suggestion img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.suggestion .suggestion-info {
	display: flex;
	align-items: center;
	flex-grow: 1;
}

.suggestion .suggestion-info .name {
	font-weight: bold;
	font-size: 14px;
}

.suggestion .suggestion-info .subtext {
	font-size: 12px;
	color: #8e8e8e;
}

.follow-btn {
	padding: 5px 10px;
	border: none;
	background-color: #0095f6;
	color: white;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}

.follow-btn:hover {
	background-color: #007bb5;
}

.footer {
	position: relative;
	top: 220px;
	right: 290px;
	font-size: 12px;
	color: #8e8e8e;
	text-align: center;
}

.footer a {
	color: #8e8e8e;
	text-decoration: none;
	margin: 0 5px;
}

.footer a:hover {
	text-decoration: underline;
}

.footer div {
	margin-top: 10px;
}

<!--모달-->

.modal-content {
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
    background-color: #007bff;
    color: #fff;
    border-bottom: none;
}

.modal-title {
    font-weight: bold;
}

.modal-body {
    padding: 20px;
}

.modal-footer {
    border-top: none;
}

.modal-footer button {
    padding: 10px 20px;
    border-radius: 20px;
    background-color: #007bff;
    color: #fff;
}

.modal-footer button:hover {
    background-color: #0056b3;
}

/* 썸네일 스타일 */
.thumbnail-container {
    text-align: center;
    margin-bottom: 20px;
}

.thumbnail {
    max-width: 100%;
    height: auto;
    border-radius: 5px;
    margin-top: 10px;
}




</style>
</head>
<body>

</body>
</html>