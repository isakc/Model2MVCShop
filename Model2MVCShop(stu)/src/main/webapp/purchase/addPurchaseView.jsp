<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<title>상품구매 페이지</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">

	$(function() {
		$("button[type='button']:contains('구매')").on("click", function () {
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
		});
		
		$("button[type='button']:contains('취소')").on("click", function () {
			history.go(-1);
		});
		
		$("input[name='divyDate']").next().on("click", function () {
			show_calendar('document.addPurhase.divyDate',$('input[name=divyDate]').value);
		});
	})
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">	
		<form name="addPurhase">
		<div class="row">
		
		<table class="table table-striped table-bordered">
			<c:forEach var="cart" items="${cartNoList}">
				<input type="hidden" name="cartNo" value="${cart }" />
			</c:forEach>
		
			<c:forEach var="product" items="${productList }">
		
			<input type="hidden" name="prodNo" value="${product.prodNo }" />
			<input type="hidden" name="quantity" value="${product.quantity }" />
			<c:set var="totalPrice" value="${ totalPrice + (product.price * product.quantity) }"/>
		
			<tr>
				<td>상품명</td>
				<td>${product.prodName }</td>
			</tr>
	
			<tr>
				<td>가격</td>
				<td><fmt:formatNumber value="${ product.price * product.quantity }" pattern="#,##0원"/></td>
			</tr>
	
			<tr>
				<td>수량</td>
				<td>${ product.quantity }</td>
			</tr>
	
			<tr>
				<td style="border-bottom:2px solid #424242" colspan="3"></td>
			</tr>
	
			</c:forEach>	
		<!-- 여기까지 for문 -->
	
			<tr>
				<td>총가격</td>
				<td><fmt:formatNumber value="${totalPrice}" pattern="#,##0원"/></td>
			</tr>
	
			<tr>
				<td>구매자아이디</td>
				<td>${user.userId }</td>
				<input type="hidden" name="buyerId" value="${user.userId }" />
			</tr>
		
			<tr>
				<td>구매방법</td>
				<td>
					<select name="paymentOption" maxLength="20">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
				</td>
			</tr>
		
			<tr>
				<td>구매자이름</td>
				<td>
					<input type="text" name="receiverName" maxLength="20" value="${user.userName }" />
				</td>
			</tr>
		
			<tr>
				<td>구매자연락처</td>
				<td>
					<input 	type="text" name="receiverPhone" maxLength="20" value="${user.phone }" />
				</td>
			</tr>
		
			<tr>
				<td>구매자주소</td>
				<td>
					<input 	type="text" name="divyAddr" maxLength="20" value="${user.addr }" />
				</td>
			</tr>
		
			<tr>
				<td>구매요청사항</td>
				<td>
					<input type="text" name="divyRequest" maxLength="20" />
				</td>
			</tr>
		
			<tr>
				<td>배송희망일자</td>
				<td>
					<input type="text" readonly="readonly" name="divyDate" maxLength="20"/>
					<img src="../images/ct_icon_date.gif" width="15" height="15"/>
				</td>
			</tr>
		
		</table>
	</div><!-- row 1 end -->

	<div class="row">
		<button type="button" class="btn btn-default">구매</button>
		<button type="button" class="btn btn-primary">취소</button>
	</div><!-- row 2 end -->
	
	</form>
</div>

</body>
</html>