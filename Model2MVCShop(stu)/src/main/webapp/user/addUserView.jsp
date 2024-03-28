<%@ page contentType="text/html; charset=euc-kr" %>

<html lang="ko">

<head>
	<title>ȸ������</title>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
	<link href="/css/animate.min.css" rel="stylesheet"/>
  	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet"/>
  	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �����ϱ� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">
	
	function fncAddUser() {
		// Form ��ȿ�� ����

		var id = $("input[name='userId']").val();
		var pw = $("input[name='password']").val();
		var pw_confirm = $("input[name='password2']").val();
		var name = $("input[name='userName']").val();

		if (id == null || id.length < 1) {
			alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (pw == null || pw.length < 1) {
			alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (pw_confirm == null || pw_confirm.length < 1) {
			alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (name == null || name.length < 1) {
			alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		if (pw != pw_confirm) {
			alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
			$("input:text[name='password2']").focus();
			return;
		}

		var value = "";
		if ($("input:text[name='phone2']").val() != ""
				&& $("input:text[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}

		$("input:hidden[name='phone']").val(value);

		$("form").attr("method", "POST").attr("action", "/user/addUser").submit();
	}

	//==> �����ϱ�Ⱥκ� : "���"  Event ó�� ��  ����
	$(function() {
		$("button[type='button']:contains('�����ϱ�')").on("click", function() {
			fncAddUser();
		});
		
		$("button[type='button']:contains('���')").on("click", function() {
			$("form")[0].reset();
		});
		
		$("input[name='email']").on("change", function() {
			var email = $("input[name='email']").val();
			
			if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
				$("input[name='email']").next().css("color", "red").text("��ȿ�� �̸����� �ƴմϴ�");
			}else{
				$("input[name='email']").next().text("");
			}
		});
		
		$("input[name='userId']").on("change", function () {
			if ($("input[name='userId']").val() != null && $("input[name='userId']").val().length > 0) {
				checkUserId();
			}else{
				$("input[name='userId']").next().css("color", "black").text("���̵� �Է����ּ���");
			}
		})
		
		$("input[name = 'ssn']").on("change", function () {
			if ($("input[name='ssn']").val() != null && $("input[name='ssn']").val().length > 0) {
				checkSsn();
			}else{
				$("input[name='ssn']").next().css("color", "black").text("-����, 13�ڸ� �Է�");
			}
		});
	});

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//==> �ֹι�ȣ ��ȿ�� check �� ����������....
	function checkSsn() {
		var ssn1, ssn2;
		var nByear, nTyear;
		var today;

		ssn = $("input[name='ssn']").val();
		// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
		if (!PortalJuminCheck(ssn)) {
			$("input[name='ssn']").next().css("color", "red").text("�߸��� �ֹι�ȣ�Դϴ�.");
			return false;
		}else{
			$("input[name='ssn']").next().text("");
			return true;
		}
	}

	function PortalJuminCheck(fieldValue) {
		var pattern = /^([0-9]{6})-?([0-9]{7})$/;
		var num = fieldValue;
		if (!pattern.test(num))
			return false;
		num = RegExp.$1 + RegExp.$2;

		var sum = 0;
		var last = num.charCodeAt(12) - 0x30;
		var bases = "234567892345";
		for (var i = 0; i < 12; i++) {
			if (isNaN(num.substring(i, i + 1)))
				return false;
			sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
		}
		var mod = sum % 11;
		return ((11 - mod) % 10 == last) ? true : false;
	}
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	function checkUserId(){
		
		var userId = $("input[name='userId']").val();
		
			$.ajax({
				url : "/user/json/checkDuplication",
				method : "POST",
				data: userId,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData , status) {
						var flag = JSONData.result;
						
						if(flag){
							$("input[name='userId']").next().css("color", "blue").text(JSONData.userId+ "�� ��� �����մϴ�");
						}else{
							$("input[name='userId']").next().css("color","red").text(JSONData.userId+ "�� ��� �Ұ����մϴ�.");
						}
					}
			});
	}
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
    <h1 class="text-center">ȸ�������� �Է����ּ���</h1>
        <form class="form-horizontal">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
                
                    <div class="form-group">
                        <input type="text" name="userId" maxLength="20" placeholder="���̵�" class="form-control" />
                        <span>���̵� �Է����ּ���</span>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" maxLength="10" placeholder="��й�ȣ" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password2" maxLength="10" placeholder="��й�ȣ Ȯ��" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="userName" maxLength="50" placeholder="�̸�" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="ssn" maxLength="13" placeholder="�ֹι�ȣ" class="form-control" />
                        <span>-����, 13�ڸ� �Է�</span>
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="addr" id="addr" maxLength="100" placeholder="�ּ�" class="form-control" />
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-4">
                    		<select name="phone1" class="form-control">
                            	<option value="010">010</option>
                            	<option value="011">011</option>
                            	<option value="016">016</option>
                            	<option value="018">018</option>
                            	<option value="019">019</option>
                        	</select>
                    	</div>
                        
                        <div class="col-sm-4">
                        	<input type="text" name="phone2" maxLength="4" placeholder="��ȭ��ȣ" class="form-control" />
                        </div>
                        
                        <div class="col-sm-4">
                        	<input type="text" name="phone3" maxLength="4" placeholder="��ȭ��ȣ" class="form-control" />
                        </div>
                        
                        <input type="hidden" name="phone">
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="email" maxLength="50" placeholder="�̸���" class="form-control" />
                    </div>
                    
                    <div class="form-group text-center">
                        <button type="button" class="btn btn-default">�����ϱ�</button>
                        <button type="button" class="btn btn-primary">���</button>
                    </div>
                </div>
            </div>
        </form>
</div>

</body>
</html>