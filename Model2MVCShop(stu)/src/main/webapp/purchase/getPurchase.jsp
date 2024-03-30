<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>상품구매완료 페이지</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
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
		$("button[type='button']:contains('수정')").on("click", function () {
			self.location = "/purchase/updatePurchase/" + $(this).data("tran-no");
		})
		
		$("button[type='button']:contains('확인')").on("click", function() {
			history.go(-1);
		})
		
		$("td:contains('물품명')").next().find("a").on("click", function () {
			$(this).attr("href", "/product/getProduct/" +$(this).data("prod-no") +"/search");
		})
	})
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		<div class="row">
			<table class="table table-striped table-bordered">
			
				<c:forEach var="orderDetail" items="${list }">

					<tr>
						<td>물품명</td>
						<td>
							<a href="" data-prod-no=${orderDetail.product.prodNo }>${orderDetail.product.prodName }</a> 
						</td>
					</tr>

					<tr>
						<td>수량</td>
						<td>${orderDetail.quantity } 개</td>
					</tr>

					<tr>
						<td style="border-bottom: 2px dotted #424242" colspan="3"></td>
					</tr>

				</c:forEach>
				
				<tr>
					<td>구매자아이디</td>
					<td>${purchase.buyer.userId }</td>
				</tr>

				<tr>
					<td>구매방법</td>
					<td>
					<c:choose>
						<c:when test="${purchase.paymentOption == 1 }">
			 				현금구매
						 </c:when>
						 
						 <c:otherwise>
						 	신용구매
						 </c:otherwise>
					</c:choose>
					</td>
				</tr>
				
				<tr>
					<td>구매자이름</td>
					<td>${purchase.receiverName }</td>
				</tr>
				
				<tr>
					<td>구매자연락처</td>
					<td>${purchase.receiverPhone }</td>
				</tr>
				
				<tr>
					<td>구매자주소</td>
					<td>${purchase.divyAddr }</td>
				</tr>
				
				<tr>
					<td>구매요청사항</td>
					<td>${purchase.divyRequest }</td>
				</tr>
				
				<tr>
					<td>배송희망일</td>
					<td>${purchase.divyDate }</td>
				</tr>

				<tr>
					<td>주문일</td>
					<td>${purchase.orderDate }</td>
				</tr>

			</table>
		</div><!-- row 1 end -->
	
		<div class="row">
			<button type="button" class="btn btn-default" data-tran-no="${purchase.tranNo}">수정</button>
			<button type="button" class="btn btn-primary">확인</button>
		</div><!-- row 2 end -->
	</div><!-- Container -->

</body>
</html>