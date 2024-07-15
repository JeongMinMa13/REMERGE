<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

.shopContainer {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	padding: 20px;
}

.ShopImage-section {
	flex: 1;
	padding-right: 10px;
}

.ShopImage-section img {
	
	width: 70%;
	height: 70%;
}

.ShopInfo-section {
	flex: 1;
	padding-left: 20px;
	border-left: 1px solid #ddd;
	margin-right: 30em;
}

.ShopInfo-section h1 {
	margin-top: 0;
	
}

.ShopInfo-section .price {
	font-size: 24px;
	font-weight: bold;
}

.ShopInfo-section .purchase-button {
	display: block;
	width: 100%;
	padding: 10px;
	margin-top: 20px;
	background-color: #ff5a5f;
	color: #fff;
	border: none;
	font-size: 18px;
	cursor: pointer;
}

.ShopInfo-section .purchase-button:hover {
	background-color: #e44e4f;
}

.ShopInfo-section .options {
	margin: 20px 0;
}

.ShopInfo-section .options select {
	width: 100%;
	padding: 10px;
	font-size: 16px;
} 
</style>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
<%@include file="../user/loginHeader.jsp" %>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<script>
	 	$(function () {
	 		const urlParams = new URLSearchParams(window.location.search);
	 	    const shopNo = urlParams.get('shopNo');

	 	    console.log("도메인에서 뽑은 shopNo:", shopNo); 
			$.ajax({
				url : "shopDetail.sh",
				data :{
					shopNo : shopNo
				},
				error : function () {
					console.log("통신 오류");
				},
				success : function (result) {
					console.log("result 세션에 값을 넘김 : ",result)
				}
			});
		});
	 	
	 	
		$(function () {
			var userId = "${loginUser.userId}";
			console.log("userId : ",userId);
			$.ajax({
				url : "addressSelect.sh",
				data :{
					userId : userId
				},
				error : function () {
					console.log("통신 오류");
				},
				success : function (result) {
					console.log("로그인유저 정보로 주소를 조회함 ad 세션에 값을 넘김 : ",result);
				}
			});
		});
	 
	</script>
	
	
	<div class="outer">
	<div style="margin-left: 10em;">
	<h2>제품 상세 보기</h2>
	<h2>${sh.modelName}</h2>
	</div>
		<div class="shopContainer">
			<div class="ShopImage-section" align="center">
				<img src=" ${sh.filePath}"alt="상품 상세 이미지" >
			</div>
			<!-- <form action="deliver.sh"> -->
				<div class="ShopInfo-section">
					<p class="price">${sh.krw} KRW</p>
					<div class="options">
						<label for="options">옵션 선택</label> 
						<select id="options" name="options">
							<c:forEach var="br" items="${br}">
								<option value="options">${br.brandSize}</option>
							</c:forEach>
						</select>
					</div>
					<br><br><br><br>
					<div id="adress-area" style="display:none;">
					<h3>배송지 정보</h3>
						<input type="text" id="userName" name="userName" placeholder="받으시는분 성함" required> <br> <br>
						<input type="hidden" id="sample6_postcode" placeholder="우편번호" style="display:none;">
						<input type="text" id="sample6_address" name="sample6_address"  readonly placeholder="주소">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br><br>
						<input type="text" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소" ><br><br>
						<input type="hidden" id="sample6_extraAddress" style="display:none;" placeholder="참고항목">
						<br>
						<c:choose>
					      <c:when test="${empty ad.addressOri}">
					          <button onclick="insertOriAD();" id="insertOriAD">기본주소 등록하기</button>
					      </c:when>
					      <c:otherwise>
					          <button onclick="updateOriAD();" id="updateOriAD">주소 재등록하기</button>
					          <br> <br>
					          <button onclick="selectOriAD();">기본주소 불러오기</button>
					      </c:otherwise>
					  	</c:choose>
						<br> <br>
					</div>
						
					<button class="purchase-button" id="paymentBtn" onclick="requestPay();">구매하기</button>
					<button class="purchase-button" id="paymentlistBtn" onclick="callPaymentList();">주문내역 바로가기</button>
				</div>
			<!-- </form> -->
		</div>
	</div>
	
	 <script>
	 	function selectOriAD() {
			 var addresschk = $("#sample6_address").val();
			 var addressDetailchk = $("#sample6_detailAddress").val();
			 //console.log("addresschk :",addresschk);
			 //console.log("addressDetailchk :",addressDetailchk);
			$.ajax({
				url : "selectOriAD.sh",
				data :{
					userId : "${loginUser.userId}"
				},
				error : function () {
					console.log("통신 오류");
				},
				success : function (result) {
					//console.log("selsect 구문 완료 ");
					//console.log("result :",result);
					//console.log("result의 addressOri",result[0].addressOri);
					$("#sample6_address").val(result[0].addressOri);
					$("#sample6_detailAddress").val(result[0].addressOriDetail);
					alert("기본 주소 불러오기 완료");
				}
			});
		}
	

    </script>
	
	<script>
	 	function updateOriAD() {
			var addressOri = $("#sample6_address").val();
			var addressOride = $("#sample6_detailAddress").val();
		    //console.log("새로운 주소 입력받은값:", addressOri); 
				$.ajax({
					url : "updateOriAD.sh",
					data :{
						userId : "${loginUser.userId}",
						addressOri : addressOri,
						addressOride : addressOride,
					},
					error : function () {
						console.log("통신 오류");
					},
					success : function (result) {
						if(result>0){
							alert("주소 재등록!");
						}else{
							alert("주소 재등록 실패");
						}
					}
				});
		    }
		
	
	</script>
	
	<script>
	function insertOriAD() {
		var addressOri = $("#sample6_address").val();
		var addressOride = $("#sample6_detailAddress").val();
		var userName = $("#userName").val();
	    console.log("새로운 주소 입력받은값:", addressOri); 
	    if(userName=""){
	    	alert("받으시는분 성함을 기입해주세요");
	    }else{
			$.ajax({
				url : "insertOriAD.sh",
				data :{
					userId : "${loginUser.userId}",
					addressOri : addressOri,
					addressOride : addressOride,
				},
				error : function () {
					console.log("통신 오류");
				},
				success : function (result) {
					if(result>0){
						alert("주소 등록 완료");
					}else{
					alert("주소 미등록");
					}
				}
			});
	    }
	}
	

    </script>
	



	<script>
       function requestPay() {
    	   var userName = $("#userName").val();
    	   var addressOri = $("#sample6_address").val();
    	   var filePath = "${sh.filePath}";
    	   if(userName==""&&addressOri==""){
    		   alert("주소지를 입력해주세요");
    		   $("#adress-area").show();
    	   }else if(userName==""){
				alert("받으시는분 성함을 입력해주세요");
				$("#adress-area").show();
			}else{
				var userId = "${loginUser.userId}";
				var IMP = window.IMP; 
			    IMP.init("imp04514880"); 
		        $(function () {
		        	const urlParams = new URLSearchParams(window.location.search);
			 	    const shopNo = urlParams.get('shopNo');
		        	var today = new Date();   
			        var hours = today.getHours(); // 시
			        var minutes = today.getMinutes();  // 분
			        var seconds = today.getSeconds();  // 초
			        var milliseconds = today.getMilliseconds();
			        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
			        var addressOri = $("#sample6_address").val();
					var addressOride = $("#sample6_detailAddress").val();
		        	var payMethod = $("input[name=payment]:checked").val(); //결제 방식
		        	var totalPrice = $("option:selected").val();//상품 가격
		        	var userName = $("input[name=userName]").val();
		        	var address = addressOri+addressOride;
		        	var productName = "${sh.brandNameList}"+" "+"${sh.brandList}"+" "+"${sh.modelName}";
		        	
		            IMP.request_pay({
		                pg : 'html5_inicis',
		                pay_method : 'card',
		                merchant_uid: makeMerchantUid, 
		                name : productName,
		                amount : 100,
		                quantity : shopNo,
		                buyer_name : userName,
		                buyer_addr : address
		            }, function (rsp) { // callback
		                if (rsp.success) {//결제 성공시
		                	var userId = "${loginUser.userId}";
		                	var address = addressOri+" "+addressOride;
		                	var today = new Date();   
					        var hours = today.getHours(); // 시
					        var minutes = today.getMinutes();  // 분
					        var seconds = today.getSeconds();  // 초
					        var milliseconds = today.getMilliseconds();
					        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
		                    console.log(rsp);
		                	//결제 성공시 비동기 처리로 응답데이터 서버에 전달하기     
		                	$.ajax({
		                    	url : "insertPayment.sh",
		                    	data : {
		                    		userId : userId,
		                    		pg : rsp.pg_provider,
		                    		mcUid : rsp.merchant_uid+makeMerchantUid,
		                    		productName : productName,
		                    		amount : rsp.paid_amount,
		                    		quantity : shopNo,
		                    		buyerName : rsp.buyer_name,
		                    		buyerAddr : address,
		                    		filePath : filePath
		                    	}, //rsp 객체를 그대로 전달해보기(응답데이터 키값으로 넘어감)
		                    	success : function(result){
		                    		
		                    		if(result>0){
		                    			alert("결제 성공! 주문내역을 보시려면 주문내역버튼을 눌러주세요.");
		                    		}else{
		                    			alert("결제정보 오류 [관리자에게 문의하세요]");
		                    		}
		                    	},
		                    	error : function(){
		                    		console.log("통신실패");
		                    	}
		                    });
		                } else {
		                    console.log(rsp);
		                }
		            });
		        });
			}
		}
    </script>

	<script>
	
	function callPaymentList() {
		location.href="/reMerge/callPaymentList.sh";
	}
	
	</script>


<script>
	//주소지 API 구문
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>