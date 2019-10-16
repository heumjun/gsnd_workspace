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
            <c:param name="menuNo" value="11104000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

        <!-- 100% 용 --></div></div></div><!-- //100% 용 -->
        <!-- m1s4_v1 -->
        <div class="m1s4_v1">
            <div class="m1s4 container">
                <div class="c1">
                    <h2><i class="bsContain"></i>이용시간</h2>
                    <p>
                        <span class="t1">시작</span> <span class="t2">10:00</span><br />
                        <span class="t1">종료</span> <span class="t2">17:00</span>
                    </p>
                </div>
                <div class="c2 init">
                    <h2>휴관일</h2>
                    <div class="t1">
                        <ul class="bu">
                            <li>매주 월요일 <br />(월요일이 법정공휴일)인 경우에는 그 다음날</li>
                            <li>1월 1일</li>
                            <li>설 및 추석연휴(대체공휴일 포함)</li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
        <!-- // m1s4_v1 -->
        <!-- 100% 용 --><div><div><div><!-- //100% 용 -->

        <!-- m1s4_t1 -->
        <div class="m1s4 container init tm1">
            <div class="item1 c1 bsContain">
                <h2>면적</h2>
                <div class="t1">
                    <ul class="bu">
                        <li>부지 : 10,520㎡</li>
                        <li>건축물 : 2,675㎡ 약 810평</li>
                    </ul>
                </div>
            </div>
            <div class="item1 c2">
                <h2>시설내용</h2>
                <div class="t1">
                    <ul class="r1">
                        <li><span class="tit1"><span class="bg">1층</span></span><span class="list1">제1작업실, 제2작업실, 제3작업실, <span class="brPC"></span>첨단장비실, 인공건조실, 촬영실, <span class="brPC"></span>저장실, 체험실, 전시실,사무실 등</span></li>
                        <li><span class="tit1"><span class="bg">2층</span></span><span class="list1">제1강의실, 제2강의실, <span class="brPC"></span>디자인 컴퓨터제도실, 강당, <span class="brPC"></span>대회의실, 숙박실 등</span></li>
                    </ul>
                </div>
                <div class="btns">
                    <a href='<c:url value="/tour/buildingInfo.do"/>' class="b1">전수관 둘러보기</a>
                </div>
            </div>
            <div class="item1 c3">
                <h2>이용대상</h2>
                <div class="t1">
                    <ul class="r1">
                        <li><span class="tit1"><span class="bg">교육</span></span><span class="list1">중·고등학생,<br />대학생,<br />일반인 </span></li>
                        <li><span class="tit1"><span class="bg">체험</span></span><span class="list1">중·고등학생,<br />대학생,<br />일반인 </span></li>
                        <li><span class="tit1"><span class="bg">전시</span></span><span class="list1">목공예인,<br />교육생</span></li>
                    </ul>
                </div>
                <div class="btns">
                    <a href='<c:url value="/prgm/prgmList.do"/>' class="b1">교육신청</a>
                    <a href='<c:url value="/exprn/exprnList.do"/>' class="b2">체험신청</a>
                </div>
            </div>
        </div>
        <!-- // m1s4_t1 -->
    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
