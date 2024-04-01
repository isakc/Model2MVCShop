<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="ko">

<head>
	<title>상품 목록조회</title>

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
        
        .card:hover {
        box-shadow: 0 0 10px rgba(0,0,0,0.3);
        transform: translateY(-5px);
   	 	}
   	 	
   	 	.card {
    		height: 335px;
    		margin-top: 25px;
    		border-bottom: 3px solid #424242;
  		}
  		
 		 .card img {
    		object-fit: cover;
    		max-width: 70%;
    		height: 70%;
  		}
  		
  		.horizontal-list-group {
        	display: flex;
        	flex-direction: row;
        	padding-left: 0;
       	 	margin-bottom: 0;
        	list-style: none;
    	}

    	.horizontal-list-group .list-group-item {
        	margin-bottom: 80;
		}
		
		.horizontal-list-group .list-group-item:hover {
        	cursor: pointer;
        	color: blue;
		}
   	</style>

	<script type="text/javascript">
	
	function getList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
	}
	
	$(function () {
		$(".product-link").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).attr("href", "/product/getProduct/"+prodNo+"/${menu}");
		});
		
		$("tbody td:nth-child(6):contains('판매목록')").on("click", function() {
			var prodNo = $(this).data("prod-no");
			$(this).find("a").attr("href", "/purchase/getOrderDetail/"+prodNo);
		});
		
		$(".horizontal-list-group li:nth-child(1)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceASC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(2)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('priceDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(3)").on("click", function () {
			$("#currentPage").val(1);
			$("input[name=sorter]").val('reg_dateDESC');
			
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$(".horizontal-list-group li:nth-child(4)").on("click", function () {
			self.location = "/product/listProduct/${menu}";
		});
		
		$("select[name=categoryNo]").on("change", function () {
			$("#currentPage").val(1);
			$('input[name="searchCondition"]').val("");
			$('input[name="searchKeyword"]').val("");

			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$("button[type='submit']:contains('검색')").on("click", function () {
			$("#currentPage").val(1);
			$("form").attr("method", "POST").attr("action", "/product/listProduct/${menu }").submit();
		});
		
		$("select[name=searchCondition]").on("change", function() {
			var searchCondition = $('select[name=searchCondition]');
			var searchKeyword = $('input[name=searchKeyword]');
			var selectedValue = searchCondition.val();

			if (selectedValue == '2') {
				searchKeyword.val(0);
				searchKeyword.after('<input name="searchKeyword2"/>');
			} else {
				searchKeyword.val("");
				$("input[name=searchKeyword2]").remove();
			}
		});
		
		//데이터 가져오는 함수
		function getData(){
			//다음페이지
			var data = {
					searchCondition: $("select[name=searchCondition]").val(),
					searchKeyword: $("input[name=searchKeyword]").val(),
					searchKeyword2: $("input[name=searchKeyword2]").val(),
					sorter: $("input[name=sorter]").val(),
					currentPage: parseInt($("input[name=currentPage]").val())+1,
					pageSize: 6,
					category: {categoryNo: $("select[name=categoryNo]").val()}
			}
			
			$.ajax({
				url: "/product/json/listProduct/search",
				type: "POST",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				data: JSON.stringify(data),
				success: function(data){
					$("#currentPage").val(data.resultPage.now);
					var productList = data.list; // 받아온 상품 목록 데이터
				    var container = $(".col-md-11"); // 상품 목록을 추가할 컨테이너 요소 선택
				    
				    productList.forEach(function(product) {
				    	var card =
				            "<div class='col-md-4'>"
				           +"<a href=/product/getProduct/"+product.prodNo+"/search class=product-link data-prod-no="+product.prodNo+">"
				                +"<div class='card text-center fixed-height'>"
				                    +"<img src='/images/uploadFiles/"+product.fileNames[0] +"'class=card-img-top/>"
				                    +"<div class='card-body'>"
				                        +"<h5 class='card-title'>"+product.prodName+"</h5>"
				                        +"<p class='card-text'>"+product.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+"원</p>"
				                        +"<p class='card-text'>"+product.quantity+" 개 남음</p>"
				                    +"</div></div></a></div>";
				        container.append(card); // 컨테이너에 상품 카드 추가
				    });
				}
			});
		}

		 let lastScroll = 0; //현재 스크롤 위치 저장
		
		$(document).scroll(function(e){
		    var currentScroll = $(this).scrollTop(); //현재높이
		    var documentHeight = $(document).height();//전체 문서의 높이
		    
		    var nowHeight = $(this).scrollTop() + $(window).height();//(현재 화면상단 + 현재 화면 높이)
		    
		    if(currentScroll > lastScroll){//스크롤이 아래로 내려갔을때만 해당 이벤트 진행.

		        //nowHeight을 통해 현재 화면의 끝이 어디까지 내려왔는지 파악가능 
		        //즉 전체 문서의 높이에 일정량 근접했을때 글 더 불러오기)
		        if(documentHeight < (nowHeight + (documentHeight*0.1))){
		        	//함수콜
		        	if(${resultPage.totalPage} > $("#currentPage").val()){
						getData();
		        	}
		        }
		    }

		    //현재위치 최신화
		    lastScroll = currentScroll;
		});
	})
</script>
</head>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<form>
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<select name="categoryNo" class="form-control">
							<option value="-1" style="font-weight: 700">전체</option>

							<c:forEach var="category" items="${categoryList}">
								<c:choose>
									<c:when test="${category.parentCategoryNo == 0 }">
										<option value="${category.categoryNo}"
											${category.categoryNo == search.category.categoryNo ? 'selected' : ''}
											style="font-weight: 700">${category.categoryName }</option>
									</c:when>

									<c:otherwise>
										<option align="center" value="${category.categoryNo}"
											${category.categoryNo == search.category.categoryNo ? 'selected' : ''}>${category.categoryName }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<ul class="list-group horizontal-list-group">
						<li class="list-group-item">낮은 가격순</li>
						<li class="list-group-item">높은 가격순</li>
						<li class="list-group-item">최신순</li>
						<li class="list-group-item">초기화</li>
					</ul>
				</div>
			
			<div class="col-md-6 text-right">
				<select id="searchCondition" name="searchCondition">
					<option value="" selected disabled hidden>선택</option>
					<c:if test="${user.role == 'admin' && user!=null}">
						<option value="0" ${search.searchCondition == '0' ? 'selected' : ''}>상품번호</option>
					</c:if>
					<option value="1" ${search.searchCondition == '1' ? 'selected' : ''}>상품명</option>
					<option value="2" ${search.searchCondition == '2' ? 'selected' : ''}>상품가격</option>
				</select>

				<c:choose>
					<c:when test="${search.searchCondition == '2' }">
						<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" />
						<input type="text" name="searchKeyword2" value="${search.searchKeyword2 }" />
					</c:when>

					<c:otherwise>
						<input type="text" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword }" />
					</c:otherwise>
				</c:choose>

				<button type="submit" class="btn btn-success">검색</button>
			</div>
			</div><!-- row -->
		</div><!-- 정렬할 박스 -->
		
		<c:choose>
			<c:when test="${menu == 'search' }">
				<div class="container">
    				<div class="row">
    					<div class="col-md-11">
    					
       		 			<c:forEach var="product" items="${list}">
            				<div class="col-md-4">
                				<a href="" data-prod-no="${product.prodNo }" class="product-link">
                				<div class="card text-center fixed-height">
                   		 			<img src="/images/uploadFiles/${product.fileNames[0]}" class="card-img-top"/>
                    					<div class="card-body">
                        					<h5 class="card-title">${product.prodName}</h5>
                        					<p class="card-text"><fmt:formatNumber value="${product.price}" pattern="#,##0원" /></p>
                        					<p class="card-text">${product.quantity} 개 남음</p>
                    					</div>
                				</div>
                    			</a>
            				</div>
       		 			</c:forEach>
       		 			</div>
       		 			
       		 			<div class="col-md-1">
       		 			<!-- 최근 본 상품 목록을 표시할 사이드바 또는 푸터 영역 -->
							<div class="container">
								<div class="row">
									<div class="col-md-3">
									<!-- 최근 본 상품 목록 제목 -->
									<h4>최근 본 상품</h4>
									<ul class="list-group">
									<!-- 최근 본 상품 목록 -->
										<c:forEach var="recentProduct" items="${history}">
										<li class="list-group-item">
											<a href="/product/getProduct/${recentProduct.prodNo}/${menu}">
												<img src="/images/uploadFiles/${recentProduct.fileNames[0]}" alt="${recentProduct.prodName}" style="max-width: 50px; max-height: 50px;">
												${recentProduct.prodName}
                        					</a>
                    					</li>
                    					</c:forEach>
                    				</ul>
                    				</div>
                    			</div>
                    		</div>
       		 			</div>
       		 			
    				</div><!-- row end -->
				</div><!-- list Container container end -->
			
			</c:when>
				
			<c:otherwise>
			<div class="container">
				<table class="table table-striped table-bordered list text-center d-flex align-items-center">
							<thead>
								<tr>
									<td>No</td>
									<td>이미지</td>
									<td>상품명</td>
									<td>가격</td>
									<td>카테고리</td>

									<c:choose>
										<c:when test="${menu == 'manage' }">
											<td>배송현황</td>
										</c:when>

										<c:otherwise>
											<td>남은 수량</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</thead>

							<tbody>
								<c:set var="i" value="0" />
								<c:forEach var="product" items="${list }">
									<c:set var="i" value="${i+1 }" />
									<tr>
										<td>${i }</td>
										<td>
											<c:choose>
												<c:when test="${not empty product.fileNames}">
													<img src="/images/uploadFiles/${product.fileNames[0] }" style="width:100px;"/>
												</c:when>
												
												<c:otherwise>
													사진이 없음
												</c:otherwise>
											</c:choose>
											
										</td>
										<td><a href="" class="product-link" data-prod-no="${product.prodNo }">${product.prodName }</a></td>
										<td><fmt:formatNumber value="${product.price}" pattern="#,##0원" /></td>
										<td>${product.category.categoryName }</td>
										<td data-prod-no="${product.prodNo }">
											<c:choose>
												<c:when test="${menu == 'manage' }">
													<a href="">판매목록</a>
												</c:when>
												
												<c:otherwise>
													${product.quantity } 개
												</c:otherwise>
											</c:choose>
										</td>
									</tr>

								</c:forEach>
								
							</tbody>
						</table>
						</div><!-- manage Container end -->
			</c:otherwise>
		</c:choose>
		
			<!-- 페이지 Navigator -->
			
		<div class="container">
			<div class="text-center">
				<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.now }" />
				<input type="hidden" id="sorter" name="sorter" value="${search.sorter }" />
				<c:if test="${menu == 'manage' }">
					<jsp:include page="../common/pageNavigator.jsp"/>
				</c:if>
			</div>
			
		</div>
		<!--  페이지 Navigator 끝 -->
	</form>
</body>
</html>