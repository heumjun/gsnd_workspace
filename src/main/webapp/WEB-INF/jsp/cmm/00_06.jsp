<%@ page import="org.springframework.context.ConfigurableApplicationContext" %>
<%@ page import="org.springframework.context.support.GenericXmlApplicationContext" %>
<%@ page import="org.springframework.core.env.ConfigurableEnvironment" %>
<%@ page import="org.springframework.core.env.MutablePropertySources" %>
<%@ page import="org.springframework.core.io.support.ResourcePropertySource" %><%--
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


<%

	// 컨텍스트를 먼저 구한다.
	ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();
// 지금까지 사용해왔던 AbstractApplicationContext, GenericApplicationContext,
// GenericXmlApplicationContext 모두 ConfigurableApplicationContext 인터페이스를
// 구현하는 (추상)클래스이다.

// 컨텍스트에서 environment 객체를 추출한다.
	ConfigurableEnvironment env = ctx.getEnvironment();

// environment 객체에서 프로퍼티 소스들을 모두 추출하여 담는다.
	MutablePropertySources PropertySources = env.getPropertySources();

	// 새로운 프로퍼티 소스를 추가할 수 있다.
	String propertyLoc = "classpath:/egovframework/egovProps/globals.properties";
	PropertySources.addLast(new ResourcePropertySource(propertyLoc));

	String domain = env.getProperty("domin.url");

	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	String sSiteCode = env.getProperty("nice.sSiteCode");			// NICE로부터 부여받은 사이트 코드
	String sSitePassword = env.getProperty("nice.sSitePassword");		// NICE로부터 부여받은 사이트 패스워드

	String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

	String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

	// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
	//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
	//String sReturnUrl = "http://localhost:8080/EgovPageLink.do?link=/cmm/checkplus_success";      // 성공시 이동될 URL
	//서버작업시 수정필요.
	String sReturnUrl = "http://"+domain+"/checkPlusSuccess3.do";      // 성공시 이동될 URL
	String sErrorUrl = "http://"+domain+"/EgovPageLink.do?link=/cmm/checkplus_fail";          // 실패시 이동될 URL

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
	if( iReturn == 0 )
	{
		sEncData = niceCheck.getCipherData();
	}
	else if( iReturn == -1)
	{
		sMessage = "암호화 시스템 에러입니다.";
	}
	else if( iReturn == -2)
	{
		sMessage = "암호화 처리오류입니다.";
	}
	else if( iReturn == -3)
	{
		sMessage = "암호화 데이터 오류입니다.";
	}
	else if( iReturn == -9)
	{
		sMessage = "입력 데이터 오류입니다.";
	}
	else
	{
		sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}

	request.setAttribute("sEncData", sEncData);
	request.setAttribute("sMessage", sMessage);
%>


<layout:extends name="wwwSub">

	<layout:put block="sidebar" type="REPLACE">
		<c:import url="/inc/sidebar.do">
			<c:param name="menuNo" value="11806000"></c:param>
			<c:param name="hideSidebar" value="Y"></c:param>
			<c:param name="hideSocialMenu" value="Y"></c:param>
			<%--<c:param name="subTitle" value="등록"></c:param>--%>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">



			<!-- cnb1 -->
			<div id="cnb1">
				<ul class="col2">
					<li class="on"><a href="#">아이디 찾기</a></li>
					<li><a href="<c:url value="/user/findPw.do"/>">비밀번호 찾기</a></li>
				</ul>
			</div>
			<!-- /cnb1 -->

			<!-- findid -->
			<div class="findid">
				<i class="ic1 bsContain"></i>
				<div class="wrap1">
					<p class="txt1">아이디 찾기</p>
					<p class="txt2">휴대폰인증으로 아이디를 찾으실 수 있습니다.</p>
					<p class="em">* 실명인증 고객센터 : <a href="tel:1600-1522"><em class="em">1600-1522</em></a></p>

					<!-- 아이디 찾기 폼 -->
					<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
					<form name="form_chk" method="post">
						<input type="hidden" name="m" value="checkplusSerivce"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
						<input type="hidden" name="EncodeData" value="${sEncData}"><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

						<!-- btns -->
						<div class="btns">
							<a href="javascript:;" onclick="fnPopup();" title="새 창" class="button submit">휴대폰 인증하기</a>
							&nbsp;
							<a href="<c:url value="/login.do"/>" class="button">로그인</a>
						</div>
						<!-- /btns -->
					</form>
					<!-- //아이디 찾기 폼 -->
				</div>
			</div>
			<!-- /findid -->



	</layout:put>

	<layout:put block="javascript" type="REPLACE">

		<script language='javascript'>
            window.name ="Parent_window";

            function fnPopup(){
                var win =  window.open("<c:url value="/inc/vname3.jsp"/>", "popupChk", "top=100, left=100, width=430, height=670, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
            }
		</script>

	</layout:put>

</layout:extends>
