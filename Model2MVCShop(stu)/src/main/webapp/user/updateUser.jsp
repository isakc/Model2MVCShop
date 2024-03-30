<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
	<title>ȸ�� ���� ����</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="../common/link.jsp"/>
  	
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
	//=====����Code �ּ� ó�� ��  jQuery ���� ======//
	function fncUpdateUser() {
		// Form ��ȿ�� ����
		//var name=document.detailForm.userName.value;
		var name = $("input[name='userName']").val();

		if (name == null || name.length < 1) {
			alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
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

	//==> �߰��Ⱥκ� : "�̸���" ��ȿ��Check  Event ó�� �� ����
	$(function() {
		$("input[name='email']").on("change", function() {

							var email = $("input[name='email']").val();

							if (email != "" && (email.indexOf('@') < 1
									|| email.indexOf('.') == -1)) {
								alert("�̸��� ������ �ƴմϴ�.");
							}
						});
	});
	
	//==> �߰��Ⱥκ� : "����"  Event ����
	$(function() {
		$("button[type='button']:contains('����')").on("click", function() {
			fncUpdateUser();
		});
	});
	
	//==> �߰��Ⱥκ� : "���"  Event ���� �� ó��
	$(function() {
		$("button[type='button']:contains('���')").on("click", function() {
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
					<td>���̵�</td>
					<td>${user.userId }</td>
				</tr>

				<tr>
					<td>�̸�</td>
					<td>
					<input type="text" name="userName" value="${user.userName }" />
					</td>
				</tr>

				<tr>
					<td>�ּ�</td>
					<td><input type="text" name="addr" value="${user.addr }" /></td>
				</tr>

				<tr>
					<td>�޴���ȭ��ȣ</td>
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
					<td>�̸���</td>
					<td>
						<input type="text" name="email" value="${user.email }"/>
					</td>
				</tr>
			</table>
			
			<div class="container">
				<button type="button" class="btn btn-default">����</button>
				<button type="button" class="btn btn-primary">���</button>			
			</div>
		</form>
	</div>

</body>
</html>