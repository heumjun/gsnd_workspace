<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:32
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
            <c:param name="menuNo" value="11202000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">


        <!-- notice1 -->
        <div class="m2s2_notice">
            <ul class="bu">
                <li><img src='<c:url value="/assets/images/woodcraft/www/content/02/m2s1_map1ic1.png"/>' width="20" height="20" alt="" class="vam" /> 를 클릭하시면 부대시설의 자세한 사진을 보실 수 있습니다.</li>
            </ul>
        </div>
        <!-- /notice1 -->

        <div class="m2s2">
            <span class="t1 info1"><a href="#m2s2info1" class="toggle"><span class="blind">주차장1</span></a></span>
            <span class="t1 info2"><a href="#m2s2info2" class="toggle"><span class="blind">지상1층 제1작업실 옆 벤치</span></a></span>
            <span class="t1 info3"><a href="#m2s2info3" class="toggle"><span class="blind">옥외벤치</span></a></span>
            <span class="t1 info4"><a href="#m2s2info4" class="toggle"><span class="blind">2층벤치</span></a></span>
            <span class="t1 info5"><a href="#m2s2info5" class="toggle"><span class="blind">주차장2</span></a></span>
            <div class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/02/m2s2_map1.jpg"/>' alt="" /></div>

        </div>

        <%@include file="/inc/facility/02_02.jsp" %>


    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
