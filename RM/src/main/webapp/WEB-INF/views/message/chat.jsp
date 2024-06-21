<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Direct Message</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head>
<body onload="connect(); loadUserList();">
    <%@include file="/WEB-INF/views/user/loginHeader.jsp" %>

    <div class="container">
        <div class="menu-bar">
            <table class="left-menu">
                <tr> <td>메뉴 아이콘</td> </tr>
            </table>
        </div>

        <div class="table-container">
            <table class="sel">
                <thead>
                    <tr height="100px;">
                        <th width="200px;"><img id="profile" src="${pageContext.request.contextPath}${loginUser.profilePath}"></th>
                        <th rowspan="2"><img id="msg" src="${pageContext.request.contextPath}/resources/css/msg.png"></th>
                    </tr>
                    <tr>
                        <th>${loginUser.userId}</th>
                    </tr>
                    <tr>
                        <th colspan="2"><hr></th>
                    </tr>
                    <tr>
                        <th colspan="2">메시지</th>
                    </tr>
                </thead>
                <tbody id="userListBody">
                </tbody>
            </table>
        </div>

        <div class="chat-container">
            <div class="chat-area" id="chatArea">
                <button id="exit" onclick="disconnect();">나가기</button>
                로그인 여부: ${not empty loginUser}
            </div>
            <div class="chat-input">
            	<img id="emoji" src="${pageContext.request.contextPath}/resources/emoji.png">
			    <input type="text" id="chat" placeholder="메시지를 입력하세요..." onkeydown="if(event.key === 'Enter') sendMessage();" style="flex: 1;">
			    <button onclick="sendMessage();">전송</button>
			</div>
        </div>
    </div>
    
    <div id="emojiModal" class="modal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <div id="emojiListModalBody"></div>
	    </div>
	</div>

    <script>
        var socket;
        var currentChatUser = null;

        function connect() {
            var url = "/reMerge/dm";
            socket = new SockJS(url);

            socket.onopen = function() {
                console.log("연결 성공");
                console.log("로그인한 사용자 아이디 : " + "${loginUser.userId}");
            };
            socket.onerror = function(e) {
                console.log("에러 발생");
                console.log(e);
            };
            socket.onmessage = function(event) {
                var message = JSON.parse(event.data);
                appendMessage(message.sendId, message.content);
            };
        }

        function sendMessage() {
            var message = document.getElementById("chat").value;

            if (message.trim() !== "" && currentChatUser) {
                console.log("Sending message to " + currentChatUser);
                $.ajax({
                    url: "/reMerge/message/send",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        sendId: "${loginUser.userId}",
                        receiveId: currentChatUser,
                        content: message
                    }),
                    success: function(response) {
                        console.log("Message sent:", response);
                        document.getElementById("chat").value = "";
                        appendMessage("${loginUser.userId}", message);
                    },
                    error: function(error) {
                        console.log("Error sending message:", error);
                    }
                });
            }
        }

        function appendMessage(sendId, content) {
            var chatArea = $("#chatArea");
            var messageElement = $("<div>").text(sendId + ": " + content);
            chatArea.append(messageElement);
        }

        function loadUserList() {
            $.ajax({
                url: "/reMerge/userListAjax.us",
                method: "GET",
                success: function(data) {
                    console.log("사용자 리스트 : ", data);

                    var userListBody = $("#userListBody");
                    userListBody.empty();

                    var userRows = "";

                    data.forEach(function(user) {
                        var loggedInUserId = "${loginUser.userId}";

                        if (user.userId !== loggedInUserId) {
                            userRows += "<tr onclick='loadChat(\"" + user.userId + "\")'>";
                            userRows += "<td><img id='userProfile' src='" + "${pageContext.request.contextPath}" + user.profilePath + "'></td>";
                            userRows += "<td rowspan='2'>" + user.userMemo + "</td>";
                            userRows += "</tr>";
                            userRows += "<tr>";
                            userRows += "<td>" + user.userId + "</td>";
                            userRows += "</tr>";
                            userRows += "<tr><td colspan='2'><hr></td></tr>";
                        }
                    });
                    userListBody.append(userRows);
                },
                error: function(error) {
                    console.log("Error fetching user list:", error);
                }
            });
        }

        function loadChat(userId) {
            console.log("Loading chat for sendId: " + "${loginUser.userId}" + ", receiveId: " + userId);
            currentChatUser = userId;

            $.ajax({
                url: "/reMerge/message/messages",
                method: "GET",
                data: {
                    sendId: "${loginUser.userId}",
                    receiveId: userId
                },
                success: function(messages) {
                    console.log("Received messages:", messages); // 받은 메시지 데이터 확인

                    var chatArea = $("#chatArea");
                    chatArea.empty();

                    messages.forEach(function(message) {
                        console.log("Message from " + message.sendId + ": " + message.content); // 각 메시지 확인
                        appendMessage(message.sendId, message.content);
                    });
                },
                error: function(error) {
                    console.log("Error fetching messages:", error); // 에러 확인
                }
            });
        }
        function disconnect() {
            socket.close();
        }
// 		이모지 기능
        $(document).ready(function() {
		    var modal = document.getElementById("emojiModal");
		    var span = document.getElementsByClassName("close")[0];
		
		    $("#emoji").click(function() {
		        $.ajax({
		            url: '/reMerge/emojis',
		            type: 'GET',
		            dataType: 'json',
		            success: function(data) {
		                var emojiListHtml = '';
		                data.forEach(function(emoji) {
		                    emojiListHtml += '<span class="emoji" data-character="' + emoji.character + '">' + emoji.character + '</span>';
		                });
		                $("#emojiListModalBody").html(emojiListHtml);
		                modal.style.display = "block";
		
		                $(".emoji").off().on("click", function() {
		                    var character = $(this).attr('data-character');
		                    var currentText = $("#chat").val();
		                    $("#chat").val(currentText + character);
		                });
		            },
		            error: function(xhr, status, error) {
		                console.error('Ajax 오류 발생: ' + error);
		            }
		        });
		    });
		
		    span.onclick = function() {
		        modal.style.display = "none";
		    }
		
		    window.onclick = function(event) {
		        if (event.target == modal) {
		            modal.style.display = "none";
		        }
		    }
		
		    $(".modal-content").click(function(event) {
		        event.stopPropagation();
		    });
	        $(document).on("click", function(event) {
	            var target = $(event.target);
	            if (!target.closest('.modal-content').length && !target.is('#emoji')) {
	                modal.style.display = "none";
	            }
	        });
		});

        
    </script>
</body>
</html>
