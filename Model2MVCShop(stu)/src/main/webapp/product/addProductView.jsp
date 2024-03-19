<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>상품등록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

	$(function() {
		$(".clickButton").on("mouseenter", function() {
			$(this).css("cursor", "pointer");
			$(this).css("color", "blue");
		}).on("mouseleave", function() {
			$(this).css("color", "black");
		})
	})

	function fncAddProduct() {
		//Form 유효성 검증
		/*  	var name = document.detailForm.prodName.value;
		 var detail = document.detailForm.prodDetail.value;
		 var manuDate = document.detailForm.manuDate.value;
		 var price = document.detailForm.price.value; */

		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();

		if (name == null || name.length < 1) {
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}

		$("form").attr("method", "POST").attr("action", "/product/addProduct").attr("enctype", "multipart/form-data")
				.submit();
	}

	$(function() {
		$("td.ct_btn01:contains('취소')").on("click", function() {
			$("form")[0].reset();
		});
	});
	
	$(function() {
		$("td.ct_write01 > img")
		.on("click",function() {
			show_calendar('document.detailForm.manuDate', $('input[name=manuDate]').value);
		   });
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<!-- <form name="detailForm" method="post" enctype="multipart/form-data"> -->
<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품등록</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<c:choose>
			<c:when test="${result == null }">
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
					<td width="105">
						<input type="text" name="prodName" class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="20">
					</td>
						</tr>
					</table>
				</td>
			</c:when>
			
			<c:otherwise>
				<td class="ct_write01">${result.prodName}</td>
			</c:otherwise>
		</c:choose>

	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
						<input type="text" name="prodDetail" class="ct_input_g" 
								style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">${result.prodDetail}</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			제조일자 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
						<input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
							&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15"/>
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">${result.manuDate}</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
						<input type="text" name="price" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10">&nbsp;원
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">${result.price}</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품이미지</td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
					<input	type="file" name="upload" class="ct_input_g" 
							style="width: 200px; height: 19px" maxLength="13"/>
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">
						<img src = "/images/uploadFiles/${product.fileName }" width="700" height="700"/>
					</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
					<input	type="text" name="quantity" class="ct_input_g" 
							style="width: 200px; height: 19px" maxLength="13"/>
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">${result.quantity}</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
		<tr>
		<td width="104" class="ct_write">카테고리 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/></td>
		<td bgcolor="D6D6D6" width="1"></td>
			<c:choose>
				<c:when test="${result == null }">
					<td class="ct_write01">
							
					<select name="categoryNo">
				<option value="" selected disabled hidden > 선택 </option>
					<c:forEach var="category" items="${categoryList}">
						<c:choose>
							<c:when test="${category.parentCategoryNo == 0 }">
								<optgroup label="${category.categoryName }">
							</c:when>
					
							<c:otherwise>
								<option align="center" value="${category.categoryNo}">${category.categoryName }</option>
							</c:otherwise>
						</c:choose>
						</optgroup>
					</c:forEach>
					</select>
					</td>
				</c:when>
						
				<c:otherwise>
					<td class="ct_write01">${result.category.categoryName}</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
					<c:choose>
						<c:when test="${result == null }">
							<!-- <a href="javascript:fncAddProduct();">등록</a> -->
							<span class="clickButton">등록</span>
						</c:when>
					
						<c:otherwise>
							<!-- <a href="/product/addProduct" target="rightFrame">추가등록</a> -->
							<span class="clickButton">추가등록</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
					<!-- <a href="javascript:resetData();">취소</a> -->
					<span class="clickButton">취소</span>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>