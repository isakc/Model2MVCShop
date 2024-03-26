<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>장바구니 리스트</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

	$(function() {
		$(".clickButton").on("mouseenter", function() {
			$(this).css("cursor", "pointer");
			$(this).css("color", "blue");
		}).on("mouseleave", function() {
			$(this).css("color", "black");
		})
		
		$("td.ct_write01:contains('삭제') span").on("click", function () {
			self.location = "/cart/deleteCart/" + $(this).data("cart-no");
		})
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

	$(function() {
		$("td.ct_write01>button:even").on("click", function() {
			updateQuantity('minus', $(this).next());
		});

		$("td.ct_write01>button:odd").on("click", function() {
			updateQuantity('plus', $(this).prev());
		});
	})

	$(function() {
		$("td.ct_btn01:contains('구매')").on(
				"click",
				function() {
					$("form").attr("method", "POST").attr("action",
							"/purchase/addPurchaseView").submit();
				})
	})

	$(function() {
		$("td.ct_btn01:contains('이전')").on("click", function() {
			history.go(-1);
		})
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<form>
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
					<%-- <img src="/images/uploadFiles/${cart.product.fileName }" width="100" height="100" /> --%>
					<span data-cart-no="${cart.cartNo }" class="clickButton">삭제</span>
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
						<button type="button" id="quantityPlus">▼</button>
						<input type="text" id="quantity" name="quantity" class="ct_input_g" style="width: 30px; text-align: center;" value="${cart.quantity }" 
									data-prod-no="${cart.product.prodNo }" data-cart-no="${cart.cartNo }" data-max-quantity="${cart.product.quantity }"/>
						<button type="button" id="quantityPlus">▲</button>
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
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23" />
						</td>
						
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<span class="clickButton">구매</span>
						</td>
						
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
						
						<td width="30"></td>

						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23" />
						</td>
						
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<span class="clickButton">이전</span>
						</td>
							
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>
</body>
</html>