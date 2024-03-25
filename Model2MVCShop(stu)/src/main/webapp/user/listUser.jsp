<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>회원 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function getList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/listUser").submit();
	}
	
	$(function() {
		$(".clickButton").on("mouseenter", function() {
			$(this).css("cursor", "pointer");
			$(this).css("color", "blue");
		}).on("mouseleave", function() {
			$(this).css("color", "red");
		})
		
		//현재 스크롤 위치 저장
		let lastScroll = 0;

		//데이터 가져오는 함수
		function getData(){
			//다음페이지

			$.ajax({
				url: "json/listUser",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				data: JSON.stringify({
					searchCondition: $("select[name=searchCondition]").val(),
					searchKeyword: $("input[name=searchKeyword]").val(),
					pageSize: 10
				}),
				
				success: function(data){
					console.log(data);
				}
			});
		}

		$(document).scroll(function(e){
		    //현재 높이 저장
		    var currentScroll = $(this).scrollTop();
		    //전체 문서의 높이
		    var documentHeight = $(document).height();

		    //(현재 화면상단 + 현재 화면 높이)
		    var nowHeight = $(this).scrollTop() + $(window).height();

		    //스크롤이 아래로 내려갔을때만 해당 이벤트 진행.
		    if(currentScroll > lastScroll){

		        //nowHeight을 통해 현재 화면의 끝이 어디까지 내려왔는지 파악가능 
		        //즉 전체 문서의 높이에 일정량 근접했을때 글 더 불러오기)
		        if(documentHeight < (nowHeight + (documentHeight*0.1))){
		        	//함수콜
				getData(50);
		        }
		    }

		    //현재위치 최신화
		    lastScroll = currentScroll;
		});
	
		
		$("input[name='searchKeyword']").on('input', function() {
			// autocomplete을 새로 초기화
			$(this).autocomplete({
				source: function(request, response) {
					$.ajax({
						url: "json/listUser",
						method: "POST",
						headers: {
							"Accept": "application/json",
							"Content-Type": "application/json"
						},
						
						data: JSON.stringify({
							searchCondition: $("select[name=searchCondition]").val(),
							searchKeyword: $("input[name=searchKeyword]").val(),
							pageSize: 10
							}),
							
						success: function(data) {
							var uniqueValues = new Set();
							
		                    data.list.forEach(function(item) {
		                        if ($("select[name=searchCondition]").val() == 0) {
		                            uniqueValues.add(item.userId);
		                        } else {
		                            uniqueValues.add(item.userName);
		                        }
		                    });
		                    
		                    response(Array.from(uniqueValues).map(function(value) {
		                        return { 
		                        	label: value,
		                        	value: value 
		                        	};
		                    }));
							}
						});
					},
					
					minLength: 2 // 최소 입력 길이
				});
			});
		
		$("td.ct_btn01:contains('검색')").on("click", function() {
			getList(1);
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function() {
			$("td[height='1'][bgcolor='D6D7D6'] p").remove();
			
			var index = $(this).parent().next().children("td");
			
			$.ajax(
					{
						url : "json/getUser/" + $(this).text().trim(),
						method : "GET",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						success : function(JSONData , status) {
							
							index.html("<p>아이디: " + JSONData.user.userId + "<p>이름: " + JSONData.user.userName + "<p>이메일: " + JSONData.user.email);
						}
				});
		});

		$(".ct_list_pop td:nth-child(3)").css("color", "red");
		$("h7").css("color", "red");

		$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/user/listUser" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
			</select>
			<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g" style="width:200px; height:20px" > 
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;"  class="clickButton">
						<span class="clickButton">검색</span>
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체  ${resultPage.total } 건수, 현재 ${resultPage.now}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			회원ID<br>
			<h7 >(id click:상세정보)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">이메일</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="user" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left" class="clickButton">
				<span>${user.userId }</span>
			</td>
			<td></td>
			<td align="left">${user.userName}</td>
			<td></td>
			<td align="left">${user.email}
			</td>		
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }"/>
	
		<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>
</div>

</body>
</html>