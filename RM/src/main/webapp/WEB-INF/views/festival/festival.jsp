<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
							str+="<li onclick='naverPage("+JSON.stringify(item)+");'>";
							str+="<div>";
							str+="<strong>"+item.fstvlNm+"</strong>";
							str+="<span>"+item.opar+"</span>";
							str+="<div>"+item.fstvlStartDate+" ~ "+item.fstvlEndDate+"</div>"
							str+="<div>"+item.fstvlCo+"</div>";
							str+="</div>"
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
		});
	
		function naverPage(data){
			console.log(data.homepageUrl); 
			location.href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+data.fstvlNm; 
		}
	</script>

</body>
</html>