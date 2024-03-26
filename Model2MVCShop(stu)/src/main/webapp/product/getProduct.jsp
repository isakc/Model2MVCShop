<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<title>상품정보조회</title>

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
        
        .sm-input{
        	width: 50px;
        }
   	</style>

	<script type="text/javascript">
	function changeQuantity(type) {

		var quantity = $("input[name='quantity']");
		var number = quantity.val();
		var maxQuantity = $('input[name="maxQuantity"]').val();

		if (type === 'plus') {
			if (maxQuantity > number) {
				number = parseInt(number) + 1;
				quantity.val(number);
			} else {
				alert("최대수량 초과");
			}
		} else {
			if (number > 1) {
				number = parseInt(number) - 1;
				quantity.val(number);
			} else {
				alert("1보다 작아질 수는 없습니다");
			}
		}
	}
	
	$(function () {
		$("#quantityMinus").on("click", function () {
			changeQuantity('minus');
		});
		
		$("#quantityPlus").on("click", function () {
			changeQuantity('plus');
		});
		
		$("button[type='button']:contains('이전')").on("click", function() {
			history.go(-1);
		});
		
		$("button[type='button']:contains('구매')").on("click", function() {
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();
		});
		
		$("button[type='button']:contains('장바구니')").on("click", function() {
			var quantity = $("input[name='quantity']").val();
			var prodNo = $("input[name='prodNo']").val();
			var url = "/cart/addCart/" + prodNo + "/" + quantity;

			window.location.href = url;
		});
	})
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
		<form>
			<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo }" />
			<input type="hidden" name="maxQuantity" value="${product.quantity }" />
			<input type="hidden" name="cartNo" />
			
			<table class="table table-striped table-bordered">
				<tr>
					<td>상품번호</td>
					<td>${product.prodNo }</td>
				</tr>

				<tr>
					<td>상품명</td>
					<td>${product.prodName }</td>
				</tr>

				<tr>
					<td>상품이미지</td>
					<td>
						<%-- <img src = "/images/uploadFiles/${product.fileName }" width="300" height="300"/> --%>
					</td>
				</tr>

				<tr>
					<td>상품상세정보</td>
					<td>${product.prodDetail }</td>
				</tr>

				<tr>
					<td>제조일자</td>
					<td>${product.manuDate }</td>
				</tr>

				<tr>
					<td>가격</td>
					<td><fmt:formatNumber value="${product.price}" pattern="#,##0원" /></td>
				</tr>

				<tr>
					<td>수량</td>
					<td>
						<button type="button" id="quantityMinus"><span class="glyphicon glyphicon-arrow-down"></span></button>
						<input type="text" id="quantity" name="quantity"
						class="sm-input" maxLength="13" value="1" />
						<button type="button" id="quantityPlus"><span class="glyphicon glyphicon-arrow-up"></span></button>
					</td>
				</tr>

				<tr>
					<td>등록일자</td>
					<td>${product.regDate }</td>
				</tr>
			</table>

			<div class="row">
				<button type="button" class="btn btn-default">장바구니</button>
				<button type="button" class="btn btn-default">구매</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</form>
	</div>
</body>
</html>