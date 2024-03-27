<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>상품정보수정</title>

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
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">

	function fncUpdateProduct(){
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
	
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		
		$('form').attr("method", "POST").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
	}

	$(function () {
		$("button[type='button']:contains('수정')").on("click", function () {
			fncUpdateProduct();
		});
		
		$("button[type='button']:contains('취소')").on("click", function () {
			history.go(-1);
		});
		
		$("input[name='manuDate']").next().on("click",function() {
			show_calendar('document.detailForm.manuDate',$('input[name=manuDate]').value);
		});
	})
	
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<form name="detailForm">
			<input type="hidden" name="prodNo" value="${product.prodNo }" />

			<table class="table table-striped table-bordered">
				<tr>
					<td>상품명</td>
					<td><input type="text" name="prodName" maxLength="20" value="${product.prodName }"></td>
				</tr>

				<tr>
					<td>상품상세정보</td>
					<td><input type="text" name="prodDetail" value="${product.prodDetail }" maxLength="10" minLength="6"></td>
				</tr>

				<tr>
					<td>제조일자</td>
					<td>
						<input type="text" name="manuDate" readonly="readonly" maxLength="10" minLength="6" />
						<img class="clickButton" src="../images/ct_icon_date.gif"/>
					</td>
				</tr>

				<tr>
					<td>가격</td>
					<td><input type="text" name="price" value="${product.price }"
						maxLength="50" />&nbsp;원</td>
				</tr>

				<tr>
					<td>상품이미지</td>
					<td>
						<%-- <input	type="file" name="upload" class="ct_input_g" 
						style="width: 200px; height: 19px" maxLength="13" value="${product.fileName }"/> --%>
						사아아진
					</td>
				</tr>

				<tr>
					<td>카테고리</td>
					<td><select name="categoryNo">
							<option value="" selected disabled hidden>선택</option>
							<c:forEach var="category" items="${categoryList}">
								<c:choose>
									<c:when test="${category.parentCategoryNo == 0 }">
										<optgroup label="${category.categoryName }">
									</c:when>

									<c:otherwise>
										<option align="center" value="${category.categoryNo}"
											${category.categoryNo == product.category.categoryNo ? 'selected' : ''}>${category.categoryName }
										</option>
									</c:otherwise>

								</c:choose>
								</optgroup>
							</c:forEach>
					</select></td>
				</tr>
			</table>
			
			<div class="row">
				<button type="button" class="btn btn-default">등록</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</form>

	</div>
</body>
</html>