<%--
/**
 * @Class Name  : EgovBannerRegist.jsp
 * @Description : EgovBannerRegist.jsp
 * @Modification Information
 * @
 * @  수정일         수정자          수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.02.01    lee.m.j          최초 생성
 *
 *  @author lee.m.j
 *  @since 2009.03.11
 *  @version 1.0
 *  @see
 *  
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
 --%>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/assets/css/egovframework/com/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/assets/css/egovframework/com/button.css' />" rel="stylesheet" type="text/css">
<title>배너 등록</title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<script type="text/javascript" src="<c:url value='/assets/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="banner" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectBannerList() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/selectBannerList.do'/>";
    varFrom.submit();       
}

function fncBannerInsert() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/addBanner.do'/>";

    if(confirm("저장 하시겠습니까?")){
        if(!validateBanner(varFrom)){           
            return;
        }else{
            if(varFrom.bannerImage.value != '') {
                varFrom.submit();
            } else {
                alert("배너이미지는 필수 입력값입니다.");
                return;
            }
        } 
    }
}

function fncOnChangeImage() {
	var varFrom = document.getElementById("banner");
	varFrom.bannerImage.value = varFrom.file_1.value;
}

function fncBannerDelete() {
    var varFrom = document.getElementById("banner");
    varFrom.action = "<c:url value='/uss/ion/bnr/removeBanner.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
}

</script>
</head>

<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
<div id="border" style="width:730px">
<table border="0">
  <tr>
    <td width="700">
<form:form commandName="banner" method="post" action="${pageContext.request.contextPath}/uss/ion/bnr/addBanner.do' />" enctype="multipart/form-data"> 
<input type="hidden" name="posblAtchFileNumber" value="1" >
<input type="hidden" name="bannerImage" >
<table width="100%" cellpadding="8" class="table-search" border="0" summary="">
 <tr>
  <td width="90%" class="title_left">
   <h1><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="middle" alt="제목아이콘이미지">&nbsp;배너 등록</h1>
  </td>
 </tr>
</table>

<table width="100%" cellpadding="8" class="table-line" summary="배너정보를 입력하는 항목">
  <caption>배너 등록</caption>
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="bannerId">배너ID</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap><input name="bannerId" id="bannerId" title="배너ID" type="text" value="<c:out value='${banner.bannerId}'/>" size="30" class="readOnlyClass" readonly ></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="bannerNm">배너명</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap><input name="bannerNm" id="bannerNm" title="배너명" type="text" value="<c:out value='${banner.bannerNm}'/>" maxLength="10" size="30" >&nbsp;<form:errors path="bannerNm" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="linkUrl">링크URL</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap><input name="linkUrl" id="linkUrl" title="링크URL" type="text" value="<c:out value='${banner.linkUrl}'/>" maxLength="255" size="50" >&nbsp;<form:errors path="linkUrl" /></td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="egovComFileUploader">배너이미지</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap>
        <input type="file" name="file_1" id="egovComFileUploader" title="배너이미지" onchange="javascript:fncOnChangeImage();">
    </td>
  </tr>
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="bannerDc">배너설명</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/no_required.gif' />" width="15" height="15" alt="선택입력표시"></th>
    <td class="lt_text" nowrap><input name="bannerDc" id="bannerDc" title="배너설명" type="text" value="<c:out value='${banner.bannerDc}'/>" maxLength="100" size="80"  ></td>
  </tr>  
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="sortOrdr">정렬순서</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap><input name="sortOrdr" id="sortOrdr" type="text" title="정렬순서" value="<c:out value='${banner.sortOrdr}'/>" maxLength="5" size="10" >&nbsp;<form:errors path="sortOrdr" /></td>
  </tr>   
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="reflctAt">반영여부</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시"></th>
    <td class="lt_text" nowrap>
      <select name="reflctAt" id="reflctAt" title="반영여부">
          <option value="Y" <c:if test="${banner.reflctAt == 'Y'}">selected</c:if> >Y</option>
          <option value="N" <c:if test="${banner.reflctAt == 'N'}">selected</c:if> >N</option>
      </select>
   </td> 
  </tr>  
  <tr>
    <th class="required_text" width="20%" scope="row"><label for="regDate">등록일시</label><img src="<c:url value='/assets/images/egovframework/com/cmm/icon/no_required.gif' />" width="15" height="15" alt="선택입력표시"></th>
    <td class="lt_text" nowrap><input name="regDate" id="regDate" title="등록일시" type="text" value="<c:out value="${banner.regDate}"/>" maxLength="20" size="20" class="readOnlyClass" readonly ></td>
  </tr>
</table>
<table width="100%" cellpadding="8" summary="">
  <tr>
    <td align="center">
	   <table border="0" cellspacing="0" cellpadding="0">
	    <tr> 
	      <td><span class="button"><input type="submit" value="<spring:message code="button.save" />" onclick="fncBannerInsert(); return false;"></span></td>
	      <td>&nbsp;&nbsp;</td>
	      <td><span class="button"><a href="<c:url value='/uss/ion/bnr/selectBannerList.do'/>?pageIndex=<c:out value='${bannerVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${bannerVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncSelectBannerList(); return false;"><spring:message code="button.list" /></a></span></td>
	    </tr>
	   </table>
   </td>
  </tr>  
</table>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${bannerVO.searchCondition}'/>" >
<input type="hidden" name="searchKeyword" value="<c:out value='${bannerVO.searchKeyword}'/>" >
<input type="hidden" name="pageIndex" value="<c:out value='${bannerVO.pageIndex}'/>" >
<!-- 검색조건 유지 -->
</form:form>
</td>
</tr>
</table>            
</DIV>
</body>
</html>

