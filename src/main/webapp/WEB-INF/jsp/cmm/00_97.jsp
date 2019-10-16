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

<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="author" content="진주목공예전수관" />
	<meta name="keywords" content="진주목공예전수관, 아이디확인" />
	<meta name="description" content="진주목공예전수관, 아이디확인" />
	<title>아이디확인 | 진주목공예전수관</title>
	<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/font.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/lib.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/layout.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/content.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/template.css"/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/popup.css"/>" />
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/iscroll-min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/hammer.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery-1.12.4.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery.easing.1.3.js"/>"></script>
	<!--[if lt IE 9]>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/html5shiv.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/selectivizr.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/respond.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery.backgroundSize.js"/>"></script>
	<![endif]-->
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib_define.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib_scroll.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/lib.js"/>"></script>

	<script type="text/javascript">

        $(document).ready(function() {

            $("#btn_serarch").click(function() {

                if($("#txt_id").val().length == 0){
                    alert("아이디를 입력하세요");
                    return false;
                }

                var view_url = "<c:url value="/user/searchUserId.do"/>";

                $("#userVO")
                    .attr("action", view_url)
                    .submit();

                return false;

            });

            $("#btn_save").click(function() {

                opener.document.getElementById("txt_id").value = '${userVO.id}';
                opener.document.getElementById("id_flag").value = 'Y';
                window.self.close();
            });

        });

	</script>

</head>
<body>

<!-- #container -->
<div id="container">
	<noscript><p>JavaScript has been disabled. This site requires JavaScript for full functionality, please enable.</p></noscript>

	<!-- #popup -->
	<div id="popup" class="init">
		<!-- #popup_head -->
		<div id="popup_head" class="clearfix">
			<a href="#?" onclick="window.close();return false;" class="close"><i class="ic1 bsContain"></i> <span class="blind">창 닫기</span></a>
			<!-- .container -->
			<div class="container">
				<h1>아이디 확인</h1>

			</div>
			<!-- /.container -->
		</div>
		<!-- /#popup_head -->

		<!-- #popup_body -->
		<div id="popup_body">
			<!-- .container -->
			<div class="container">

				<form:form id="userVO" method="post">
					<!-- fieldset -->
					<fieldset><legend class="blind">아이디 검색</legend>
						<!-- bbs_write -->
						<div class="bbs_write">
							<table class="t1">
								<caption class="blind">
									<strong class="h1">아이디 검색</strong>
								</caption>
								<col style="width:25%" />
								<col />
								<tbody>
								<tr>
									<th scope="row"><label for="txt_id">아이디</label></th>
									<td>
										<input type="text" id="txt_id" name="id" size="20" maxlength="20" title="아이디" value="${userVO.id}" />
									</td>
								</tr>
								<tr>
									<c:if test="${code == 'OK'}">
										<th scope="row" colspan="2">사용가능합 아이디 입니다.</th>
									</c:if>
									<c:if test="${code == 'NG'}">
										<th scope="row" colspan="2">이미 사용중인 아이디 입니다.</th>
									</c:if>
								</tr>
								</tbody>
							</table>

						</div>
						<!-- /bbs_write -->

					</fieldset>
					<!-- //fieldset -->
					<!-- infosection1 -->
					<div class="infosection1">
						<p class="tac">
							<button id="btn_serarch" class="button submit">검색</button>
							<c:if test="${code == 'OK'}">
								<button id="btn_save" class="button submit">사용</button>
							</c:if>
							<a href="#?" onclick="window.close();return false;" class="button">취소</a>
						</p>
					</div>
					<!-- /infosection1 -->
				</form:form>

			</div>
			<!-- /.container -->
		</div>
		<!-- /#popup_body -->
	</div>
	<!-- /#popup -->


</div>
<!--/#container-->

</body>
</html>