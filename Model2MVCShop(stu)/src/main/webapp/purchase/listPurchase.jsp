<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">

<head>
	<title>구매 목록조회</title>

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
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
	}

	$(function() {
		$(".ct_list_pop td:nth-child(1) span").on("click", function() {
			self.location = "/purchase/getPurchase/" + $(this).data("tran-no");
		})
		
		$(".ct_list_pop td:nth-child(3) span").on("click", function() {
			self.location = "/user/getUser/" + $(this).text();
		})
		
		$("table tr:not(:first) td:nth-child(1) a").on("click", function() {
			console.log($(this).data("tran-no"));
			$(this).attr("href", "/purchase/getPurchase/"+$(this).data("tran-no"));
		})
		
		$("table tr:not(:first) td:nth-child(2) a").on("click", function() {
			
			$(this).attr("href", "/user/getUser/"+$(this).text().trim());
		})
		
		$("table tr:not(:first) td:nth-child(6) a").on("click", function() {
			
			$(this).attr("href", "/purchase/updateTranCode/"+$(this).data("tran-no")+"/3");
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
			<div class="row">
				<span>전체 ${resultPage.total }건수, 현재 ${resultPage.now } 페이지</span>
				
				<table class="table table-striped table-bordered">
				
				<tr>
					<td>No</td>
					<td>회원ID</td>
					<td>회원명</td>
					<td>전화번호</td>
					<td>배송현황</td>
					<td>정보수정</td>
				</tr>

				<c:set var="no" value="0" />
				<c:set var="index" value="-1" />
				<c:forEach var="purchase" items="${list }">
					<c:set var="no" value="${no+1 }" />
					<c:set var="index" value="${index+1 }" />

					<tr>
						<td>
							<a href="" data-tran-no="${purchase.tranNo }">${no }</a>
						</td>
						<td>
							<a href="">${purchase.buyer.userId}</a>
						</td>
						<td>${purchase.buyer.userName }</td>
						<td>${purchase.receiverPhone }</td>
						<td>현재 ${statusList[index] } 상태 입니다.</td>
						<td>
						<c:if test="${isDeliveredList[index]}">
							<a href="" data-tran-no="${purchase.tranNo }">물건도착</a>
						</c:if>
					</tr>
				</c:forEach>
			</table>
			</div><!-- row 1 end -->
		
			<div class="row">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }"/>
				<c:import var="paging" url="../common/pageNavigator.jsp" scope="request"/>
				${ paging }
			</div>
		
		</form>
	</div>
</body>
</html>