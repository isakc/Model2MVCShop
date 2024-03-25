<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>���� �����ȸ</title>

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
	})
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action",
				"/purchase/listPurchase").submit();
	}

	$(function() {
		$(".ct_list_pop td:nth-child(1) span").on("click", function() {
			self.location = "/purchase/getPurchase/" + $(this).data("tran-no");
		})
		
		$(".ct_list_pop td:nth-child(3) span").on("click", function() {
			self.location = "/user/getUser/" + $(this).text();
		})
		
		$(".ct_list_pop td:nth-child(11) span").on("click", function() {
			self.location = "/purchase/updateTranCode/"+$(this).data("tran-no")+"/3";
		})
		
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/purchase/listPurchase" method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">���� �����ȸ</td>
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
					<td colspan="11">��ü ${resultPage.total }�Ǽ�, ����
						${resultPage.now } ������</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ��ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">ȸ����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��ȭ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="no" value="0" />
				<c:set var="index" value="-1" />
				<c:forEach var="purchase" items="${list }">
					<c:set var="no" value="${no+1 }" />
					<c:set var="index" value="${index+1 }" />

					<tr class="ct_list_pop">
						<td align="center">
							<span class="clickButton" data-tran-no="${purchase.tranNo }">${no }</span>
						</td>
						<td></td>
						<td align="left">
						<span class="clickButton">${purchase.buyer.userId }</span>
						</td>
						<td></td>
						<td align="left">${purchase.buyer.userName }</td>
						<td></td>
						<td align="left">${purchase.receiverPhone }</td>
						<td></td>
						<td align="left">���� ${statusList[index] } ���� �Դϴ�.</td>
						<td></td>
						<td align="left">
						<c:if test="${isDeliveredList[index]}">
							<span data-tran-no="${purchase.tranNo }" class="clickButton">���ǵ���</span>
						</c:if>
						<td></td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<!-- ������ Navigator -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="${resultPage.now }" /> <c:import
							var="paging" url="../common/pageNavigator.jsp" scope="request" />
						${ paging }</td>
				</tr>
			</table>
			<!--  ������ Navigator �� -->
		</form>
	</div>
</body>
</html>