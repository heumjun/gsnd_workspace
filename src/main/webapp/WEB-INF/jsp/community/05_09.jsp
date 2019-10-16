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

            <!-- gallery1bbs1 -->
            <div class="gallery1bbs1">
                <ul>

                    <c:if test="${resultCnt == 0}">
                        <li class="gallerylinodata"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</li>
                    </c:if>

                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <li><a href="#" data-ntt-id="${result.nttId}" class="a1">
                        <span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.nttCn}" /></span>
                        <span class="text1">
									<strong class="t1">${result.nttSj}</strong>
									<span class="t2grp">
										<span class="t2">${result.frstRegisterPnttm}</span>
										<span class="t2">${result.frstRegisterNm}</span>
										<!--<span class="t2">조회수 : 9999</span>-->
									</span>
								</span>
                    </a></li>
                    </c:forEach>
                </ul>
            </div>
            <!-- /gallery1bbs1 -->

            <!-- infosection1 -->
            <div class="infosection1">
                <!-- pagination -->
                <div class="pagination" title="페이지 수 매기기">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="goList"/>
                </div>
                <!-- /pagination -->

                <p class="right">
                    <a href="<c:url value="/community/regist/"/>${boardId}.do" class="button">글작성</a>
                </p>
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
