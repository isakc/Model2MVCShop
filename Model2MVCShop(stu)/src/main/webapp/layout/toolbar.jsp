<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
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
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <c:if test="${user != null }">
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	               </c:if>
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                     </ul>
	                 </li>
	                 
	                 <c:if test="${sessionScope.user.role == 'user'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >장바구니</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">장바구니 목록</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	                 <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >카테고리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">카테고리등록</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	             </ul>
	             
	             <c:choose>
	             	<c:when test="${user != null }">
	             		<ul class="nav navbar-nav navbar-right">
	                		<li><a href="#">로그아웃</a></li>
	           	 		</ul>
	           	 	
	             	</c:when>
	             	
	             	<c:otherwise>
	             		<ul class="nav navbar-nav navbar-right">
	                		<li><a href="#">회원가입</a></li>
	                		<li><a href="#">로그인</a></li>
	                	</ul>
	             	</c:otherwise>
	             </c:choose>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	<script type="text/javascript">
	
		//============= logout Event  처리 =============	
		 $(function() {
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
		 });
		
		 $(function() {
			 $("a:contains('로그인')").on("click" , function() {
				$(self.location).attr("href","/user/login");
			}); 
		});
		 
		 $(function() {
			 $("a:contains('회원가입')").on("click" , function() {
				$(self.location).attr("href","/user/addUser");
			}); 
		});
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
		 	$("a:contains('회원정보조회')").on("click" , function() {
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUser/${user.userId}");
		});
		
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {
			$(self.location).attr("href","/product/addProduct");
		});
	 	
	 	$( "a:contains('판매상품관리')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct/manage");
		});
	 	
	 	<!-- 시작 -->
	 	
	 	$( "a:contains('상 품 검 색')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct/search");
		});
	 	
	 	$( "a:contains('구매이력조회')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/listPurchase");
		});
	 	
	 	$( "a:contains('카테고리등록')" ).on("click" , function() {
			$(self.location).attr("href","/category/addCategory");
		});
	 	
	 	$( "a:contains('장바구니 목록')" ).on("click" , function() {
			$(self.location).attr("href","/cart/listCart");
		});
	</script>  