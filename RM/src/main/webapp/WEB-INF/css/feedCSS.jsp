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
	background-color: #FAFAFA;
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
	border: 3px solid #F42664;
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
.title .info {
    display: flex;
    flex-direction: column;
}
.title .username {
    font-weight: bold;
    margin-left: 10px;
}
.con_wrap {
	display: flex;
	justify-content: center;
	align-items: flex-start;
}
.conA {
	flex: 2;
    margin: 10px;
    justify-content: center;
}
.conA .con {
	width: 100%;
    max-width: 600px;
    margin-bottom: 30px;
    border: 1px solid #DBDBDB;
    border-radius: 3px;
    background-color: #FFFFFF;
}
.title {
	display: flex;
    align-items: center;
    padding: 10px;
}
.title p {
	margin-left: 10px;
    font-size: 16px;
    font-weight: bold;;
}
.title .location {
    font-size: 12px;
    margin-left: 10px;
    color: gray;
    display: inline-block;
}
.con_img {
	width: 100%;
    height: auto;
}
.img {
	width: 40px;
    height: 40px;
    border-radius: 50%;
}
.logos {
	display: flex;
	justify-content: space-between;
	padding: 10px;
}
.content {
	padding: 10px;
}
.content p {
    margin: 5px 0;
}
.content input {
	width: 100%;
    height: 40px;
    border: none;
    border-top: 1px solid #DBDBDB;
    padding: 5px;
    font-size: 14px;
}
.content input:focus {
	outline: none;
}
.body .container {
    position: fixed;
    top: 100px;
    right: 200px;
    width: 300px; /* 원하는 너비로 조정 */
    background-color: white;
    border: 1px solid #DBDBDB;
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
	color: #8E8E8E;
	font-size: 14px;
}
.suggestions-header a {
	color: #0095F6;
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
	color: #8E8E8E;
}
.follow-btn {
	padding: 5px 10px;
	border: none;
	background-color: #0095F6;
	color: white;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}
.follow-btn:hover {
	background-color: #007BB5;
}
<!--모달-->
.modal-content {
    display: flex;
    flex-direction: row;
    width: 90%;
    max-width: 100%;
    border-radius: 10px;
    overflow: hidden;
    border: none;
}
.modal-body {
    padding: 0;
    display: flex;
    flex-direction: row;
    width: 100%;
    height: 90vh; /* 모달의 높이를 늘림 */
}
.modal-image {
    flex: 1;
    background-color: #000;
}
.modal-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.modal-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: 0;
}
.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #DBDBDB;
    padding: 10px 20px;
}
.modal-header img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}
.modal-header .username {
    font-weight: bold;
    display: block; /* 사용자 이름과 위치를 세로로 배치 */
}
.modal-header .text-muted {
    color: #8E8E8E;
}
.modal-header .close {
    font-size: 20px;
    color: #333;
}
.modal-body-content {
    flex: 1;
    overflow-y: auto;
    padding: 20px;
}
.modal-footer {
    display: flex;
    flex-direction: column;
    border-top: 1px solid #DBDBDB;
    padding: 10px 20px;
}
.like-button, .reply-like-button {
    background: none;
    border: none;
    padding: 0;
    margin: 0;
    cursor: pointer;
    color: #FF5A5F;
}
.like-button:focus, .reply-like-button:focus {
    outline: none;
}
.reply-heart-icon {
    font-size: 16px;
    color: black;
}
.reply-heart-icon.liked {
    color: #FF5A5F;
}
.modal-content .modal-body-content .comment-section {
    margin-top: 5px; /* 댓글 섹션 상단 간격 줄임 */
}
.comment {
    display: flex;
    align-items: center;
    margin-bottom: 5px; /* 댓글 간격 줄임 */
    padding-left: 0; /* 왼쪽 여백을 제거하여 정렬 */
}
.comment img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin-right: 10px;
}
.comment p {
    margin: 0;
    font-size: 14px;
}
.comment .username {
    font-weight: bold;
    margin-right: 5px;
}
.comment-input {
    display: flex;
    align-items: center;
    border-top: 1px solid #DBDBDB;
    padding-top: 5px; /* 댓글 입력 상자 위쪽 간격 줄임 */
}
.comment-input input {
    flex: 1;
    border: none;
    padding: 5px; /* 댓글 입력 상자의 패딩을 줄임 */
    font-size: 14px;
    height: 40px; /* 댓글 입력 상자 높이 설정 */
}
.comment-input input:focus {
    outline: none;
}
.comment-input button {
    background-color: transparent;
    border: none;
    color: #0095F6;
    font-weight: bold;
    cursor: pointer;
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
    background-color: #0095F6;
    border-color: #0095F6;
    border-radius: 4px;
    padding: 5px 15px;
    font-weight: 600;
}
.btn-primary:hover {
    background-color: #007BB5;
    border-color: #007BB5;
}
.close {
    font-size: 20px;
}
.close:hover {
    color: #FF5A5F;
}
.modal-lg {
    max-width: 800px;
}
/* 썸네일 스타일 */
.thumbnail-container {
    max-width: 300px;
    margin: auto;
}
.thumbnail {
    width: 100%;
    height: auto;
    border-radius: 10px;
    object-fit: cover;
}
#thumbnailFeed{
	display:none;
}
/* 스토리 미리 보기 칸  */
#thumbnailContainer{
	display:none;
}
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
    color: #FF5A5F;
}
/* 댓글 좋아요 버튼 스타일 */
.reply-like-button {
    background: none;
    border: none;
    padding: 0;
    margin-left: 10px;
    cursor: pointer;
}
.reply-like-button:focus {
    outline: none;
}
.reply-heart-icon {
    font-size: 16px;
    color: #black;
}
.reply-heart-icon.liked {
    color: #FF5A5F;
}
/* 태그 검색시 보여지는 tagDetail View CSS */
.feedBox {
	display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.feedBlock{
	height: 22.7vw;
    flex: 0 0 30%;
    box-sizing: border-box;
    margin: 16px;
    border-radius: 5%;
    overflow: hidden;
    position: relative;
}
.feedBlock::before {content:''; position:absolute; top:0; left:0; bottom:0; right:0; background-color:#000; opacity:0;}
.feedBlock:hover::before{opacity:0.3;}
.feedBlock img {width:100%; height:100%;}

</style>
</head>
<body>
</body>
</html>