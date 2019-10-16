<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="11303000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- search1 -->
            <div class="search1">
                <form:form commandName="frmSearch" name="frmSearch" method="post">
                <form:hidden path="pageIndex"/>
                    <fieldset><legend class="blind">게시물 검색</legend>
                        <select id="searchOption" name="searchOption" title="선택옵션1" class="select1">
                            <option value="01">목공예품명</option>
                        </select><input type="text" id="searchKeyword" name="searchKeyword" title="검색어" class="text1" value="${frmSearch.searchKeyword}"/>
                        <button type="submit" value="submit" class="button submit search"><span class="t1">검색</span></button>
                    </fieldset>
                </form:form>
            </div>
            <!-- /search1 -->

            <!-- infosection1 -->
            <div class="infosection1">
                <div class="left">
                    <div class="info_list1">
                        * 총 <b class="em"> ${resultCnt}</b>건의 게시물이 있습니다.  (<b class="em">${paginationInfo.currentPageNo}</b>/${paginationInfo.totalPageCount} 페이지)
                    </div>
                </div>
            </div>
            <!-- /infosection1 -->

            <!-- gallery1product1 -->
            <div class="gallery1product1">
                <ul>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <li><a href="javascript:;" class="a1" data-wcrf-id="${result.wcrfId}">
                            <span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.wcrfDesc}" /></span>
                            <span class="text1">
									<strong class="t1">${result.wcrfNm}</strong>
									<span class="t2">
                                        <c:set var="price" value="${result.wcrfAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />원
                                    </span>
								</span>
                        </a></li>
                    </c:forEach>
                </ul>
            </div>
            <!-- /gallery1product1 -->

            <!-- infosection1 -->
            <div class="infosection1">

                <!-- Pagination(Common) -->
                <div class="pagination" title="페이지 수 매기기">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="goList"/>
                </div>
                <!-- Pagination(Common) -->

            </div>
            <!-- /infosection1 -->


    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("#btn_search").click(function() {
                    goList(1);
                });

                $("a[data-wcrf-id]").click(function(event) {
                    event.preventDefault();
                    var wcrfId = $(this).attr("data-wcrf-id");
                    var view_url = "<c:url value="/wcrf/wcrfPay.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","wcrfId").val(wcrfId))
                        .submit();

                    return false;
                });
            });

            function goList(pageIndex) {

                var view_url = "<c:url value="/wcrf/wcrfList.do"/>";

                $("#pageIndex").val(pageIndex);
                $("form[name=frmSearch]")
                    .attr("action", view_url)
                    .submit();

                return false;
            }

        </script>

    </layout:put>

</layout:extends>
