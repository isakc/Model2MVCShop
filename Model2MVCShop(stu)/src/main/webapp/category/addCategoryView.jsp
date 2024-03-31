<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>카테고리추가</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
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
	
	$(function() {
		$("button[type='button']:contains('등록')").on("click",function() {
			$("form").attr("method", "POST").attr("action","/category/addCategory").submit();
		})
	})

	$(function() {
		$("button[type='button']:contains('취소')").on("click", function() {
			$("form")[0].reset();
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
			<table class="table table-striped table-bordered">
				<tr>
					<td>카테고리명</td>
					<td>
						<input type="text" name="categoryName"/>
					</td>
				</tr>
				
				<tr>
					<td>상위 카테고리</td>
					<td>
						<select name="parentCategoryNo">
							<option value="0">상위 카테고리</option>
							<c:forEach var="category" items="${categoryList }">
								<c:if test="${category.parentCategoryNo == 0 }">
									<option value="${category.categoryNo}">${category.categoryName }</option>
								</c:if>
							</c:forEach>
						</select>
						
					</td>
				</tr>
			</table>
			
			<div class="container">
				<button type="button" class="btn btn-default">등록</button>
				<button type="button" class="btn btn-primary">취소</button>			
			</div>
		</form>
	</div>
</body>
</html>