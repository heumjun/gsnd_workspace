<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">프로그램신청(취소)</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">프로그램신청(취소)</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <div class="list-search">
                    <form:form commandName="frmSearch" name="frmSearch" method="post">
                        <form:hidden path="pageIndex"/>
                        <form:hidden path="searchPurchsDt"/>
                        <form:hidden path="searchRefdReqDt"/>
                        <!--<form:hidden path="searchRefdResnCd"/>-->
                        <form:hidden path="searchPurchsProgrsSttus"/>
                        <div class="search-form">
                            <table class="two_search1">
                                <col style="width:12%" />
                                <col style="width:30%" />
                                <col style="width:10%" />
                                <col style="width:15%" />
                                <col />
                                <tr>
                                    <td><label class="two_label_ic1">신청자명</label></td>
                                    <td><input type="text" id="txt_searchByerNm" name="searchByerNm" class="k-textbox" value="${frmSearch.searchByerNm}"></td>
                                    <td><label class="two_label_ic1">신청일시</label></td>
                                    <td><input id="txt_searchPurchsDt" /></td>
                                    <td class="btns1" rowspan="2">
                                        <button id="btn_search" type="submit" class="h_r2">검색</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label class="two_label_ic1">환불신청일시</label></td>
                                    <td><input id="txt_searchRefdReqDt" /></td>
                                    <td><label class="two_label_ic1">진행상태</label></td>
                                    <td><input id="txt_searchPurchsProgrsSttus" /></td>
                                </tr>
                                <tr>
                                    <td><label class="two_label_ic1">프로그램명</label></td>
                                    <td colspan="4"><input type="text" id="txt_searchPurchsDesc" name="searchPurchsDesc" class="k-textbox" value="" style="width:65%;"></td>
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
                <table class="template-table" summary="프로그램목록">
                    <caption class="display-none">프로그램목록</caption>
                    <colgroup>
                        <col style="width:50px" />
                        <col />
                        <col style="width:210px" />
                        <col style="width:80px"/>
                        <col style="width:210px" />
                        <col style="width:80px"/>
                        <col style="width:100px" />
                    </colgroup>
                    <thead><tr>
                        <th scope="row">순번</th>
                        <th scope="row">프로그램명</th>
                        <th scope="row">환불신청일시</th>
                        <th scope="row">구매자</th>
                        <th scope="row">구매일시</th>
                        <th scope="row">구매금액</th>
                        <th scope="row">진행상태</th>
                    </tr></thead>
                    <tbody>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td>
                                <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                            </td>
                            <td><span class="font-color-gray"><a href="javascript:;" class="font-color-green" data-purchsLst-id="${result.purchsLstId}">${result.purchsDesc}</a></span></td>
                            <td><span class="font-weight-bold font-size-l">${result.refdReqDt}</span></td>
                            <td><span class="font-color-gray">${result.byerNm}</span></td>
                            <td><span class="font-color-gray">${result.purchsDt}</span></td>
                            <td><span class="font-color-gray">
                                <c:set var="price" value="${result.returnAmt}" />
                                <fmt:formatNumber value="${price}" type="number"  />
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

                $("#txt_searchRefdReqDt").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_searchRefdReqDt').data('kendoDatePicker').value('${frmSearch.searchRefdReqDt}');

                //$("#txt_searchRefdResnCd").kendoComboBox({
                //    dataTextField: "codeNm",
                //    dataValueField: "code",
                //    dataSource: ${refdResnCdList}
                //});

                //$('#txt_searchRefdResnCd').data('kendoComboBox').value('${frmSearch.searchRefdResnCd}');

                $("#txt_searchPurchsProgrsSttus").kendoComboBox({
                    dataTextField: "codeNm",
                    dataValueField: "code",
                    dataSource: ${purchsProgrsSttusList}
                });

                $('#txt_searchPurchsProgrsSttus').data('kendoComboBox').value('${frmSearch.searchPurchsProgrsSttus}');

                $("#btn_search").click(function() {

                    $('#searchPurchsDt').val($("#txt_searchPurchsDt").val());
                    $('#searchRefdReqDt').val($("#txt_searchRefdReqDt").val());

                    //var select = $("#txt_searchRefdResnCd").data("kendoComboBox");
                    //$('#searchRefdResnCd').val(select.value());

                    var select = $("#txt_searchPurchsProgrsSttus").data("kendoComboBox");
                    $('#searchPurchsProgrsSttus').val(select.value());

                    goList(1);
                });

                $("a[data-purchsLst-id]").click(function(event) {
                    event.preventDefault();
                    var purchsLstId = $(this).attr("data-purchsLst-id");
                    var view_url = "<c:url value="/mng/prgm/prgmRefdRegit.do"/>";

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