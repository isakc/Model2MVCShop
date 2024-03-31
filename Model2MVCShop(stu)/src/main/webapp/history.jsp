<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>열어본 상품 보기</title>

</head>
<body>
	<%-- 당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String history = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split("/");
			for (int i = 0; i < h.length; i++) {
				if (!h[i].equals("null")) {
%>
<a href="/product/getProduct/<%=h[i]%>/search"	target="rightFrame"><%=h[i]%></a>
<br>
<%
				}
			}
		}
	}
%> --%>

<h1>최근 본 상품</h1>
    <c:if test="${not empty cookie.history}">
        <ul>
            <c:forEach var="productId" items="${cookie.history.value.split('/')}">
                <li>${productId}</li>
            </c:forEach>
        </ul>
    </c:if>
    
    
</body>
</html>