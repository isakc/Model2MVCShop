<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>상품등록</title>

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

	function fncAddProduct() {
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if (name == null || name.length < 1) {
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}

		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data").submit();
	}

	$(function() {
		$("button[type='button']:contains('등록')").on("click", function() {
			fncAddProduct();
		});
		
		$("button[type='button']:contains('취소')").on("click", function() {
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
    	<h1 class="text-center">상품정보를 입력해주세요</h1>
		<form name="detailForm" class="form-horizontal">
			<div class="row">
                <div class="col-sm-6 col-sm-offset-3">
                	<div class="form-group">
                	<c:choose>
                		<c:when test="${result == null }">
                			<input type="text" name="prodName" maxLength="20" placeholder="상품명" class="form-control"/>
                		</c:when>
                		
                		<c:otherwise>
                			${result.prodName}
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    <c:choose>
                		<c:when test="${result == null }">
                			<input type="text" name="prodDetail" maxLength="10" minLength="6" placeholder="상세정보" class="form-control"/>
                		</c:when>
                		
                		<c:otherwise>
                			${result.prodDetail}
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    <c:choose>
                		<c:when test="${result == null }">
                			<input type="text" name="manuDate" readonly="readonly" maxLength="10" minLength="6" placeholder="제조 일자" class="form-control"/>
                        	<img src="../images/ct_icon_date.gif"/>
                		</c:when>
                		
                		<c:otherwise>
                			${result.manuDate}
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    <c:choose>
                		<c:when test="${result == null }">
                			<input type="text" name="price" maxLength="10" placeholder="가격" class="form-control">
                		</c:when>
                		
                		<c:otherwise>
                			${result.price}
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    <c:choose>
                		<c:when test="${result == null }">
                			<span class="glyphicon glyphicon-open-file">
                			<input type="file" name="uploads" multiple="multiple" style="display:none"/>
                			</span>
                		</c:when>
                		
                		<c:otherwise>
                			<c:forEach var="fileName" items="${result.fileNames }">
								<img src="/images/uploadFiles/${fileName}"/>
							</c:forEach>
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    <c:choose>
                		<c:when test="${result == null }">
                			<input type="text" name="quantity" maxLength="13" placeholder="수량" class="form-control"/>
                		</c:when>
                		
                		<c:otherwise>
                			${result.quantity}
                		</c:otherwise>
                    </c:choose>
                    </div>
                    
                    <div class="form-group">
                    	<c:choose>
							<c:when test="${result == null }">
								<select name="categoryNo">
									<option value="" selected disabled hidden>선택</option>
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
								</select>
						</c:when>

						<c:otherwise>
							<td>${result.category.categoryName}</td>
						</c:otherwise>
						</c:choose>
                    </div>
                </div><!-- col-sm-6 -->
			</div><!-- row end -->
			
			<div id="container">
				<button type="button" class="btn btn-default">등록</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</form>
	</div>
</body>
</html>