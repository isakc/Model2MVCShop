<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:if test="${resultPage.nowBlock != 1 }">
		<a href="javascript:getList('${ (resultPage.nowBlock-1)*resultPage.numBlock }')" style="color:blue">◀ 이전</a>
	</c:if>
	
	<c:set var="loop_flag" value="false" />
	<c:forEach var="i" begin="1" end="${resultPage.numBlock }" varStatus="status"> 
	
		<c:if test="${not loop_flag }">
		<c:set var="realPage" value="${( resultPage.nowBlock-1)*resultPage.numBlock+i }"/>
		
		<c:choose>
			<c:when test="${realPage > resultPage.totalPage }">
				<c:set var="loop_flag" value="true"/>
			</c:when>
		
			<c:otherwise>
				
				<a href="javascript:getList('${realPage }');" style="${ (realPage eq resultPage.now ? 'color:green; font-weight: 700;': '') }">${realPage }</a>
			</c:otherwise>
		</c:choose>
		</c:if>
	</c:forEach>
	
	<c:if test="${resultPage.nowBlock < resultPage.totalBlock }">
		<a href="javascript:getList('${resultPage.nowBlock * resultPage.numBlock+1 }')" style="color:blue">이후 ▶</a>
	</c:if>