<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<table width="100%" height="37" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
					width="15" height="37"></td>
				<td background="/images/ct_ttl_img02.gif" width="100%"
					style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">구매 목록조회</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
					width="12" height="37"></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>
				<td class="ct_list_b" width="150">회원ID</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">회원명</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">전화번호</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">배송현황</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">주소</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">수량</td>
			</tr>
			<tr>
				<td colspan="11" bgcolor="808285" height="1"></td>
			</tr>

			<c:set var="index" value="-1" />
			<c:forEach var="orderDetail" items="${list }">
				<c:set var="index" value="${index+1 }" />

				<tr class="ct_list_pop">
					<td align="center"><a
						href="/user/getUser/${orderDetail.transaction.buyer.userId }">${orderDetail.transaction.buyer.userId }</a>
					</td>
					<td></td>
					<td align="center">${orderDetail.transaction.receiverName }</td>
					<td></td>
					<td align="center">${orderDetail.transaction.receiverPhone }</td>
					<td></td>
					<td align="center">${statusList[index] } <c:if
							test="${orderDetail.transaction.tranCode < 2 }">
							<a
								href="/purchase/updateTranCode/${orderDetail.transaction.tranNo }/2">배송하기</a>
						</c:if>
					<td></td>

					<td align="center">${orderDetail.transaction.divyAddr }</td>
					<td></td>
					<td align="center">${orderDetail.quantity }</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>