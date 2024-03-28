<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<title>��ǰ������ȸ</title>

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
        
        .sm-input{
        	width: 50px;
        }
        
        input[name='quantity']{
        	height:47px;
        	font-weight: bold;
        	font-size: 20px
        }
        
        img{
        	max-width: 100%;
        	height: auto;
        }
        
        .product-image {
      		transition: transform 0.3s ease;
    	}
    	
    	.product-image:hover {
      		transform: scale(1.2);
      		border:1px solid blue;
			box-shadow: 0 12px 15px 0 rgba(0, 0, 0, 0.24),
			0 17px 50px 0 rgba(0, 0, 0, 0.19);
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
				alert("�ִ���� �ʰ�");
			}
		} else {
			if (number > 1) {
				number = parseInt(number) - 1;
				quantity.val(number);
			} else {
				alert("1���� �۾��� ���� �����ϴ�");
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
		
		$("button[type='button']:contains('�ٷα���')").on("click", function() {
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();
		});
		
		$("button[type='button']:contains('��ٱ��� ���')").on("click", function() {
			var quantity = $("input[name='quantity']").val();
			var prodNo = $("input[name='prodNo']").val();
			var url = "/cart/addCart/" + prodNo + "/" + quantity;

			window.location.href = url;
		});
		
		$(".product-image").on("mouseover", function () {
			$("#mainImage").attr("src", $(this).attr("src"));
		})
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
			
			<div class="container mt-5">
  				<div class="row">
  					 <div class="col-md-2">
  					 	<ul class="list-group">
  					 		<c:forEach var="fileName" items="${product.fileNames }">
  					 		
						 	<li class="list-group-item">
						 		<img src = "/images/uploadFiles/${fileName }" alt="${product.prodName} ��ǰ �̹���" class="img-fluid product-image" />
						 	</li>
						 	
  					 		</c:forEach>
						</ul>
    					
    				</div><!-- ���� div -->
    				
    				<div class="col-md-4">
    					<img src ="/images/uploadFiles/${product.fileNames[0] }" alt="${product.prodName} ��ǰ �̹���" class="img-fluid" id="mainImage" />
    				</div><!-- ���� div -->
    				
    				<div class="col-md-6">
      					<h2 class="mb-4">${product.prodName }</h2>
      					<p class="text-muted mb-4">${product.prodDetail }</p>
      					<p class="lead font-weight-bold"><fmt:formatNumber value="${product.price}" type="currency" pattern="#,##0��" /></p>
      					
      					<div class="row">
      						<div class="col-md-3">
      							
      							<div class="row">
      								<div class="col-md-7" style="padding:0;">
	        							<input type="text" name="quantity" class="form-control text-center" min="1" value="1">
      								</div>
      								
      								<div class="col-md-5" style="padding:0">
      									<button type="button" class="btn btn-sm"><span class="glyphicon glyphicon-chevron-up"></span></button>
        								<button type="button" class="btn btn-sm"><span class="glyphicon glyphicon-chevron-down"></span></button>
      								</div>
      							</div>
        						
      						</div>
      						
      						<div class="col-md-3">
      							<button type="button" class="btn btn-default">��ٱ��� ���</button>
      						</div>
      						
      						<div class="col-md-2">
      							<button type="button" class="btn btn-primary">�ٷα���<span class="glyphicon glyphicon-chevron-right"></span></button>
      						</div>
      					</div><!-- ��ø �׸��� -->
      					
    				</div><!-- ���� div -->
  				</div><!-- �׸��� row -->
			</div>
			
			<%-- <table class="table table-striped table-bordered">
				<tr>
					<td>��ǰ��</td>
					<td>${product.prodName }</td>
				</tr>

				<tr>
					<td>��ǰ�̹���</td>
					<td>
						<c:forEach var="fileName" items="${product.fileNames }">
							<img src = "/images/uploadFiles/${fileName }" width="300" height="300"/>
						</c:forEach>
					</td>
				</tr>

				<tr>
					<td>��ǰ������</td>
					<td>${product.prodDetail }</td>
				</tr>

				<tr>
					<td>��������</td>
					<td>${product.manuDate }</td>
				</tr>

				<tr>
					<td>����</td>
					<td><fmt:formatNumber value="${product.price}" pattern="#,##0��" /></td>
				</tr>

				<tr>
					<td>����</td>
					<td>
						<button type="button" id="quantityMinus"><span class="glyphicon glyphicon-arrow-down"></span></button>
						<input type="text" id="quantity" name="quantity"
						class="sm-input" maxLength="13" value="1" />
						<button type="button" id="quantityPlus"><span class="glyphicon glyphicon-arrow-up"></span></button>
					</td>
				</tr>
			</table>

			<div class="container">
				<button type="button" class="btn btn-default">��ٱ���</button>
				<button type="button" class="btn btn-default">����</button>
				<button type="button" class="btn btn-primary">���</button>
			</div> --%>
		</form>
	</div>
</body>
</html>