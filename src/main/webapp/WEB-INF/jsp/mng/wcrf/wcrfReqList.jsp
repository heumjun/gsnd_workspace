<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">목공예품(구매/결제)</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">목공예관리</a></li>
                        <li><a class="on" href="#">목공예품(구매/결제)</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <div class="list-search">
                    <form:form commandName="frmSearch" name="frmSearch" method="post">
                        <form:hidden path="pageIndex"/>
                        <form:hidden path="searchSetleSe"/>
                        <form:hidden path="searchPurchsDt"/>
                        <form:hidden path="searchPurchsProgrsSttus"/>
                        <div class="search-form">
                            <table class="two_search1">
                                <col style="width:9%" />
                                <col style="width:40%" />
                                <col style="width:9%" />
                                <col style="width:17%" />
                                <col />
                                <tr>
                                    <td><label class="two_label_ic1">구매자명</label></td>
                                    <td><input type="text" id="txt_searchByerNm" name="searchByerNm"  class="k-textbox" value="${frmSearch.searchByerNm}"></td>
                                    <td><label class="two_label_ic1">결제방법</label></td>
                                    <td><input id="txt_searchSetleSe" /></td>
                                    <td class="btns1" rowspan="2"><button id="btn_search" class="h_r2" type="submit">검색</button></td>
                                </tr>
                                <tr>
                                    <td><label class="two_label_ic1">구매일시</label></td>
                                    <td><input id="txt_searchPurchsDt" /></td>
                                    <td><label class="two_label_ic1">진행상태</label></td>
                                    <td><kendo:dropDownList name="txt_searchPurchsProgrsSttus" dataTextField="text" dataValueField="value"  value="${frmSearch.searchPurchsProgrsSttus}" >
                                        <kendo:dataSource data="${purchsProgrsSttus}"></kendo:dataSource>
                                    </kendo:dropDownList>
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </form:form>
                    <div class="info">
                        <p class="page-paragraph">총 <em class="em">${resultCnt}건</em>, 쪽번호 <strong class="strong">${paginationInfo.currentPageNo}/${paginationInfo.totalPageCount}</strong></p>
                    </div>
                </div>
                <!-- Table Contents -->
                <!-- Table Contents -->
                <table class="template-table" summary="목공예품목록">
                    <caption class="display-none">목공예품목록</caption>
                    <colgroup>
                        <col width="50" />
                        <col width="210" />
                        <col />
                        <col width="80"/>
                        <col width="90" />
                    </colgroup>
                    <thead><tr>
                        <th scope="row">순번</th>
                        <th scope="row">구매일시</th>
                        <th scope="row">구매자</th>
                        <th scope="row">구매금액</th>
                        <th scope="row">결제방법</th>
                        <th scope="row">결제금액</th>
                        <th scope="row">진행상태</th>
                    </tr></thead>
                    <tbody>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td>
                                <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                            </td>
                            <td><span class="font-weight-bold font-size-l">${result.purchsDt}</span></td>
                            <td><span class="font-color-gray"><a href="javascript:;" class="font-color-green" data-purchsLst-id="${result.purchsLstId}">${result.byerNm}</a></span></td>
                            <td><span class="font-color-gray">
                                <c:set var="price" value="${result.purchsAllAmt}" />
                                <fmt:formatNumber value="${price}" type="number"  />
                            </span></td>
                            <td><span class="font-color-gray">${result.setleSeNm}</span></td>
                            <td><span class="font-color-gray">
                                <c:set var="price2" value="${result.setleAmt}" />
                                <fmt:formatNumber value="${price2}" type="number"  />
                            </span></td>
                            <td><span class="font-color-gray">${result.purchsProgrsSttusNm}</span></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table><div class="clear"></div>
                <!-- //Table Contents -->
                <!-- Pagination(Common) -->
                <div class="pagination">
                    <ul>
                        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="goList"/>
                    </ul>
                </div>
                <!-- Pagination(Common) -->
            </section>
            </section>
        </article>
    </layout:put>
    <layout:put block="javascript">
        <script type="text/javascript">

            $(document).ready(function() {

                $("#txt_searchPurchsDt").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_searchPurchsDt').data('kendoDatePicker').value('${frmSearch.searchPurchsDt}');

                $("#txt_searchSetleSe").kendoComboBox({
                    dataTextField: "codeNm",
                    dataValueField: "code",
                    dataSource: ${setleSeList}
                });

                $('#txt_searchSetleSe').data('kendoComboBox').value('${frmSearch.searchSetleSe}');


                $("#btn_search").click(function() {

                    //alert($("#txt_searchPurchsDt").val());

                    //var dropdownlist = $("#txt_searchSetleSe").data("kendoComboBox");
                    //var dataItem = dropdownlist.dataItem();
                    //alert(dataItem.toLocaleString());

                    $('#searchPurchsDt').val($("#txt_searchPurchsDt").val());

                    var select = $("#txt_searchSetleSe").data("kendoComboBox");
                    //alert(select.value());
                    $('#searchSetleSe').val(select.value());

                    select = $("#txt_searchPurchsProgrsSttus").data("kendoDropDownList");
                    //alert(select.value());
                    $('#searchPurchsProgrsSttus').val(select.value());

                    goList(1);
                });

                $("a[data-purchsLst-id]").click(function(event) {
                    event.preventDefault();
                    var purchsLstId = $(this).attr("data-purchsLst-id");
                    var view_url = "<c:url value="/mng/wcrf/wcrfReqRegit.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#content")
                        .append($("<input />").attr("type","hidden").attr("name","purchsLstId").val(purchsLstId))
                        .submit();
                });
            });

            function goList(pageIndex) {
                $("#pageIndex").val(pageIndex);
                $("form[name=frmSearch]").submit();
            }

        </script>
    </layout:put>
</layout:extends>