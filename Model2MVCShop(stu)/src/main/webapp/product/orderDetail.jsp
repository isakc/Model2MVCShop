<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">

<head>
	<title>회원정보조회</title>

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
		
	</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="container">
		<table class="table table-striped table-bordered list">
			<tr>
				<td>회원ID</td>
				<td>회원명</td>
				<td>전화번호</td>
				<td>배송현황</td>
				<td>주소</td>
				<td>수량</td>
			</tr>

			<c:set var="index" value="-1" />
			<c:forEach var="orderDetail" items="${list }">
				<c:set var="index" value="${index+1 }" />

				<tr>
					<td>
						<a href="/user/getUser/${orderDetail.transaction.buyer.userId }">${orderDetail.transaction.buyer.userId }</a>
					</td>
					<td>${orderDetail.transaction.receiverName }</td>
					<td>${orderDetail.transaction.receiverPhone }</td>
					<td>${statusList[index] }
						<c:if test="${orderDetail.transaction.tranCode < 2 }">
							<a href="/purchase/updateTranCode/${orderDetail.transaction.tranNo }/2">배송하기</a>
						</c:if>
					<td>${orderDetail.transaction.divyAddr }</td>
					<td>${orderDetail.quantity }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>