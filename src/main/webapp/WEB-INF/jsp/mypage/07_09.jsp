<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-16
  Time: 오후 5:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>

<layout:extends name="wwwSub">

	<layout:put block="sidebar" type="REPLACE">
		<c:import url="/inc/sidebar.do">
			<c:param name="menuNo" value="11701000"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">

			<!-- mem1out -->
			<div class="mem1out tac">
				<i class="ic1 bsContain"></i>
				<p class="txt1">탈퇴하기</p>
				<p class="txt2">탈퇴를 하시면 회원님의 정보는 삭제되며 복구하실 수 없습니다.<br />정말로 탈퇴를 원하신다면 아래에 비밀번호를 입력하시고 탈퇴 버튼을 눌러주세요.</p>

				<!-- 탈퇴하기 입력 폼 -->
				<form:form commandName="userVO" id="userVO" method="post">
					<!-- fieldset -->
					<fieldset><legend class="blind">탈퇴하기 입력 폼</legend>
						<div class="bbs_write">
							<table class="t1">
								<caption class="blind"><strong class="h1">탈퇴하기 입력 폼</strong></caption>
								<col style="width:15%" /><col />
								<tbody>
								<tr>
									<th scope="row"><label for="txt_password">비밀번호 <em class="required" title="필수항목">*</em></label></th>
									<td><input type="password" id="txt_password" lang="en" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="txt_text">의견</label></th>
									<td><div class="explain">* 개인정보보호를 위해 주민번호, 주소, 전화번호 등은 내용에 남기지 마십시오.</div>
										<textarea id="txt_text" rows="5" cols="80" class="w100"></textarea></td>
								</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
					<!-- //fieldset -->
					<!-- btns -->
					<div class="btns">
						<p class="tac">
							<button id="btn_save" type="button" class="button submit">탈퇴하기</button>
						</p>
					</div>
					<!-- /btns -->
				</form:form>
				<!-- //탈퇴하기 입력 폼 -->
			</div>
			<!-- /mem1out -->

	</layout:put>

	<layout:put block="javascript" type="REPLACE">

		<script type="text/javascript">

            $(document).ready(function() {

                $("#btn_save").click(function() {

                    if($("#txt_password").val().length == 0){
                        alert("패스워드를 입력하세요");
                        return false;
                    }

                    var view_url = "<c:url value="/mypage/userOutSave.do"/>";

                    $("#userVO")
                        .attr("action", view_url)
                        .submit();

                    return false;

                });

            });

		</script>

	</layout:put>

</layout:extends>
