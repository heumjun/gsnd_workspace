<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">목공예품관리</layout:put>
    <layout:put block="contents" type="REPLACE">

        <article  id="content">

            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">프로그램신청현황</a></li>
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
                                    <col style="width:10%" />
                                    <col style="width:70%" />
                                    <col />
                                    <tr>
                                        <td><label class="two_label_ic1">프로그램명</label></td>
                                        <td><input type="text" id="searchExprnNm" name="searchExprnNm" class="k-textbox" value=""></td>
                                        <td class="btns1"><button id="btn_search" type="submit">검색</button></td>
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
                            <col style="width:100px"/>
                            <col style="width:80px"/>
                            <col style="width:210px" />
                            <col style="width:100px" />
                        </colgroup>
                        <thead><tr>
                            <th scope="row">순번</th>
                            <th scope="row">프로그램명</th>
                            <th scope="row">인원</th>
                            <th scope="row">개설과정</th>
                            <th scope="row">교육기간</th>
                            <th scope="row">진행상태</th>
                        </tr></thead>
                        <tbody>
                        <c:forEach var="result" items="${resultList}" varStatus="status">
                            <tr>
                                <td>
                                    <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                                </td>
                                <td><span class="font-weight-bold font-size-l"><a href="javascript:;" class="font-color-green" data-exprn-id="${result.exprnId}">${result.exprnNm}</a></span></td>
                                <td><span class="font-weight-bold font-color-light font-size-l font-color-red">${result.reqCnt}</span>
                                    <span class="font-weight-bold font-size-l">/</span>
                                    <span class="font-weight-bold font-color-light font-size-l font-color-blue"> ${result.exprnNmpr}</span></td>
                                <td><span class="font-color-gray">${result.exprnSeNm}</span></td>
                                <td><span class="font-color-gray">${result.bgnDe} ~ ${result.endDe}</span></td>
                                <td><span class="font-color-gray">${result.exprnSttusNm}</span></td>
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
                            <span class="button medium icon"><span class="check ico_new"></span><a href='<c:url value="/mng/prgm/prgmRegit.do"/>' id="btn_banner_add">등록</a></span>
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

                $("a[data-exprn-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id");
                    var view_url = "<c:url value="/mng/prgm/prgmView2.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
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