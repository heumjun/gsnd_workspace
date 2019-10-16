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
			<c:param name="menuNo" value="11803000"></c:param>
			<c:param name="hideSidebar" value="Y"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
			<%--<c:param name="subTitle" value="등록"></c:param>--%>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">



			<!-- join_cnb -->
			<div class="join_cnb">
				<ul>
					<li><a href='<c:url value="/user/userCheck.do"/>'><i class="ic1 bsContain"></i>본인인증</a></li>
					<li class="on"><a href="#"><i class="ic2 bsContain"></i>약관동의</a></li>
					<li><a href="#"><i class="ic3 bsContain"></i>회원정보</a></li>
					<li><a href="#"><i class="ic4 bsContain"></i>가입완료</a></li>
				</ul>
			</div>
			<!-- / join_cnb -->

			<!-- 약관동의 폼 -->
			<form name="termsForm" action="?">
				<!-- fieldset -->
				<fieldset><legend class="blind">약관동의 폼</legend>

					<h2 class="hb1 h2">이용 약관</h2>
					<div class="join_agree_box1">
						<%@include file="/inc/agree/01.jsp" %>

					</div>
					<p class="join_agree_check"><input type="checkbox" name="termsCheck1" id="termsCheck1" value="Y" /><label for="termsCheck1" class="label"> 위 약관에 동의합니다.</label></p>

					<h2 class="hb1 h2">개인정보 수집, 이용 및 제공 동의서</h2>
					<div class="join_agree_box1">
						<table class="t1">
							<caption>
								<strong class="h1 blind">개인정보 수집, 이용 및 제공 동의서</strong>
								<span class="blind" title="요약(summary)">(필수정보와 선택정보 수집 및 이용 제공의 목적,항목,보유기간)</span>
							</caption>
							<col style="width:15%;" /><col style="width:20%;" /><col /><col style="width:20;" />
							<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">목적</th>
								<th scope="col">항목</th>
								<th scope="col">보유기간</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<th scope="row">필수정보</th>
								<td>회원제 서비스 이용 / 본인확인</td>
								<td class="com1agree1td1">이름, 아이디, 비밀번호, 생일, 성별, 이메일, 주소, 연락처, 휴대폰</td>
								<td>회원탈퇴 후 5일까지</td>
							<tr>
							</tbody>
						</table>
						<p>
							귀하께서는 진주목공예전수관에서 위와 같이 수집하는 개인정보에 대해, 동의하지 않거나 개인정보를 기재하지 않음으로써 거부할 수 있습니다.<br />
							다만, 이때 회원에게 제공되는 서비스가 제한될 수 있습니다.
						</p>
					</div>
					<p class="join_agree_check"><input type="checkbox" name="termsCheck2" id="termsCheck2" value="Y" /><label for="termsCheck2" class="label"> 위 약관에 동의합니다.</label></p>

				</fieldset>
				<!-- //fieldset -->
				<!-- infosection1 -->
				<div class="infosection1 mgt1em">
					<p class="tac">
						<button id="btn_confirm" type="submit" value="submit" class="button submit">확인하기</button>
						&nbsp;
						<a href="<c:url value="/login.do"/>" class="button">취소하기</a>
					</p>
				</div>
				<!-- /infosection1 -->
			</form>
			<!-- //약관동의 폼 -->



	</layout:put>

	<layout:put block="javascript" type="REPLACE">

		<c:if test="${errorMsg != null}">
			<script type="text/javascript">
                alert("${errorMsg}");
                window.location.href='<c:url value="/login.do"/>';
			</script>
		</c:if>

		<script type="text/javascript">

            $(document).ready(function() {

                $("#btn_confirm").click(function() {

                    //alert(view_url);
                    //alert($(":input:radio[name=txt_setleSe]:checked").val());

                    if ($(":input:checkbox[name=termsCheck1]:checked").val() != 'Y') {
                        alert('이용 약관에 동의해주세요.');
                        return false;
                    } else if ($(":input:checkbox[name=termsCheck2]:checked").val() != 'Y') {
                        alert('개인정보 수집, 이용 및 제공 동의서에 동의해주세요.');
                        return false;
                    } else {

                        var view_url = "<c:url value="/user/userRegist.do"/>";

                        $("form[name=termsForm]")
                            .attr("action", view_url)
                            .attr("method", "post")
                            .submit();

                        return false;

                    }

                });

            });

		</script>

	</layout:put>

</layout:extends>
