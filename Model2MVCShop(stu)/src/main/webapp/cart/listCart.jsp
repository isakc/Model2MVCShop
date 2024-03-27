<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">

<head>
	<title>장바구니 목록</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link href="/css/animate.min.css" rel="stylesheet">
  	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  	
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
		$(".table-bordered tr td a:contains('삭제')").on("click", function () {
			$(this).attr("href", "/cart/deleteCart/" + $(this).data("cart-no"));
		});
		
		$("#quantityMinus").on("click", function() {
			updateQuantity('minus', $(this).next());
		});

		$("#quantityPlus").on("click", function() {
			updateQuantity('plus', $(this).prev());
		});
		
		$("button[type='button']:contains('구매')").on("click", function() {
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();
		});
				
		$("button[type='button']:contains('이전')").on("click", function() {
			history.go(-1);
		});
		
		$("button[type='button']:contains('상품검색')").on("click", function() {
			self.location = "/product/listProduct/search";
		});
	})

	function updateQuantity(type, elem) {
		var prodNo = elem.data("prod-no");
		var cartNo = elem.data("cart-no");
		var quantity = elem.val();
		var maxQuantity = elem.data("max-quantity");

		let number = quantity;

		if (type === 'plus') {
			if (maxQuantity > number) {
				number = parseInt(number) + 1;
			} else {
				alert("최대수량 초과");
				return;
			}
		} else {
			if (number > 1) {
				number = parseInt(number) - 1;
			} else {
				alert("1보다 작아질 수는 없습니다");
				return;
			}
		}

		var url = "/cart/updateCart/" + prodNo + "/" + cartNo + "/" + number;
		window.location.href = url;
	}
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<c:choose>
   		<c:when test="${listCart.size() == 0}">
   			<div class="container">
   				<h1 class="text-info">카트가 비어있습니다!</h1>
   				<div class="row">
   					<button type="button" class="btn btn-default">상품검색</button>
   				</div>
   			</div>
   		</c:when>
   		
   		<c:otherwise>
			<div class="container">
				<form>
					<div class="row">
						<input type="hidden" name="buyerId" value="${user.userId }" />

						<table class="table table-striped table-bordered">
							<c:forEach var="cart" items="${listCart }">
								<input type="hidden" id="prodNo" name="cartNo"
									value="${cart.cartNo}" />
								<input type="hidden" id="prodNo" name="prodNo"
									value="${cart.product.prodNo}" />

								<tr>
									<td>상품명</td>
									<td>${cart.product.prodName }</td>
								</tr>

								<tr>
									<td>상품이미지</td>
									<td>
										<%-- <img src="/images/uploadFiles/${cart.product.fileName }" width="100" height="100" /> --%>
										<a href="" data-cart-no="${cart.cartNo }">삭제</a>
								</tr>

								<tr>
									<td>가격</td>
									<td><fmt:formatNumber
											value="${ (cart.product.price * cart.quantity) }"
											pattern="#,##0원" /></td>
								</tr>

								<tr>
									<td>수량</td>
									<td>
										<button type="button" id="quantityMinus">▼</button>
										<input type="text" id="quantity" name="quantity" value="${cart.quantity }"
										data-prod-no="${cart.product.prodNo }" data-cart-no="${cart.cartNo }"
										data-max-quantity="${cart.product.quantity }" />
										<button type="button" id="quantityPlus">▲</button>
									</td>
								</tr>

							</c:forEach>
						</table>
					</div>
				</form>

				<div class="row">
					<button type="button" class="btn btn-default">구매</button>
					<button type="button" class="btn btn-primary">취소</button>
				</div>
			</div>
			<!-- Container -->
		</c:otherwise>
   	</c:choose>
</body>
</html>