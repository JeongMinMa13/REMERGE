<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- jquery CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><!-- bootstrapCSS -->
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
                    <li><div class="menu-item" id="search" onclick="searchDisplay();"><img src="resources/search.png">검색</div></li>
                    <li><div class="menu-item" id="explore"><img src="resources/explore.png">탐색</div></li>
                    <li><div class="menu-item" id="messages"><img src="resources/messages.png"><a href="/reMerge/message/dm">메시지</a></div></li>
                    <li><div class="menu-item" id="notifications"><img src="resources/notifications.png">알림</div></li>
                    <li><div class="menu-item" id="create"><img src="resources/create.png">만들기</div></li>
                    <li><div class="menu-item" id="store"><img src="resources/store.png">스토어</div></li>
                    <li><div class="menu-item" id="profile"><a href="myPage.us?userId=${loginUser.userId}"><img src="">프로필</a></div></li>
                    <li><div class="menu-item" id="calendarIcon"><a href="calendar.sc"><img src="resources/calendaricon.png">캘린더</a></div></li>
                </ul>
            </nav>
        </div>
        <div class="searchBox">
        	<div class="searchBoxTitle">검색</div>
        	<button class="btn btn-danger" onclick="closeSearch();">X</button>
	       	<div id="searchfollow" class="searchfollow"><!-- 검색 인풋 영역 -->
	       		<input type="text" id="searchUser" oninput="search();"><!-- oninput == 입력값이 변할때마다 -->
	       	</div>
	       	<div id="searchUserResult" class="searchUserResult"></div><!-- 검색 결과 -->
	       	
        </div>
    </header>
    <script>
    	function searchDisplay(){//검색 버튼 클릭시 검색 창 영역 보여주기
    		$('.searchBox').toggleClass('active');
    	}
    	
    	function closeSearch(){//검색창 활성화시 x버튼 클릭하면 검색창 닫기
    		$('.searchBox').removeClass('active');
    	}
    
    	function search(){//검색창에 하나의 단어 입력시마다 db에 저장된 아이디값에 포함된 단어의 아이디 조회해서 보여주기
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
    				html += "<ul>";
    				for(var i=0;i<data.length;i++){
    					html+="<li class='searchResult' onclick='profileUser("+JSON.stringify(data[i])+");'>";//해당하는 div 클릭시 data를 매개변수로 보내 클릭시 아이디값 알수 있게 하기
	    				html+="<span class='profileImage'><img src='"+data[i].profilePath+"'></span>";
	    				html+="<p>";
	    				html+="<strong class='userId'>"+data[i].userId+"</strong>";
	    				html+="<span class='email'>"+data[i].email+"</span>";
	    				html+="</p>";
	    				html+="</li>";
    				}
    				html+="</ul>"	
	    			$('#searchUserResult').html(html);
    			},
    			error:function(){
					console.log("통신 실패");    				
    			}
    		});
    	}
    	
    	function profileUser(data){//검색결과에서 해당하는 사용자 클릭시 프로필로 이동하는 함수
    		console.log(data.userId);
    		location.href="/reMerge/myPage.us?userId="+data.userId;
    	}  
    	
    	$('#home').click(function(){
    		location.href="/reMerge/feed.fe";
    	});
    
    </script>
</body>
</html>