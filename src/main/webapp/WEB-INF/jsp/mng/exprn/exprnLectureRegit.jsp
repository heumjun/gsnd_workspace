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
                        <li><a class="on" href="#">체험일정관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
                <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">체험일정등록</h2>
                <div class="form">

                    <form:form commandName="ExprnLectureForm" id="ExprnLectureForm" method="post">
                        <form:hidden path="exprnLectureId"/>
                        <form:hidden path="exprnId"/>
                        <form:hidden path="exprnDay"/>

                        <fieldset>
                            <legend>체험일정등록</legend>
                            <table class="template-table">
                                <caption class="display-none">체험일정등록</caption>
                                <colgroup>
                                <col style="width:140px" />
                                <col />
                                <col style="width:160px" />
                                <col />
                            </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnNm">체험명</label></td>
                                    <td colspan="3" class="align-left">
                                        <kendo:dropDownList name="txt_exprnId" dataTextField="text" dataValueField="value"  value="${ExprnLectureForm.exprnId}" style="width:150px;">
                                            <kendo:dataSource data="${exprnList}"></kendo:dataSource>
                                        </kendo:dropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnDay">체험일</label></td>
                                    <td class="align-left">
                                        <input id="txt_exprnDay" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnTime">체험시간</label></td>
                                    <td class="align-left">
                                        <input type="text" id="txt_exprnTime" name="exprnTime" class="k-textbox" style="width:100%;" value="${ExprnLectureForm.exprnTime}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnNmlc">전체인원수</label></td>
                                    <td class="align-left">
                                        <input type="text" id="txt_exprnNmlc" name="exprnNmlc" class="k-textbox" style="width:100%;"  value="${ExprnLectureForm.exprnNmlc}" />
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_exprnReqCnt">현재예약인원(온라인)</label></td>
                                    <td class="align-left">
                                        <input type="text" id="txt_exprnReqCnt" name="exprnReqCnt" class="k-textbox" style="width:100%;"  value="${ExprnLectureForm.exprnReqCnt}" disabled/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_reservationCnt">전화예약(입력)</label></td>
                                    <td class="align-left">
                                        <input type="text" id="txt_reservationCnt" name="reservationCnt" class="k-textbox" style="width:100%;"  value="${ExprnLectureForm.reservationCnt}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"></td>
                                    <td class="align-left"></td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_note">비고</label></td>
                                    <td colspan="3" class="align-left">
                                        <textarea type="text" id="txt_note" name="note" class="k-textbox" style="width:100%;height:100px; resize: none;"><c:out value="${ExprnLectureForm.note}"/></textarea>
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
                        <c:when test="${ExprnLectureForm.exprnLectureId != null}">
                            <span class="button medium icon"><span class="check ico_del"></span><button id="btn_delete" type="button">삭제</button></span>
                        </c:when>
                    </c:choose>
                </div>
                </span>
                    <!-- ryan.added  -->
                    <c:if test="${ExprnLectureForm.exprnLectureId != null}">
                        <h2 class="title-h2">체험예약자 리스트</h2>
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
                    </c:if>
                    <!-- ryan.added  -->
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
                    document.location.href = "<c:url value="/mng/exprn/exprnLectureList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $("#txt_exprnDay").kendoDatePicker({
                    value: new Date(),
                    min: new Date(1950, 0, 1),
                    max: new Date(2049, 11, 31),
                    format: "yyyyMMdd"
                })

                $('#txt_exprnDay').data('kendoDatePicker').value('${ExprnLectureForm.exprnDay}');

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/exprn/exprnLectureList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    var select = $("#txt_exprnId").data("kendoDropDownList");
                    $('#exprnId').val(select.value());

                    $('#exprnDay').val($("#txt_exprnDay").val());

                    $("#ExprnLectureForm").attr("action",'<c:url value="/mng/exprn/exprnLectureSave.do" />')
                    //.append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnLectureForm.exprnId}'))
                        .submit();
                });

                $("#btn_delete").click(function(){

                    var result = confirm('삭제 하시겠습니까?');

                    if (result){
                        $("#ExprnLectureForm")
                            .attr("action",'<c:url value="/mng/exprn/exprnLectureDelete.do" />')
                            //.append($("<input />").attr("type","hidden").attr("name","exprnId").val('${ExprnLectureForm.exprnLectureId}'))
                            .submit();
                    }

                });

            });

        </script>
    </layout:put>
</layout:extends>