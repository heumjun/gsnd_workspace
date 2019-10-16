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
            <c:param name="menuNo" value="11703000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예 구매내역 상세
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- 주문/결재 작성 폼 -->
            <form:form commandName="WcrfRefdForm" id="WcrfRefdForm" method="post">

                <form:hidden path="purchsLstId" value="${WcrfBuyForm.purchsLstId}" />
                <form:hidden path="setleId" value="${WcrfBuyForm.setleId}" />
                <form:hidden path="purchsProgrsSttus" value="${WcrfBuyForm.purchsProgrsSttus}" />
                <form:hidden path="returnAmt" value="${sum}" />
                <form:hidden path="refdSe" />
                <form:hidden path="refdResnCd" />

                <!-- fieldset -->
                <fieldset><legend class="blind">주문/결재 작성 폼</legend>
                    <h2 class="hb1 h2">주문리스트</h2>

                    <!-- cart_list -->
                    <div class="cart_list">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">장바구니 목록</strong>
                            </caption>
                            <thead>
                            <tr>
                                <th class="cart_title" scope="col">제품</th>
                                <th class="cart_num" scope="col">수량</th>
                                <th class="cart_price" scope="col">가격</th>
                                <!--<th class="cart_delivery" scope="col">배송비</th>-->
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="result" items="${wcrfBuyList}" varStatus="status">
                                <tr>
                                    <td class="cart_title">
                                        <a href="#" class="a1"><span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.wcrfDesc}" /></span>
                                            <span class="text1">${result.wcrfNm}</span></a>
                                    </td>
                                    <td class="cart_num">${result.wcrfCnt}</td>
                                    <td class="cart_price">
                                        <c:set var="price" value="${result.wcrfAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />
                                    </td>
                                    <!--<td class="cart_delivery">3,000</td>-->
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                    <!-- / cart_list -->

                    <h2 class="hb1 h2">주문자 정보</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                                </caption>
                                <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label>이름</label></th>
                                <td>${WcrfBuyForm.byerNm}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label>메일주소</label></th>
                                <td>${WcrfBuyForm.byerEmail}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label>연락처</label></th>
                                <td>${WcrfBuyForm.byerTelNo}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">배송지 정보</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label>이름</label></th>
                                <td>${WcrfBuyForm.orerNm}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label>전화번호</label></th>
                                <td>${WcrfBuyForm.orerTelNo}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label>연락처</label></th>
                                <td>${WcrfBuyForm.orerHp}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label>주소</label></th>
                                <td>
                                    ${WcrfBuyForm.orerZip}
                                    <!--<span class="vam">-</span>
                                    <input type="text" id="txt_orerZip2" name="orerZip2" size="3" maxlength="3" placeholder="000" title="우편번호 뒷자리" />-->
                                    <br />
                                    ${WcrfBuyForm.orerAddr}
                                    <br />
                                    ${WcrfBuyForm.orerAddrDtl}
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>주문메세지</label></th>
                                <td>${WcrfBuyForm.orderMessCn}</td>
                            </tr>
                            <!--<tr>
                                <th scope="row"><label for="f1name">무통장 입금자명</label></th>
                                <td><input type="text" id="f1name" placeholder="실명" />
                                    <span class="explain ">* 주문자와 같을 경우 생략 가능</span>
                                </td>
                            </tr>-->
                            </tbody>
                        </table>

                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">결제 금액</h2>
                    <!-- order_list -->
                    <div class="order_list">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">결제 금액</strong>
                            </caption>
                            <col style="width:30%" />
                            <col style="width:5%" />
                            <!--<col style="width:30%" />
                            <col style="width:5%" />-->
                            <col style="width:30%" />
                            <thead>
                            <tr>
                                <th scope="col">상품금액</th>
                                <th scope="col"></th>
                                <!--<th scope="col">배송비</th>
                                <th scope="col"></th>-->
                                <th scope="col">결제금액</th>
                            </tr>
                            <thead>
                            <tbody>
                            <tr>
                                <td>
                                    <c:set var="price2" value="${sum}" />
                                    <fmt:formatNumber value="${price2}" type="number"  />원
                                </td>
                                <td><i class="ic1 bsContain"></i></td>
                                <!--<td>3,000원</td>
                                <td><i class="ic2 bsContain"></i></td>-->
                                <td class="order_total_price">
                                    <c:set var="price3" value="${sum}" />
                                    <fmt:formatNumber value="${price3}" type="number"  />원
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- / order_list -->

                    <h2 class="hb1 h2">결제 정보 및 주문 상태</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row">결제방법</th>
                                <td>${WcrfBuyForm.setleSeNm}</td>
                            </tr>
                            <tr>
                                <th scope="row">주문상태</th>
                                <td>${WcrfBuyForm.purchsProgrsSttusNm}</td>
                            </tr>
                            <tr>
                                <th scope="row">송장번호</th>
                                <td>${WcrfBuyForm.invoiceNumber}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">주문 취소 및 환불</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문 취소 및 환불</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label for="txt_refdSe">환불방법</label></th>
                                <td>
                                    <select id="txt_refdSe" title="환불방법">
                                        <option value=""></option>
                                        <option value="01">카드승인취소</option>
                                        <option value="02">계좌입금</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdReqDt">반품/취소신청일자</label></th>
                                <td>
                                    <input type="tel" id="txt_refdReqDt" name="refdReqDt" size="20" maxlength="20" title="반품/취소신청일자" value="${WcrfRefdForm.refdReqDt}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdResnCd">반품/취소사유</label></th>
                                <td>
                                    <select id="txt_refdResnCd" title="반품/취소사유">
                                        <option value=""></option>
                                        <option value="01">단순변심</option>
                                        <option value="02">제품하자</option>
                                        <option value="03">기타</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdSttusCd">진행상태</label></th>
                                <td>
                                    <select id="txt_refdSttusCd" title="진행상태" disabled >
                                        <!--<option value=""></option>-->
                                        <option selected value="01">신청</option>
                                        <option value="02">접수</option>
                                        <option value="03">완료</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdBankOwr">예금주</label></th>
                                <td>
                                    <input type="text" id="txt_refdBankOwr" name="refdBankOwr" size="20" maxlength="20" title="예금주" value="${WcrfRefdForm.refdBankOwr}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdBank">은행명</label></th>
                                <td>
                                    <input type="text" id="txt_refdBank" name="refdBank" size="20" maxlength="20" title="은행명" value="${WcrfRefdForm.refdBank}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdAccNo">계좌번호</label></th>
                                <td>
                                    <input type="text" id="txt_refdAccNo" name="refdAccNo" size="20" maxlength="20" title="계좌번호" value="${WcrfRefdForm.refdAccNo}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_returnCn">반품취소사유</label></th>
                                <td>
                                    <textarea id="txt_returnCn" name="returnCn" rows="5" cols="80" class="w100" >${WcrfRefdForm.returnCn}</textarea></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_refdRsltCn">처리내용</label></th>
                                <td>
                                    <textarea id="txt_refdRsltCn" name="refdRsltCn" rows="5" cols="80" class="w100" disabled >${WcrfRefdForm.refdRsltCn}</textarea></td>
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
                        <c:if test="${WcrfBuyForm.purchsProgrsSttus == '01'
                        || WcrfBuyForm.purchsProgrsSttus == '02'
                        || WcrfBuyForm.purchsProgrsSttus == '03'
                        || WcrfBuyForm.purchsProgrsSttus == '04'
                        || WcrfBuyForm.purchsProgrsSttus == '05'}">
                            <button id="btn_save" class="button submit">주문취소 / 환불</button>
                        </c:if>
                        <a href="<c:url value="/mypage/wcrfMyPayList.do?pageIndex=1"/>" class="button">목록</a>
                    </p>
                </div>
                <!-- /infosection1 -->

            </form:form>
            <!-- //주문/결재 작성 폼 -->



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("select[id=txt_refdSe]").val("${WcrfRefdForm.refdSe}");
                $("select[id=txt_refdResnCd]").val("${WcrfRefdForm.refdResnCd}");
                $("select[id=txt_refdSttusCd]").val("${WcrfRefdForm.refdSttusCd}");

                $("#btn_save").click(function() {

                    var view_url = "<c:url value="/mypage/wcrfRefdSave.do"/>";

                    $("#refdSe").val($("select[id=txt_refdSe]").val());
                    $("#refdResnCd").val($("select[id=txt_refdResnCd]").val());

                    $("#WcrfRefdForm")
                        .attr("action", view_url)
                        .submit();

                    return false;

                });

            });

        </script>

    </layout:put>

</layout:extends>
