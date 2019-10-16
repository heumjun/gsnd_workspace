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
			<c:param name="menuNo" value="11807000"></c:param>
			<c:param name="hideSidebar" value="Y"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
			<%--<c:param name="subTitle" value="등록"></c:param>--%>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">

			<!-- cnb1 -->
			<div id="cnb1">
				<ul class="col2">
					<li><a href="<c:url value="/user/findId.do"/>">아이디 찾기</a></li>
					<li class="on"><a href="#">비밀번호 찾기</a></li>
				</ul>
			</div>
			<!-- /cnb1 -->

			<!-- findpassword -->
			<div class="findpassword tac">
				<i class="ic1 bsContain"></i>
				<p class="txt1">비밀번호 찾기</p>
				<p class="txt2">회원정보에 등록된 이메일로 임시 비밀번호를 발송해드립니다.</p>

				<!-- 비밀번호 찾기 폼 -->
				<form:form commandName="userVO" id="userVO" method="post">
					<!-- fieldset -->
					<fieldset><legend class="blind">비밀번호 찾기 폼</legend>
						<div class="bbs_write">
							<table class="t1">
								<caption class="blind"><strong class="h1">비밀번호 찾기 폼</strong></caption>
								<col style="width:25%" /><col />
								<tbody>
								<tr>
									<th scope="row"><label for="txt_name">이름</label></th>
									<td><input type="text" id="txt_name" name="name" placeholder="실명" /></td>
								</tr>
								<tr>
									<th scope="row">아이디</th>
									<td><input type="text" id="txt_id" name="id" lang="en" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="txt_email">이메일</label></th>
									<td>
										<input type="text" id="txt_email" name="email" placeholder="email" title="이메일 계정" />
										<!--<input type="text" id="f1email3" placeholder="email" title="이메일 계정" />
										<span class="vam">@</span>
										<input type="text" id="f1email3inputEmailServer" placeholder="email.com" title="이메일 서버 직접 입력" />
										<select id="f1email3selectEmailServer" title="이메일 서버">
											<option value="Option 1">직접 입력</option>
											<option value="Option 2">naver.com</option>
											<option value="Option 3">daum.net</option>
											<option value="Option 3">gmail.com</option>
										</select>-->
									</td>
								</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
					<!-- //fieldset -->
					<!-- btns -->
					<div class="btns">
						<p class="tac">
							<button type="button" id="btn_search" value="" class="button submit">비밀번호 찾기</button>
							&nbsp;
							<a href="<c:url value="/login.do"/>" class="button">로그인</a>
						</p>
					</div>
					<!-- /btns -->
				</form:form>
				<!-- //비밀번호 찾기 폼 -->
			</div>
			<!-- /findpassword -->

	</layout:put>

	<layout:put block="javascript" type="REPLACE">

		<script type="text/javascript">

            <c:if test="${msgCd != null}">
            if ("${msgCd}" == "OK") {
                alert("메일이 발송되었습니다.");
            }
            if ("${msgCd}" == "NG") {
                alert("메일 전송에 실패했습니다.");
            }
            </c:if>

            $(document).ready(function() {

                $("#btn_search").click(function() {

                    if($("#txt_name").val().length == 0){
                        alert("이름을 입력하세요");
                        return false;
                    }
                    if($("#txt_id").val().length == 0){
                        alert("아이디를 입력하세요");
                        return false;
                    }
                    if($("#txt_email").val().length == 0){
                        alert("이메일을 입력하세요");
                        return false;
                    }

                    var view_url = "<c:url value="/user/sendUserEmail.do"/>";

                    $("#userVO")
                        .attr("action", view_url)
                        .submit();

                    return false;

                });

            });

		</script>

	</layout:put>

</layout:extends>
