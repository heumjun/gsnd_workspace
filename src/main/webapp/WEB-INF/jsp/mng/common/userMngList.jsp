<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">회원관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">회원관리</a></li>
                        <li><a class="on" href="#">회원관리</a></li>
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
                                <col style="width:60%" />
                                <col />
                                <tr>
                                    <td><label class="two_label_ic1">사용자명</label></td>
                                    <td><input type="text" id="searchKeyword" name="searchKeyword" class="k-textbox" value="${frmSearch.searchKeyword}"></td>
                                    <td class="btns1">
                                        <button id="btn_search" type="submit">검색</button>
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
                <table class="template-table" summary="회원목록">
                    <caption class="display-none">회원목록</caption>
                    <colgroup>
                        <col width="50" />
                        <col width="210" />
                        <col />
                    </colgroup>
                    <thead><tr>
                        <th scope="row">순번</th>
                        <th scope="row">회원명</th>
                        <th scope="row">유저아이디</th>
                    </tr></thead>
                    <tbody>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td>
                                <span class="font-color-light font-size-s"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></span>
                            </td>
                            <td><span class="font-weight-bold font-size-l"><a href="javascript:;" class="font-color-green" data-uniq-id="${result.uniqId}">${result.userNm}</a></span></td>
                            <td><span class="font-color-gray">${result.userId}</span></td>
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
                        <span class="button medium icon"><span class="check ico_new"></span><a href='<c:url value="/mng/user/userRegit.do"/>' id="btn_banner_add">등록</a></span>
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

                $("a[data-uniq-id]").click(function(event) {
                    event.preventDefault();
                    var uniqId = $(this).attr("data-uniq-id");
                    var view_url = "<c:url value="/mng/user/userView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#content")
                        .append($("<input />").attr("type","hidden").attr("name","uniqId").val(uniqId))
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