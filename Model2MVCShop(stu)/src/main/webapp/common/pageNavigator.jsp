<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav aria-label="Page navigation">
	<ul class="pagination">
	
		<li class="page-item">
		<c:if test="${resultPage.nowBlock != 1 }">
			<a class="page-link" href="javascript:getList('${ (resultPage.nowBlock-1)*resultPage.numBlock }')"><span aria-hidden="true">&laquo;</span></a>
		</c:if>
		</li>

		<c:set var="loop_flag" value="false" />
		<c:forEach var="i" begin="1" end="${resultPage.numBlock }" varStatus="status">

			<c:if test="${not loop_flag }">
				<c:set var="realPage" value="${( resultPage.nowBlock-1)*resultPage.numBlock+i }" />

				<c:choose>
					<c:when test="${realPage > resultPage.totalPage }">
						<c:set var="loop_flag" value="true" />
					</c:when>

					<c:otherwise>
						<li class="page-item ${ (realPage eq resultPage.now ? 'active': '') }">
                        	<a class="page-link" href="javascript:getList('${realPage }');">${realPage }</a>
                    	</li>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>

		<li class="page-item">
		<c:if test="${resultPage.nowBlock < resultPage.totalBlock }">
			<a class="page-link" href="javascript:getList('${resultPage.nowBlock * resultPage.numBlock+1 }')" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
		</c:if>
		</li>
	</ul>
</nav>