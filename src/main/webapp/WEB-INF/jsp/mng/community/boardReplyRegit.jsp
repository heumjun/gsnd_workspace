<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 2:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">게시물관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">게시물관리</a></li>
                        <li><a class="on" href="#">게시물관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">게시물 답변등록</h2>
                <div class="form">

                    <form:form commandName="board" id="board" method="post">
                        <form:hidden path="nttId"/>
                        <form:hidden path="atchFileId" />
                        <form:hidden path="replyAt" value="Y" />
                        <form:hidden path="parnts"  />
                        <form:hidden path="sortOrdr"  />
                        <form:hidden path="replyLc" />

                        <fieldset>
                            <legend>게시물 답변등록</legend>
                            <table class="template-table">
                                <caption class="display-none">게시물 답변등록</caption>
                                <colgroup>
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_nttSj">제목</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_nttSj" name="nttSj" class="k-textbox" style="width:100%;" value="${board.nttSj}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_nttCn">내용</label></td>
                                    <td colspan="7" class="align-left">
                                        <textarea type="text" id="txt_nttCn" name="nttCn" class="k-textbox" style="width:100%;height:100px; resize: none;"><c:out value="${board.nttCn}"/></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="files">첨부파일</label></td>
                                    <td colspan="7" class="align-left">
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
                                        <kendo:upload name="files" multiple="false"/>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>

                    </form:form>
                </div>

                <div class="clear"></div>

                <div class="btn-container align-right">
                    <span class="button medium icon strong">
                        <span class="menu ico_list"></span><button id="btn_list" type="button">목록</button></span>
                    <span class="button medium icon">
                       <span class="check ico_save"></span>
                       <button id="btn_submit" type="button">
                           저장
                       </button>
                    </span>
                    <c:choose>
                        <c:when test="${board.nttId != null}">
                            <span class="button medium icon"><span class="check ico_del"></span><button id="btn_delete" type="button">삭제</button></span>
                        </c:when>
                    </c:choose>
                </div>
                </span>
                </div>
                <!-- content -->
            </section>
            </section>
        </article>
    </layout:put>

    <layout:put block="javascript" type="REPLACE">
        <script type="text/javascript">
            $(document).ready(function () {

                <c:if test="${message != null}">
                alert("${message}");
                if ("${result}" == "OK")
                    document.location.href = "<c:url value="/mng/community/list/${boardId}.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action',"<c:url value="/mng/community/list/${boardId}.do"/>").append($(input)).submit();
                });

                $("#btn_submit").click(function() {
                    if($("#txt_nttSj").val().length == 0){
                        alert("제목을 입력하세요");
                        return false;
                    }

                    $("#board").attr("action",'<c:url value="/mng/community/replySave/${boardId}.do" />').submit();
                });

                $('[data-dn-file-id]').click(function(event) {
                    var atchFileId = $(event.target).attr('data-dn-file-id');
                    var fileSn = $(event.target).attr('data-dn-file-sn');

                    window.open('<c:url value="/cmm/fms/FileDown.do?atchFileId=" />'+atchFileId+"&fileSn="+fileSn);
                });

                $('[data-rm-file-id]').click(function(event) {

                    var atchFileId = $(event.target).attr('data-rm-file-id');
                    var fileSn = $(event.target).attr('data-rm-file-sn');
                    var url = '<c:url value="/cmm/fms/json/deleteFile.do?atchFileId=" />'+atchFileId+"&fileSn="+fileSn;

                    var me = $(event.target);
                    $.post(url, function(data) {
                        if (data.indexOf("OK") > 0)
                            $(me).parent().parent().parent().remove();
                    });
                });

                $("#btn_delete").click(function(){

                    var result = confirm('삭제 하시겠습니까?');

                    if (result){
                        $("#board")
                            .attr("action",'<c:url value="/mng/community/delete/${boardId}.do" />')
                            //.append($("<input />").attr("type","hidden").attr("name","nttId").val('${board.nttId}'))
                            .submit();
                    }

                });

            });

        </script>
    </layout:put>
</layout:extends>