<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">

<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	function history(){
		popWin = window.open("/history.jsp","popWin",
				"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}
	
	$(function() {
		
		$(".clickButton").on("mouseenter", function () {
			$(this).css("cursor", "pointer");
			$(this).css("color", "blue");
		}).on("mouseleave", function () {
			$(this).css("color", "black");
		})
		
	 	$( ".Depth03:contains('����������ȸ')" ).on("click" , function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser/${user.userId}");
		});
		
	 	$( ".Depth03:contains('ȸ��������ȸ')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
		}); 
	 	
	 	$( ".Depth03:contains('ī�װ����')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/category/addCategory");
		}); 
	 	
	 	$( ".Depth03:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/addProduct");
		}); 
	 	
	 	$( ".Depth03:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct/manage");
		}); 
	 	
	 	$( ".Depth03:contains('�� �� �� ��')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/cart/listCart");
		}); 
	 	
	 	$( ".Depth03:contains('�� ǰ �� ��')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct/search");
		}); 
	 	
	 	$( ".Depth03:contains('�����̷���ȸ')" ).on("click" , function() {
	 		$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/listPurchase");
		}); 
	 	
	 	$( ".Depth03:contains('�ֱ� �� ��ǰ')" ).on("click" , function() {
	 		history();
		}); 
	});	
</script>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">
							<span class="clickButton">����������ȸ</span>
						</td>
					</tr>
				</c:if>
			
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							<span class="clickButton">ȸ��������ȸ</span>
						</td>
					</tr>
				</c:if>
			
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
		</table>
	</td>
</tr>

<!--menu 02 line-->
<c:if test="${user.role == 'admin'}">
	<tr>
		<td valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						<span class="clickButton">ī�װ����</span>
					</td>
				</tr>
				
				<tr>
					<td class="Depth03">
						<span class="clickButton">�ǸŻ�ǰ���</span>
					</td>
				</tr>
				
				<tr>
					<td class="Depth03">
						<span class="clickButton">�ǸŻ�ǰ����</span>
					</td>
				</tr>
				
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
		
			<c:if test="${user != null }">
				<tr>
					<td class="Depth03">
						<span class="clickButton">�� �� �� ��</span>
					</td>
				</tr>
			</c:if>
			
			<tr>
				<td class="Depth03">
						<span class="clickButton">�� ǰ �� ��</span>
				</td>
			</tr>
			
			<c:if test="${ !empty user && user.role == 'user'}">
			<tr>
				<td class="Depth03">
						<span class="clickButton">�����̷���ȸ</span>
				</td>
			</tr>
			</c:if>
			
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">
					<span class="clickButton">�ֱ� �� ��ǰ</span>
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>
</html>