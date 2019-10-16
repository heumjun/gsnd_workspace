<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="author" content="진주목공예전수관" />
    <meta name="keywords" content="진주목공예전수관, 개인정보 수집 및 이용안내" />
    <meta name="description" content="진주목공예전수관, 개인정보 수집 및 이용안내" />
    <title>개인정보 수집 및 이용안내 | 진주목공예전수관</title>
    <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans" />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/font.css"/>' />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/lib.css"/>' />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/layout.css"/>' />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/content.css"/>' />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/template.css"/>' />
    <link rel="stylesheet" type="text/css" href='<c:url value="/assets/css/woodcraft/www/popup.css"/>' />
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/iscroll-min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/hammer.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/jquery-1.12.4.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/jquery.easing.1.3.js"/>'></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/html5shiv.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/selectivizr.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/respond.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/define/jquery.backgroundSize.js"/>'></script>
    <![endif]-->
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/lib_define.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/lib_scroll.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/assets/js/woodcraft/www/lib.js"/>'></script>
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
                <h1>개인정보 수집 및 이용안내</h1>

            </div>
            <!-- /.container -->
        </div>
        <!-- /#popup_head -->

        <!-- #popup_body -->
        <div id="popup_body">
            <!-- .container -->
            <div class="container_agree">
                <h4 class="hb2 h4">개인정보 수집 및 이용안내</h4>
                진주목공예전수관 홈페이지 게시판 서비스제공을 위해 필요한 최소한의 개인정보를 수집하며, 이에대한 동의를 얻고 있습니다.
                <table class="t5">
                    <caption class="blind"><strong class="h1">개인정보 수집 및 이용안내</strong></caption>
                    <col style="width:25%" />
                    <col />
                    <tbody>
                    <tr>
                        <th scope="row">개인정보 수집·이용 목적</th>
                        <td>의견 대응</td>
                    </tr>
                    <tr>
                        <th scope="row">수집하는 개인정보의 항목</th>
                        <td>
                            <b>회원</b>
                            <ul class="bu">
                                <li>필수정보 : 성명</li>
                            </ul>
                            <b>비회원</b>
                            <ul class="bu">
                                <li>필수정보 : 성명, 암호(글쓰기)</li>
                                <li>선택정보 : 전화번호</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">개인정보의 보유 및 이용 기간</th>
                        <td>게시 종료일까지</td>
                    </tr>
                    </tbody>
                </table>

                귀하는 개인정보 수집·이용에 동의하지 않으실 수 있습니다.<br />
                <br />
                <p class="tac"><a href="#" onclick="window.close();return false;" class="button">창닫기</a></p>

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