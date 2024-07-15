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
<body onload="loadUserList();">
    <%@include file="../user/loginHeader.jsp" %>

    <div class="outer">
        <div class="table-container">
            <table class="sel">
                <thead>
                    <tr height="100px;">
                        <th width="200px;"><img id="selfie" src="${pageContext.request.contextPath}/${loginUser.profilePath}"></th>
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
                <div id="other">${receiveId}</div>
            <div class="chat-area" id="chatArea">
            </div>
            <div class="chat-input">
                <img id="emoji" src="${pageContext.request.contextPath}/resources/emoji.png">
                <input type="file" id="fileInput" style="display: none;" accept="image/*">
				<img id="photo" src="${pageContext.request.contextPath}/resources/ph.png" onclick="document.getElementById('fileInput').click();">
                <input type="text" id="chat" placeholder="메시지를 입력하세요..." onkeydown="if(event.key === 'Enter') sendMessage(currentChatUserId);">
                <button id="sendMessageBtn">전송</button>
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
        if (currentChatRoom) {
            joinChatRoom(currentChatRoom);
        }
        console.log("채팅방 입장 성공")
    };
    socket.onerror = function(e) {
        console.log(e);
    };
    socket.onmessage = function(event) {
        var message = JSON.parse(event.data);
        if (message.changeName) {
            appendImage(message.sendId, message.changeName);
        } else {
            appendMessage(message.sendId, message.content);
        }
    };
    socket.onclose = function(event) {
        console.log("메시지 서버 연결 종료", event);
    };
}

function disconnect() {
    if (socket) {
        socket.close();
        socket = null;
    }
}

