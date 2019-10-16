<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 1:29
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
            <c:param name="menuNo" value="11505000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

        <!-- #faq1 -->
        <div id="faq1">

            <!-- 질문 1 -->
            <h2 class="tab">
                <a href="#faq1c1">
                    <i class="ic1 bsContain"><span class="blind">질문</span></i>
                    예약을 하려면 어떻게 해야하나요?
                    <i class="ic2 bsContain"><span class="blind">열기/닫기</span></i>
                </a>
            </h2>
            <div id="faq1c1" class="cont">
                <span class="blind">답변</span>
                <%@include file="/inc/faq/01.jsp" %>
            </div>
            <!-- 질문 1 -->

            <!-- 질문 2 -->
            <h2 class="tab">
                <a href="#faq1c2">
                    <i class="ic1 bsContain"><span class="blind">질문</span></i>
                    이용요금은 어떻게 되나요?
                    <i class="ic2 bsContain"><span class="blind">열기/닫기</span></i>
                </a>
            </h2>
            <div id="faq1c2" class="cont">
                <span class="blind">답변</span>
                <%@include file="/inc/faq/02.jsp" %>
            </div>
            <!-- 질문 2 -->


            <!-- 질문 3 -->
            <h2 class="tab">
                <a href="#faq1c3">
                    <i class="ic1 bsContain"><span class="blind">질문</span></i>
                    배송/반품/환불은 어떻게 되나요?
                    <i class="ic2 bsContain"><span class="blind">열기/닫기</span></i>
                </a>
            </h2>
            <div id="faq1c3" class="cont">
                <span class="blind">답변</span>
                <%@include file="/inc/faq/03.jsp" %>
            </div>
            <!-- 질문 3 -->

        </div>
        <!-- //#faq1 -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                var index = '${qn}';
                fncFaq1('click', '#faq1', '.tab', index, '.cont');

            });

        </script>

    </layout:put>

</layout:extends>
