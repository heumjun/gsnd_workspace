<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>관리자 로그인</title>
    <!--STYLESHEETS-->
    <!--<link href="/assets/css/mng/login.css" rel="stylesheet" type="text/css" />-->
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/reset.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/font.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/admin.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/layout.css"/>' />
    <!--SCRIPTS-->
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/jquery.min.js"/>'></script>
    <!--Slider-in icons-->
    <script type="text/javascript">
        $(document).ready(function() {
            $(".username").focus(function() {
                $(".user-icon").css("left","-48px");
            });
            $(".username").blur(function() {
                $(".user-icon").css("left","0px");
            });

            $(".password").focus(function() {
                $(".pass-icon").css("left","-48px");
            });
            $(".password").blur(function() {
                $(".pass-icon").css("left","0px");
            });
        });
    </script>

</head>
<body class="admBg">
<section class="adm">
    <div class="admLgn">
        <h1 class="ir">관리자 로그인</h1>
        <form name="login-form" class="login-form"
              action="<c:url value='/processLogin' />"
              method="post">
        <ul>
            <li class="lgiIp"><input name="j_username" type="text" class="input username" value="Username" onfocus="this.value=''" /></li>
            <li class="lgiIp"><input name="j_password" type="password" class="input password" value="Password" onfocus="this.value=''" /></li>
            <li class="rmb"><input type="checkbox" />아이디 기억하기</li>
            <li class="lgiBtn"><button name="submit" value="Login">로그인</button></li>
        </ul>
        </form>
    </div>
</section>
</body>
<script type="text/javascript">
    $(function() {
        <c:if test="${not empty param.login_error}">
             alert("아이디/비밀번호 및 로그인 유형을 확인해 주십시오.");
        </c:if>
    });
</script>
</html>
