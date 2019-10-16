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

                function fnDownload(atchFileId, fileSn, orignlFileNm){
                    //data/woodcraft/download/
                    //yyyy-mm-dd hh:mm:ss
                    var time = getTimeStamp();
                    //alert(time);
                    var path = '/cmm/pas/FileDown.do?atchFileId='+atchFileId+'&fileSn='+fileSn;
                    var fileName = orignlFileNm;

                    //alert(path);
                    //alert(fileName);

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

                fnDownload('<%= request.getParameter("atchFileId") %>', '<%= request.getParameter("fileSn") %>', '<%= request.getParameter("orignlFileNm") %>');

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