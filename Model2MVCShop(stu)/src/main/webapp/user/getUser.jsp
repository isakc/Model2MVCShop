<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>회원 정보조회</title>

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
	//==> 추가된부분 : "수정" "확인"  Event 연결 및 처리
	$(function() {
		$("button[type='button']:contains('확인')").on("click", function() {
			history.go(-1);
		});

		$("button[type='button']:contains('수정')").on("click", function() {
			self.location = "/user/updateUser/${user.userId }"
		});
		
	});
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<table class="table table-striped table-bordered">
			<tr>
				<td>아이디</td>
				<td>${user.userId }</td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td>${user.userName }</td>
			</tr>
			
			<tr>
				<td>주소</td>
				<td>${user.addr1 } ${user.addr2 } ${user.addr3 }</td>
			</tr>
			
			<tr>
				<td>휴대전화번호</td>
				<td>${user.phone}</td>
			</tr>
			
			<tr>
				<td>이메일</td>
				<td>${user.email }</td>
			</tr>
			
			<tr>
				<td>가입일자</td>
				<td>${user.regDate }</td>
			</tr>
		</table>
	</div>
	
	<div class="container">
		<button type="button" class="btn btn-default">수정</button>
		<button type="button" class="btn btn-primary">확인</button>
	</div>

</body>
</html>