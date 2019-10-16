<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">체험신청(결제)</layout:put>
    <layout:put block="contents" type="REPLACE">

        <article  id="content">

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
		            <div class="list-search">
                        <form:form commandName="frmSearch" name="frmSearch" method="post" cssClass="search-form form">
                            <form:hidden path="pageIndex"/>
                            <form:hidden path="searchSetleSe"/>
                            <form:hidden path="searchPurchsDt"/>
                            <form:hidden path="searchBgnDe"/>
                            <form:hidden path="searchEndDe"/>
                            <form:hidden path="searchPurchsProgrsSttus"/>
	                        <fieldset>

                                <table class="two_search1">
                                    <col style="width:9%" />
                                    <col style="width:17%" />
                                    <col style="width:9%" />
                                    <col style="width:17%" />
                                    <col style="width:9%" />
                                    <col style="width:17%" />
                                    <col />
                                    <tr>
                                        <td><label class="two_label_ic1">신청자명</label></td>
                                        <td><input type="text" id="txt_searchByerNm" name="searchByerNm" class="k-textbox" value="${frmSearch.searchByerNm}"></td>
                                        <td><label class="two_label_ic1">결제방법</label></td>
                                        <td><input type="text" id="txt_searchSetleSe"></td>
                                        <td><label class="two_label_ic1">진행상태</label></td>
                                        <td><kendo:dropDownList name="txt_searchPurchsProgrsSttus" dataTextField="text"
                                                                dataValueField="value"
                                                                value="${frmSearch.searchPurchsProgrsSttus}"
                                                                style="width:150px;" optionLabel="">
                                            <kendo:dataSource data="${purchsProgrsSttus}"></kendo:dataSource>
                                        </kendo:dropDownList></td>
                                        <td rowspan="2" class="btns1"><button id="btn_search" class="h_r2" type="submit">
                                            검색
                                            </button></td>
                                    </tr>
                                    <tr>
                                        <td><label class="two_label_ic1">신청일자</label></td>
                                        <td colspan="3"><input type="text" id="txt_searchApplyDtFr" data-type="date">&nbsp;~&nbsp;
                                            <input type="text" id="txt_searchApplyDtTo" data-type="date"></td>
                                        <td><label class="two_label_ic1">체험일자</label></td>
                                        <td><input type="text" id="txt_searchPurchsDt" data-type="date"></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </form:form>
                        <div class="info">
                            <p class="page-paragraph">총 <em class="em">${resultCnt}건</em>, 쪽번호 <strong
                                class="strong">${paginationInfo.currentPageNo}/${paginationInfo.totalPageCount}</strong>
                            </p>
                        </div>
                    </div>
                    <!-- Table Contents -->
                    <table class="template-table" summary="체험신청목록">
                        <caption class="display-none">체험신청목록</caption>
                        <colgroup>
                            <col style="width:50px"/>
                            <col style="width:180px"/>
                            <col />
                            <col />
                            <col />
                            <col />
                            <col />
                            <col />
                            <col />
                            <col />
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="row">순번</th>
                            <th scope="row">프로그램명</th>
                            <th scope="row">개설과정</th>
                            <th scope="row">신청자명</th>
                            <th scope="row">신청인원</th>
                            <th scope="row" style="width:95px">체험일자</th>
                            <th scope="row" style="width:95px">신청일시</th>
                            <th scope="row">결제방법</th>
                            <th scope="row">결제금액</th>
                            <th scope="row">진행상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="result" items="${resultList}" varStatus="status">
                            <fmt:parseDate var="dateString" value="${result.exprnDay}" pattern="yyyyMMdd"/>
                            <tr>
                                <td>
                                    <span class="font-color-light font-size-s"><c:out
                                        value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                                </td>
                                <td><span class="font-weight-bold font-size-l">${result.purchsDesc}</span></td>
                                <td><span class="font-weight-bold font-size-l">${result.exprnSeNm}</span></td>
                                <td><span class="font-color-gray"><a href="javascript:;" class="font-color-green"
                                                                     data-purchsLst-id="${result.purchsLstId}">${result.byerNm}</a></span>
                                </td>
                                <td><span class="font-color-gray">${result.qy}</span></td>
                                <td><span class="font-color-gray"><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/></span></td>
                                <td><span class="font-color-gray">${result.purchsDt}</span></td>
                                <td><span class="font-color-gray">${result.setleSeNm}</span></td>
                                <td><span class="font-color-gray">
                                <c:set var="price2" value="${result.setleAmt}"/>
                                <fmt:formatNumber value="${price2}" type="number"/>
                            </span></td>
                                <td><span class="font-color-gray">${result.purchsProgrsSttusNm}</span></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="clear"></div>
                    <!-- //Table Contents -->`
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

                $("input[data-type=date]").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy-MM-dd"
                });

                $('#txt_searchPurchsDt').data('kendoDatePicker').value('${frmSearch.searchPurchsDt}');
                $('#txt_searchApplyDtFr').data('kendoDatePicker').value('${frmSearch.searchBgnDe}');
                $('#txt_searchApplyDtTo').data('kendoDatePicker').value('${frmSearch.searchEndDe}');

                $("#txt_searchSetleSe").kendoComboBox({
                    dataTextField: "codeNm",
                    dataValueField: "code",
                    dataSource: ${setleSeList}
                });

                $('#txt_searchSetleSe').data('kendoComboBox').value('${frmSearch.searchSetleSe}');


                $("#btn_search").click(function() {

                    $('#searchPurchsDt').val($("#txt_searchPurchsDt").val());
                    $('#searchBgnDe').val($("#txt_searchApplyDtFr").val());
                    $('#searchEndDe').val($("#txt_searchApplyDtTo").val());

                    var select = $("#txt_searchSetleSe").data("kendoComboBox");
                    $('#searchSetleSe').val(select.value());

                    select = $("#txt_searchPurchsProgrsSttus").data("kendoDropDownList");
                    $('#searchPurchsProgrsSttus').val(select.value());

                    goList(1);
                });

                $("a[data-purchsLst-id]").click(function(event) {
                    event.preventDefault();
                    var purchsLstId = $(this).attr("data-purchsLst-id");
                    var view_url = "<c:url value="/mng/exprn/exprnReqRegit.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnReqstId").val(purchsLstId))
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