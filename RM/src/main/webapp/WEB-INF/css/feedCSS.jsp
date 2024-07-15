
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
	position: absolute;
	top: 0px; /* 화면 맨 위에 고정 */
	left: 50%; /* 가운데 정렬을 위한 위치 조정 */
	transform: translateX(-50%); /* 가운데 정렬을 위한 위치 조d정 */
	padding: 10px; /* 내부 패딩 추가 */
	z-index: 1000; /* 다른 요소 위에 표시되도록 z-index 설정 */
	background-color: white;
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
/* 읽었던 스토리에 추가될 css */
.readed { 
	border: 3px solid gray;
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
	justify-content: center;
}

.conA .con {
	width: 500px;
	height: 600px;
	margin-bottom: 100px;
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
	width: 497px;
	height: 380px;
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
	position: fixed;
	top: 100px;
	width: 300px;
	left: 1400px;
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
	position: fixed;
	top: 420px;
	right: 130px;
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
    border-radius: 10px;
    overflow: hidden;
    border: none;
}

.modal-header, .modal-footer {
    border: none;
}

.modal-header {
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #007bff;
    color: #fff;
}

.modal-title {
    font-size: 18px;
    font-weight: 600;
}

.modal-body {
    padding: 0;
}

.thumbnail-container, .form-group, .hashTag {
    padding: 20px;
}

.thumbnail-container img {
    width: 100%;
    height: auto;
    display: block;
}

.btn-primary {
    background-color: #0095f6;
    border-color: #0095f6;
    border-radius: 4px;
    padding: 5px 15px;
    font-weight: 600;
}

.btn-primary:hover {
    background-color: #007bb5;
    border-color: #007bb5;
}

.close {
    font-size: 20px;
}

.close:hover {
    color: #ff5a5f;
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
#thumbnailFeed{
	display:none;
}
/* 스토리 미리 보기 칸  */
#thumbnailContainer{
	display:none;
}

/* 임시 좋아요 버튼*/
.like-button {
    background: none;
    border: none;
    padding: 0;
    margin: 0;
    cursor: pointer;
}

.like-button:focus {
    outline: none;
}

.heart-icon {
    font-size: 30px;
    color: #ff5a5f;
}


</style>
</head>
<body>

</body>

</html>