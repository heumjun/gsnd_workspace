	<%--
	Created by IntelliJ IDEA.
	User: DELL
	Date: 2018-05-15
	Time: 오전 9:10
	To change this template use File | Settings | File Templates.
	--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="userStore"/>
<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<meta name="author" content="진주목공예전수관"/>
	<meta name="keywords" content="진주목공예전수관"/>
	<meta name="description" content="진주목공예전수관"/>
	<title>
		<layout:block name="title"></layout:block>
	</title>
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/font.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/lib.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/layout.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/content.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/template.css"/>" />

	<layout:block name="cssPart"></layout:block>

	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/iscroll-min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/hammer.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery-1.12.4.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery.easing.1.3.js"/>"></script>
	<!--[if lt IE 9]>
	<script type="text/javascript" src="<c:url value='/assets/js/woodcraft/www/define/html5shiv.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/assets/js/woodcraft/www/define/selectivizr.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/assets/js/woodcraft/www/define/respond.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/assets/js/woodcraft/www/define/jquery.backgroundSize.js'/>"></script>
	<![endif]-->
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib_define.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib_scroll.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib.js"/>"></script>
</head>
<body>
	<div id="container">

		<noscript>
			<p>JavaScript has been disabled. This site requires JavaScript for full functionality, please enable.</p>
		</noscript>

		<!-- #skipnav -->
		<div id="skipnav">
			<ul>
				<li><a href="#body">본문 바로가기</a></li>
			</ul>
		</div>
		<!-- /#skipnav -->

		<c:import url="/inc/header.do" />

		<!-- #wrap -->
		<div id="wrap">
			<layout:block name="sidebar"></layout:block>
			<!-- #body -->
			<div id="body">
				<layout:block name="contents"></layout:block>
			</div>
			<!-- /#body -->

		</div>
		<!-- /#wrap -->
		<hr class="dpn"/>

		<c:import url="/inc/footer.do"/>

	</div>

	<layout:block name="javascript"></layout:block>
</body>
</html>