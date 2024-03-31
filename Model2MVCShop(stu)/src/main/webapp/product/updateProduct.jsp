<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>상품정보수정</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
	<script type="text/javascript" src="/javascript/calendar.js"></script>
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
		var detail = $("textArea[name='prodDetail']").val();
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
	
	function setImageFromFile(input) {
		
	    if (input.files) {
	    	for(let i=0; i<input.files.length; i++){
	    		var reader = new FileReader();
		        reader.onload = function (e) {
		        	let img = $("<img />");
		            $(img).attr('src', e.target.result);
	                $('#preview').append(img);
		        }
		        reader.readAsDataURL(input.files[i]);
	    	}
	    }
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
		
		$("input[name='uploads']").change(function() {
			$("#preview").empty();
		    setImageFromFile(this);
		});
	})
	
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
    	<h1 class="text-center">상품정보를 입력해주세요</h1>
			<div class="row">
                <div class="col-sm-6 col-sm-offset-3">
				<form name="detailForm" class="form-horizontal">
					<input type="hidden" name="prodNo" value="${product.prodNo }" />
				
                	<div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="fas fa-tag"></i></span>
                    		<input type="text" name="prodName" maxLength="20" placeholder="상품명" class="form-control input-lg" value="${product.prodName }"/>
    					</div>
                    </div>
                    
                    <div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="fas fa-info-circle"></i></span>
                    		<textarea class="form-control input-lg" rows="3" name="prodDetail" placeholder="상세정보" >${product.prodDetail }</textarea>
    					</div>
                    </div>
                    
                    <div class="form-group">
                		<div class="input-group">
                    		<span class="input-group-addon"><i class="far fa-calendar-alt"></i></span>
                    		<input type="text" name="manuDate" readonly="readonly" maxLength="10" minLength="6"
                    		readonly="readonly" placeholder="제조 일자" class="form-control input-lg" value="${product.manuDate }"/>
    					</div>
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-6" style="padding-left:0;">
                			<div class="input-group">
                    			<span class="input-group-addon"><i class="fas fa-money-bill-alt"></i></span>
                    			<input type="text" name="price" maxLength="10" placeholder="가격" class="form-control input-lg" value="${product.price }"/>
    						</div>
                    	</div>
                    
                    	<div class="col-sm-6">
                			<div class="input-group">
                    			<span class="input-group-addon"><i class="fas fa-warehouse"></i></span>
                    			<input type="text" name="quantity" maxLength="13" placeholder="수량" class="form-control input-lg" value="${product.quantity }"/>
    						</div>
                    	</div>
                    </div>
                    
                    <div class="form-group">
                    	<select name="categoryNo" class="form-control input-lg">
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
					</select>
                    </div>
                    
                    <div class="form-group">
                    	<div class="col-sm-7">
                			<div class="input-group">
                				<label>
                					<i class="fas fa-image" style="font-size: 90px;"></i>
                          			<input type="file" multiple="multiple" name="uploads" accept="image/*" style="display:none"/>
                      			</label>
                			</div>
    					</div>
                    </div>
                    
                    <div class="form-group" id="preview">
                    	<c:forEach var="fileName" items="${product.fileNames }">
							<img src = "/images/uploadFiles/${fileName }" width="300" height="300"/>
						</c:forEach>
                    </div>
                    
				</form>
                </div><!-- col-sm-6 -->
			</div><!-- row end -->
			
		<div class="container text-center">
			<button type="button" class="btn btn-primary">수정</button>
			<button type="button" class="btn btn-default">리셋</button>
		</div>
	</div>
	
	<%-- <div class="container">
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
						<img src="/images/ct_icon_date.gif"/>
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
						<c:forEach var="fileName" items="${product.fileNames }">
							<img src = "/images/uploadFiles/${fileName }" width="300" height="300"/>
							<input type="file" name="uploads" multiple="multiple" value="${fileName }"/>
						</c:forEach>
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
			
			<div class="container">
				<button type="button" class="btn btn-default">수정</button>
				<button type="button" class="btn btn-primary">취소</button>
			</div>
		</form>

	</div> --%>
</body>
</html>