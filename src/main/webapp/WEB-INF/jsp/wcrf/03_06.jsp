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
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예품결제하기
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
                    <li class="on"><a href="#"><i class="ic3 bsContain"></i>결재하기</a></li>
                    <li><a href="#"><i class="ic4 bsContain"></i>주문완료</a></li>
                </ul>
            </div>
            <!-- / cart_cnb -->

            <!-- 주문/결재 작성 폼 -->
            <form:form commandName="WcrfBuyForm" id="WcrfBuyForm" method="post">
                <form:hidden path="menuNo" value="${menuNo}" />
                <form:hidden path="bsktIdList" value="${bsktIdList}" />

                <!-- fieldset -->
                <fieldset><legend class="blind">주문/결재 작성 폼</legend>

                    <h2 class="hb1 h2">결제 정보</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row">구매자</th>
                                <td>${WcrfBuyForm.byerNm}</td>
                            </tr>
                            <tr>
                                <th scope="row">EMail</th>
                                <td>${WcrfBuyForm.byerEmail}</td>
                            </tr>
                            <tr>
                                <th scope="row">연락처</th>
                                <td>${WcrfBuyForm.byerTelNo}</td>
                            </tr>
                            <tr>
                                <th scope="row">결제금액</th>
                                <td>
                                    <c:set var="price" value="${WcrfBuyForm.purchsAllAmt}" />
                                    <fmt:formatNumber value="${price}" type="number"  />원
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">결제방법</th>
                                <td>${WcrfBuyForm.setleSeNm}</td>
                            </tr>
                            <tr>
                                <th scope="row">현금영수증</th>
                                <td>${WcrfBuyForm.cashReceiptsOptNm}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                </fieldset>
                <!-- //fieldset -->
                <!-- infosection1 -->
                <div class="infosection1">
                    <p class="tac">
                        <c:if test="${WcrfBuyForm.setleSe == '01'}">
                            <button id="btn_save" type="button" value="" class="button submit">결제하기</button>
                        </c:if>
                        <c:if test="${WcrfBuyForm.setleSe == '02'}">
                            <button id="btn_confirm" type="button" value="" class="button submit">주문확인</button>
                        </c:if>
                    </p>
                </div>
                <!-- /infosection1 -->

            </form:form>
            <!-- //주문/결재 작성 폼 -->


    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("#btn_save").click(function() {

                    event.preventDefault();

                    //var view_url = "<c:url value="/wcrf/wcrfPaySave.do"/>";

                    //$("#WcrfBuyForm")
                    //    .attr("action", view_url)
                    //    .submit();

                    var IMP = window.IMP; // 생략해도 괜찮습니다.
                    IMP.init("imp52367176"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.

                    var payMethod = 'card';
                    //if ('${WcrfBuyForm.setleSe}' == '02') {
                    //    payMethod = 'vbank';
                    //}

                    // IMP.request_pay(param, callback) 호출
                    IMP.request_pay({ // param
                        pg: "kcp",
                        pay_method: payMethod,
                        merchant_uid: "${WcrfBuyForm.storeDelngId}",
                        name: "${WcrfBuyForm.wcrfNm}",
                        amount: ${WcrfBuyForm.purchsAllAmt},
                        buyer_email: "${WcrfBuyForm.byerEmail}",
                        buyer_name: "${WcrfBuyForm.byerNm}",
                        buyer_tel: "${WcrfBuyForm.byerTelNo}",
                        buyer_addr: "${WcrfBuyForm.orerAddr}",
                        buyer_postcode: "${WcrfBuyForm.orerZip}"
                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시 로직,
                            //alert('결제성공 : ' + rsp.imp_uid + ' ' + rsp.merchant_uid);

                            var data = {};
                            //data["imp_uid"] = 'imp_524223945095';
                            //data["merchant_uid"] = 'ORDR_0000000324';
                            data["imp_uid"] = rsp.imp_uid;
                            data["merchant_uid"] = rsp.merchant_uid;

                            //var obj = "imp_uid=imp_524223945095";

                            // jQuery로 HTTP 요청
                            $.ajax({
                                url: "<c:url value='/wcrf/payComplete.do' />"+"?imp_uid="+rsp.imp_uid+"&merchant_uid="+rsp.merchant_uid, // 가맹점 서버
                                type: "POST",
                                dataType: "json",
                                contentType : "application/json",
                                data : JSON.stringify(data)
                                //data : {'imp_uid' : 'imp_524223945095'}
                            }).done(function (data) {
                                switch(data.status) {
                                    case "success":
                                        // 결제 성공 시 로직
                                        alert('결제 성공');

                                        var view_url = "<c:url value="/wcrf/wcrfPaySave.do"/>";

                                        $("#WcrfBuyForm")
                                            .attr("action", view_url)
                                            .append($("<input />").attr("type","hidden").attr("name","purchsLstId").val(data.purchsLstId))
                                            .append($("<input />").attr("type","hidden").attr("name","storeDelngId").val(data.storeDelngId))
                                            .submit();

                                        break;
                                    case "fail":
                                        // 결제 실패 시 로직
                                        alert('결제 실패. 관리자에게 문의바랍니다.');
                                        break;
                                }
                            })

                        } else {
                            // 결제 실패 시 로직,
                            alert('결제실패 : ' + rsp.error_code + ' ' + rsp.error_msg);
                        }
                    });
                });


                $("#btn_confirm").click(function() {

                    event.preventDefault();
                    var view_url = "<c:url value="/wcrf/wcrfPaySave.do"/>";

                    $("#WcrfBuyForm")
                        .attr("action", view_url)
                        .append($("<input />").attr("type","hidden").attr("name","purchsLstId").val('${WcrfBuyForm.purchsLstId}'))
                        .append($("<input />").attr("type","hidden").attr("name","storeDelngId").val('${WcrfBuyForm.storeDelngId}'))
                        .submit();

                    return false;

                });

            });

        </script>

    </layout:put>

</layout:extends>
