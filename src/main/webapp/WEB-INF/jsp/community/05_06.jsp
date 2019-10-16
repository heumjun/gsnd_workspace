<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 1:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="${menuNo}"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

            <!-- search1 -->
            <div class="search1">
                <form:form commandName="searchVO" name="searchVO" method="post">
                    <form:hidden path="pageIndex"/>
                    <fieldset><legend class="blind">게시물 검색</legend>
                        <select id="searchCnd" name="searchCnd" title="선택옵션1" class="select1">
                            <option value="0">제목</option>
                        </select><input type="text" id="searchWrd" name="searchWrd" title="검색어" class="text1" value="${boardVO.searchWrd}"/>
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
            <div class="bbs_list">

                <table class="t1">
                    <caption class="blind">
                        <strong class="h1">공지사항 목록</strong>
                    </caption>
                    <thead>
                    <tr>
                        <th scope="col" class="bbs_num">번호</th>
                        <th scope="col" class="bbs_title">제목</th>
                        <th scope="col" class="bbs_author">작성자</th>
                        <th scope="col" class="bbs_date">작성일</th>
                        <th scope="col" class="bbs_attach">첨부</th>
                        <!--<th scope="col" class="bbs_view">조회수</th>-->
                    </tr>
                    </thead>
                    <tbody>

                    <c:if test="${resultCnt == 0}">
                        <tr>
                            <td colspan="5"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td class="bbs_num"><c:out value="${(paginationInfo.totalRecordCount - ((frmSearch.pageIndex-1) * frmSearch.pageSize) + 1) - status.count}"/></td>
                            <!--<td class="bbs_title tal"><a href="#" data-ntt-id="${result.nttId}">${result.nttSj}<i class="ic1 new">새 글</i></a></td>-->
                            <td class="bbs_title tal">
                                <c:if test="${result.replyAt =='Y'}">
                                    <i class="ic1 reply"><i>└</i><b class="t1">[답변]</b></i>
                                </c:if>
                                <a href="#" data-ntt-id="${result.nttId}">${result.nttSj}</a>
                            </td>
                            <td class="bbs_author">${result.frstRegisterNm}</td>
                            <td class="bbs_date">${result.frstRegisterPnttm}</td>
                            <td class="bbs_attach">
                                <c:if test="${result.atchFileId != ''}">
                                    <a href="<c:url value="/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&fileSn=0"/>" target="_blank" title="첨부파일 새창 열림"><img src="/assets/images/woodcraft/www/template/ic16_file.png" width="16" height="16" alt="doc 파일 첨부" /></a>
                                </c:if>
                            </td>
                           <!--<td class="bbs_view">9999</td>-->
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
            <!-- /bbs_list -->

            <!-- infosection1 -->
            <div class="infosection1">

                <!-- pagination -->
                <div class="pagination" title="페이지 수 매기기">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="goList"/>
                </div>
                <!-- /pagination -->

                <c:if test="${menuNo == '11501000'}">
                    <c:if test="${writeFlag == true}">
                        <p class="right">
                            <a href="<c:url value="/community/regist/"/>${boardId}.do" class="button">글작성</a>
                        </p>
                    </c:if>
                </c:if>
                <c:if test="${menuNo != '11501000'}">
                    <p class="right">
                        <a href="<c:url value="/community/regist/"/>${boardId}.do" class="button">글작성</a>
                    </p>
                </c:if>

            </div>
            <!-- /infosection1 -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("#btn_search").click(function() {
                    goList(1);
                });

                $("a[data-ntt-id]").click(function(event) {
                    event.preventDefault();
                    var nttId = $(this).attr("data-ntt-id");
                    var view_url = "<c:url value="/community/view/"/>${boardId}.do";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","nttId").val(nttId))
                        .submit();

                    return false;
                });
            });

            function goList(pageIndex) {

                var view_url = "<c:url value="/community/list/"/>${boardId}.do";

                $("#pageIndex").val(pageIndex);
                $("form[name=searchVO]")
                    .attr("action", view_url)
                    .submit();

                return false;
            }

        </script>

    </layout:put>

</layout:extends>
