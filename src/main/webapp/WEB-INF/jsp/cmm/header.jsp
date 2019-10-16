<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-16
  Time: 오전 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<hr class="dpn"/>

<!-- #head -->
<div id="head" class="init">

	<!-- #head_s1 -->
	<div id="head_s1" class="clearfix">

		<!-- container -->
		<div class="container">
			<!-- gn1 -->
			<div id="gn1">
				<strong class="blind">Global Navigation</strong>
				<ul>
					<!--<li><a href='/html/woodcraft/index.html' target="_blank">사이트맵(템플릿임시)</a></li>-->
					<sec:authorize access="isAuthenticated()">
					<li><a href='<c:url value="/mypage/myInfo.do"/>'>마이페이지</a></li>
					<li><a href='<c:url value="/mypage/wcrfBskt.do"/>'>장바구니</a></li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
					<li><a href='<c:url value="/login.do"/>'>로그인</a></li>
					<!--<li><a href="javascript:;" onclick="fnTest();">회원가입</a></li>-->
                        <li><a href='<c:url value="/user/userCheck.do"/>'>회원가입</a></li>

						<script language='javascript'>
                            function fnTest(){
                                //임시코드
                                alert("시범 운영중 입니다.");
                                return false;
                            }
						</script>

					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
					<li><a href="<c:url value="/actionLogout.do"/>">로그아웃</a></li>
					</sec:authorize>
					<li class="m1">
						<a href="http://www.jinju.go.kr" target="_blank" title="새 창"><i class="ic1"></i>진주시</a>
					</li>
					<li class="m2">
						<a href="http://tour.jinju.go.kr/" target="_blank" title="새 창"><i class="ic1"></i>문화관광</a>
					</li>
					<sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
					<li class="manager">
						<a href="<c:url value="/mng/artist/artistList.do"/>" target="_blank" title="새 창"><i class="ic1"></i>관리자</a>
					</li>
					</sec:authorize>
				</ul>
			</div>
			<!-- /gn1 -->
			<h1 id="logo">
				<a href='<c:url value="/"/>' title="홈으로 이동">
					<img src='<c:url value="/assets/images/woodcraft/www/layout/logo@2x.png"/>' alt="진주목공예전수관"/>
				</a>
			</h1>
		</div>
		<!-- /container -->

	</div>
	<!-- /#head_s1 -->

	<!-- #head_s2 -->
	<div id="head_s2" class="clearfix">
		<!-- container -->
		<div class="container">
			<h2 class="blind">상단 메뉴</h2>

			<!-- tnb1 [jQ] -->
			<div id="tnb1">
				<h3 class="blind">주 메뉴</h3>
				<strong class="h1">
					<a href="#tnb1c" class="b1 toggle">
						<i class="ic1 bsContain"></i><span class="t1 blind">주 메뉴</span><span class="blind">여닫기</span>
					</a>
				</strong>
				<!-- tnb1c -->
				<div id="tnb1c">
					<div class="bg"></div>

					<!-- cont -->
					<div class="cont">
						<a href="#tnb1c" class="b2 close">
							<i class="ic1 bsContain"></i><span class="t1 blind">주 메뉴</span><span class="blind">닫기</span>
						</a>
						<!-- tnb1head_s1 -->
						<div id="tnb1head_s1">
							<!-- tnb1gn1 -->
							<div id="tnb1gn1">
								<strong class="blind">Global Navigation</strong>
								<ul>
									<sec:authorize access="isAnonymous()">
									<li>
										<a href="<c:url value="/login.do"/>"><i class="ic1 bsContain"></i><span class="t1">로그인</span></a>
									</li>
									</sec:authorize>
									<sec:authorize access="isAuthenticated()">
									<li>
										<a href="<c:url value="/actionLogout.do"/>">
											<i class="ic1 bsContain"></i><span class="t1">로그아웃</span
										></a>
									</li>
									</sec:authorize>
								</ul>
							</div>
							<!-- tnb1gn1 -->

							<!-- tnb1gn2 -->
							<div id="tnb1gn2">
								<strong class="blind">Global Navigation</strong>
								<ul>
									<sec:authorize access="isAuthenticated()">
									<li>
										<a href="<c:url value="/mypage/wcrfBskt.do"/>" target="_blank" title="새 창">
											<i class="ic1 bsContain"></i><span class="t1">장바구니</span><!--<span class="num1">1</span>-->
										</a>
									</li>
									<li>
										<a href="<c:url value="/mypage/myInfo.do"/>" target="_blank" title="새 창">
											<i class="ic2 bsContain"></i><span class="t1">마이페이지</span>
										</a>
									</li>
									<li><a href="<c:url value="/mypage/myInfo.do"/>" target="_blank" title="새 창">
											<i class="ic3 bsContain"></i><span class="t1">나의 정보</span>
										</a>
									</li>
									<li>
										<a href="<c:url value="/mypage/wcrfBskt.do"/>" target="_blank" title="새 창">
											<i class="ic1 bsContain"></i> <span class="t1">장바구니</span>
											<!--<span class="num1">1</span>-->
										</a>
									</li>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
									<li>
										<a href="<c:url value="/user/userCheck.do"/>" target="_blank" title="새 창">
											<i class="ic4 bsContain"></i><span class="t1">회원가입</span>
										</a>
									</li>
									</sec:authorize>
								</ul>
							</div>
							<!-- /tnb1gn2 -->
						</div>
						<!-- /tnb1head_s1 -->

						<%-- 메뉴 --%>
						<!-- d1 -->
						<div class="d1">

							<div class="bg"></div>
							<c:if test="${fn:length(menuList) > 0}">
								<c:set value="true" var="is"/>
							<ul>
								<c:forEach var="item" items="${menuList}" varStatus="status" begin="0">
									<c:choose>
										<c:when test="${item.url == 'dir'}">
											<c:if test="${status.index > 1}">
										</ul>
									</div>
								</li>
											</c:if>

											<c:choose>
												<c:when test="${item.menuNo == sessionScope.currentMenu.upperMenuNo}">
								<li class="m${item.menuOrdr} on">
												</c:when>
												<c:otherwise>
								<li class="m${item.menuOrdr}">
												</c:otherwise>
											</c:choose>

									<a href="javascript:;">
										<i class="ic1"></i><span class="t1">${item.menuNm}</span>
									</a>
									<div class="d2">
										<div class="bg"></div>
										<ul>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${item.menuNo == sessionScope.currentMenu.menuNo}">
													<li class="m${item.menuOrdr} on">
												</c:when>
												<c:otherwise>
													<li class="m${item.menuOrdr}">
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${item.progrmStrePath == 'url'}">
													<a href="<c:url value="${item.url}"/>" target="_blank" title="${item.menuNm}">
												</c:when>
												<c:otherwise>
													<a href="<c:url value="${item.url}"/>">
												</c:otherwise>
											</c:choose>
													<i class="ic1"></i><span class="t1">${item.menuNm}</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>

								</c:forEach>
										</ul>
									</div>
								</li>
							</ul>
							</c:if>

						</div>
						<!-- /d1 -->
						<%--// 메뉴 --%>

						<a href="#tnb1c" class="b2 close">
							<i class="ic1 bsContain"></i><span class="t1 blind">주 메뉴</span><span class="blind">닫기</span>
						</a>

					</div>
					<!-- /cont -->

				</div>
				<!-- /tnb1c -->

			</div>
			<!-- /tnb1 -->

		</div>
		<!-- /container -->

	</div>
	<!-- /#head_s2 -->

</div>
<!-- /#head -->

<hr class="dpn"/>