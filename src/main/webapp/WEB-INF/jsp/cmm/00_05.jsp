<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-16
  Time: 오후 5:59
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
			<c:param name="menuNo" value="11803000"></c:param>
			<c:param name="hideSidebar" value="Y"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
			<%--<c:param name="subTitle" value="등록"></c:param>--%>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">



			<!-- join_cnb -->
			<div class="join_cnb">
				<ul>
					<li><a href="#"><i class="ic1 bsContain"></i>본인인증</a></li>
					<li><a href="#"><i class="ic2 bsContain"></i>약관동의</a></li>
					<li><a href="#"><i class="ic3 bsContain"></i>회원정보</a></li>
					<li class="on"><a href="#"><i class="ic4 bsContain"></i>가입완료</a></li>
				</ul>
			</div>
			<!-- / join_cnb -->

			<!-- complete1 -->
			<div class="complete1 tac">
				<div class="wrap1">
					<i class="ic2 bsContain"></i>
					<p class="txt1">회원가입이 완료되었습니다.</p>
					<p class="txt2"></p>
					<p class="txt3">
							${userVO.name}님의 회원가입을 축하합니다.<br />로그인 후 다양한 서비스를 이용하실 수 있습니다.
					</p>
					<div class="btns">
						<a href="<c:url value="/login.do"/>" target="_blank" title="새 창" class="button">로그인</a>
					</div>
				</div>
			</div>
			<!-- /complete1 -->



	</layout:put>

	<layout:put block="javascript" type="REPLACE">
	</layout:put>

</layout:extends>
