<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:52
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
			<c:param name="menuNo" value="11404000"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">


			<!-- notice1 -->
			<!--<div class="notice1">
            <i class="ic1 bsContain"></i>
            <ul>
            <li>신청 당일 6시까지 미입금시 신청취소입니다.</li>
            </ul>
            </div>-->
			<!-- /notice1 -->

			<!-- search1 -->
			<div class="search1">
				<form:form commandName="frmSearch" name="frmSearch" method="post">
					<form:hidden path="pageIndex"/>
					<fieldset><legend class="blind">게시물 검색</legend>
						<select id="searchOption" name="searchOption" title="선택옵션1" class="select1">
							<option value="01">체험명</option>
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

			<!-- edu1list1 -->
			<div class="edu1list1">
				<ul>

					<c:if test="${resultCnt == 0}">
						<li class="tac"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</li>
					</c:if>

					<c:forEach var="result" items="${resultList}" varStatus="status">
						<li><a href="javascript:;" data-exprn-id="${result.exprnId}" class="a1">
							<span class="edu1item1">
								<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>"  alt="${result.exprnIntrcn}" /></span>
								<span class="texts">
									<em class="c1">${result.exprnSeNm}</em>
									<strong class="t1">${result.exprnNm}</strong>
									<span class="t2">운영기간 : ${result.bgnDe} ~ ${result.endDe}</span>
									<span class="t3">
										<span class="t3t1">시간 : ${result.exprnTime}</span>
										<span class="t3t1">인원 : 각 ${result.exprnNmpr}명</span>
										<span class="t3t1">체험료 : <fmt:formatNumber value="${result.exprnBaseAmt}" type="number"  />원 +
										재료비 : <fmt:formatNumber value="${result.exprnMtrAmt}" type="number"  />원</span>
										<span class="t3t1">총비용 : <c:set var="price" value="${result.exprnBaseAmt + result.exprnMtrAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />원</span>
									</span>
								</span>
							</span>
							<span class="now">
								<c:if test="${result.exprnSttus == '01'}">
                                    <span class="sting st3">대기</span>
                                </c:if>
                                <c:if test="${result.exprnSttus == '02'}">
									<span class="sting st1">예약중</span>
                                </c:if>
                                <c:if test="${result.exprnSttus == '03'}">
                                    <span class="sting st2">예약완료</span>
                                </c:if>
                                <c:if test="${result.exprnSttus == '04'}">
                                    <span class="sting st6">취소</span>
                                </c:if>
								<!-- ★★ 색상변경 : st1, st2, st3, st4, st5, st6 ★★ -->
							</span>
						</a>
						<span class="btns">
							<a href="javascript:;" data-exprn-id="${result.exprnId}" class="button">상세정보</a>
							<a href="javascript:;" data-exprn-id2="${result.exprnId}" data-exprn-sttus="${result.exprnSttus}" class="button">예약하기</a>
						</span>
						</li>
					</c:forEach>

				</ul>
			</div>
			<!-- /edu1list1 -->

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

                $("a[data-exprn-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id");
                    var view_url = "<c:url value="/exprn/exprnView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

                $("a[data-exprn-id2]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id2");
                    var view_url = "<c:url value="/exprn/exprnReqRegitAll.do"/>";
                    var exprnSttus = $(this).attr("data-exprn-sttus");

                    if(exprnSttus == '01') {
                        alert("대기중인 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '03') {
                        alert("예약이 완료된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '04') {
                        alert("취소된 프로그램입니다.");
                        return false;
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit()

                    return false;
                });
            });

            function goList(pageIndex) {

                var view_url = "<c:url value="/exprn/exprnList.do"/>";

                $("#pageIndex").val(pageIndex);
                $("form[name=frmSearch]")
                    .attr("action", view_url)
                    .submit();

                return false;
            }

		</script>

	</layout:put>

</layout:extends>
