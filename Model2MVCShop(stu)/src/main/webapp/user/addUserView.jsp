<%@ page contentType="text/html; charset=euc-kr" %>

<html lang="ko">

<head>
	<title>회원가입</title>

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
	
	<!--  CSS 가입하기 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>

	<script type="text/javascript">
	
	function fncAddUser() {
		// Form 유효성 검증

		var id = $("input[name='userId']").val();
		var pw = $("input[name='password']").val();
		var pw_confirm = $("input[name='password2']").val();
		var name = $("input[name='userName']").val();

		if (id == null || id.length < 1) {
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		}
		if (pw == null || pw.length < 1) {
			alert("패스워드는  반드시 입력하셔야 합니다.");
			return;
		}
		if (pw_confirm == null || pw_confirm.length < 1) {
			alert("패스워드 확인은  반드시 입력하셔야 합니다.");
			return;
		}
		if (name == null || name.length < 1) {
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}

		if (pw != pw_confirm) {
			alert("비밀번호 확인이 일치하지 않습니다.");
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

	//==> 가입하기된부분 : "취소"  Event 처리 및  연결
	$(function() {
		$("button[type='button']:contains('가입하기')").on("click", function() {
			fncAddUser();
		});
		
		$("button[type='button']:contains('취소')").on("click", function() {
			$("form")[0].reset();
		});
		
		$("input[name='email']").on("change", function() {
			var email = $("input[name='email']").val();
			
			if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
				$("input[name='email']").next().css("color", "red").text("유효한 이메일이 아닙니다");
			}else{
				$("input[name='email']").next().text("");
			}
		});
		
		$("input[name='userId']").on("change", function () {
			if ($("input[name='userId']").val() != null && $("input[name='userId']").val().length > 0) {
				checkUserId();
			}else{
				$("input[name='userId']").next().css("color", "black").text("아이디를 입력해주세요");
			}
		})
		
		$("input[name = 'ssn']").on("change", function () {
			if ($("input[name='ssn']").val() != null && $("input[name='ssn']").val().length > 0) {
				checkSsn();
			}else{
				$("input[name='ssn']").next().css("color", "black").text("-제외, 13자리 입력");
			}
		});
	});

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//==> 주민번호 유효성 check 는 이해정도로....
	function checkSsn() {
		var ssn1, ssn2;
		var nByear, nTyear;
		var today;

		ssn = $("input[name='ssn']").val();
		// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임 
		if (!PortalJuminCheck(ssn)) {
			$("input[name='ssn']").next().css("color", "red").text("잘못된 주민번호입니다.");
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
							$("input[name='userId']").next().css("color", "blue").text(JSONData.userId+ "는 사용 가능합니다");
						}else{
							$("input[name='userId']").next().css("color","red").text(JSONData.userId+ "는 사용 불가능합니다.");
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
    <h1 class="text-center">회원정보를 입력해주세요</h1>
        <form class="form-horizontal">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
                
                    <div class="form-group">
                        <input type="text" name="userId" maxLength="20" placeholder="아이디" class="form-control" />
                        <span>아이디를 입력해주세요</span>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" maxLength="10" placeholder="비밀번호" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password2" maxLength="10" placeholder="비밀번호 확인" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="userName" maxLength="50" placeholder="이름" class="form-control" />
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="ssn" maxLength="13" placeholder="주민번호" class="form-control" />
                        <span>-제외, 13자리 입력</span>
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="addr" id="addr" maxLength="100" placeholder="주소" class="form-control" />
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
                        	<input type="text" name="phone2" maxLength="4" placeholder="전화번호" class="form-control" />
                        </div>
                        
                        <div class="col-sm-4">
                        	<input type="text" name="phone3" maxLength="4" placeholder="전화번호" class="form-control" />
                        </div>
                        
                        <input type="hidden" name="phone">
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="email" maxLength="50" placeholder="이메일" class="form-control" />
                    </div>
                    
                    <div class="form-group text-center">
                        <button type="button" class="btn btn-default">가입하기</button>
                        <button type="button" class="btn btn-primary">취소</button>
                    </div>
                </div>
            </div>
        </form>
</div>

</body>
</html>