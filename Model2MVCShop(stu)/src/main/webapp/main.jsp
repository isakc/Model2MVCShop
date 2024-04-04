<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>MEET PLAY SHARE</title>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
   	<script type="text/javascript">
   		$(function () {
			$.ajax({
				url: "/openAPI/json/main",
				method: "GET",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
					
				success: function(data) {
			        var tableBody = $('#boxOfficeBody');
					
					$.each(data.list, (index, movie)=> {
				          var row = $('<tr>');
				          row.append('<td>' + movie.rank + '위</td>');
				          row.append('<td>' + movie.movieNm + '</td>');
				          row.append('<td>' + movie.openDt + '</td>');
				          row.append('<td>' + movie.salesAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</td>');
				          row.append('<td>' + movie.audiCnt.replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '명</td>');
				          tableBody.append(row);
				        });
				}
			})
		})
   	</script>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<div class="container ">
      <!-- Main jumbotron for a primary marketing message or call to action -->
      
      <!-- 여기를 Slide로 처리해서 product 이미지로 -->
      <div class="jumbotron">
        <h1>Model2MVCShop </h1>
        <p>J2SE , DBMS ,JDBC , Servlet & JSP, Java Framework , HTML5 , UI Framework 학습 후 Mini-Project 진행</p>
     </div>
     
     
    </div>

	<!-- 참조 : http://getbootstrap.com/css/   : container part..... -->
	<div class="container">
		<h2 class="my-4">Daily Box Office</h2>
		<table id="boxOfficeTable" class="table">
			<thead>
				<tr>
					<th>순위</th>
					<th>영화명</th>
					<th>개봉일</th>
					<th>매출액</th>
					<th>일일관객수</th>
				</tr>
			</thead>
			<tbody id="boxOfficeBody">
			</tbody>
		</table>
	</div>

</body>

</html>