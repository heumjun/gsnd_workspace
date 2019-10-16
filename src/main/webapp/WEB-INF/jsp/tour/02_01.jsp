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
            <c:param name="menuNo" value="11201000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">
        <!-- #floor1 -->
        <div id="floor1">
            <!-- cnb1 -->
            <div id="cnb1">
                <ul class="col3">
                    <li class="tab"><a href="#floor1c1">본관 1층</a></li>
                    <li class="tab"><a href="#floor1c2">본관 2층</a></li>
                    <li class="tab"><a href="#floor1c3">별관 1층</a></li>
                </ul>
            </div>
            <!-- /cnb1 -->

            <!-- floor1c1 -->
            <div id="floor1c1" class="cont">
                <div class="m2s1 mbf1">
                    <div class="note1">
                        <h2>본관 1층</h2>
                        <p><i class="ic1 bsContain"></i><span class="no1 ic1">숫자</span>를 클릭하시면 <span class="brT"></span>주요시설의 자세한 사진을 보실 수 있습니다.</p>
                    </div>
                    <div class="map1 bsContain">
                        <span class="t1 info1"><a href="#mbf1info1" class="toggle"><span class="no1 ic1">1</span><span class="name1">제 1작업실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info2"><a href="#mbf1info2" class="toggle"><span class="no1 ic1">2</span><span class="name1">제 2작업실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info3"><a><span class="no1">3</span><span class="name1">부출입구</span></a></span>
                        <span class="t1 info4"><a><span class="no1">4</span><span class="name1">화장실</span></a></span>
                        <span class="t1 info5"><a><span class="no1">5</span><span class="name1">첨단장비실</span></a></span>
                        <span class="t1 info6"><a href="#mbf1info6" class="toggle"><span class="no1 ic1">6</span><span class="name1">제 3작업실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info7"><a href="#mbf1info7" class="toggle"><span class="no1 ic1">7</span><span class="name1">인공건조실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info8"><a><span class="no1">8</span><span class="name1">부출입구</span></a></span>
                        <span class="t1 info9"><a href="#mbf1info9" class="toggle"><span class="no1 ic1">9</span><span class="name1">촬영실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info10"><a><span class="no1">10</span><span class="name1">저장실</span></a></span>
                        <span class="t1 info11"><a><span class="no1">11</span><span class="name1">사무실</span></a></span>
                        <span class="t1 info12"><a href="#mbf1info12" class="toggle"><span class="no1 ic1">12</span><span class="name1">체험실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info13"><a><span class="no1">13</span><span class="name1">매점</span></a></span>
                        <span class="t1 info14"><a href="#mbf1info14" class="toggle"><span class="no1 ic1">14</span><span class="name1">전시실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info15"><a><span class="no1">15</span><span class="name1">주출입구</span></a></span>
                    </div>
                    <div class="desc1">
                        <span class="t1"><a><span class="no1">1</span><span class="name1">제 1작업실</span></a></span>
                        <span class="t1"><a><span class="no1">2</span><span class="name1">제 2작업실</span></a></span>
                        <span class="t1"><a><span class="no1">3</span><span class="name1">부출입구</span></a></span>
                        <span class="t1"><a><span class="no1">4</span><span class="name1">화장실</span></a></span>
                        <span class="t1"><a><span class="no1">5</span><span class="name1">첨단장비실</span></a></span>
                        <span class="t1"><a><span class="no1">6</span><span class="name1">제3작업실</span></a></span>
                        <span class="t1"><a><span class="no1">7</span><span class="name1">인공건조실</span></a></span>
                        <span class="t1"><a><span class="no1">8</span><span class="name1">부출입구</span></a></span>
                        <span class="t1"><a><span class="no1">9</span><span class="name1">촬영실</span></a></span>
                        <span class="t1"><a><span class="no1">10</span><span class="name1">저장실</span></a></span>
                        <span class="t1"><a><span class="no1">11</span><span class="name1">사무실</span></a></span>
                        <span class="t1"><a><span class="no1">12</span><span class="name1">체험실</span></a></span>
                        <span class="t1"><a><span class="no1">13</span><span class="name1">매점</span></a></span>
                        <span class="t1"><a><span class="no1">14</span><span class="name1">전시실</span></a></span>
                        <span class="t1"><a><span class="no1">15</span><span class="name1">주출입구</span></a></span>
                    </div>
                </div>
            </div>
            <!-- //floor1c1 -->


            <!-- floor1c2 -->
            <div id="floor1c2" class="cont">
                <div class="m2s1 mbf2">
                    <div class="note1">
                        <h2>본관 2층</h2>
                        <p><i class="ic1 bsContain"></i><span class="no1">숫자</span>를 클릭하시면 <span class="brT"></span>주요시설의 자세한 사진을 보실 수 있습니다.</p>
                    </div>
                    <div class="map1 bsContain">
                        <span class="t1 info1"><a href="#mbf2info1" class="toggle"><span class="no1 ic1">1</span><span class="name1">제1작업실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info2"><a href="#mbf2info2" class="toggle"><span class="no1 ic1">2</span><span class="name1">제2작업실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info3"><a><span class="no1">3</span><span class="name1">화장실</span></a></span>
                        <span class="t1 info4"><a href="#mbf2info4" class="toggle"><span class="no1 ic1">4</span><span class="name1">디자인 컴퓨터 제도실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info5"><a><span class="no1">5</span><span class="name1">숙박실(남)</span></a></span>
                        <span class="t1 info6"><a><span class="no1">6</span><span class="name1">탈의실</span></a></span>
                        <span class="t1 info7"><a><span class="no1">7</span><span class="name1">숙박실(여)</span></a></span>
                        <span class="t1 info8"><a href="#mbf2info8" class="toggle"><span class="no1 ic1">8</span><span class="name1">강당</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info9"><a href="#mbf2info9" class="toggle"><span class="no1 ic1">9</span><span class="name1">소회의실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info10"><a><span class="no1">10</span><span class="name1">자료실</span></a></span>
                        <span class="t1 info11"><a href="#mbf2info11" class="toggle"><span class="no1 ic1">11</span><span class="name1">대회의실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info12"><a><span class="no1">12</span><span class="name1">휴게실/탕비실</span></a></span>
                    </div>
                    <div class="desc1">
                        <span class="t1"><a><span class="no1">1</span><span class="name1">제1작업실</span></a></span>
                        <span class="t1"><a><span class="no1">2</span><span class="name1">제2작업실</span></a></span>
                        <span class="t1"><a><span class="no1">3</span><span class="name1">화장실</span></a></span>
                        <span class="t1"><a><span class="no1">4</span><span class="name1">디자인 컴퓨터 제도실</span></a></span>
                        <span class="t1"><a><span class="no1">5</span><span class="name1">숙박실(남)</span></a></span>
                        <span class="t1"><a><span class="no1">6</span><span class="name1">탈의실</span></a></span>
                        <span class="t1"><a><span class="no1">7</span><span class="name1">숙박실(여)</span></a></span>
                        <span class="t1"><a><span class="no1">8</span><span class="name1">강당</span></a></span>
                        <span class="t1"><a><span class="no1">9</span><span class="name1">소회의실</span></a></span>
                        <span class="t1"><a><span class="no1">10</span><span class="name1">자료실</span></a></span>
                        <span class="t1"><a><span class="no1">11</span><span class="name1">대회의실</span></a></span>
                        <span class="t1"><a><span class="no1">12</span><span class="name1">휴게실/탕비실</span></a></span>
                    </div>
                </div>
            </div>
            <!-- //floor1c2 -->

            <!-- floor1c3 -->
            <div id="floor1c3" class="cont">
                <div class="m2s1 abf1">
                    <div class="note1">
                        <h2>별관</h2>
                        <p><i class="ic1 bsContain"></i><span class="no1">숫자</span>를 클릭하시면 <span class="brT"></span>주요시설의 자세한 사진을 보실 수 있습니다.</p>
                    </div>
                    <div class="map1 bsContain">
                        <span class="t1 info1"><a><span class="no1">1</span><span class="name1">분체도장실</span></a></span>
                        <span class="t1 info2"><a><span class="no1">2</span><span class="name1">도장실-1</span></a></span>
                        <span class="t1 info3"><a><span class="no1">3</span><span class="name1">도장실-2</span></a></span>
                        <span class="t1 info4"><a href="#abf1info4" class="toggle"><span class="no1 ic1">4</span><span class="name1">건조실</span><i class="ic1 bsContain"></i></a></span>
                        <span class="t1 info5"><a href="#abf1info5" class="toggle"><span class="no1 ic1">5</span><span class="name1">기계실</span><i class="ic1 bsContain"></i></a></span>
                    </div>
                    <div class="desc1">
                        <span class="t1"><a><span class="no1">1</span><span class="name1">분체도장실</span></a></span>
                        <span class="t1"><a><span class="no1">2</span><span class="name1">도장실-1</span></a></span>
                        <span class="t1"><a><span class="no1">3</span><span class="name1">도장실-2</span></a></span>
                        <span class="t1"><a><span class="no1">4</span><span class="name1">건조실</span></a></span>
                        <span class="t1"><a><span class="no1">5</span><span class="name1">기계실</span></a></span>
                    </div>
                </div>
            </div>
            <!-- //floor1c3 -->
        </div>
        <!-- //#floor1 -->
        <script type="text/javascript">/*<![CDATA[*/
        $(function(){
            fncTab1('click', '#floor1', '.tab', 1, '.cont');
        });
        /*]]>*/</script>

        <%@include file="/inc/facility/02_01_01.jsp" %>
        <%@include file="/inc/facility/02_01_02.jsp" %>
        <%@include file="/inc/facility/02_01_03.jsp" %>

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
