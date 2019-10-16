<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-16
  Time: 오후 4:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!-- #foot -->
<div id="foot" class="init">
	<h2 class="blind">하단 정보</h2>

	<!-- fn1 -->
	<div id="fn1">
		<div class="container init">
			<ul>
				<li>
					<a href="http://www.jinju.go.kr/07guide/sitereport.jsp?amode=private&amp;pagesize=1000&amp;cpage=1&amp;gcode=1084"
					   target="_blank" title="새 창">홈페이지 개선의견</a></li>
				<li><a href="http://www.jinju.go.kr/07guide/privacy.jsp" target="_blank" title="새 창">개인정보 처리방침</a>
				</li>
				<li><a href="http://www.jinju.go.kr/07guide/copyright.jsp" target="_blank" title="새 창">저작권 정책</a>
				</li>
				<li><a href="http://www.jinju.go.kr/07guide/viewer.jsp" target="_blank" title="새 창">뷰어프로그램</a></li>
				<!--li><a href="#">웹마스터 메일</a></li-->
			</ul>
		</div>
	</div>
	<!-- /fn1 -->

	<!-- container -->
	<div class="container">
		<p id="foot_logo"><img src='<c:url value="/assets/images/woodcraft/www/layout/foot_logo@2x.png"/>' alt="진주시"/></p>
		<!-- author1 -->
		<div id="author1">
			<strong class="h1 blind">작성자 (연락처/저작권)</strong>
			<address class="address">
				52641 경상남도 진주시 명석면 광제산로 367 진주목공예전수관 <a href="http://www.juso.go.kr/openIndexPage.do" class="juso1" target="_blank" title="새 창">도로명주소검색</a> / 대표전화 : <a href="tel:055-746-3633" class="tel1" title="전화걸기">055-746-3633~4</a> / 팩스 : 055-748-3633<br />
				상호명 : 진주시청 / 사업자번호 : 613-83-00022 / 대표자명 :
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
				<c:if test="${today <= '2018-06-30'}">
					이창희
				</c:if>
				<c:if test="${today >= '2018-07-01'}">
					조규일
				</c:if>
				/ 통신판매신고업등록번호 : 2018-경남진주-0195<br />
				사업장 주소지 : 경상남도 진주시 동진로 155, 진주시청 (상대동)
			</address>
			<p class="nophishing">본 사이트에 게시된 이메일주소의 자동수집을 거부하며 이를 위반시 정보통신망법에 의해 형사처벌됩니다.</p>
			<address class="copyright">Copyright ⓒ 2018 Jinju City ALL RIGHTS RESERVED.</address>
		</div>
		<!-- /author1 -->
	</div>
	<!-- /container -->
</div>
<!-- /#foot -->
