<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<layout:extends name="mngBase">
    <layout:put block="title" type="REPLACE">팝업존관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article  id="content">
        <div class="article-header">
            <nav class="curr-nav">
                <ul>
                    <li><a class="home" href="#">홈</a></li>
                    <li><a href="#">팝업관리</a></li>
                    <li><a class="on" href="#">팝업존 관리</a></li>
                </ul>
            </nav>
        </div>

        <section class="sub">
            <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">팝업존 정보</h2>
                <div class="form">

                    <form:form commandName="PopupForm" id="PopupForm" method="post">
                        <form:hidden path="popupId"/>
                        <form:hidden path="atchFileId"/>
                        <fieldset>
                            <legend>팝업존정보</legend>
                            <table class="template-table">
                                <caption class="display-none">팝업존정보</caption>
                                <col style="width:90px" />
                                <col />
                                <col style="width:80px" />
                                <col />
                                <col style="width:80px" />
                                <col />
                                <col style="width:80px" />
                                <col />
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="">제목</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_popupNm" name="popupNm" class="k-textbox" style="width:100%;" value="${PopupForm.popupNm}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="">사용여부</label></td>
                                    <td colspan="7" class="align-left">
                                        <kendo:dropDownList  name="txt_useYn" dataTextField="text" dataValueField="value"  value="${PopupForm.useYn}" style="width:150px;">
                                            <kendo:dataSource data="${useType}"></kendo:dataSource>
                                        </kendo:dropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="">기간</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_strtDe" name="strtDe" data-type="date" value="${PopupForm.strtDe}"/>&nbsp;~&nbsp;
                                        <input type="text" id="txt_endDe" name="endDe" data-type="date" value="${PopupForm.endDe}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="">링크</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_linkUrl" name="linkUrl" class="k-textbox" style="width:100%;" value="${PopupForm.linkUrl}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="">새창 타입</label></td>
                                    <td colspan="7" class="align-left">
                                        <kendo:dropDownList name="txt_urlType" dataTextField="text" dataValueField="value"  value="${PopupForm.urlType}" style="width:150px;">
                                            <kendo:dataSource data="${popupType}"></kendo:dataSource>
                                        </kendo:dropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="files">팝업이미지</label></td>
                                    <td colspan="7" class="align-left">
                                        * 이미지 사이즈 : <em style="color:#d00;">000*000</em>
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
                                <%--<tr>--%>
                                    <%--<td class="align-left font-weight-bold"><label for="">이미지 설명</label></td>--%>
                                    <%--<td class="align-left">--%>
                                        <%--<textarea id="txt_refdRsltCn" name="refdRsltCn" rows="5" cols="80" style="width:850px;" ></textarea>--%>
                                    <%--</td>--%>
                                <%--</tr>--%>
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
                        <c:when test="${PopupForm.popupId != null}">
                            <span class="button medium icon"><span class="check ico_del"></span><button id="btn_delete" type="button">삭제</button></span>
                        </c:when>
                    </c:choose>
                </div>
                </span>
                </div>
                <!-- content -->
            </section>
        </section>
    </layout:put>

    <layout:put block="javascript" type="REPLACE">
        <script type="text/javascript">
            $(document).ready(function() {

                <c:if test="${message != null}">
                alert("${message}");
                if ("${result}" == "OK")
                    document.location.href = "<c:url value="/mng/popup/popupList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $('#txt_useYn').data('kendoDropDownList').value('${PopupForm.useYn}');
                $('#txt_urlType').data('kendoDropDownList').value('${PopupForm.urlType}');

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action',"<c:url value="/mng/popup/popupList.do" />").append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    if($("#txt_popupNm").val().length == 0){
                        alert("제목을 입력하세요");
                        return false;
                    }

                    if($("#txt_linkUrl").val().length == 0){
                        alert("링크를 입력하세요");
                        return false;
                    }

                    $("#PopupForm").attr("action",'<c:url value="/mng/popup/popupSave.do" />').submit();
                });

                $('[data-dn-file-id]').click(function(event) {
                    var atchFileId = $(event.target).attr('data-dn-file-id');
                    var fileSn = $(event.target).attr('data-dn-file-sn');

                    window.open("<c:url value="/cmm/fms/FileDown.do" />"+"?atchFileId="+atchFileId+"&fileSn="+fileSn);
                });

                $('[data-rm-file-id]').click(function(event) {

                    var atchFileId = $(event.target).attr('data-rm-file-id');
                    var fileSn = $(event.target).attr('data-rm-file-sn');
                    var url = "<c:url value="/cmm/fms/json/deleteFile.do" />"+"?atchFileId="+atchFileId+"&fileSn="+fileSn;

                    var me = $(event.target);
                    $.post(url, function(data) {
                        if (data.indexOf("OK") > 0)
                            $(me).parent().parent().parent().remove();
                    });
                });


                $("#btn_delete").click(function(){

                    var result = confirm('삭제 하시겠습니까?');

                    if (result){
                        $("#PopupForm")
                            .attr("action",'<c:url value="/mng/artist/artistDelete.do" />')
                            .submit();
                    }

                });

            });
        </script>
    </layout:put>
</layout:extends>