<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Arrays"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역 페이지</title>
<style>

h1 {
    text-align: center;
    margin-top: 20px;
    font-size: 24px;
    letter-spacing: 1.5px;
}

table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 15px;
    text-align: center;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

td img {
    width: 50px;
    height: auto;
    display: block;
    margin: 0 auto;
}

td {
    font-size: 16px;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f1f1;
}
</style>

</head>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
<%@include file="../user/loginHeader.jsp" %>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<body>

	<script>
	$(function () {
		$.ajax({
			url : "PaymentList.sh",
			data :{
				userId : "${loginUser.userId}"
			},
			error : function () {
				console.log("통신 오류");
			},
			success : function (result) {
            	//console.log("result : ",result);
			}
		});
	});
	
	</script> 
	
	<div class="outer">
	
	  <table>
        <thead>
            <tr align="center">
            	<th>주문 번호</th>
                <th>상품 이미지</th>
                <th>상 품 명</th>
                <th>받으시는분 성함</th>
                <th>주 소</th>
                <th>가 격</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="pl" items="${pl}"> 
            <tr>
             	<td>${pl.mcUid}</td>
                <td><img src="${pl.filePath}" alt="Item Image"></td>
                <td>${pl.productName}</td>
                <td>${pl.buyerName }</td>
                <td>${pl.buyerAddr}</td>
                <td>₩${pl.amount}</td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
 	</div>
	
	
</body>
</html>