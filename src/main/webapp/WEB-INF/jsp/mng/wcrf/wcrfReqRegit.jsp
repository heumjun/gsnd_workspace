<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">목공예품(구매/결제)</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">목공예품관리</a></li>
                        <li><a class="on" href="#">목공예품(구매/결제)</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">목공예품(구매/결제) 상세</h2>
                <div class="form">

                    <form:form commandName="WcrfBuyForm" id="WcrfBuyForm" method="post">
                        <form:hidden path="purchsProgrsSttus"/>
                        <form:hidden path="purchsLstId"/>
                        <form:hidden path="storeDelngId"/>

                        <fieldset>
                            <legend>목공예품등록</legend>
                            <table class="template-table">
                                <caption class="display-none">목공예품등록</caption>
                                <colgroup>
                                    <col style="width:100px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:90px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_purchsLstId">구매목록번호</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_purchsLstId" name="purchsLstId" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.purchsLstId}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_purchsDt">구매일자</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_purchsDt" name="purchsDt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.purchsDt}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_purchsAllAmt">구매금액</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_purchsAllAmt" name="purchsAllAmt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.purchsAllAmt}" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_setleSeNm">결제방법</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_setleSeNm" name="setleSeNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleSeNm}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_purchsDt">결제일시</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_setleDt" name="setleDt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleDt}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_purchsAllAmt">결제금액</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_setleAmt" name="setleAmt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleAmt}" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_byerNm">구매자</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_byerNm" name="byerNm" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.byerNm}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_rcpmnyNm">무통장입금자명</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_rcpmnyNm" name="rcpmnyNm" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.rcpmnyNm}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_cashReceiptsOptNm">현금영수증</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_cashReceiptsOptNm" name="cashReceiptsOptNm" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.cashReceiptsOptNm}" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_searchPurchsProgrsSttus">진행상태</label></td>
                                    <td colspan="2" class="align-left">
                                        <!--<input type="text" id="txt_purchsProgrsSttusNm" name="purchsProgrsSttusNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.purchsProgrsSttusNm}"/>-->
                                        <input id="txt_searchPurchsProgrsSttus" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_rcpmnyAmt">입금금액</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_rcpmnyAmt" name="rcpmnyAmt" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.rcpmnyAmt}" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_invoiceNumber">송장번호</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_invoiceNumber" name="invoiceNumber" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.invoiceNumber}" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                    </form:form>

                    <br/>
                    <h3>구매목록</h3>

                    <!-- Table Contents -->
                    <table class="template-table" summary="목공예품목록">
                        <caption class="display-none">목공예품목록</caption>
                        <colgroup>
                            <col width="100" />
                            <col width="300" />
                            <col width="100" />
                            <col />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="row">No</th>
                                <th scope="row">목공예품명</th>
                                <th scope="row">수량</th>
                                <th scope="row">가격</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="result" items="${wcrfBuyList}" varStatus="status">
                            <tr>
                                <td>
                                    <span class="font-color-light font-size-s"><c:out value="${status.count}"/></span>
                                </td>
                                <td><span class="font-weight-bold font-size-l">${result.wcrfNm}</span></td>
                                <td><span class="font-color-gray">${result.wcrfCnt}</span></td>
                                <td><span class="font-color-gray">${result.wcrfAmt}</span></td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                    <div class="clear"></div>
                    <!-- //Table Contents -->

                    <br/>
                    <h3>배송지정보</h3>

                    <table class="template-table">
                        <caption class="display-none">목공예품등록</caption>
                        <colgroup>
                            <col style="width:100px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td class="align-left font-weight-bold"><label for="txt_orerNm">이름</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_orerNm" name="orerNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerNm}" disabled />
                            </td>
                            <td class="align-left font-weight-bold"><label for="txt_orerTelNo">전화번호</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_orerTelNo" name="orerTelNo" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerTelNo}" disabled />
                            </td>
                            <td class="align-left font-weight-bold"><label for="txt_orerHp">연락처</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_orerHp" name="orerHp" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerHp}" disabled />
                            </td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label for="txt_orerZip">우편번호</label></td>
                            <td colspan="8" class="align-left">
                                <input type="text" id="txt_orerZip" name="orerZip" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerZip}" disabled />
                            </td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label for="txt_orerAddr">주소</label></td>
                            <td colspan="4" class="align-left">
                                <input type="text" id="txt_orerAddr" name="orerAddr" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerAddr}" disabled />
                            </td>
                            <td colspan="4" class="align-left">
                                <input type="text" id="txt_orerAddrDtl" name="orerAddrDtl" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.orerAddrDtl}" disabled />
                            </td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label for="txt_purchsDesc">주문메세지</label></td>
                            <td colspan="8" class="align-left">
                                <textarea type="text" id="txt_purchsDesc" name="purchsDesc" class="k-textbox" style="width:100%;height:100px; resize: none;" disabled><c:out value="${WcrfBuyForm.purchsDesc}"/></textarea>
                            </td>
                        </tr>
                    </table>

                </div>

                <div class="clear"></div>

                <div class="btn-container align-right">
                    <span class="button medium icon strong">
                        <span class="menu ico_list"></span><button id="btn_list" type="button">목록</button></span>
                    <span class="button medium icon">
                       <span class="check ico_save"></span>
                       <button id="btn_submit" type="button">
                           저장
                       </button>
                    </span>
                </div>
           </span>
                </div>
                <!-- content -->
            </section>
            </section>
        </article>
    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function () {

                <c:if test="${message != null}">
                alert("${message}");
                if ("${result}" == "OK") {
                    document.location.href = "<c:url value="/mng/wcrf/wcrfReqList.do" />";
                }
                </c:if>

                kendo.culture("ko-KR");

                <c:if test="${purchsProgrsSttusList != null}">
                    $("#txt_searchPurchsProgrsSttus").kendoComboBox({
                        dataTextField: "codeNm",
                        dataValueField: "code",
                        dataSource: ${purchsProgrsSttusList}
                    });

                    $('#txt_searchPurchsProgrsSttus').data('kendoComboBox').value('${WcrfBuyForm.purchsProgrsSttus}');
                </c:if>

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/wcrf/wcrfReqList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    var select = $("#txt_searchPurchsProgrsSttus").data("kendoComboBox");
                    $('#purchsProgrsSttus').val(select.value());

                    $('#purchsLstId').val($("#txt_purchsLstId").val());
                    $('#storeDelngId').val('${WcrfBuyForm.storeDelngId}');

                    $("#WcrfBuyForm").attr("action",'<c:url value="/mng/wcrf/wcrfReqSave.do" />')
                    .submit();
                });

            });

        </script>

    </layout:put>
</layout:extends>