<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�
	
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
		$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
	}
	
	$(function () {
		$(".ct_list_pop td:nth-child(5)").on("click", function() {
			var prodNo = $(this).data("prod-no");
			
			self.location = "/product/getProduct/"+prodNo+"/${menu}";
		});
		
		$(".ct_list_pop td:nth-child(11)").on("click", function() {
			var prodNo = $(this).data("prod-no");
			
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/getOrderDetail/"+prodNo);
		});
	})

	$(function () {
		$("td.ct_list_b:contains('����')>span:eq(0)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceASC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
		
		$("td.ct_list_b:contains('����')>span:eq(1)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
	})
	
	$(function () {
		$("select[name=categoryNo]").on("change", function () {
			$("#currentPage").val(1);
			$('input[name="searchCondition"]').val("");
			$('input[name="searchKeyword"]').val("");

			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
	})
	
	$(function () {
		$("td.ct_btn01:contains('�˻�')").on("click", function () {
			getList(${resultPage.now });
		})
	})

	$(function() {
		$("select[name=searchCondition]").on("change", function() {
			var searchCondition = $('select[name=searchCondition]');
			var searchKeyword = $('input[name=searchKeyword]');
			var selectedValue = searchCondition.val();

			if (selectedValue == '2') {
				searchKeyword.val(0);
				searchKeyword.css("width", "90px");

				searchKeyword.after('<input name="searchKeyword2"/>');
				$('input[name=searchKeyword2]').css({
					"width" : "90px",
					"height" : "19px"
				});
			} else {
				searchKeyword.val("");
				searchKeyword.css("width", "200px");
				$("input[name=searchKeyword2]").remove();
			}
		});
	})
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form>

			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
					</td>
					
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
									<c:set var="menuOption" value="${menu == 'manage' ? '����' : '�����ȸ' }" />
									��ǰ ${menuOption }
								</td>
							</tr>
						</table>
					</td>
					
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td align="right">
 						<!--<select id="searchCondition" name="searchCondition" class="ct_input_g" onchange="changeInputType()" style="width: 80px"> -->
						<select id="searchCondition" name="searchCondition" class="ct_input_g" style="width: 80px">
							<option value="" selected disabled hidden>����</option>
							<c:if test="${user.role == 'admin' && user!=null}">
								<option value="0" ${search.searchCondition == '0' ? 'selected' : ''}>��ǰ��ȣ</option>
							</c:if>
							<option value="1" ${search.searchCondition == '1' ? 'selected' : ''}>��ǰ��</option>
							<option value="2" ${search.searchCondition == '2' ? 'selected' : ''}>��ǰ����</option>
						</select>
						
						<c:choose>
							<c:when test="${search.searchCondition == '2' }">
								<input type="text" id="searchKeyword" name="searchKeyword"
									class="ct_input_g" style="width: 90px; height: 19px"
									value="${searchPrice }" />
								<input type="text" name="searchKeyword2" class="ct_input_g"
									style="width: 90px; height: 19px" value="${searchPrice2 }" />
							</c:when>

							<c:otherwise>
								<input type="text" id="searchKeyword" name="searchKeyword"
									class="ct_input_g" style="width: 200px; height: 19px"
									value="${search.searchKeyword }" />
							</c:otherwise>
						</c:choose>
					</td>
					
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23">
								</td>
								
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<span class="clickButton">�˻�</span>
								</td>
								
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<c:choose>
					<c:when test="${resultPage.total==0 }">
						<tr>
							<td class="ct_list_b">�ش��ǰ ����</td>
						<tr/>
					</c:when>
					
					<c:otherwise>
						<tr>
							<td colspan="11">��ü ${resultPage.total} �Ǽ�, ����
								${resultPage.now } ������</td>
						</tr>
						
						<tr>
							<td class="ct_list_b" width="100">No</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">�̹���</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="350">��ǰ��</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="150">����
								<span class="clickButton">��</span>
								<span class="clickButton">��</span>
							</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b">ī�װ�
							<select name="categoryNo">
									<option value="-1" style="font-weight: 700">��ü</option>
									<c:forEach var="category" items="${categoryList}">
										<c:choose>
											<c:when test="${category.parentCategoryNo == 0 }">
												<option value="${category.categoryNo}"
													${category.categoryNo == selectedCategoryNo ? 'selected' : ''}
													style="font-weight: 700">${category.categoryName }</option>
											</c:when>

											<c:otherwise>
												<option align="center" value="${category.categoryNo}"
													${category.categoryNo == selectedCategoryNo ? 'selected' : ''}>${category.categoryName }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
							</select>
							</td>
							<td class="ct_line02"></td>
							<c:choose>
								<c:when test="${menu == 'manage' }">
									<td class="ct_list_b">�����Ȳ</td>
								</c:when>
								<c:otherwise>
									<td class="ct_list_b">���� ����</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<td colspan="11" bgcolor="808285" height="1"></td>
						</tr>

						<c:set var="i" value="0" />
						<c:forEach var="product" items="${list }">
							<c:set var="i" value="${i+1 }" />
							<tr class="ct_list_pop">
								<td align="center">${i }</td>
								<td></td>
								<td align="center">
									<%-- <img src="/images/uploadFiles/${product.fileName }" style="width: 100px; height: 100px;" /> --%>
								</td>
								<td></td>
								<td align="center" data-prod-no="${product.prodNo }">
									<span class="clickButton">${product.prodName }</span>
								</td>
								<td></td>
								<td align="center"><fmt:formatNumber value="${product.price}" pattern="#,##0��" /></td>
								<td></td>
								<td align="center">${product.category.categoryName }</td>
								<td></td>
								<td align="center" data-prod-no="${product.prodNo }"><c:choose>
										<c:when test="${menu == 'manage' }">
											<span class="clickButton">�ǸŸ��</span>
										</c:when>
										<c:otherwise>
				${product.quantity } ��
			</c:otherwise>
									</c:choose></td>
							</tr>

							<tr>
								<td colspan="11" bgcolor="D6D7D6" height="1"></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>

			<!-- ������ Navigator -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }" />
						<input type="hidden" id="sorter" name="sorter" value="${sorter }" />
						<input type="hidden" name="preSearchCondition" value="${search.searchCondition }" />
						<input type="hidden" name="preSearchKeyword" value="${search.searchKeyword }" />
						<c:import var="paging" url="../common/pageNavigator.jsp" scope="request" />
						${ paging }
					</td>
				</tr>
			</table>
			<!--  ������ Navigator �� -->

		</form>

	</div>
</body>
</html>