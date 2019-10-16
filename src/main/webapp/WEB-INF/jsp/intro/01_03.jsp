<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>

<layout:extends name="wwwSub">

	<layout:put block="sidebar" type="REPLACE">
		<c:import url="/inc/sidebar.do">
			<c:param name="menuNo" value="11103000"></c:param>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">

		<div class="m1s3">
			<h2><span><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s3_h2bg1.png"/>' alt="이념 및 목표" /></span></h2>
			<div class="bg1"><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s3_bg1.png"/>' alt="" /></div>
			<div class="txt1">
				<div class="item1 m1"><span class="t1">오랜 전통을 가진<span class="brT"></span>진주목공예를 계승·발전 시키고</span><span class="t2">공방 활성화 도모</span></div>
				<div class="item1 m2"><span class="t1">교육과 체험활동을 통한 </span><span class="t2">전문 인력 양성과<span class="brT"></span>시민 참여 활성화</span></div>
				<div class="item1 m3"><span class="t1">전시와 판매를 통한 </span><span class="t2">고부가가치 산업<span class="brT"></span>육성 발전</span></div>
			</div>
		</div>

	</layout:put>

	<layout:put block="javascript" type="REPLACE">

	</layout:put>

</layout:extends>
