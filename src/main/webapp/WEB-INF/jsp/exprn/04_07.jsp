<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 1:01
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
<% pageContext.setAttribute("newLineChar", "\n"); %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="11404000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

            <!-- edu1view1 -->
            <div class="edu1view1">
                <!-- info1 -->
                <div class="info1">
                        <div class="f1">
                            <!-- 사진 갤러리 -->
                            <div class="pic1list1">
                                    <div class="figure pt1">
                                        <p class="p1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${ExprnForm.atchFileId}"/>" alt="${ExprnForm.exprnIntrcn}" /></p>
                                    </div>
                                    <div class="mNum">
                                        <c:if test="${fn:length(fileResult) > 0}">
                                        <ul>
                                            <c:forEach var="fileVO" items="${fileResult}" varStatus="status">
                                                <li class="m">
                                                    <a href="<c:url value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>"><span class="mf1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>" alt="${ExprnForm.exprnIntrcn}" /></span></a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                        </c:if>
                                    </div>
                                </div>
                            <!-- /pic1list1 -->
                            <!-- /사진 갤러리 -->
                        </div>
                    <div class="texts">
								<div class="now">
                                    <c:if test="${ExprnForm.exprnSttus == '01'}">
                                        <span class="sting st3">대기</span>
                                    </c:if>
                                    <c:if test="${ExprnForm.exprnSttus == '02'}">
                                        <span class="sting st1">예약중</span>
                                    </c:if>
                                    <c:if test="${ExprnForm.exprnSttus == '03'}">
                                        <span class="sting st2">예약완료</span>
                                    </c:if>
                                    <c:if test="${ExprnForm.exprnSttus == '04'}">
                                        <span class="sting st6">취소</span>
                                    </c:if>
                                    <!-- ★★ 색상변경 : st1, st2, st3, st4, st5, st6 ★★ -->
								</div>
								<div class="edu1tit">
									<em class="c1">${ExprnForm.exprnSeNm}</em>
									<strong class="t1">${ExprnForm.exprnNm}</strong>
								</div>
								<div class="t2">
									<ul class="bu">
									<li><span class="tit">운영기간</span> ${ExprnForm.bgnDe} ~ ${ExprnForm.endDe}</li>
									<li><span class="tit">시간</span> ${ExprnForm.exprnTime}</li>
									<li><span class="tit">인원</span> 각 ${ExprnForm.exprnNmpr}명</li>
									<li><span class="tit">체험료</span> <c:set var="price" value="${ExprnForm.exprnBaseAmt + ExprnForm.exprnMtrAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />원</li>
									</ul>
                                    <!-- files1 -->
									<div class="files1">
									<ul>
									<!--<li><a href="AbcdeFghijKlmnoPqrstUvwxyZ.hwp" class="filename" target="_blank" title="첨부파일 새창 열림"><i class="ic_hwp"></i> AbcdeFghijKlmnoPqrstUvwxyZ.hwp</a></li>-->
									</ul>
									</div>
                                    <!-- /files1 -->
								</div>

							</div>
                </div>
                <!-- /info1 -->

                <!-- substance -->
                <div class="substance">
                    <!--<div><img src="/assets/images/woodcraft/www/_sample/edu1_view_01.png" alt="★대체텍스트필수" /></div>-->
                        ${fn:replace(ExprnForm.exprnIntrcn, newLineChar, "<br/>")}
                </div>
                <!-- /substance -->

            </div>
            <!-- /edu1view1 -->

            <!-- infosection1 -->
            <div class="infosection1">
                <p class="tac">
                    <a href="#" class="button submit" data-exprn-id="${ExprnForm.exprnId}" data-exprn-sttus="${ExprnForm.exprnSttus}" data-exprn-nmpr='${ExprnForm.exprnNmpr}' data-req-cnt='${ExprnForm.reqCnt}'>체험예약</a>
                    &nbsp;
                    <a href="<c:url value="/exprn/exprnList.do?pageIndex=1"/>" class="button">목록</a>
                </p>
            </div>
            <!-- /infosection1 -->


    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                changePic1('click', '.pic1list1', '.m', 1, '.pt1');

                $("a[data-exprn-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id");

                    var view_url = "<c:url value="/exprn/exprnReqRegitAll.do"/>";

                    var exprnSttus = $(this).attr("data-exprn-sttus");
                    var exprnNmpr = $(this).attr("data-exprn-nmpr");
                    var reqCnt = $(this).attr("data-req-cnt");

                    // 주석제거 2018.12.21
                    if(exprnSttus == '01') {
                        alert("대기중인 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '03') {
                        alert("예약이 완료된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '04') {
                        alert("취소된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '02') {
                        if(exprnNmpr <= reqCnt) {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

            });

        </script>

    </layout:put>

</layout:extends>
