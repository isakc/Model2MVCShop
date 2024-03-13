<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>상품등록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
	
</script>

<script type="text/javascript">
	function submitForm() {
		document.detailForm.submit();
	}
	
	function updateQuantity(type, prodNo, cartNo, quantity, maxQuantity) {
		
		let number = quantity;
		
		 if(type === 'plus') {
			 if(maxQuantity > number){
				   number = parseInt(number) + 1;
			 }else{
				 alert("최대수량 초과");
			 }
		 }else  {
		   if(number > 1){
			   number = parseInt(number) - 1;
		   }else{
			   alert("1보다 작아질 수는 없습니다");
		   }
		 }

		var url = "/cart/updateCart/" + prodNo + "/" + cartNo + "/" + number;
	    window.location.href = url;
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<form name="detailForm" method="post" action="/purchase/addPurchaseView">
		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
					width="15" height="37" /></td>
				<td background="/images/ct_ttl_img02.gif" width="100%"
					style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">장바구니 목록</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
					width="12" height="37" /></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
			<input type="hidden" name="buyerId" value="${user.userId }" />
			<c:forEach var="cart" items="${listCart }">
				<input type="hidden" id="prodNo" name="cartNo" value="${cart.cartNo}" />
				<input type="hidden" id="prodNo" name="prodNo" value="${cart.product.prodNo}" />
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">상품명 <img
						src="/images/ct_icon_red.gif" width="3" height="3"
						align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${cart.product.prodName }</td>
				</tr>

				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">상품이미지 <img
						src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
					<img src="/images/uploadFiles/${cart.product.fileName }" width="100" height="100" />
					<a href="/cart/deleteCart/${cart.cartNo}">삭제</a></td>
				</tr>

				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">가격</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
					<fmt:formatNumber value="${ (cart.product.price * cart.quantity) }" pattern="#,##0원" /></td>
				</tr>

				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">수량</td>
					<td bgcolor="D6D6D6" width="1"></td>

					<td class="ct_write01">
					<%-- <a href="/cart/updateCart/${cart.product.prodNo }/${cart.cartNo }/${cart.quantity -1}">▼</a> --%>
					<a href="javascript:updateQuantity('minus', ${cart.product.prodNo }, ${cart.cartNo }, ${cart.quantity}, ${cart.product.quantity });">▼</a>
						<input type="text" id="quantity" name="quantity"
						class="ct_input_g" style="width: 30px; text-align: center;"
						value="${cart.quantity }" />
					<%-- <a href="/cart/updateCart/${cart.product.prodNo }/${cart.cartNo }/${cart.quantity +1}">▲</a> --%>
					<a href="javascript:updateQuantity('plus', ${cart.product.prodNo }, ${cart.cartNo }, ${cart.quantity}, ${cart.product.quantity });">▲</a>
					</td>
				</tr>
				<tr>
					<td colspan="15" style="border-bottom: 2px solid #424242">
				</tr>
			</c:forEach>
		</table>
	</form>

	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">

				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<!-- 구매하기 -->
						<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"
							style="padding-top: 3px;"><a href="javascript:submitForm();">구매</a>
						</td>
						<td width="14" height="23"><img src="/images/ct_btnbg03.gif"
							width="14" height="23"></td>
						<td width="30"></td>

						<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"
							style="padding-top: 3px;">
							<a href="javascript:history.go(-1)">이전</a></td>
						<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
</body>
</html>