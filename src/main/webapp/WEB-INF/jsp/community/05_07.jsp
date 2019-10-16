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
<% pageContext.setAttribute("newLineChar", "\n"); %>

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

            <!-- bbs_view -->
            <div class="bbs_view">
                <h1 class="h1">
                        ${result.nttSj}</h1>
                <!-- info1 -->
                <div class="info1">
                    <dl>
                        <dt>작성일</dt>
                        <dd>${result.frstRegisterPnttm}</dd>
                        <dt>작성자</dt>
                        <dd>${result.ntcrNm}</dd>
                        <!--<dt>공개 여부</dt>
                        <dd><em class="em1">비공개</em></dd>
                        <dt>출처</dt>
                        <dd>${result.nttSj}</dd>
                        <dt>처리</dt>
                        <dd><em class="em4">완료</em></dd>
                        <dt>조회수</dt>
                        <dd>${result.nttSj}</dd>-->
                    </dl>
                </div>
                <!-- /info1 -->
                <!-- attach1 -->
                <c:if test="${menuNo == '11501000' || menuNo == '11504000'}">
                    <div class="attach1">
                        <c:if test="${fn:length(fileResult) > 0}">
                            <ul>
                                <c:forEach var="fileVO" items="${fileResult}" varStatus="status">
                                    <li>
                                        <a href="<c:url value="/cmm/pas/FileDown.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>" class="filename" title="첨부파일 새창 열림"><i class="ic_file"></i> ${fileVO.orignlFileNm} </a>
                                        <a href="#" onclick="fnDownload('${result.atchFileId}','${fileVO.fileSn}',encodeURIComponent('${fileVO.orignlFileNm}'));return false;" title="파일명 [새 창]" class="b1 quickview"><i class="ic1"></i><span class="t1">바로보기</span></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>
                </c:if>
                <!-- /attach1 -->
                <!-- substance -->
                <div class="substance">
                        <!-- 갤러리의 경우 이미지 표시 -->
                        <c:if test="${menuNo == '11502000' || menuNo == '11503000'}">

                            <c:forEach var="fileVO" items="${fileResult}" varStatus="status">
                                <img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>" alt="${result.nttCn}" />
                                <br/>
                                <br/>
                            </c:forEach>
                            <br/>
                        </c:if>

                        ${fn:replace(result.nttCn, newLineChar, "<br/>")}
                </div>
                <!-- /substance -->
            </div>
            <!-- /bbs_view -->

            <!-- infosection1 -->
            <div class="infosection1">
                <!--<p class="left" style="width:50%;">
                    <a href="?" class="button"><span class="t1">이전글</span></a>
                    <a href="?" class="button"><span class="t1">다음글</span></a>
                </p>-->
                <p class="right">
                    <c:if test="${updateFlag == true}">
                        <a href="<c:url value="/community/delete/"/>${boardId}.do?nttId=${result.nttId}" class="button">삭제</a>
                        <a href="<c:url value="/community/regist/"/>${boardId}.do?nttId=${result.nttId}" class="button">수정</a>
                    </c:if>
                    <a href="<c:url value="/community/list/"/>${boardId}.do" class="button">목록</a>
                </p>
            </div>
            <!-- /infosection1 -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript" src='http://www.jinju.go.kr/program/includejs/convertV3.js'></script>

        <script type="text/javascript" charset="utf-8">

            function fnDownload(atchFileId, fileSn, orignlFileNm){

                alert("<c:url value='/inc/agree/98.jsp'/>"+'?atchFileId='+atchFileId+'&fileSn='+fileSn+'&orignlFileNm='+orignlFileNm);
                window.open("<c:url value='/inc/agree/98.jsp'/>"+'?atchFileId='+atchFileId+'&fileSn='+fileSn+'&orignlFileNm='+orignlFileNm, '_blank', "top=100, left=100, width=430, height=430, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
                return false;
            }

        </script>

    </layout:put>

</layout:extends>
