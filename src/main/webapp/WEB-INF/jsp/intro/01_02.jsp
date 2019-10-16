<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오전 11:25
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
            <c:param name="menuNo" value="11102000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

        <!-- 100% 용 --></div></div></div><!-- //100% 용 -->
        <div class="m1s2">
            <!-- 사진 -->
            <div class="p1">
                <div class="p1g1">
                    <img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s2_p1@2x.jpg"/>' alt="" />
                    <img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s2_p2@2x.jpg"/>' alt="" />
                    <img src='<c:url value="/assets/images/woodcraft/www/content/01/m1s2_p3@2x.jpg"/>' alt="" />
                </div>
            </div>
            <!-- // 사진 -->

            <!-- 연혁 -->
            <div class="history">
                <div class="container">
                    <h2 class="bsContain">진주목공예전수관</h2>
                    <div class="history_list">

                        <div class="history_item">
                            <h3><i class="bsContain"></i>2018년</h3>
                            <div class="item1">
                                <ul class="init">
                                    <li><span class="ym">하반기</span><span class="t1">정식 운영</span></li>
                                    <li><span class="ym">6월~7월</span><span class="t1">시험운영</span></li>
                                    <li><span class="ym">1월~6월</span><span class="t1">시설 및 장비 구축</span></li>
                                    <li><span class="ym">3월</span><span class="t1">조례제정</span></li>
                                </ul>
                            </div>
                        </div>

                        <div class="history_item">
                            <h3><i class="bsContain"></i>2017년</h3>
                            <div class="item1">
                                <ul class="init">
                                    <li><span class="ym">8월</span><span class="t1">진주목공예전수관 명칭 공모</span></li>
                                    <li><span class="ym">7월</span><span class="t1">3차분 공사준공</span></li>
                                </ul>
                            </div>
                        </div>

                        <div class="history_item">
                            <h3><i class="bsContain"></i>2016년</h3>
                            <div class="item1">
                                <ul class="init">
                                    <li><span class="ym">3월~</span><span class="t1">1,2차분 공사준공</span></li>
                                </ul>
                            </div>
                        </div>

                        <div class="history_item">
                            <h3><i class="bsContain"></i>2014년</h3>
                            <div class="item1">
                                <ul class="init">
                                    <li><span class="ym">6월</span><span class="t1">건축설계 공모 응모작품 접수 및 심사</span></li>
                                </ul>
                            </div>
                        </div>

                        <div class="history_item">
                            <h3><i class="bsContain"></i>2012년</h3>
                            <div class="item1">
                                <ul class="init">
                                    <li><span class="ym">11월</span><span class="t1">사업부지 매입</span></li>
                                    <li><span class="ym">2월</span><span class="t1">기본계획 수립 및 타당성 조사 용역</span></li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- //연혁 -->
        </div>
        <!-- 100% 용 --><div><div><div><!-- //100% 용 -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
