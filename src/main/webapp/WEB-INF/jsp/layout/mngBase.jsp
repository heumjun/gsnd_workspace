<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>

    <!DOCTYPE html>
    <html lang="ko">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title><layout:block name="title"></layout:block></title>

    <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/assets/images/woodcraft/mng/favicon.ico"/>" />
    <!-- CSS -->
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/reset.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/font.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/admin.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/sub.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/tpl_common.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/tpl_table.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/tpl_form.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/tpl_button.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/tpl_pagination.css"/>" />

    <!-- kendoUI -->
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/kendo/kendo.common.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/assets/css/woodcraft/mng/kendo/kendo.bootstrap.min.css" />" />
    <!-- //CSS -->
    <!-- JS -->

    <!-- kendoUI -->
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/kendo/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/kendo/kendo.all.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/kendo/cultures/kendo.culture.ko-KR.min.js"/>"></script>

    <!-- parseley -->
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/parsley/i18n/messages.kr.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/parsley/parsley.min.js"/>"></script>

    <!-- common util -->
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/util/common_util.js"/>"></script>

    <link href="<c:url value="/assets/css/woodcraft/mng/jquery.alerts.css"/>" rel="stylesheet" />
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/jquery.alerts.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/assets/js/woodcraft/mng/util/common_util.js"/>"/>

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <script src="<c:url value="/assets/js/woodcraft/mng/respond.min.js"/>"></script>
    <![endif]--><!-- //For Old Browser : html5 Element Support -->
    <!-- Google Webfont js -->
    <script src="http://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js"></script>
    <script type="text/javascript">
        WebFont.load({
                custom: {
                families: ['NanumBarunGothic'],
                urls: ['<c:url value="/assets/css/woodcraft/mng/font.css"/>"']
             }
        });
    </script>

    <script src="<c:url value="/assets/js/woodcraft/mng/admin_nav.js"/>"></script>
    <!-- //JS -->

    </head>
    <body>
    <div class="adm">

    <header>
    <h1>진주목공예전수관 관리자</h1>
    <a href="<c:url value="/" />">홈&nbsp;&nbsp;</a>
    <!-- a href="<c:url value="j_spring_security_logout" />">로그아웃</a -->
    </header>

    <c:import url="/mng/include/sidebar.do"/>
    <!-- Main -->
    <layout:block name="contents"></layout:block>

    <%--<footer class="text-center">--%>
       <%--<p>&copy; Copyright twogoms All Rights Reserved. 2018</p>--%>
    <%--</footer>--%>
    <%--</div>--%>

    <layout:block name="javascript"></layout:block>
    <%--</body>--%>
    <%--</html>--%>