<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">

<head>
	<title>��ǰ �����ȸ</title>

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
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
	}
	
	$(function () {
		$("tbody td:nth-child(3)").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).find("a").attr("href", "/product/getProduct/"+prodNo+"/${menu}");
		});
		
		$("tbody td:nth-child(6):contains('�ǸŸ��')").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).find("a").attr("href", "/product/getOrderDetail/"+prodNo);
		});
		
		$(".list td > span:eq(0)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceASC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
		
		$(".list td > span:eq(1)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
		
		$("select[name=categoryNo]").on("change", function () {
			$("#currentPage").val(1);
			$('input[name="searchCondition"]').val("");
			$('input[name="searchKeyword"]').val("");

			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		})
		
		$("button[type='buutton']:contains('�˻�')").on("click", function () {
			getList(${resultPage.now });
		})
		
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

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
		<form>
			<div class="row">
				<div class="col text-right">
					<select id="searchCondition" name="searchCondition">
							<option value="" selected disabled hidden>����</option>
							<c:if test="${user.role == 'admin' && user!=null}">
								<option value="0" ${search.searchCondition == '0' ? 'selected' : ''}>��ǰ��ȣ</option>
							</c:if>
							<option value="1" ${search.searchCondition == '1' ? 'selected' : ''}>��ǰ��</option>
							<option value="2" ${search.searchCondition == '2' ? 'selected' : ''}>��ǰ����</option>
						</select>
					
					<c:choose>
						<c:when test="${search.searchCondition == '2' }">
							<input type="text" id="searchKeyword" name="searchKeyword" value="${searchPrice }" />
							<input type="text" name="searchKeyword2" value="${searchPrice2 }" />
						</c:when>
						
						<c:otherwise>
							<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" />
						</c:otherwise>
					</c:choose>
						
					<button type="submit" class="btn btn-success">�˻�</button>
				</div>
			</div><!-- row 1 end-->

			<div class="row">
			
				<c:choose>
					<c:when test="${resultPage.total==0 }">
						<span>�ش��ǰ ����</span>
					</c:when>

					<c:otherwise>
						<span>��ü ${resultPage.total }�Ǽ�, ���� ${resultPage.now } ������</span>

						<table class="table table-striped table-bordered list">
							<thead>
								<tr>
									<td>No</td>
									<td>�̹���</td>
									<td>��ǰ��</td>
									<td>���� <span>��</span> <span>��</span></td>
									<td>ī�װ�
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

									<c:choose>
										<c:when test="${menu == 'manage' }">
											<td>�����Ȳ</td>
										</c:when>

										<c:otherwise>
											<td>���� ����</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</thead>

							<tbody>
								<c:set var="i" value="0" />
								<c:forEach var="product" items="${list }">
									<c:set var="i" value="${i+1 }" />
									<tr>
										<td>${i }</td>
										<td>
											��ƾ���
											<%-- <img src="/images/uploadFiles/${product.fileName }" style="width: 100px; height: 100px;" /> --%>
										</td>
										<td data-prod-no="${product.prodNo }"><a href="">${product.prodName }</a></td>
										<td><fmt:formatNumber value="${product.price}" pattern="#,##0��" /></td>
										<td>${product.category.categoryName }</td>
										<td data-prod-no="${product.prodNo }">
											<c:choose>
												<c:when test="${menu == 'manage' }">
													<a href="">�ǸŸ��</a>
												</c:when>
												
												<c:otherwise>
													${product.quantity } ��
												</c:otherwise>
											</c:choose>
										</td>
									</tr>

								</c:forEach>
								
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- ������ Navigator -->
			<div class="row text-center">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }" />
				<input type="hidden" id="sorter" name="sorter" value="${sorter }" />
				<input type="hidden" name="preSearchCondition" value="${search.searchCondition }" />
				<input type="hidden" name="preSearchKeyword" value="${search.searchKeyword }" />
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
			<!--  ������ Navigator �� -->
		</form>

	</div>
</body>
</html>