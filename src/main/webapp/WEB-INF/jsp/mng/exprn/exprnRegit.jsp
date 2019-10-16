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
    <layout:put block="title" type="REPLACE">체험관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">체험관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">체험등록</h2>
                <div class="form">

                    <form:form commandName="ExprnForm" id="ExprnForm" method="post">
                        <form:hidden path="exprnId"/>
                        <form:hidden path="atchFileId"/>
                        <form:hidden path="atchFileId2"/>
                        <form:hidden path="bgnDe"/>
                        <form:hidden path="endDe"/>
                        <form:hidden path="exprnSe"/>
                        <form:hidden path="exprnSttus"/>

                        <fieldset>
                            <legend>체험등록</legend>
                            <table class="template-table">
                                <caption class="display-none">목공예품등록</caption>
                                <colgroup>
                                    <col style="width:90px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                    <col style="width:80px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnNm">체험명</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_exprnNm" name="exprnNm" class="k-textbox" style="width:100%;" value="${ExprnForm.exprnNm}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_teacherNm">강사명</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_teacherNm" name="teacherNm" class="k-textbox" style="width:100%;" value="${ExprnForm.teacherNm}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_bgnDe">시작일</label></td>
                                    <td colspan="3" class="align-left">
                                        <input id="txt_bgnDe" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_endDe">종료일</label></td>
                                    <td colspan="3" class="align-left">
                                        <input id="txt_endDe" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnSe">체험구분</label></td>
                                    <td colspan="3" class="align-left">
                                        <kendo:dropDownList name="txt_exprnSe" dataTextField="text" dataValueField="value"  value="${ExprnForm.exprnSe}" style="width:150px;">
                                            <kendo:dataSource data="${exprnSe}"></kendo:dataSource>
                                        </kendo:dropDownList>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnSttus">진행상태</label></td>
                                    <td colspan="3" class="align-left">
                                        <kendo:dropDownList name="txt_exprnSttus" dataTextField="text" dataValueField="value"  value="${ExprnForm.exprnSttus}" style="width:150px;">
                                            <kendo:dataSource data="${exprnSttus}"></kendo:dataSource>
                                        </kendo:dropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnBaseAmt">기본체험료</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_exprnBaseAmt" name="exprnBaseAmt" class="k-textbox" style="width:100%;"  value="${ExprnForm.exprnBaseAmt}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnMtrAmt">재료비</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_exprnMtrAmt" name="exprnMtrAmt" class="k-textbox" style="width:100%;"  value="${ExprnForm.exprnMtrAmt}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnNmpr">체험인원</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_exprnNmpr" name="exprnNmpr" class="k-textbox" style="width:100%;" value="${ExprnForm.exprnNmpr}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnTime">체험시간</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_exprnTime" name="exprnTime" class="k-textbox" style="width:100%;" value="${ExprnForm.exprnTime}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnIntrcn">소개</label></td>
                                    <td colspan="7" class="align-left">
                                        <textarea type="text" id="txt_exprnIntrcn" name="exprnIntrcn" class="k-textbox" style="width:100%;height:100px; resize: none;"><c:out value="${ExprnForm.exprnIntrcn}"/></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="files">사진</label></td>
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
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="files">첨부파일</label></td>
                                    <td colspan="7" class="align-left">
                                        <c:if test="${fn:length(fileResult2) > 0}">
                                            <ul class="attach-style">
                                                <c:forEach var="fileVO" items="${fileResult2}" varStatus="status">
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
                                        <kendo:upload name="files2" multiple="false"/>
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
                        <c:when test="${ExprnForm.exprnId != null}">
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
                    document.location.href = "<c:url value="/mng/exprn/exprnList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $('#txt_exprnSe').data('kendoDropDownList').value('${ExprnForm.exprnSe}');
                $('#txt_exprnSttus').data('kendoDropDownList').value('${ExprnForm.exprnSttus}');

                $("#txt_bgnDe").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_bgnDe').data('kendoDatePicker').value('${ExprnForm.bgnDe}');

                $("#txt_endDe").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_endDe').data('kendoDatePicker').value('${ExprnForm.endDe}');

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/exprn/exprnList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    if($("#txt_exprnNm").val().length == 0){
                        alert("체험명을 입력하세요");
                        return false;
                    }

                    var select = $("#txt_exprnSe").data("kendoDropDownList");
                    $('#exprnSe').val(select.value());

                    select = $("#txt_exprnSttus").data("kendoDropDownList");
                    $('#exprnSttus').val(select.value());

                    $('#bgnDe').val($("#txt_bgnDe").val());
                    $('#endDe').val($("#txt_endDe").val());

                    $("#ExprnForm").attr("action",'<c:url value="/mng/exprn/exprnSave.do" />')
                    //.append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnForm.exprnId}'))
                        .submit();
                });

                $('[data-dn-file-id]').click(function(event) {
                    var atchFileId = $(event.target).attr('data-dn-file-id');
                    var fileSn = $(event.target).attr('data-dn-file-sn');

                    window.open('<c:url value="/cmm/fms/FileDown.do" />'+"?atchFileId="+atchFileId+"&fileSn="+fileSn);
                });

                $('[data-rm-file-id]').click(function(event) {

                    var atchFileId = $(event.target).attr('data-rm-file-id');
                    var fileSn = $(event.target).attr('data-rm-file-sn');
                    var url = '<c:url value="/cmm/fms/json/deleteFile.do" />' + "?atchFileId="+atchFileId+"&fileSn="+fileSn;

                    var me = $(event.target);
                    $.post(url, function(data) {
                        if (data.indexOf("OK") > 0)
                            $(me).parent().parent().parent().remove();
                    });
                });

                $("#btn_delete").click(function(){

                    var result = confirm('삭제 하시겠습니까?');

                    if (result){
                        $("#ExprnForm")
                            .attr("action",'<c:url value="/mng/exprn/exprnDelete.do" />')
                            //.append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnForm.exprnId}'))
                            .submit();
                    }

                });

            });

        </script>
    </layout:put>
</layout:extends>