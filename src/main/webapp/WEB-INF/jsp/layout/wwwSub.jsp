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

	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/sns.js"/>"></script>

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

				<!-- container -->
				<div class="container clearfix">
					<!-- #forPrint -->
					<div id="forPrint">
						<!-- #body_head -->
						<div id="body_head" class="init">
							<!-- body_head_s1 -->
							<div id="body_head_s1">
								<div id="body_title">
									<h1 class="hb1 h1"><c:out value="${sessionScope.title2}"/> </h1>
								</div>
								<!-- location1 -->
								<div id="location1">
									<div class="breadcrumb clearfix">
										<strong class="blind">현재페이지 위치:</strong>
										<span class="cont">
											<a href='<c:url value="/"/>' class='home' title='홈'>홈</a>
											<span class='sep'>&gt;</span>
											<a href='javascript:;'><c:out value="${sessionScope.title1}"/></a>
											<span class='sep'>&gt;</span>
											<a href='javascript:;' class="on"><c:out value="${sessionScope.title2}"/></a>
										</span>
									</div>
								</div>
								<!-- /location1 -->
							</div>
							<!-- /body_head_s1 -->

							<c:if test="${sessionScope.hideSocialMenu != 'Y'}">
							<!-- body_head_s2 -->
							<div id="body_head_s2">
								<!-- bn1 -->
								<div id="bn1">
									<ul>
										<li class="m share1">
											<div id="bn1share1">
												<ul>
													<li class="m facebook">
														<a id="btnFacebook" href="javascript:;">
															<i class="ic1 bsContain">
																<span class="blind">페이스북 담기</span>
															</i>
														</a>
													</li>
													<li class="m twitter">
														<a id="btnTwitter" href="javascript:;">
															<i class="ic1 bsContain">
																<span class="blind">트위터 담기</span>
															</i>
														</a>
													</li>
													<li class="m kakaostory">
														<a id="btnKakao" href="javascript:;">
															<i class="ic1 bsContain">
																<span class="blind">카카오스토리 담기</span>
															</i>
														</a>
													</li>
												</ul>
												<i class="deco1 bsContain"></i>
											</div>
											<a href="#bn1share1" class="m toggle">
												<i class="ic1 bsContain">
													<span class="blind">Share toggle</span>
												</i>
											</a>
										</li>
										<li class="m link">
											<a href="#?">
												<i class="ic1 bsContain">
													<span class="blind">링크 공유 (링크 주소 복사)</span>
												</i>
											</a>
										</li>
										<li class="m print">
											<a href="#?" onclick="window.print(); return false;" target="_blank">
												<i class="ic1 bsContain">
													<span class="blind">본문 인쇄</span>
												</i>
											</a>
										</li>
									</ul>
								</div>
								<!-- /bn1 -->
							</div>
							<!-- /body_head_s2 -->
							</c:if>
						</div>
						<!-- /#body_head -->

						<!-- #body_content -->
						<div id="body_content" class="body_content init">
							
							<layout:block name="contents"></layout:block>

						</div>
						<!-- /#body_content -->
					</div>
					<!-- /#forPrint -->
				</div>
				<!-- /container -->

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