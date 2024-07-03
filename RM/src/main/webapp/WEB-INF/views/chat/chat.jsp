<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Direct Message</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/chatStyle.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head>
<body onload="connect(); loadUserList();">
    <%@include file="../user/loginHeader.jsp" %>

    <div class="outer">	
        <div class="table-container">
            <table class="sel">
                <thead>
                    <tr height="100px;">
                        <th width="200px;"><img id="selfie" src="${pageContext.request.contextPath}${loginUser.profilePath}"></th>
                        <th rowspan="2"><button id="exit" onclick="disconnect();">채팅방 나가기</button></th>
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
                
            </div>
            <div class="chat-input">
            	<img id="emoji" src="${pageContext.request.contextPath}/resources/emoji.png">
            	<input type="file" id="fileInput" style="display: none;" accept="image/*">
				<img id="photo" src="${pageContext.request.contextPath}/resources/ph.png" onclick="document.getElementById('fileInput').click();">
			    <input type="text" id="chat" placeholder="메시지를 입력하세요..." onkeydown="if(event.key === 'Enter') sendMessage(currentChatUserId);">
			    <button onclick="sendMessage(currentChatUserId);">전송</button>
			</div>
        </div>
    </div>
    <div id="emojiModal" class="modal" style="width:600px; height:200px; left:30%; bottom:10%; top:70%; position:absolute; display:none;">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <div id="emojiListModalBody"></div>
	    </div>
	</div>

    <script>
        var socket;
        var currentChatRoom = null;
        var currentChatUserId = null;

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
                appendMessage(message.sendId, message.content, message.readCheck);

                if (currentChatRoom !== message.messageRoomNo) {
                    return;
                }
            };
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
                    console.log("유저 목록 불러오기 실패 : ", error);
                }
            });
        }
        
        function loadChat(receiveId) {
            currentChatUserId = receiveId;
            $.ajax({
                url: "/reMerge/message/getChatRoom",
                method: "GET",
                data: { receiveId: receiveId },
                success: function(messageRoomNo) {
                    if (messageRoomNo > 0) {
                        currentChatRoom = messageRoomNo;
                        $.ajax({
                            url: "/reMerge/message/getChatHistory",
                            method: "GET",
                            data: { messageRoomNo: messageRoomNo },
                            success: function(data) {
                                var chatArea = $("#chatArea");

                                chatArea.empty();

                                data.forEach(function(message) {
                                    appendMessage(message.sendId, message.content);
                                });

                                joinChatRoom(messageRoomNo);
                                $("#exit").attr("onclick", "disconnect('" + messageRoomNo + "');");
                            },
                            error: function(error) {
                                console.log("채팅 기록 불러오기 실패 : ", error);
                            }
                        });
                    } else {
                        createNewChatRoom(receiveId);
                    }
                },
                error: function(error) {
                    console.log("채팅방 번호 불러오기 실패 : ", error);
                }
            });
        }
        
        function createNewChatRoom(receiveId) {
            $.ajax({
                url: "/reMerge/message/createChatRoom",
                method: "GET",
                data: { receiveId: receiveId },
                success: function(response) {
                    console.log("새로운 채팅방 생성 성공: ", response);
                    currentChatRoom = response; // 여기에 currentChatRoom 설정
                    joinChatRoom(response);
                },
                error: function(error) {
                    console.log("채팅방 생성 실패 : ", error);
                }
            });
        }

        function joinChatRoom(messageRoomNo) {
            var joinMessage = {
                type: "join",
                messageRoomNo: messageRoomNo
            };
            socket.send(JSON.stringify(joinMessage));
        }

        function sendMessage(receiveId) {
            var messageContent = $("#chat").val();

            var message = {
                    messageRoomNo: currentChatRoom,
                    sendId: "${loginUser.userId}",
                    receiveId: receiveId,
                    content: messageContent,
                    sendTime: new Date(),
                    readCheck: 1
                };
            
            // WebSocket을 통해 메시지 전송
            socket.send(JSON.stringify(message));
            $("#chat").val(""); // 메시지 전송 후 입력 창 초기화
        }

        function appendMessage(sendId, content, readCheck) {
            var chatArea = $("#chatArea");
            var message = $("<div class='message'></div>");

            var isSender = sendId === "${loginUser.userId}";

            // 보낸 메시지와 받은 메시지에 따라 클래스를 다르게 적용
            if (isSender) {
                message.addClass("sent-message");
            } else {
                message.addClass("received-message");
            }

            var contentElement = $("<p class='message-content'></p>").text(content);
            message.append(contentElement);

            chatArea.append(message);
            chatArea.scrollTop(chatArea[0].scrollHeight);
        }
        
        function disconnect(messageRoomNo) {
            if (socket != null) {
                var disconnectMessage = {
                    type: "leave",
                    messageRoomNo: messageRoomNo
                };
                socket.send(JSON.stringify(disconnectMessage));
                socket.close();
            }
            
            $("#chatArea").empty();

            currentChatRoom = null;
            currentChatUserId = null;
        }
        
        function appendImage(sendId, photo) {
            var chatArea = $("#chatArea");
            var message = $("<div class='message'></div>");

            var isSender = sendId === "${loginUser.userId}";

            if (isSender) {
                message.addClass("sent-message");
            } else {
                message.addClass("received-message");
            }

            var imgElement = $("<img class='message-image'>");
            imgElement.attr("src", photo);
            imgElement.css({
                "max-width": "100px",   
                "max-height": "200px", 
            });

            message.append(imgElement);

            chatArea.append(message);
            chatArea.scrollTop(chatArea[0].scrollHeight);
        }
		
     // 이미지를 선택했을 때의 처리
        document.getElementById('fileInput').onchange = function(e) {
            var file = e.target.files[0];
            var reader = new FileReader();

            reader.onload = function() {
                var message = {
                    messageRoomNo: currentChatRoom,
                    sendId: "${loginUser.userId}",
                    receiveId: currentChatUserId,
                    content: null,
                    sendTime: new Date(),
                    readTime: null,
                    photo: reader.result,  // 이미지를 Base64로 인코딩한 데이터
                    readCheck: 1
                };

                socket.send(JSON.stringify(message));

                // 채팅창에 이미지 추가
                appendImage("${loginUser.userId}", reader.result);
                
                // 서버에 이미지 전송 및 저장 (추가된 부분)
                sendImageToServer(file);
            };

            if (file) {
                reader.readAsDataURL(file);
            }
        };

        // 서버에 이미지 전송 및 저장 함수
        function sendImageToServer(file) {
            var formData = new FormData();
            formData.append("file", file);

            $.ajax({
                url: "/reMerge/message/uploadImage",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log("이미지 전송 성공: ", response);
                },
                error: function(error) {
                    console.log("이미지 전송 실패: ", error);
                }
            });
        }
		
        // 이모지 모달
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
        
//         setInterval(loadChat, 2000);
    </script>
</body>
</html>