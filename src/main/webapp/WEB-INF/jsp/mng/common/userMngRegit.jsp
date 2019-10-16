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
    <layout:put block="title" type="REPLACE">회원관리</layout:put>
    <layout:put block="contents" type="REPLACE">
        <article id="content">
            <div class="article-header">
                <nav class="curr-nav">
                    <ul>
                        <li><a class="home" href="#">홈</a></li>
                        <li><a href="#">회원관리</a></li>
                        <li><a class="on" href="#">회원관리</a></li>
                    </ul>
                </nav>
            </div>
            <section class="sub">
            <section class="sub-body">
                <!-- content -->
                <h2 class="title-h2">회원등록</h2>
                <div class="form">

                    <form:form commandName="userManageForm" id="userManageForm" method="post">
                        <form:hidden path="uniqId" value="${userManageForm.uniqId}" />

                        <fieldset>
                            <legend>회원등록</legend>
                            <table class="template-table">
                                <caption class="display-none">회원등록</caption>
                                <colgroup>
                                    <col style="width:90px" />
                                    <col />
                                    <col style="width:90px" />
                                    <col />
                                    <col style="width:90px" />
                                    <col />
                                    <col style="width:90px" />
                                    <col />
                                </colgroup>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_emplyrNm">회원명</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_emplyrNm" name="emplyrNm" class="k-textbox" style="width:100%;" value="${userManageForm.emplyrNm}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_emplyrId">유저아이디</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_emplyrId" name="emplyrId" class="k-textbox" style="width:100%;" value="${userManageForm.emplyrId}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_moblphonNo">전화번호</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_moblphonNo" name="moblphonNo" class="k-textbox" style="width:100%;" value="${userManageForm.moblphonNo}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_emailAdres">이메일</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_emailAdres" name="emailAdres" class="k-textbox" style="width:100%;" value="${userManageForm.emailAdres}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_zip">우편번호</label></td>
                                    <td colspan="7" class="align-left">
                                        <input type="text" id="txt_zip" name="zip" class="k-textbox" style="width:100%;" value="${userManageForm.zip}"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-left font-weight-bold"><label for="txt_homeadres">주소</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_homeadres" name="homeadres" class="k-textbox" style="width:100%;" value="${userManageForm.homeadres}"/>
                                    </td>
                                    <td class="align-left font-weight-bold"><label for="txt_detailAdres">상세주소</label></td>
                                    <td colspan="3" class="align-left">
                                        <input type="text" id="txt_detailAdres" name="detailAdres" class="k-textbox" style="width:100%;" value="${userManageForm.detailAdres}"/>
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
                        <c:when test="${userManageForm.uniqId != null}">
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
                    document.location.href = "<c:url value="/mng/user/userList.do" />";
                </c:if>

                kendo.culture("ko-KR");

                $("#btn_list").click(function() {
                    var input = $("<input>").attr("type", "hidden").attr("name", "type").val("view");
                    $('<form/>').appendTo("#content").attr('action','<c:url value="/mng/user/userList.do" />').append($(input)).submit();
                });

                $("#btn_submit").click(function() {

                    if($("#txt_emplyrNm").val().length == 0){
                        alert("회원명을 입력하세요");
                        return false;
                    }

                    $("#userManageForm").attr("action",'<c:url value="/mng/user/userSave.do" />')
                    //.append($("<input />").attr("type","hidden").attr("name","wcrfId").val('${userManageForm.uniqId}'))
                        .submit();
                });

                $("#btn_delete").click(function(){

                    var result = confirm('삭제 하시겠습니까?');

                    if (result){
                        $("#userManageForm")
                            .attr("action",'<c:url value="/mng/user/userDelete.do" />')
                            //.append($("<input />").attr("type","hidden").attr("name","wcrfId").val('${userManageForm.uniqId}'))
                            .submit();
                    }

                });

            });

        </script>
    </layout:put>
</layout:extends>