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
    <layout:put block="title" type="REPLACE">체험신청(결제)</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">체험신청(결제)</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">체험신청(결제) 상세</h2>
                <div class="form">

                    <form:form commandName="WcrfBuyForm" id="WcrfBuyForm" method="post">
                        <form:hidden path="purchsProgrsSttus"/>
                        <form:hidden path="purchsLstId"/>
                        <form:hidden path="storeDelngId"/>

                        <fieldset>
                            <legend>체험신청(결제) 상세</legend>
                            <table class="template-table">
                                <caption class="display-none">체험신청(결제) 상세</caption>
                                <colgroup>
                                    <col style="width:90px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_wcrfNm">일일체험명</label></td>
                                    <td colspan="5" class="align-left">
                                        <input type="text" id="txt_wcrfNm" name="wcrfNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.wcrfNm}" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnSeNm">개설과정</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_exprnSeNm" name="exprnSeNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.exprnSeNm}" disabled/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_bgnDe">교육기간</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_bgnDe" name="bgnDe" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.bgnDe} - ${WcrfBuyForm.endDe}" disabled/>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                        <br/>
                        <h3>신청자 정보</h3>

                        <table class="template-table">
                            <caption class="display-none">목공예품등록</caption>
                            <colgroup>
                                <col style="width:80px" />
                                <col />
                                <col style="width:80px" />
                                <col />
                                <col style="width:80px" />
                                <col />
                                <col style="width:90px" />
                                <col />
                            </colgroup>
                            <tr>
                                <td class="align-left font-weight-bold"><label for="txt_purchsLstId">신청번호</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_purchsLstId" name="purchsLstId" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.purchsLstId}" disabled/>
                                </td>
                                <td class="align-left font-weight-bold"><label for="txt_purchsDt">신청일자</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_purchsDt" name="purchsDt" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.purchsDt}" disabled/>
                                </td>
                                <td class="align-left font-weight-bold"><label for="txt_purchsAllAmt">수강금액</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_purchsAllAmt" name="purchsAllAmt" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.purchsAllAmt}" disabled/>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-left font-weight-bold"><label for="txt_byerNm">신청자명</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_byerNm" name="byerNm" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.byerNm}" disabled/>
                                </td>
                                <td class="align-left font-weight-bold"><label for="txt_qy">신청인원</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_qy" name="qy" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.qy}" disabled/>
                                </td>
                                <td class="align-left font-weight-bold"><label for="txt_searchPurchsProgrsSttus">진행상태</label></td>
                                <td colspan="2" class="align-left">
                                    <input id="txt_searchPurchsProgrsSttus" />
                                </td>
                            </tr>
                            <tr>
                                <td class="align-left font-weight-bold"><label for="txt_rcpmnyAmt">입금금액</label></td>
                                <td colspan="2" class="align-left">
                                    <input type="text" id="txt_rcpmnyAmt" name="rcpmnyAmt" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.rcpmnyAmt}" />
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
                                <td class="align-left font-weight-bold"><label for="txt_rcpmnyAmt">휴대전화</label></td>
                                <td colspan="8" class="align-left">
                                    <input type="text" id="txt_byerTelNo" name="byerTelNo" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.byerTelNo}" />
                                </td>
                            </tr>
                        </table>

                    </form:form>

                    <br/>
                    <h3>결제 정보</h3>

                    <table class="template-table">
                        <caption class="display-none">결제 정보</caption>
                        <colgroup>
                            <col style="width:80px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td class="align-left font-weight-bold"><label for="txt_setleSeNm">결제방법</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_setleSeNm" name="setleSeNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleSeNm}" disabled/>
                            </td>
                            <td class="align-left font-weight-bold"><label for="txt_setleDt">결제일시</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_setleDt" name="setleDt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleDt}" disabled/>
                            </td>
                            <td class="align-left font-weight-bold"><label for="txt_setleAmt">결제금액</label></td>
                            <td colspan="2" class="align-left">
                                <input type="text" id="txt_setleAmt" name="setleAmt" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.setleAmt}" disabled/>
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
                    document.location.href = "<c:url value="/mng/prgm/prgmReqList.do" />";
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
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/prgm/prgmReqList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    var select = $("#txt_searchPurchsProgrsSttus").data("kendoComboBox");
                    $('#purchsProgrsSttus').val(select.value());

                    $('#purchsLstId').val($("#txt_purchsLstId").val());
                    $('#storeDelngId').val('${WcrfBuyForm.storeDelngId}');

                    $("#WcrfBuyForm").attr("action",'<c:url value="/mng/prgm/prgmReqSave.do" />')
                        .submit();
                });

            });

        </script>

    </layout:put>
</layout:extends>