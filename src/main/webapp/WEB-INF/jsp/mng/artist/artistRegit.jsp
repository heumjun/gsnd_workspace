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
    <layout:put block="title" type="REPLACE">목공예인관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">목공예인관리</a></li>
                        <li><a class="on" href="#">목공예인관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">목공예인등록</h2>
                <div class="form">

                    <form:form commandName="ArtistForm" id="ArtistForm" method="post">
                        <form:hidden path="artistId"/>
                        <form:hidden path="atchFileId"/>
                        <form:hidden path="atchFileId2"/>

                        <fieldset>
                            <legend>목공예인등록</legend>
                            <table class="template-table">
                                <caption class="display-none">목공예인등록</caption>
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
                                    <td class="align-left font-weight-bold"><label for="txt_artistNm">작가명</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_artistNm" name="artistNm" class="k-textbox" style="width:100%;" value="${ArtistForm.artistNm}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_crfShopNm">공방명</label></td>
                                    <td colspan="3" class="align-left">
                                        <input name="crfShopNm" id="txt_crfShopNm" class="k-textbox" style="width:100%;"  value="${ArtistForm.crfShopNm}"/>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_hpNo">휴대폰번호</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_hpNo" name="hpNo" class="k-textbox" style="width:100%;" value="${ArtistForm.hpNo}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_telNo">전화번호</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_telNo" name="telNo" class="k-textbox" style="width:100%;" value="${ArtistForm.telNo}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_adres">공방주소</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_adres" name="adres" class="k-textbox" style="width:100%;" value="${ArtistForm.adres}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_dtlAdres">주소상세</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_dtlAdres" name="dtlAdres" class="k-textbox" style="width:100%;" value="${ArtistForm.dtlAdres}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_hmpg">홈페이지</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_hmpg" name="hmpg" class="k-textbox" style="width:100%;" value="${ArtistForm.hmpg}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_email">이메일</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_email" name="email" class="k-textbox" style="width:100%;" value="${ArtistForm.email}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_supGoods">취급품</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_supGoods" name="supGoods" class="k-textbox" style="width:100%;" value="${ArtistForm.supGoods}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_etcCn">비고</label></td>
                                    <td colspan="7" class="align-left">
                                        <textarea type="text" id="txt_etcCn" name="etcCn" class="k-textbox" style="width:100%;height:100px; resize: none;"><c:out value="${ArtistForm.etcCn}"/></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="files">작가사진(목록,상세)</label></td>
                                    <td colspan="7" class="align-left">
                                        * 이미지 사이즈 : <em style="color:#d00;">480*640</em>
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
                                    <td class="align-left font-weight-bold"><label for="files">작가사진(메인)</label></td>
                                    <td colspan="7" class="align-left">
                                        * 이미지 사이즈 : <em style="color:#d00;">237*195</em>
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
                        <c:when test="${ArtistForm.artistId != null}">
                            <span class="button medium icon"><span class="check ico_del"></span><button id="btn_delete" type="button">삭제</button></span>
                        </c:when>
                    </c:choose>
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
                       document.location.href = "<c:url value="/mng/artist/artistList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action',"<c:url value="/mng/artist/artistList.do" />").append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    if($("#txt_artistNm").val().length == 0){
                        alert("작가명을 입력하세요");
                        return false;
                    }

                    if($("#txt_crfShopNm").val().length == 0){
                        alert("공방명을 입력하세요");
                        return false;
                    }

                    $("#ArtistForm").attr("action",'<c:url value="/mng/artist/artistSave.do" />').submit();
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
                        $("#ArtistForm")
                            .attr("action",'<c:url value="/mng/artist/artistDelete.do" />')
                            .submit();
                    }

                });

            });
        </script>
    </layout:put>
</layout:extends>