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
  	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group > div{
        	padding: 0px;
        }
   	</style>

	<script type="text/javascript">
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.querySelector('input[name="addr3"]').value = extraAddr;
                } else {
                    document.querySelector('input[name="addr3"]').value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.querySelector('input[name="addr1"]').value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector('input[name="addr2"]').focus();
            }
        }).open();
    }
	
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
		
		var addrValue = $("input[name='addr1']").val() + "/"
		+ $("input[name='addr2']").val() + "/"
		+ $("input[name='addr3']").val();

		$("input:hidden[name='addr']").val(addrValue);

		$("form").attr("method", "POST").attr("action", "/user/updateUser").submit();
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
		
		$("button[type='button']:contains('수정하기')").on("click", function() {
			fncUpdateUser();
		});
		
		$("button[type='button']:contains('취소')").on("click", function() {
			history.go(-1);
		});
		
		$("button[type='button']:contains('주소검색')").on("click", function () {
			sample6_execDaumPostcode();
		});
	});
	
</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
    	<h1 class="text-center">회원정보 수정</h1>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
       			<form class="form-horizontal">
				<input type="hidden" name="userId" value="${user.userId }">
                
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user"></i></span>
                    		<input type="text" name="userId" class="form-control input-lg" value="${user.userId }" disabled/>
    					</div>
    					<span></span>
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-user-circle"></i></span>
                    		<input type="text" name="userName" maxLength="50" placeholder="이름" class="form-control input-lg" value="${user.userName }" />
    					</div>
                    </div>
                    
                    <div class="form-group row">
                    	<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-home"></i></span>
                    			<input type="text" name="addr1" maxLength="100" placeholder="주소" class="form-control input-lg" value="${user.addr1 }" />
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<button type="button" class="btn btn-secondary btn-lg">주소검색</button>
                    	</div>
    					
    					<div class="col-sm-7">
                    		<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    			<input type="text" name="addr2" maxLength="100" placeholder="상세주소" class="form-control input-lg" value="${user.addr2 }" />
    						</div>
                    	</div>
                    	
                    	<div class="col-sm-5">
                    		<div class="input-group">
                    			<input type="text" name="addr3" maxLength="100" placeholder="참고항목" class="form-control input-lg" value="${user.addr3 }" />
    						</div>
                    	</div>
                    </div>
                    <input type="hidden" name="addr">
                    
                    <div class="form-group row">
                    	<div class="col-sm-4">
                    		<select name="phone1" class="form-control input-lg">
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
                    	</div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone2" maxLength="4" placeholder="전화번호" class="form-control input-lg" value="${user.phone2 }" />
    						</div>
                        </div>
                        
                        <div class="col-sm-4">
                        	<div class="input-group">
                    			<span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    		 	<input type="text" name="phone3" maxLength="4" placeholder="전화번호" class="form-control input-lg" value="${user.phone3 }" />
    						</div>
                        </div>
                        
                        <input type="hidden" name="phone">
                    </div>
                    
                    <div class="form-group">
                    	<div class="input-group">
                    		<span class="input-group-addon"><i class="fa fa-at"></i></span>
                    		<input type="text" name="email" maxLength="50" placeholder="이메일" class="form-control input-lg" value="${user.email }" />
    					</div>
                    </div>
                    
        			</form>
                    <div class="form-group text-center">
                        <button type="button" class="btn btn-default">수정하기</button>
                        <button type="button" class="btn btn-primary">취소</button>
                    </div>
                </div>
            </div>
	</div>
</body>
</html>