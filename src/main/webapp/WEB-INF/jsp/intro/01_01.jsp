<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오전 11:00
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
			<c:param name="menuNo" value="11101000"></c:param>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">

		<!-- 100% 용 --></div></div></div><!-- //100% 용 -->
		<div class="m1s1">
			<div class="m1s1c1">
				<div class="container">
            <span class="t1">
                <span class="t1t1">진주목공예전수관 홈페이지를<br />방문해주신 여러분 진심으로 환영합니다.</span>
                <span class="t1t2 bsContain"><span class="blind">진주목공예전수관</span></span>
                <span class="t1t3">진주목공예전수관은 목공예 전문 인력을 양성하고<br />시민여러분에게 다양한 취미활동을 제공합니다.</span>
            </span>
					<span class="p1 bsContain"><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s1_img1.jpg"/>' alt="" /></span>
				</div>
			</div>

			<div class="container">
				<div class="m1s1c2">
					<div class="t1">
						<p class="t1t1">진주시 명석면 소재 진주목공예전수관은 전국에서도 찾아보기 어려운 20Km의 한국산 자생 소나무 숲길을 보유하고 있는 광제산 아래 위치하고 있으며 부지 10,520㎡, 건축물 2,675㎡ 면적을 조성하였습니다.</p>
						<p class="t1p1"><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s1_img2@1.jpg"/>' alt="" /></p>
						<p class="t1p2"><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s1_img2.jpg"/>' alt="" /></p>
					</div>
					<div class="t2">
						<p>
							명석면에는 무형문화재로 지정된 목공예 명장이 다수 거주하고 있으며 진주 전통 목공예가 다양한 형태로 전승 되고 있습니다. 진주는 예로부터 상, 장, 농 등의 가구 또는 나전칠기로 유명하여 궁궐에서 사용하는 함이나 장 같은 가구류를 만들어 진상 하였다고 합니다.
						</p>
						<p>
							진주목공예전수관은 아름다운 자연을 배경으로 우리에게 꼭 필요한 가구를 직접 만드는 활동을 통해 즐거움을 느낄 수 있는 공간입니다. 또한, 인력양성교육, 공예품판매·전시 및 체험 등 다양한 프로그램으로 여러분에게(청소년, 가족, 연인 등) 잊지 못할 소중한 추억을 남겨 줄 것입니다.
						</p>
					</div>
					<div class="t3">
						<p class="t3t1">
							많은 방문객에게 목공예의 우수성을 널리 알리면서, 일상에서 사용되는 다양한 제품을 직접 만들고 체험하는 기회의 공간으로 자리매김하여 진주 목공예를 계승·발전 시키는데 선도적인 역할을 다하겠습니다.<br /><br />
							우리 진주시는 관광객의 유익한 경험과 편의를 위해 앞으로도 최선을 다해 노력하겠습니다.<br /><br />
						</p>
						<p class="t3p1"><img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s1_img3.jpg"/>' alt="" /></p>
					</div>
				</div>
			</div>
		</div>
		<!-- 100% 용 --><div><div><div><!-- //100% 용 -->
	</layout:put>

	<layout:put block="javascript" type="REPLACE">

	</layout:put>

</layout:extends>
