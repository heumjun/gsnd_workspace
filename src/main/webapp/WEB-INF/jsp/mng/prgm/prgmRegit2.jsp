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
    <layout:put block="title" type="REPLACE">프로그램/체험</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">프로그램/체험</a></li>
                        <li><a class="on" href="#">프로그램신청현황</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                    <!-- content -->
                    <h2 class="title-h2">프로그램정보</h2>
                    <div class="form">

                        <form:form commandName="PrgmForm" id="PrgmForm" method="post">
                            <form:hidden path="exprnId"/>
                            <form:hidden path="atchFileId"/>
                            <form:hidden path="atchFileId2"/>
                            <form:hidden path="bgnDe"/>
                            <form:hidden path="endDe"/>
                            <form:hidden path="exprnSe"/>
                            <form:hidden path="exprnSttus"/>

                            <fieldset>
                                <legend>프로그램등록</legend>
                                <table class="template-table">
                                    <caption class="display-none">프로그램등록</caption>
                                    <colgroup>
                                        <col style="width:100px" />
                                        <col />
                                        <col style="width:80px" />
                                        <col />
                                        <col style="width:80px" />
                                        <col />
                                        <col style="width:80px" />
                                        <col />
                                    </colgroup>
                                    <tr>
                                        <td class="align-left font-weight-bold"><label for="txt_exprnNm">프로그램명</label></td>
                                        <td colspan="7" class="align-left">
                                            <input type="text" id="txt_exprnNm" name="exprnNm" class="k-textbox" style="width:100%;" value="${PrgmForm.exprnNm}" disabled/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-left font-weight-bold"><label for="txt_teacherNm">강사명</label></td>
                                        <td colspan="7" class="align-left">
                                            <input type="text" id="txt_teacherNm" name="teacherNm" class="k-textbox" style="width:100%;" value="${PrgmForm.teacherNm}" disabled/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-left font-weight-bold"><label for="txt_bgnDe">시작일자</label></td>
                                        <td colspan="3" class="align-left">
                                            <input id="txt_bgnDe" disabled/>
                                        </td>
                                        <td class="align-left font-weight-bold"><label for="txt_endDe">종료일자</label></td>
                                        <td colspan="3" class="align-left">
                                            <input id="txt_endDe" disabled/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="align-left font-weight-bold"><label for="txt_exprnSe">개설과정</label></td>
                                        <td colspan="3" class="align-left">
                                            <kendo:dropDownList name="txt_exprnSe" dataTextField="text" dataValueField="value"  value="${PrgmForm.exprnSe}" style="width:150px;" disabled="true">
                                                <kendo:dataSource data="${exprnSe}"></kendo:dataSource>
                                            </kendo:dropDownList>
                                        </td>
                                        <td class="align-left font-weight-bold"><label for="txt_exprnSttus">진행상태</label></td>
                                        <td colspan="3" class="align-left">
                                            <kendo:dropDownList name="txt_exprnSttus" dataTextField="text" dataValueField="value"  value="${PrgmForm.exprnSttus}" style="width:150px;" disabled="true">
                                                <kendo:dataSource data="${exprnSttus}"></kendo:dataSource>
                                            </kendo:dropDownList>
                                        </td>
                                    </tr>
                                    <%--<tr>--%>
                                        <%--<td class="align-left font-weight-bold"><label for="txt_exprnBaseAmt">수강료</label></td>--%>
                                        <%--<td colspan="3" class="align-left">--%>
                                            <%--<input type="text" id="txt_exprnBaseAmt" name="exprnBaseAmt" class="k-textbox" style="width:100%;"  value="${PrgmForm.exprnBaseAmt}"/>--%>
                                        <%--</td>--%>
                                        <%--<td class="align-left font-weight-bold"><label for="txt_exprnMtrAmt">재료비</label></td>--%>
                                        <%--<td colspan="3" class="align-left">--%>
                                            <%--<input type="text" id="txt_exprnMtrAmt" name="exprnMtrAmt" class="k-textbox" style="width:100%;" value="${PrgmForm.exprnMtrAmt}"/>--%>
                                        <%--</td>--%>
                                    <%--</tr>--%>
                                    <%--<tr>--%>
                                        <%--<td class="align-left font-weight-bold"><label for="txt_exprnNmpr">모집인원</label></td>--%>
                                        <%--<td colspan="3" class="align-left">--%>
                                            <%--<input type="text" id="txt_exprnNmpr" name="exprnNmpr" class="k-textbox" style="width:100%;" value="${PrgmForm.exprnNmpr}"/>--%>
                                        <%--</td>--%>
                                        <%--<td class="align-left font-weight-bold"><label for="txt_exprnTime">시간</label></td>--%>
                                        <%--<td colspan="3" class="align-left">--%>
                                            <%--<input type="text" id="txt_exprnTime" name="exprnTime" class="k-textbox" style="width:100%;" value="${PrgmForm.exprnTime}"/>--%>
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
                    </span>
                    </div>
                    </span>
                    <!-- 프로그램 예약자 리스트 -->
                    <h2 class="title-h2">프로그램 예약자 리스트</h2>
                    <table class="template-table" summary="체험목록">
                        <caption class="display-none">체험목록</caption>
                        <colgroup>
                            <col />
                            <col style="width:100px" />
                            <col style="width:150px"/>
                            <col style="width:200px"/>
                            <col style="width:150px"/>
                            <col style="width:200px" />
                        </colgroup>
                        <thead><tr>
                            <th scope="row">신청자명</th>
                            <th scope="row">신청인원</th>
                            <th scope="row">진행상태</th>
                            <th scope="row">전화번호</th>
                            <th scope="row">예약방법</th>
                            <th scope="row">등록일시</th>
                        </tr></thead>
                        <tbody>
                        <c:forEach var="result" items="${retList}" varStatus="status">
                            <tr>
                                <td><span class="font-weight-bold font-size-l">${result.reqNm}</span></td>
                                <td><span class="font-color-gray">${result.exprnNmpr}</span></td>
                                <td><span class="font-color-gray">${result.reqSttus}</span></td>
                                <td><span class="font-color-gray">${result.telNo}</span></td>
                                <td><span class="font-color-gray">온라인</span></td>
                                <td><span class="font-color-gray">${result.reqDt}</span></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table><div class="clear"></div>
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
                    document.location.href = "<c:url value="/mng/prgm/prgmList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $('#txt_exprnSe').data('kendoDropDownList').value('${PrgmForm.exprnSe}');
                $('#txt_exprnSttus').data('kendoDropDownList').value('${PrgmForm.exprnSttus}');

                $("#txt_bgnDe").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_bgnDe').data('kendoDatePicker').value('${PrgmForm.bgnDe}');

                $("#txt_endDe").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyy/MM/dd"
                })

                $('#txt_endDe').data('kendoDatePicker').value('${PrgmForm.endDe}');

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action',"<c:url value="/mng/prgm/prgmList2.do" />").append($(input)).submit();
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

            });

        </script>
    </layout:put>
</layout:extends>