function loadUserList() {
    $.ajax({
        url: "/reMerge/userListAjax.us",
        method: "GET",
        success: function(data) {
            var userListBody = $("#userListBody");
            userListBody.empty();

            var userRows = "";

            data.forEach(function(user) {
                var loggedInUserId = "${loginUser.userId}";
                if (user.userId !== loggedInUserId) {
                    userRows += "<tr onclick='loadChat(\"" + user.userId + "\")'>";
                    userRows += "<td><img id='userProfile' src='" + "${pageContext.request.contextPath}/" + user.profilePath + "'></td>";
                    if (user.userMemo != null) {
                        userRows += "<td rowspan='2'>" + user.userMemo + "</td>";
                    }
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
    if (socket) {
        disconnect();
    }
    connect();

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
                        chatArea.empty(); // 기존 채팅 내용 초기화
                        data.forEach(function(message) {
                            appendMessage(message.sendId, message.content, message.changeName);
                        });
                        joinChatRoom(messageRoomNo);
                        $("#exit").attr("onclick", "disconnect();");
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
    $("#other").text(receiveId);
}

function createNewChatRoom(receiveId) {
    $.ajax({
        url: "/reMerge/message/createChatRoom",
        method: "GET",
        data: { receiveId: receiveId },
        success: function(response) {
            currentChatRoom = response;
            joinChatRoom(response);
        },
        error: function(error) {
            console.log("채팅방 생성 실패 : ", error);
        }
    });
}

function joinChatRoom(messageRoomNo) {
    if (socket && socket.readyState === SockJS.OPEN) {
        var joinMessage = {
            type: "join",
            messageRoomNo: messageRoomNo
        };
        socket.send(JSON.stringify(joinMessage));
    } else {
        console.log("Socket 연결이 아직 열리지 않았습니다.");
    }
}

function sendMessage(receiveId, readCheck) {
    var messageContent = $("#chat").val();
    
    if (!messageContent.trim()) {
        return; // 메시지 내용이 공백이면 전송하지 않음
    }

    if (socket && socket.readyState === SockJS.OPEN) {
        socket.send(JSON.stringify({
            messageRoomNo: currentChatRoom,
            sendId: "${loginUser.userId}",
            receiveId: receiveId,
            content: messageContent,
            readCheck: readCheck
        }));
        $("#chat").val(""); // 메시지 전송 후 입력 창 초기화
    } else {
        console.log("소켓 연결 끊긴듯");
    }
}

function appendMessage(sendId, content, changeName) {
    var chatArea = $("#chatArea");
    var message = $("<div class='message'></div>");
    var isSender = sendId === "${loginUser.userId}";

    if (isSender) {
        message.addClass("sent-message");
    } else {
        message.addClass("received-message");
    }

    var contentElement = $("<p class='message-content'></p>").text(content);
    message.append(contentElement);
    
    if (changeName) { // 이미지가 있을 경우에만 이미지 요소를 추가
        var imgElement = $("<img class='message-image' style='width:150px; height:200px;'>");
        imgElement.attr("src", changeName);
        message.append(imgElement);
    }
    
    if (isSender || sendId === currentChatUserId) { // 보낸 메시지와 받은 메시지에 따라 채팅창에 추가
        chatArea.append(message);
        chatArea.scrollTop(chatArea[0].scrollHeight);
    }
}

function appendImage(sendId, changeName) {
    var chatArea = $("#chatArea");
    var message = $("<div class='message'></div>");
    var isSender = sendId === "${loginUser.userId}";

    if (isSender) {
        message.addClass("sent-message");
    } else {
        message.addClass("received-message");
    }

    var imgElement = $("<img class='message-image'>");
    imgElement.attr("src", changeName);
    imgElement.css({
        "max-width": "150px",   
        "max-height": "200px", 
    });
    message.append(imgElement);

    if (isSender || sendId === currentChatUserId) { // 보낸 메시지와 받은 메시지에 따라 채팅창에 추가
        chatArea.append(message);
        chatArea.scrollTop(chatArea[0].scrollHeight);
    }
}

$(document).ready(function() {
    $("#sendMessageBtn").on("click", function() {
        sendMessage(currentChatUserId);
    });

    $("#chat").on("keydown", function(event) {
        if (event.keyCode === 13) { // 엔터 키 코드
            event.preventDefault();
            sendMessage(currentChatUserId);
        }
    });

    $("#exit").on("click", function() {
        if (confirm("채팅방에서 나가시겠습니까?")) {
        	$("#chatArea").empty();
            disconnect();
            currentChatRoom = null;
            currentChatUserId = null;
        }
    });
});

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
            originName: reader.result,
            readCheck: 1
        };

        socket.send(JSON.stringify(message));
        // 채팅창에 이미지 추가
        appendImage("${loginUser.userId}", reader.result);
        // 서버에 이미지 전송 및 저장
        sendImageToServer(file);
    };

    if (file) {
        reader.readAsDataURL(file);
    }
};

//서버에 이미지 전송 및 저장 함수
function sendImageToServer() {
    var fileInput = document.getElementById("fileInput");
    var file = fileInput.files[0];

    var formData = new FormData();
    formData.append("file", file);
    formData.append("messageRoomNo", currentChatRoom);
    formData.append("sendId", "${loginUser.userId}");
    formData.append("receiveId", currentChatUserId);
    formData.append("readCheck", 1);

    $.ajax({
        url: "/reMerge/message/upload",
        method: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(data) {
            console.log("이미지 전송 성공, 서버 응답 데이터:", data);
            // 이미지 전송 성공 후 WebSocket 메시지 전송
            var message = {
                messageRoomNo: currentChatRoom,
                sendId: "${loginUser.userId}",
                receiveId: currentChatUserId,
                content: null,
                changeName: "/reMerge/resources/uploadFiles/" + data, // 서버에서 반환된 변경된 파일 이름을 사용
                readCheck: 1
            };
            socket.send(JSON.stringify(message)); // WebSocket을 통해 메시지 전송
        },
        error: function(error) {
            console.log("파일 전송 실패:", error);
        }
    });
    connect();
}

//이모지 모달
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
