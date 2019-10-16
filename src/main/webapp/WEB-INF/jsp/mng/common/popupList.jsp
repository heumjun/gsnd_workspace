<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">팝업존 관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">팝업관리</a></li>
                        <li><a class="on" href="#">팝업관리</a></li>
                    </ul>
                </nav>
            </div>

            <section class="sub">
                <section class="sub-body">
                    <div class="list-search">
                        <form:form commandName="frmSearch" name="frmSearch" method="post">
                            <form:hidden path="pageIndex"/>
                            <form:hidden path="searchStrtDe"/>
                            <form:hidden path="searchEndDe"/>
                            <fieldset>
                                <table class="two_search1">
                                    <col style="width:80px" />
                                    <col style="width:370px" />
                                    <col style="width:80px" />
                                    <col style="width:350px" />
                                    <col />
                                    <tr>
                                        <td><label class="two_label_ic1">제목</label></td>
                                        <td colspan="3"><input type="text" id="searchPopupNm" name="searchPopupNm" class="k-textbox" value="${frmSearch.searchPopupNm}"></td>
                                        <td rowspan="2" class="btns1"><button id="btn_search" class="h_r2" type="submit">
                                            검색
                                        </button></td>
                                    </tr>
                                    <tr>
                                        <td><label class="two_label_ic1">기간</label></td>
                                        <td><input type="text" id="txt_searchStrtDe" name="searchStrtDe" data-type="date">&nbsp;~&nbsp;
                                            <input type="text" id="txt_searchEndDe" name="searchEndDe" data-type="date"></td>
                                        <td><label class="two_label_ic1">사용여부</label></td>
                                        <td><input name="searchUseYn" id="searchUseYn" /><script>jQuery(function(){jQuery("#searchUseYn").kendoDropDownList
                                        ({"dataTextField":"text","dataValueField":"value","value":"","dataSource":{"data":[{"text":"전체","value":""},{"text":"사용","value":"Y"},{"text":"미사용","value":"N"}]}});})</script></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </form:form>
                        <div class="info">
                            <p class="page-paragraph">총 <em class="em">${resultCnt}건</em>, 쪽번호 <strong class="strong">${paginationInfo.currentPageNo}/${paginationInfo.totalPageCount}</strong></p>
                        </div>
                    </div>
                    <!-- Table Contents -->
                    <table class="template-table" summary="팝업존목록">
                        <caption class="display-none">팝업목록</caption>
                        <colgroup>
                            <col style="width:50px"/>
                            <col />
                            <col style="width:200px"/>
                            <col style="width:100px"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="row">순번</th>
                            <th scope="row">제목</th>
                            <th scope="row">기간</th>
                            <th scope="row">사용여부</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="result" items="${resultList}" varStatus="status">
                            <fmt:parseDate var="startDateString" value="${result.strtDe}" pattern="yyyyMMdd"/>
                            <fmt:parseDate var="endDateString" value="${result.endDe}" pattern="yyyyMMdd"/>
                        <tr>
                            <td>
                                <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                            </td>
                            <td><span class="font-weight-bold font-size-l"><a href="javascript:;" class="font-color-green" data-popup-id="${result.popupId}">${result.popupNm}</a></span></td>
                            <td><span class="font-color-gray"><fmt:formatDate value="${startDateString}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${endDateString}" pattern="yyyy-MM-dd"/></span></td>
                            <td><span class="font-color-gray">O</span></td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="clear"></div>
                    <!-- //Table Contents -->
                    <!-- Pagination(Common) -->
                    <div class="pagination">
                        <ul>
                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="goList"/>
                        </ul>
                        <div class="btn-container align-right">
                            <span class="button medium icon"><span class="check ico_new"></span><a href='<c:url value="/mng/popup/popupRegit.do"/>' id="btn_banner_add">등록</a></span>
                        </div>
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

                $('#txt_searchStrtDe').data('kendoDatePicker').value('${frmSearch.searchStrtDe}');
                $('#txt_searchEndDe').data('kendoDatePicker').value('${frmSearch.searchEndDe}');

                $("#btn_search").click(function() {

                    $('#searchStrtDe').val($("#txt_searchStrtDe").val());
                    $('#searchEndDe').val($("#txt_searchEndDe").val());

                    goList(1);
                });

                $("a[data-popup-id]").click(function(event) {
                    event.preventDefault();
                    var purchsLstId = $(this).attr("data-popup-id");
                    var view_url = "<c:url value="/mng/popup/popupView.do"/>";

                    $("<form />")
                    .attr("action", view_url)
                    .attr("method", "post")
                    .appendTo("#content")
                    .append($("<input />").attr("type","hidden").attr("name","popupId").val(purchsLstId))
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