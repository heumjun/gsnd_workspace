<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 1:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="11404000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- notice1 -->
            <div class="notice1">
                <i class="ic1 bsContain"></i>
                <ul>
                    <li><em>신청 당일 6시까지 미입금시 신청취소입니다.</em></li>
                    <li>달력 안의 예약현황의 숫자는 (예약인원/정원)을 의미합니다.</li>
                </ul>
            </div>
            <!-- /notice1 -->

            <!-- res1cal1 -->
            <div class="res1cal1">

                <div class="month">
                    <strong class="h1">${year}.<em class="em1">${month}</em></strong>
                    <a href="#" id="prevMonth" class="b1 prev"><i class="ic1 bsContain"></i> <span class="blind">이전 달 보기</span></a>
                    <a href="#" id="nextMonth" class="b1 next"><i class="ic1 bsContain"></i> <span class="blind">다음 달 보기</span></a>
                </div>

                <!-- note1 -->
                <div class="note1 init">
                    <div class="menu">
                        <ul>
                            <li><a class="st0"><b class="ic1" title="휴관일">휴</b> <span class="t1">휴관일</span></a></li>
                            <li><a class="st1"><b class="ic1" title="예약가능">예</b> <span class="t1">예약가능</span></a></li>
                            <li><a class="st2"><b class="ic1" title="예약기간종료">종</b> <span class="t1">예약기간종료</span></a></li>
                            <li><a class="st3"><b class="ic1" title="예약완료">완</b> <span class="t1">예약완료</span></a></li>
                            <li><a class="st4"><b class="ic1" title="예약불가(운영 측 사정)">불</b> <span class="t1">예약불가(운영 측 사정)</span></a></li>
                        </ul>
                    </div>
                </div>
                <!-- /note1 -->

                <table class="t1cal1">
                    <caption>
                        <strong class="blind">달력</strong>
                        <span class="blind" title="요약(summary)">예약 현황 달력. 링크를 통해서 예약가능합니다.</span>
                    </caption>
                    <thead>
                    <tr class="day">
                        <th scope="col" class="sun">일</th>
                        <th scope="col">월</th>
                        <th scope="col">화</th>
                        <th scope="col">수</th>
                        <th scope="col">목</th>
                        <th scope="col">금</th>
                        <th scope="col" class="sat">토</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="result" items="${calendarList}" varStatus="status">

                        <tr>

                            <td class="sun">
                            <div class="cell">
                                <div class="date" title="일">${result.sun}</div>
                                <c:if test="${result.sun != null && result.sun != ''}">
                                    <div class="menu">
                                        <ul>
                                            <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                <c:if test="${result.sun == result2.day}">
                                                    <li><a href="#" data-day="${result.sun}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                            </div>
                        </td>

                            <td>
                                <div class="cell">
                                    <div class="date" title="일">${result.mon}</div>
                                    <c:if test="${result.mon != null && result.mon != ''}">
                                        <div class="menu">
                                            <ul>
                                                <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                    <c:if test="${result.mon == result2.day}">
                                                        <li><a href="#" data-day="${result.mon}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <div class="cell">
                                    <div class="date" title="일">${result.tue}</div>
                                    <c:if test="${result.tue != null && result.tue != ''}">
                                        <div class="menu">
                                            <ul>
                                                <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                    <c:if test="${result.tue == result2.day}">
                                                        <li><a href="#" data-day="${result.tue}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <div class="cell">
                                    <div class="date" title="일">${result.wed}</div>
                                    <c:if test="${result.wed != null && result.wed != ''}">
                                        <div class="menu">
                                            <ul>
                                                <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                    <c:if test="${result.wed == result2.day}">
                                                        <li><a href="#" data-day="${result.wed}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </td>
                            <td><div class="cell">
                                <div class="date" title="일">${result.thu}</div>
                                <c:if test="${result.thu != null && result.thu != ''}">
                                    <div class="menu">
                                        <ul>
                                            <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                <c:if test="${result.thu == result2.day}">
                                                    <li><a href="#" data-day="${result.thu}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                            </div></td>
                            <td><div class="cell">
                                <div class="date" title="일">${result.fri}</div>
                                <c:if test="${result.fri != null && result.fri != ''}">
                                    <div class="menu">
                                        <ul>
                                            <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                <c:if test="${result.fri == result2.day}">
                                                    <li><a href="#" data-day="${result.fri}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                            </div></td>
                            <td class="sat"><div class="cell">
                                <div class="date" title="일">${result.sat}</div>
                                <c:if test="${result.sat != null && result.sat != ''}">
                                    <div class="menu">
                                        <ul>
                                            <c:forEach var="result2" items="${dataList}" varStatus="status">
                                                <c:if test="${result.sat == result2.day}">
                                                    <li><a href="#" data-day="${result.sat}" data-time="${result2.text}" data-code="${result2.code}" class="${result2.style}"><b class="ic1" title="${result2.text2}">${result2.text3}</b> <span class="t1">${result2.text} <br/>${result2.text4}</span></a></li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                            </div></td>
                        </tr>

                    </c:forEach>

                    </tbody>
                </table>

            </div>
            <!-- /res1cal1 -->



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                <c:if test="${msgCd != null}">
                    if ("${msgCd}" == "ERR001") {
                        alert("이미 예약이 완료된 체험입니다.");
                    }
                </c:if>

                $("a[data-day]").click(function(event) {
                    event.preventDefault();
                    var day = $(this).attr("data-day");
                    var time = $(this).attr("data-time");
                    var code = $(this).attr("data-code");
                    var view_url = "<c:url value="/exprn/exprnPay.do"/>";

                    //예약가능 체크
                    if (code != '02') {
                        alert("예약이 종료된 체험입니다.")
                        return false;
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnForm.exprnId}'))
                        .append($("<input />").attr("type","hidden").attr("name","yearMonth").val('${year}${month}'))
                        .append($("<input />").attr("type","hidden").attr("name","day").val(day))
                        .append($("<input />").attr("type","hidden").attr("name","time").val(time))
                        .submit();

                    return false;
                });

                $("#nextMonth").click(function(event) {
                    event.preventDefault();
                    var year = '${year}';
                    var month = ${month};
                    var view_url = "<c:url value="/exprn/exprnReqRegit.do"/>";

                    if (month == '12') {
                        year = Number(year) + 1;
                        month = 1;
                    } else {
                        month = Number(month) + 1;
                    }

                    if (month < 10) {
                        month = '0' + month;
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnForm.exprnId}'))
                        .append($("<input />").attr("type","hidden").attr("name","yearMonth").val(year+''+month))
                        .submit();

                    return false;
                });

                $("#prevMonth").click(function(event) {
                    event.preventDefault();
                    var year = '${year}';
                    var month = ${month};
                    var view_url = "<c:url value="/exprn/exprnReqRegit.do"/>";

                    if (month == '1') {
                        year = Number(year) - 1;
                        month = 12;
                    } else {
                        month = Number(month) - 1;
                    }

                    if (month < 10) {
                        month = '0' + month;
                    }

                    //alert(year);
                    //alert(month);

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnForm.exprnId}'))
                        .append($("<input />").attr("type","hidden").attr("name","yearMonth").val(year+''+month))
                        .submit();

                    return false;
                });
            });

        </script>

    </layout:put>

</layout:extends>
