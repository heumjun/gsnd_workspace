<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">체험일정관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">체험일정관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <div class="list-search">
                    <form:form commandName="frmSearch" name="frmSearch" method="post">
                        <form:hidden path="pageIndex"/>
                        <div class="search-form">
                            <table class="two_search1">
                                <col style="width:7%" />
                                <col style="width:70%" />
                                <col />
                                <tr>
                                    <td><label class="two_label_ic1">체험명</label></td>
                                    <td><input type="text" id="searchExprnNm" name="searchExprnNm" class="k-textbox" value="${frmSearch.searchExprnNm}"></td>
                                    <td class="btns1"><button id="btn_search" type="submit">
                                        검색
                                    </button></td>
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
                <table class="template-table" summary="체험일정목록">
                    <caption class="display-none">체험일정목록</caption>
                    <colgroup>
                        <col style="width:50px" />
                        <col />
                        <col style="width:100px" />
                        <col style="width:150px" />
                        <col style="width:150px"/>
                    </colgroup>
                    <thead><tr>
                        <th scope="row">순번</th>
                        <th scope="row">체험명</th>
                        <th scope="row">인원</th>
                        <th scope="row">체험일</th>
                        <th scope="row">체험시간</th>
                    </tr></thead>
                    <tbody>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <fmt:parseDate var="dateString" value="${result.exprnDay}" pattern="yyyyMMdd"/>
                        <tr>
                            <td>
                                <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                            </td>
                            <td><span class="font-weight-bold font-size-l"><a href="javascript:;" class="font-color-green" data-exprnLecture-id="${result.exprnLectureId}">${result.exprnNm}</a></span></td>
                            <td><span class="font-weight-bold font-color-light font-size-l font-color-red">${result.reservationCnt + result.exprnReqCnt}</span>
                                <span class="font-weight-bold font-size-l">/</span>
                                <c:choose>
                                    <c:when test="${result.exprnNmlc != null}">
                                        <span class="font-weight-bold font-color-light font-size-l font-color-blue"> ${result.exprnNmlc}</span>
                                    </c:when>
                                    <c:when test="${result.exprnNmlc == null}">
                                        <span class="font-weight-bold font-color-light font-size-l font-color-blue"> ${result.exprnNmpr}</span>
                                    </c:when>
                                </c:choose>
                                <%--<span class="font-weight-bold font-color-light font-size-l font-color-blue"> ${result.exprnNmlc}</span>--%>
                            <td><span class="font-color-gray"><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/></span></td>
                            <td><span class="font-color-gray">${result.exprnTime}</span></td>
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
                    <div class="btn-container align-right">
                        <span class="button medium icon"><span class="check ico_new"></span><a href='<c:url value="/mng/exprn/exprnLectureRegit.do"/>' id="btn_banner_add">등록</a></span>
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

                $("#btn_search").click(function() {
                    goList(1);
                });

                $("a[data-exprnLecture-id]").click(function(event) {
                    event.preventDefault();
                    var exprnLectureId = $(this).attr("data-exprnLecture-id");
                    var view_url = "<c:url value="/mng/exprn/exprnLectureView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnLectureId").val(exprnLectureId))
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