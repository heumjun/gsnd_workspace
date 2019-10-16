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
    <layout:put block="title" type="REPLACE">목공예품(반품/취소)</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">목공예관리</a></li>
                        <li><a class="on" href="#">목공예품(반품/취소)</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">목공예품(반품/취소) 상세</h2>
                <div class="form">

                    <form:form commandName="WcrfRefdForm" id="WcrfBuyForm" method="post">
                        <form:hidden path="purchsProgrsSttus"/>
                        <form:hidden path="refdSttusCd"/>
                        <form:hidden path="purchsLstId"/>
                        <form:hidden path="returnId" value="${WcrfRefdForm.returnId}" />

                        <fieldset>
                            <legend>목공예품구매정보</legend>
                            <table class="template-table">
                                <caption class="display-none">목공예품구매정보</caption>

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
                                    <td class="align-left font-weight-bold"><label for="txt_searchPurchsProgrsSttus">진행상태</label></td>
                                    <td colspan="2" class="align-left">
                                        <!--<input type="text" id="txt_purchsProgrsSttusNm" name="purchsProgrsSttusNm" class="k-textbox" style="width:100%;" value="${WcrfBuyForm.purchsProgrsSttusNm}"/>-->
                                        <input id="txt_searchPurchsProgrsSttus" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_invoiceNumber">송장번호</label></td>
                                    <td colspan="2" class="align-left">
                                        <input type="text" id="txt_invoiceNumber" name="invoiceNumber" class="k-textbox" style="width:100%;"  value="${WcrfBuyForm.invoiceNumber}" disabled />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                    <br/>
                    <h3>구매목록</h3>

                    <!-- Table Contents -->
                    <table class="template-table" summary="목공예품구매목록">
                        <caption class="display-none">목공예품구매목록</caption>
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
                        <h3>취소 및 환불 정보</h3>

                    <table class="template-table">
                        <caption class="display-none">취소 및 환불 정보</caption>
                        <colgroup>
                            <col style="width:140px" />
                            <col />
                            <col style="width:120px" />
                            <col />
                            <col style="width:80px" />
                            <col />
                        </colgroup>
                        <tr>
                            <td class="align-left font-weight-bold"><label>환불방법</label></td>
                            <td class="align-left">${WcrfRefdForm.refdSeNm}</td>
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label>반품/취소신청일자</label></td>
                            <td class="align-left">${WcrfRefdForm.refdReqDt}</td>
                            <td class="align-left font-weight-bold"><label>반품/취소사유</label></td>
                            <td class="align-left">${WcrfRefdForm.refdResnCdNm}</td>
                            <td class="align-left font-weight-bold"><label>진행상태</label></td>
                            <td class="align-left">
                                <input id="txt_searchRefdSttusCd" />
                            </td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label>예금주</label></td>
                            <td class="align-left">${WcrfRefdForm.refdBankOwr}</td>
                            <td class="align-left font-weight-bold"><label>은행명</label></td>
                            <td class="align-left">${WcrfRefdForm.refdBank}</td>
                            <td class="align-left font-weight-bold"><label>계좌번호</label></td>
                            <td class="align-left">${WcrfRefdForm.refdAccNo}</td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label>반품취소사유</label></td>
                            <td colspan="5" class="align-left">${WcrfRefdForm.returnCn}</td>
                        </tr>
                        <tr>
                            <td class="align-left font-weight-bold"><label>처리내용</label></td>
                            <td colspan="5" class="align-left">
                                <textarea id="txt_refdRsltCn" name="refdRsltCn" rows="5" cols="80" style="width:850px;" >${WcrfRefdForm.refdRsltCn}</textarea>
                            </td>
                        </tr>
                    </table>

                    </form:form>

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
                    document.location.href = "<c:url value="/mng/wcrf/wcrfRefdList.do" />";
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

                <c:if test="${refdSttusCdList != null}">
                $("#txt_searchRefdSttusCd").kendoComboBox({
                    dataTextField: "codeNm",
                    dataValueField: "code",
                    dataSource: ${refdSttusCdList}
                });

                $('#txt_searchRefdSttusCd').data('kendoComboBox').value('${WcrfRefdForm.refdSttusCd}');
                </c:if>

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/wcrf/wcrfRefdList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    var select = $("#txt_searchPurchsProgrsSttus").data("kendoComboBox");
                    $('#purchsProgrsSttus').val(select.value());

                    select = $("#txt_searchRefdSttusCd").data("kendoComboBox");
                    $('#refdSttusCd').val(select.value());

                    $('#purchsLstId').val($("#txt_purchsLstId").val());

                    $("#WcrfBuyForm").attr("action",'<c:url value="/mng/wcrf/wcrfRefdSave.do" />')
                        .submit();
                });

            });

        </script>

    </layout:put>
</layout:extends>