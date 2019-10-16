<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="author" content="진주목공예전수관" />
    <meta name="keywords" content="진주목공예전수관, 진주목공예전수관 운영 및 관리 조례 시행규칙안" />
    <meta name="description" content="진주목공예전수관, 진주목공예전수관 운영 및 관리 조례 시행규칙안" />
    <title>진주목공예전수관 운영 및 관리 조례 시행규칙안 | 진주목공예전수관</title>
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

    <script type="text/javascript" src='http://www.jinju.go.kr/program/includejs/convertV3.js'></script>
</head>
<body>

            <script type="text/javascript" charset="utf-8">

                function fnDownload(cmd){
                    //data/woodcraft/download/
                    //yyyy-mm-dd hh:mm:ss
                    var time = getTimeStamp();
                    //alert(time);
                    var path = '';
                    var fileName = '';

                    if (cmd == '01') {
                        path = '/cmm/pas/FileDown.do?atchFileId=FILE_000000000000091&fileSn=0';
                        fileName = '[별지 제1호] 서식 시설 (장비) 사용허가(변경, 취소) 신청서.hwp';
                    } else if (cmd == '02') {
                        path = '/cmm/pas/FileDown.do?atchFileId=FILE_000000000000091&fileSn=1';
                        fileName = '[별지 제2호서식] 프로그램 및 체험(변경, 취소) 신청서.hwp';
                    } else if (cmd == '03') {
                        path = '/cmm/pas/FileDown.do?atchFileId=FILE_000000000000091&fileSn=2';
                        fileName = '[별지 제3호서식] 작품 전시 신청서.hwp';
                    } else if (cmd == '04') {
                        path = '/cmm/pas/FileDown.do?atchFileId=FILE_000000000000091&fileSn=3';
                        fileName = '[별지 제4호서식] 진주목공예전수관 시설물(장비) 사용 신청 및 허가대장 .hwp';
                    } else if (cmd == '05') {
                        path = '/cmm/pas/FileDown.do?atchFileId=FILE_000000000000091&fileSn=4';
                        fileName = '[별지 제5호서식] 진주목공예전수관 프로그램 및 체험 신청대장.hwp';
                    }

                    loading_convert("www.jinju.go.kr/mokgong",path+"&TT=" + time, fileName, "");
                }

                function getTimeStamp() {

                    var d = new Date();
                    var date = leadingZeros(d.getFullYear(), 4) + '-' +
                        leadingZeros(d.getMonth() + 1, 2) + '-' +
                        leadingZeros(d.getDate(), 2) + ' ';
                    var time = leadingZeros(d.getHours(), 2) + ':' +
                        leadingZeros(d.getMinutes(), 2) + ':' +
                        leadingZeros(d.getSeconds(), 2);

                    return date + ' ' + time;

                }

                function leadingZeros(n, digits) {
                    var zero = '';
                    n = n.toString();

                    if (n.length < digits) {
                        for (i = 0; i < digits - n.length; i++)
                            zero += '0';
                    }
                    return zero + n;
                }

                fnDownload('<%= request.getParameter("cmd") %>');

            </script>

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