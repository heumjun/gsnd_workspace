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
            <c:param name="menuNo" value="${menuNo}"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예품주문완료
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- cart_cnb -->
            <div class="cart_cnb">
                <c:if test="${menuNo == '11702000'}">
                    <ul class="col4">
                    <li><a href="#"><i class="ic1 bsContain"></i>장바구니</a></li>
                </c:if>
                <c:if test="${menuNo != '11702000'}">
                    <ul class="col3">
                </c:if>
                    <li><a href="#"><i class="ic2 bsContain"></i>주문하기</a></li>
                    <li><a href="#"><i class="ic3 bsContain"></i>결재하기</a></li>
                    <li class="on"><a href="#"><i class="ic4 bsContain"></i>주문완료</a></li>
                </ul>
            </div>
            <!-- / cart_cnb -->

            <!-- complete1 -->
            <div class="complete1 tac">
                <div class="wrap1">
                    <i class="ic3 bsContain"></i>
                    <p class="txt1">목공예 주문이 정상적으로 접수되었습니다.</p>
                    <p class="txt2"><span class="tdu">마이페이지 &gt; 목공예 주문내역</span> 현황 메뉴에서 <span class="dpib">예약 내역 확인하세요.</span></p>
                    <p class="txt3">
                        아래의 목공예 주문정보를 다시 한번 확인해주세요.
                    </p>
                    <div class="btns">
                        <a href="#" class="button" page-index="1">쇼핑계속하기</a>
                        &nbsp;
                        <a href="#" class="button" page-index2="1">나의 목공예 주문내역</a>
                    </div>
                </div>

                <div class="bbs_write">
                    <table class="t1">
                        <caption>
                            <strong class="h1 blind">주문정보</strong>
                            <span class="blind" title="요약(summary)">(주문번호,결재방법,결재금액,배송지정보,주문자명,주문일자)</span>
                        </caption>
                        <col style="width:13em" /><col />
                        <tbody>
                        <tr>
                            <th scope="row">주문번호</th>
                            <td>${WcrfBuyForm.purchsLstId}</td>
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
                        <tr>
                            <th scope="row">배송지정보</th>
                            <td>${WcrfBuyForm.orerAddr} ${WcrfBuyForm.orerAddrDtl}</td>
                        </tr>
                        <tr>
                            <th scope="row">주문자명</th>
                            <td>${WcrfBuyForm.byerNm}</td>
                        </tr>
                        <tr>
                            <th scope="row">주문일자</th>
                            <td>${WcrfBuyForm.purchsDt}</td>
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
                    var view_url = "<c:url value="/wcrf/wcrfList.do"/>";

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
                    var view_url = "<c:url value="/mypage/wcrfMyPayList.do"/>";

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
