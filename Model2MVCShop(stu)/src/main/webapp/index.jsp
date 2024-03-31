<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 
<html>
<head>
	<title>MEET PLAY SHARE</title>
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<c:import url="/common/link.jsp"/>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
	
	<script type="text/javascript">
		//============= 회원원가입 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('회원가입')").on("click" , function() {
				self.location = "/user/addUser"
			});
			
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('로 그 인')").on("click" , function() {
				self.location = "/user/login"
			});
			
			$("a[href='#' ]:contains('상품검색')").on("click" , function() {
				self.location = "/product/listProduct/search"
			});
		});
		
	</script>
	
	<title>Model2 MVC Shop</title>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar navbar-default">
		
        <div class="container">
        
        	<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">회원가입</a></li>
	                 <li><a href="#">로 그 인</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  회원관리 목록에 제목 -->
				<div class="panel panel-primary">
				
					<div class="panel-heading">
						<span class="glyphicon glyphicon-heart"></span>
						회원관리
         			</div>
         			
         			<!--  회원관리 아이템 -->
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">개인정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">회원정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-briefcase"></span> 판매상품관리
         			</div>
         			
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">판매상품등록</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">판매상품관리</a> <span class="glyphicon glyphicon-ban-circle"></span>
						 </li>
					</ul>
					
		        </div>
               
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<span class="glyphicon glyphicon-shopping-cart"></span> 상품구매
	    			</div>
	    			
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">상품검색</a></li>
						  <li class="list-group-item">
						  	<a href="#">구매이력조회</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
				<div class="panel panel-primary">
				
					<div class="panel-heading">
							<i class="fas fa-box"></i> 장바구니
	    			</div>
	    			
					<ul class="list-group">
						  <li class="list-group-item">
						  	<a href="#">장바구니</a> <span class="glyphicon glyphicon-ban-circle"></span>
						  </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>로그인 후 사용가능...</p>
			  		<p>로그인 전 검색만 가능합니다.</p>
			  		<p>회원가입 하세요.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">회원가입</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">로 그 인</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- 다단레이아웃(row) end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성(container div) end /////////////////////////////////////-->
	
</body>

</html>