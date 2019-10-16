<%@ page import="org.springframework.context.ConfigurableApplicationContext" %>
<%@ page import="org.springframework.core.env.ConfigurableEnvironment" %>
<%@ page import="org.springframework.core.env.MutablePropertySources" %>
<%@ page import="org.springframework.context.support.GenericXmlApplicationContext" %>
<%@ page import="org.springframework.core.io.support.ResourcePropertySource" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-07-03
  Time: 오후 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	// 컨텍스트를 먼저 구한다.
	ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

	// 컨텍스트에서 environment 객체를 추출한다.
	ConfigurableEnvironment env = ctx.getEnvironment();

	// environment 객체에서 프로퍼티 소스들을 모두 추출하여 담는다.
	MutablePropertySources PropertySources = env.getPropertySources();

	// 새로운 프로퍼티 소스를 추가할 수 있다.
	String propertyLoc = "classpath:/egovframework/egovProps/globals.properties";
	PropertySources.addLast(new ResourcePropertySource(propertyLoc));

	String domain = env.getProperty("domin.url");

	NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

	String sSiteCode = env.getProperty("nice.sSiteCode");            // NICE로부터 부여받은 사이트 코드
	String sSitePassword = env.getProperty("nice.sSitePassword");        // NICE로부터 부여받은 사이트 패스워드

	String sRequestNumber = "REQ0000000001";            // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	session.setAttribute("REQ_SEQ", sRequestNumber);    // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	String sAuthType = "";        // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

	String popgubun = "N";        //Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize = "";        //없으면 기본 웹페이지 / Mobile : 모바일페이지

	String sGender = "";            //없으면 기본 선택 값, 0 : 여자, 1 : 남자

	// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
	//String sReturnUrl = "http://localhost:8080/EgovPageLink.do?link=/cmm/checkplus_success";      // 성공시 이동될 URL
	//서버작업시 수정필요.
	String sReturnUrl = "http://" + domain + "/checkPlusSuccess.do";      // 성공시 이동될 URL
	String sErrorUrl = "http://" + domain + "/EgovPageLink.do?link=/cmm/checkplus_fail";          // 실패시 이동될 URL

	// 입력될 plain 데이타를 만든다.
	String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
		"8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
		"9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
		"7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
		"7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
		"11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
		"9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
		"6:GENDER" + sGender.getBytes().length + ":" + sGender;

	String sMessage = "";
	String sEncData = "";

	int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	if (iReturn == 0) {
		sEncData = niceCheck.getCipherData();
	} else if (iReturn == -1) {
		sMessage = "암호화 시스템 에러입니다.";
	} else if (iReturn == -2) {
		sMessage = "암호화 처리오류입니다.";
	} else if (iReturn == -3) {
		sMessage = "암호화 데이터 오류입니다.";
	} else if (iReturn == -9) {
		sMessage = "입력 데이터 오류입니다.";
	} else {
		sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}

	request.setAttribute("sEncData", sEncData);
	request.setAttribute("sMessage", sMessage);
%>
<html>
<head>
	<title>실명인증</title>
	<script type="text/javascript" src="<c:url value="/assets/js/woodcraft/www/define/jquery-1.12.4.min.js"/>"></script>
</head>
<body>
	<form id='form_chk' action="https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb?m=checkplusSerivce&EncodeData=${sEncData}" method="post"></form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
	    $("#form_chk").submit();
	})
</script>
</html>
