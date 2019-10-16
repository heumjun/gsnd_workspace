<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:39
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
            <c:param name="menuNo" value="11302000"></c:param>
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
                            <option value="01">이름</option>
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
                        * 총 <b class="em"> ${resultCnt}</b>건의 게시물이 있습니다.  <%--(<b class="em">${paginationInfo.currentPageNo}</b>/${paginationInfo.totalPageCount} 페이지)--%>
                    </div>
                </div>
            </div>
            <!-- /infosection1 -->

            <!-- artist1bbs1 -->
            <div class="artist1bbs1">
                <ul>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <li>
                            <span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.artistNm} 인물사진" /></span>
                            <span class="text1">
							<strong class="t1">${result.artistNm}</strong>
                           <span class="t3">${result.etcCn}</span>
							<span class="t2"><span class="tit">공방이름</span>${result.crfShopNm}</span>
							<span class="t2"><span class="tit">공방주소</span>${result.adres} ${result.dtlAdres}</span>
                            <span class="t2"><span class="tit">공방전화</span>
                                <c:if test="${result.telNo != null && result.telNo != ''}"><a href="tel:${result.telNo}" title="전화">${result.telNo}</a></c:if>
                                <c:if test="${result.telNo != null && result.telNo != '' && result.hpNo != null && result.hpNo != ''}"> , </c:if>
                                <c:if test="${result.hpNo != null && result.hpNo != ''}"><a href="tel:${result.hpNo}" title="전화">${result.hpNo}</a></c:if>
                            </span>
                            <c:if test="${result.email != null && result.email != ''}">
                                <span class="t2"><span class="tit">이메일</span><a href="mailto:${result.email}" title="이메일">${result.email}</a></span>
                            </c:if>
                            <c:if test="${result.supGoods != null && result.supGoods != ''}">
                                <span class="t2"><span class="tit">취급품</span>${result.supGoods}</span>
                            </c:if>
						</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- /artist1bbs1 -->

            <!-- infosection1 -->
            <div class="infosection1">
                <!-- Pagination(Common) -->
                <div class="pagination" title="페이지 수 매기기">
                    <%--<ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="goList"/>--%>
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
            });

            function goList(pageIndex) {

                var view_url = "<c:url value="/artist/artistList.do"/>";

                $("#pageIndex").val(pageIndex);
                $("form[name=frmSearch]")
                    .attr("action", view_url)
                    .submit();
            }

        </script>

    </layout:put>

</layout:extends>
