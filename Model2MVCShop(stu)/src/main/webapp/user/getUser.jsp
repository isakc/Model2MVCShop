<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<head>
	<title>ȸ��������ȸ</title>

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
   	</style>
   	
	<script type="text/javascript">
	//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
	$(function() {
		$("button[type='button']:contains('Ȯ��')").on("click", function() {
			history.go(-1);
		});

		$("button[type='button']:contains('����')").on("click", function() {
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
				<td>���̵�</td>
				<td>${user.userId }</td>
			</tr>
			
			<tr>
				<td>�̸�</td>
				<td>${user.userName }</td>
			</tr>
			
			<tr>
				<td>�ּ�</td>
				<td>${user.addr }</td>
			</tr>
			
			<tr>
				<td>�޴���ȭ��ȣ</td>
				<td>${user.phone}</td>
			</tr>
			
			<tr>
				<td>�̸���</td>
				<td>${user.email }</td>
			</tr>
			
			<tr>
				<td>��������</td>
				<td>${user.regDate }</td>
			</tr>
		</table>
	</div>
	
	<div class="container">
		<button type="button" class="btn btn-default">����</button>
		<button type="button" class="btn btn-primary">Ȯ��</button>
	</div>

</body>
</html>