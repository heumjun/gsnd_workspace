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
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="${menuNo}"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="cssPart" type="REPLACE">
        <!-- kendoUI -->
        <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.common.min.css"/>' />
        <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.default.min.css"/>'/>
        <!-- link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.customsilver.css"/>' / -->
        <!-- //CSS -->
        <!-- JS -->
    </layout:put>

    <layout:put block="contents" type="REPLACE">

            <!-- bbs_write -->
            <div class="bbs_write">
                <p><em class="required" title="필수항목">*</em> 는 필수 입력 항목입니다.</p>

                <!-- 작성 폼 -->
                <form:form commandName="board" id="board" method="post">
                    <form:hidden path="nttId" value="${board.nttId}" />
                    <form:hidden path="atchFileId" value="${board.atchFileId}" />

                    <!-- fieldset -->
                    <fieldset><legend class="blind">작성 폼</legend>
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">공지사항 작성 폼</strong>
                            </caption>
                            <col style="width:12em;" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label for="txt_nttSj">제목</label></th>
                                <td><input type="text" id="txt_nttSj" name="nttSj" value="${board.nttSj}" class="w100" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_nttCn">내용</label></th>
                                <td><div class="explain">* 개인정보보호를 위해 주민번호, 주소, 전화번호 등은 내용에 남기지 마십시오.</div>
                                    <textarea id="txt_nttCn" name="nttCn" rows="5" cols="80" class="w100">${board.nttCn}</textarea></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_atchFileId">첨부파일1</label></th>
                                <td><!--<input type="file" id="txt_atchFileId" name="atchFileId" />-->

                                    <c:if test="${fn:length(fileResult) > 0}">
                                        <ul class="attach-style">
                                            <c:forEach var="fileVO" items="${fileResult}" varStatus="status">
                                                <li class="btn-container">
                                                    <span class="k-filename" title="${fileVO.orignlFileNm}" style="width:350px;">${fileVO.orignlFileNm}</span>
                                                    <span class="attach-btn-wrapper">
                                                    <span class="button small icon"><span class="download"></span><button type="button" data-dn-file-id="${fileVO.atchFileId}" data-dn-file-sn="${fileVO.fileSn}">다운로드</button></span>
                                                    <span class="button small icon"><span class="cancel"></span><button type="button" data-rm-file-id="${fileVO.atchFileId}" data-rm-file-sn="${fileVO.fileSn}">삭제</button></span>
                                                </span>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                    <kendo:upload name="files" multiple="true"/>

                                </td>
                            </tr>
                            <!--<tr>
                                <th scope="row"><label for="f1file1alt1">첨부파일1<br /> 대체텍스트</label></th>
                                <td><div class="explain"><em class="em2">이미지는 웹 접근성을 위해 적절한 대체텍스트를 제공해야 합니다.</em></div>
                                    <textarea id="f1file1alt1" rows="5" cols="80" class="w100"></textarea></td>
                            </tr>-->
                            <!--<tr>
                                <th scope="row"><label for="f1file2">첨부파일2</label></th>
                                <td><input type="file" id="f1file2" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="f1file2alt1">첨부파일2<br /> 대체텍스트</label></th>
                                <td><textarea id="f1file2alt1" rows="5" cols="80" class="w100"></textarea></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="f1cite1">출처</label></th>
                                <td><input type="text" id="f1cite1" class="w100" /></td>
                            </tr>
                            <tr>
                                <th scope="row">답변요청</th>
                                <td><div class="explain">답변요청을 하시겠습니까?</div>
                                    &nbsp;&nbsp;
                                    <input type="radio" name="f1radio2" id="f1radio2e0" checked="checked" /><label for="f1radio2e0">예</label>
                                    &nbsp;&nbsp;
                                    <input type="radio" name="f1radio2" id="f1radio2e1" /><label for="f1radio2e1">아니요</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">내 권한</th>
                                <td>
                                    <input type="checkbox" name="f1checkbox2" id="f1checkbox2e0" checked="checked" /><label for="f1checkbox2e0"> 조회</label>
                                    &nbsp;&nbsp;
                                    <input type="checkbox" name="f1checkbox2" id="f1checkbox2e1" /><label for="f1checkbox2e1"> 작성/편집/수정/삭제</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">정보공개</th>
                                <td><span class="explain ">일반인에게</span>
                                    <label for="f1openinfo" class="blind">공개옵션</label>
                                    &nbsp;
                                    <select id="f1openinfo" title="공개옵션">
                                        <option value="">공개</option>
                                        <option value="">비공개</option>
                                    </select>
                                    &nbsp;
                                    <span class="explain">하시겠습니까?</span>
                                </td>
                            </tr>
                            -->
                            </tbody>
                        </table>

                        <!-- 약관 추가 -->
                        <h2 class="hb1 h2">약관동의</h2>
                        <table class="t5">
                            <caption class="blind"><strong class="h1">동의여부</strong></caption>
                            <tbody>
                            <tr>
                                <th class="tal" scope="row"><span class="com1agree1q1">개인정보 수집 및 이용안내</span></th>
                                <td class="tac com1agree1w1"><a href="/inc/agree/07.jsp" class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                                <td class="tac com1agree1w1"><input type="checkbox" id="tosCheck1" name="tosCheck1" value="Y" /> <label for="tosCheck1"> 동의함</label></td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- // 약관 추가 -->

                    </fieldset>
                    <!-- //fieldset -->

                    <!-- infosection1 -->
                    <div class="infosection1">
                        <p class="tac">
                            <button id="btn_save" type="button" class="button submit">저장하기</button>
                            <a href="<c:url value="/community/list/"/>${boardId}.do" class="button">취소하기</a>
                        </p>
                    </div>
                    <!-- /infosection1 -->
                </form:form>
                <!-- //작성 폼 -->
            </div>
            <!-- /bbs_write -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <!-- kendoUI -->
        <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/jquery.min.js"/>'></script>
        <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/kendo.all.min.js"/>'></script>
        <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/cultures/kendo.culture.ko-KR.min.js"/>'></script>

        <script type="text/javascript">

            <c:if test="${message != null}">
                alert(message);
                window.location.href='<c:url value="/community/list/"/>${boardId}.do';
            </c:if>

            $(document).ready(function() {

                $("#btn_save").click(function() {

                    if ($(":input:checkbox[name=tosCheck1]:checked").val() != 'Y') {
                        alert('개인정보 수집 및 이용안내에 동의해주세요.');
                        return false;
                    } else {
                        if($("#txt_nttSj").val().length == 0){
                            alert("제목을 입력하세요");
                            return false;
                        }
                        if($("#txt_nttCn").val().length == 0){
                            alert("내용을 입력하세요");
                            return false;
                        }

                        var view_url = "<c:url value="/community/save/"/>${boardId}.do";

                        $("#board")
                            .attr("action", view_url)
                            .submit();

                        return false;
                    }

                });

            });

        </script>

    </layout:put>

</layout:extends>
