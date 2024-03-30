<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
	<title>회원 정보 수정</title>

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
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	function fncUpdateUser() {
		// Form 유효성 검증
		//var name=document.detailForm.userName.value;
		var name = $("input[name='userName']").val();

		if (name == null || name.length < 1) {
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}

		var value = "";
		if ($("input[name='phone2']").val() != ""
				&& $("input[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}
		$("input:hidden[name='phone']").val(value);

		$("form").attr("method", "POST").attr("action", "/user/updateUser")
				.submit();
	}//===========================================//

	//==> 추가된부분 : "이메일" 유효성Check  Event 처리 및 연결
	$(function() {
		$("input[name='email']").on("change", function() {

							var email = $("input[name='email']").val();

							if (email != "" && (email.indexOf('@') < 1
									|| email.indexOf('.') == -1)) {
								alert("이메일 형식이 아닙니다.");
							}
						});
	});
	
	//==> 추가된부분 : "수정"  Event 연결
	$(function() {
		$("button[type='button']:contains('수정')").on("click", function() {
			fncUpdateUser();
		});
	});
	
	//==> 추가된부분 : "취소"  Event 연결 및 처리
	$(function() {
		$("button[type='button']:contains('취소')").on("click", function() {
			history.go(-1);
		});
	});
</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<form>
			<input type="hidden" name="userId" value="${user.userId }">

			<table class="table table-striped table-bordered">
				<tr>
					<td>아이디</td>
					<td>${user.userId }</td>
				</tr>

				<tr>
					<td>이름</td>
					<td>
					<input type="text" name="userName" value="${user.userName }" />
					</td>
				</tr>

				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="${user.addr }" /></td>
				</tr>

				<tr>
					<td>휴대전화번호</td>
					<td>
					<select name="phone1" onChange="document.detailForm.phone2.focus();">
							<option value="010"
								${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  }>010</option>
							<option value="011"
								${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  }>011</option>
							<option value="016"
								${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  }>016</option>
							<option value="018"
								${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  }>018</option>
							<option value="019"
								${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  }>019</option>
					</select>
					
					<input type="text" name="phone2" value="${ ! empty user.phone2 ? user.phone2 : ''}"> - 
					<input type="text" name="phone3" value="${ ! empty user.phone3 ? user.phone3 : ''}">
					<input type="hidden" name="phone"/>
					</td>
				</tr>

				<tr>
					<td>이메일</td>
					<td>
						<input type="text" name="email" value="${user.email }"/>
					</td>
				</tr>
			</table>
			
			<div class="container">
				<button type="button" class="btn btn-default">수정</button>
				<button type="button" class="btn btn-primary">취소</button>			
			</div>
		</form>
	</div>

</body>
</html>