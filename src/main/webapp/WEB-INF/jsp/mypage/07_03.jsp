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
            <c:param name="menuNo" value="11703000"></c:param>
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
                            <option value="01">주문내역</option>
                        </select><input type="text" id="searchKeyword" name="searchKeyword" value="" title="검색어" class="text1" />
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

            <!-- bbs_list -->
            <div class="bbs_list t1o1list1">

                <table class="t1">
                    <caption class="blind">
                        <strong class="h1">목공예품 구매 목록</strong>
                    </caption>
                    <col style="width:16%" />
                    <col style="width:10%" />
                    <col />
                    <col style="width:10%" />
                    <col style="width:10%" />
                    <col style="width:10%" />
                    <col style="width:10%" />
                    <thead>
                    <tr>
                        <th scope="col">주문번호</th>
                        <th scope="col">주문일자</th>
                        <th scope="col">주문내역</th>
                        <th scope="col">주문금액</th>
                        <th scope="col">주문자</th>
                        <th scope="col">수령자</th>
                        <th scope="col">주문상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!--<tr>
                        <td colspan="7" class="tac">
                            <i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.
                        </td>
                    </tr>-->

                    <c:if test = "${resultCnt == 0}">
                        <tr>
                            <td colspan="7" class="tac"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td><a href="#" data-purchsLst-id="${result.purchsLstId}" >${result.purchsLstId}</a></td>
                        <td>${result.purchsDt}</td>
                        <td>${result.purchsDesc}</td>
                        <td>
                            <c:set var="price" value="${result.purchsAllAmt}" />
                            <fmt:formatNumber value="${price}" type="number"  />원
                        </td>
                        <td>${result.byerNm}</td>
                        <td>${result.orerNm}</td>
                        <td>${result.purchsProgrsSttusNm}</td>
                    </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
            <!-- /bbs_list -->

            <!-- infosection1 -->
            <div class="infosection1">

                <!-- Pagination(Common) -->
                <div class="pagination" title="페이지 수 매기기">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="goList"/>
                </div>
                <!-- Pagination(Common) -->

                <!--<p class="right">
                    <a href="?" class="button">글작성</a>
                </p>-->
            </div>
            <!-- /infosection1 -->




    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("a[data-purchsLst-id]").click(function(event) {
                    event.preventDefault();
                    var purchsLstId = $(this).attr("data-purchsLst-id");
                    var view_url = "<c:url value="/mypage/wcrfMyPayView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","purchsLstId").val(purchsLstId))
                        .submit();

                    return false;
                });
            });

            function goList(pageIndex) {

                var view_url = "<c:url value="/mypage/wcrfMyPayList.do"/>";

                $("#pageIndex").val(pageIndex);
                $("form[name=frmSearch]")
                    .attr("action", view_url)
                    .submit();

                return false;
            }

        </script>

    </layout:put>

</layout:extends>
