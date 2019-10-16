<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-16
  Time: 오후 2:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- #sidebar -->

<%--<c:set var="currentMenu" value="${menuItem}" scope="session" />--%>
<%--<c:set var="title1" value="${menuNm1}" scope="session"/>--%>
<%--<c:set var="title2" value="${menuNm2}" scope="session"/>--%>

<div id="sidebar" class="clearfix init">
	<div class="container">
		<h2 class="blind">${menuNm2}</h2>
		<strong class="h1 blind">부 메뉴</strong>
		<div class="snb">
			<ul>
				<c:if test="${sessionScope.hideSidebar != 'Y'}">
				<c:forEach var="item" items="${siblingList}" varStatus="status">
					<c:choose>
						<c:when test="${item.menuNo == menuItem.menuNo}">
							<li class="on">
						</c:when>
						<c:otherwise>
							<li>
						</c:otherwise>
					</c:choose>
					<a href="<c:url value="${item.url}"/>">${item.menuNm}</a>
					</li>
				</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<!-- /#sidebar -->

<hr class="dpn"/>
