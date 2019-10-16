<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="generator" content="twogoms" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>[관리자]-${title}</title>

    <link rel="shortcut icon" type="image/x-icon" href='<c:url value="/assets/images/woodcraft/mng/favicon.ico"/>' />
    <!-- CSS -->
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/reset.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/font.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/admin.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/sub.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/tpl_common.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/tpl_table.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/tpl_form.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/tpl_button.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/tpl_pagination.css"/>' />

    <!-- kendoUI -->
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.common.min.css"/>' />
    <link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.default.min.css"/>'/>
    <!-- link rel="stylesheet" href='<c:url value="/assets/css/woodcraft/mng/kendo/kendo.customsilver.css"/>' / -->
    <!-- //CSS -->
    <!-- JS -->

    <!-- kendoUI -->
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/jquery.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/kendo.all.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/kendo/cultures/kendo.culture.ko-KR.min.js"/>'></script>

    <!-- parseley -->
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/parsley/i18n/messages.kr.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/parsley/parsley.min.js"/>'></script>

    <!-- common util -->
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/util/common_util.js"/>'></script>

    <link href='<c:url value="/assets/css/woodcraft/mng/jquery.alerts.css"/>' rel="stylesheet" />
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/jquery.alerts.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/mng/util/common_util.js"/>'/>

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <script src='<c:url value="/assets/js/respond.min.js"/>'></script>
    <![endif]--><!-- //For Old Browser : html5 Element Support -->
    <!-- Google Webfont js -->
    <script src="http://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js"></script>
    <script type="text/javascript">
        WebFont.load({
            custom: {
                families: ['NanumBarunGothic'],
                urls: ['<c:url value="/assets/css/woodcraft/mng/font.css"/>']
            }
        });
    </script>

    <%--<script src='<c:url value="/assets/js/woodcraft/mng/admin_nav.js"></script>--%>
    <!-- //JS -->
</head>
<body>
<div class="adm">