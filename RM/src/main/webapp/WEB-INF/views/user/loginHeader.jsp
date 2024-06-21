<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
html.active,
html.active body {
  overflow: hidden;
}

html.active section {
  -webkit-transform: matrix(1, 0, 0, 1, -320, 0);
  -moz-transform: matrix(1, 0, 0, 1, -320, 0);
  transform: matrix(1, 0, 0, 1, -320, 0);
  -webkit-transition: all .5s ease-in-out;
  -moz-transition: all .5s ease-in-out;
  transition: all .5s ease-in-out;
}
</style>

</head>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>	
	<header>
        <div class="sidebar">
            <div class="logo">
                <img src="resources/Remergelogo.png" alt="Remerge logo">
            </div>
            <nav class="menu">
                <ul>
                    <li><div class="menu-item" id="home"><img src="resources/home.png">홈</div></li>
                    <li><div class="menu-item" id="search"><img src="resources/search.png">검색</div></li>
                    <li><div class="menu-item" id="explore"><img src="resources/explore.png">탐색</div></li>
                    <li><div class="menu-item" id="messages"><img src="resources/messages.png"><a href="/reMerge/message/dm">메시지</a></div></li>
                    <li><div class="menu-item" id="notifications"><img src="resources/notifications.png">알림</div></li>
                    <li><div class="menu-item" id="create"><img src="resources/create.png">만들기</div></li>
                    <li><div class="menu-item" id="store"><img src="resources/store.png">스토어</div></li>
                    <li><div class="menu-item" id="profile"><img src="">프로필</div></li>
                    <li><div class="menu-item" id="calendarIcon"><img src="resources/calendaricon.png"><a href="calendar.sc">캘린더</a></div></li>
                </ul>
            </nav>
        </div>
        <div class="searchBox">
	       	<div id="searchfollow"><!-- 검색 인풋 영역 -->
	       		<input type="text" id="searchUser" oninput="search();"><!-- oninput == 입력값이 변할때마다 -->
	       	</div>
	       	<div id="searchUserResult"></div><!-- 검색 결과 -->
        </div>
    </header>
    <script>
    	function search(){
    		var searchStr = $('#searchUser').val();
    		$.ajax({
    			url:"searchUser.us",
    			type:"get",
    			data:{
    				searchStr:searchStr
    			},
    			success:function(data){
    				console.log(data)// 데이터 확인
    				var html = "";
    				for(var i=0;i<data.length;i++){
    					html+="<div class='searchResult' onclick='profileUser("+data+");'>"
	    				html+="<span> <img src='"+data[i].profilePath+"'></span>";
	    				html+="<div>"+data[i].userId+"</div>";
	    				html+="<span>"+data[i].email+"</span>";
	    				html+="</div>";
	    				
	    				$('#searchUserResult').html(html);
	    				
    				}
    			},
    			error:function(){
					console.log("통신 실패");    				
    			}
    		});
    	}
    	
    	function profileUser(data){
    		console.log(data.userId);
    	}
    
    </script>
</body>
</html>