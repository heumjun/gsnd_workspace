<%--
Created by IntelliJ IDEA.
User: DELL
Date: 2018-05-15
Time: 오전 9:10
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<meta name="author" content="진주목공예전수관"/>
	<meta name="keywords" content="진주목공예전수관"/>
	<meta name="description" content="진주목공예전수관"/>
	<title>
		빈페이지
	</title>

	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery-1.12.4.min.js"/>"></script>

	<script language='javascript'>

        //window.opener.location.href='<c:url value="/index.do"/>';
        var childWindow = window.parent;
        var parentWindow = childWindow.opener;
        parentWindow.location.href = '<c:url value="/index.do"/>'

        alert("실명인증이 완료되었습니다.");

        //if ( $.browser.msie ) {
        //    window.opener='Self';
        //    window.open('','_parent','');
        //    window.close();
        //} else {

            //window.close(); // 일반적인 현재 창 닫기
            //window.open('about:blank','_self').self.close();  // IE에서 묻지 않고 창 닫기
        //}
        var nvua = navigator.userAgent;
        if (nvua.indexOf('MSIE') >= 0){
            if(nvua.indexOf('MSIE 5.0') == -1) {
                top.opener = '';
            }
        } else if (nvua.indexOf('Gecko') >= 0){
            top.name = 'CLOSE_WINDOW';
            wid = window.open('','CLOSE_WINDOW');
        }
        top.close();

	</script>

</head>
<body>
<div id="container">

	<noscript>
		<p>JavaScript has been disabled. This site requires JavaScript for full functionality, please enable.</p>
	</noscript>

</div>

</body>
</html>

