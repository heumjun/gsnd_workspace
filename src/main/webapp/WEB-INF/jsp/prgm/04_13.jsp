<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:40
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
            <c:param name="menuNo" value="11402000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예품주문완료
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- complete1 -->
            <div class="complete1 tac">
                <div class="wrap1">
                    <i class="ic1 bsContain"></i>
                    <p class="txt1">예약이 완료되었습니다.</p>
                    <p class="txt2"><span class="tdu">마이페이지 &gt; 프로그램 신청/취소</span> 현황 메뉴에서 <span class="dpib">예약 내역 확인하세요.</span></p>
                    <p class="txt3">신청 당일 6시까지 미입금시 신청취소입니다.</p>
                    <div class="btns">
                        <a href="#" class="button" page-index="1">목록</a>
                        &nbsp;
                        <a href="#" class="button" page-index2="1">나의 예약 내역</a>
                    </div>
                </div>

                <div class="bbs_write">
                    <table class="t1">
                        <caption>
                            <strong class="h1 blind">예약정보</strong>
                            <span class="blind" title="요약(summary)">(프로그램명,교육일시,결재방법,결재금액)</span>
                        </caption>
                        <col style="width:13em" /><col />
                        <tbody>
                        <tr>
                            <th scope="row">프로그램명</th>
                            <td>${WcrfBuyForm.wcrfNm}</td>
                        </tr>
                        <tr>
                            <th scope="row">교육일시</th>
                            <td>${WcrfBuyForm.purchsDesc}</td>
                        </tr>
                        <tr>
                            <th scope="row">결재방법</th>
                            <td>${WcrfBuyForm.setleSeNm}</td>
                        </tr>
                        <tr>
                            <th scope="row">결재금액</th>
                            <td>
                                <c:set var="price" value="${WcrfBuyForm.purchsAllAmt}" />
                                <fmt:formatNumber value="${price}" type="number"  />원
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /complete1 -->



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("a[page-index]").click(function(event) {
                    event.preventDefault();
                    var pageIndex = $(this).attr("page-index");
                    var view_url = "<c:url value="/prgm/prgmList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","pageIndex").val(pageIndex))
                        .submit();

                    return false;
                });

                $("a[page-index2]").click(function(event) {
                    event.preventDefault();
                    var pageIndex = $(this).attr("page-index2");
                    var view_url = "<c:url value="/mypage/prgmMyList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","pageIndex").val(pageIndex))
                        .submit();

                    return false;
                });

            });

        </script>

    </layout:put>

</layout:extends>
