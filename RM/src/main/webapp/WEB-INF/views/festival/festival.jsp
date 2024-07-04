<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- jquery CDN -->
<style type="text/css">
	.festivalTitle{
		background-color: black;
		color:white;
		text-align: center;
		font-size: 30px;
	}
	.festivalContent{
		padding-top: 50px; 
	}
	.festivalBox li{
		margin: 3px;
		border: 1px solid black;
	}
	
	.festivalBox li:hover{
		cursor:pointer;
		background-color: gray;
	}
</style>
</head>
<body>
	<%@ include file="../user/loginHeader.jsp" %>
	<div class="outer">
		<div class="festivalTitle">
			축제 리스트 
		</div>
		<div class="festivalContent">
			<div id="openDataResult"></div>
		</div>
		<button id="prevPage">이전</button>
		<button id="nextPage">다음</button>
	</div>
	
	<script type="text/javascript">
		$(function(){
			var pageNo = 1;
			function paging(pageNo){
				$.ajax({
					url:"selectFestival.fs",
					type:"get",
					data:{
						pageNo:pageNo,
					},
					success:function(data){
						/* console.log(data); */
						var items=data.response.body.items;
						var str = "<ul class='festivalBox'>";
						for(var i=0;i<items.length;i++){
							var item = items[i];
							var recommendCount = getRecommendCount(item.fstvlNm);
							var recStr = getRecStr(item.fstvlNm);
							str+="<li>";
							str+="<div onclick='naverPage("+JSON.stringify(item)+");'>";
							str+="<strong>"+item.fstvlNm+"</strong>";
							str+="<span>"+item.opar+"</span>";
							str+="<div>"+item.fstvlStartDate+" ~ "+item.fstvlEndDate+"</div>"
							str+="<div>"+item.fstvlCo+"</div>";
							str+="</div>"
							if(recommendCount > 0){
                                str += "<div class='countRecommend'>추천 수 : " + recommendCount + "</div>";
                            }
							if(recStr === '추천'){
								str+="<button onclick='recommend(event,"+JSON.stringify(item)+");'>"+recStr+"</button>";
							}else{
								str+="<button onclick='deRecommend(event,"+JSON.stringify(item)+");'>"+recStr+"</button>";
							}
							str+="</li>";
						}
						str+="</ul>";
						document.getElementById("openDataResult").innerHTML = str;
						//console.log("ajax 실행됨");
						updateButton(pageNo);
					},
					error:function(){
						console.log("통신 실패");
					}
				});
			}
			paging(pageNo);
			
			function updateButton(pageNo) {
                if (pageNo === 1) {
                    $("#prevPage").attr("disabled", true);
                } else {
                    $("#prevPage").attr("disabled", false);
                }
            }
			
			$("#prevPage").click(function() {
		        if (pageNo > 1) {
			    	pageNo--;
			        paging(pageNo);
			    
			    }
			 });
	
			 $("#nextPage").click(function() {
			 	pageNo++;
			 	/* console.log(pageNo); */
			    paging(pageNo);
			 });
			 
			 //세션에 담긴 추천수 공공데이터와 비교하여 추천수 넣어주기
			 function getRecommendCount(festivalName) {
                var count = 0;
                <c:forEach var="recommend" items="${recommendList}">
                    if (festivalName === "${recommend.festivalName}") {
                        count = ${recommend.recommendCount};
                    }
                </c:forEach>
                return count;
	         }
			 
			 function getRecStr(festivalName){
				 var recStr='추천';
				 <c:forEach var="recommendUser" items="${userList}">
                 if (festivalName === "${recommendUser.festivalName}"&& ${recommendUser.userId eq loginUser.userId} ) {
                     //추천 누른 유저 비교하여 비추천 으로 바꾸기 
                     //console.log("통과");
                     recStr = '추천 취소';
                 }
            	 </c:forEach>
            	 return recStr;
			 }
		});
	
		function naverPage(data){
			//console.log(data.homepageUrl); 
			location.href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+encodeURIComponent(data.fstvlNm); 
		}
		
		function recommend(e,festival){
			e.preventDefault();
			e.stopPropagation();
			var festivalName = festival.fstvlNm;
			$.ajax({
				url:"insertRecommend.fs",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					festivalName:festivalName
				},
				success:function(data){
					//console.log(data);
					if(data>0){
						alert('성공적으로 추천되었습니다.');
            			location.reload();
					}
				},
				error:function(){
					
				}
			});
			
		}
		
		function deRecommend(e,festival){
			e.preventDefault();
			e.stopPropagation();
			var festivalName = festival.fstvlNm;
			$.ajax({
				url:"deleteRecommend.fs",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					festivalName:festivalName
				},
				success:function(data){
					//console.log(data);
					if(data>0){
						alert('성공적으로 취소되었습니다.');
	        			location.reload();
					}
				},
				error:function(){
					
				}
			});
			
		}
	</script>

</body>
</html>