<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>��ǰ���</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link href="/css/animate.min.css" rel="stylesheet">
  	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
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

	function fncAddProduct() {
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if (name == null || name.length < 1) {
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	}

	$(function() {
		$("button[type='button']:contains('���')").on("click", function() {
			fncAddProduct();
		});
		
		$("button[type='button']:contains('���')").on("click", function() {
			$("form")[0].reset();
		});
		
		$("input[name='manuDate']").next().on("click",function() {
			show_calendar('document.detailForm.manuDate',$('input[name=manuDate]').value);
		});
	});
	
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<form name="detailForm">
			<div class="row">
			<table class="table table-striped table-bordered">
				<tr>
					<td>
						��ǰ��
					</td>
					<c:choose>
						<c:when test="${result == null }">
							<td>
								<input type="text" name="prodName" maxLength="20">
							</td>
						</c:when>

						<c:otherwise>
							<td>${result.prodName}</td>
						</c:otherwise>
					</c:choose>

				</tr>

				<tr>
					<td>
						��ǰ������ 
					</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td>
								<input type="text" name="prodDetail" maxLength="10" minLength="6" />
							</td>
						</c:when>

						<c:otherwise>
							<td>${result.prodDetail}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td>��������</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td>
								<input type="text" name="manuDate" readonly="readonly" maxLength="10" minLength="6" />
								<img src="../images/ct_icon_date.gif"/>
							</td>
						</c:when>

						<c:otherwise>
							<td>${result.manuDate}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td>����</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td>
							<input type="text" name="price" maxLength="10">&nbsp;��</td>
						</c:when>

						<c:otherwise>
							<td>${result.price}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td>��ǰ�̹���</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td>
								<input type="file" name="uploads" multiple="multiple" />
							</td>
						</c:when>

						<c:otherwise>
							<td>
								<c:forEach var="fileName" items="${result.fileNames }">
									<img src="/images/uploadFiles/${fileName}"/>
								</c:forEach>
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td>����</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td><input type="text" name="quantity" maxLength="13" /></td>
						</c:when>

						<c:otherwise>
							<td>${result.quantity}</td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td>ī�װ�</td>
					
					<c:choose>
						<c:when test="${result == null }">
							<td><select name="categoryNo">
									<option value="" selected disabled hidden>����</option>
									<c:forEach var="category" items="${categoryList}">
										<c:choose>
											<c:when test="${category.parentCategoryNo == 0 }">
												<optgroup label="${category.categoryName }">
											</c:when>

											<c:otherwise>
												<option align="center" value="${category.categoryNo}">${category.categoryName }</option>
											</c:otherwise>
										</c:choose>
										</optgroup>
									</c:forEach>
							</select></td>
						</c:when>

						<c:otherwise>
							<td>${result.category.categoryName}</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</table>
			</div>
			
			<div id="row">
				<button type="button" class="btn btn-default">���</button>
				<button type="button" class="btn btn-primary">���</button>
			</div>
		</form>
	</div>
</body>
</html>