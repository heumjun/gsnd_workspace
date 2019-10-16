
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<aside>
<div class="aside-search">
   <b>관리자</b>님 반갑습니다.
</div>

<div class="vNav">
    <ul>
        <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
            <li id="menu_0" class="submenu"><a href="#" data-toggle-state="false"><span>관리자</span></a>
                <ul>
                    <li><a href="https://admin.iamport.kr/users/login" target="_blank"><span>결제 관리자 <i class="ic_new_win_01"></i></span></a></li>
                    <li><a href="https://mng.niceid.co.kr/login/loginPage" target="_blank"><span>NICE 관리자 <i class="ic_new_win_01"></i></span></span></a></li>
                </ul>
            </li>
        <li id="menu_1" class="submenu"><a href="#" data-toggle-state="false"><span>회원관리</span></a>
            <ul>
                <li><a href='<c:url value="/mng/user/userList.do"/>'><span>회원관리</span></a></li>
                <li><a href="javascript:fn_egov_inqire_Grant();"><span>권한그룹관리 <i class="ic_new_win_01"></i></span></span></a></li>
                <li><a href="javascript:fn_egov_inqire_loginLog();"><span>로그인접속로그 <i class="ic_new_win_01"></i></span></span></a></li>
                <li><a href="javascript:fn_egov_inqire_userLog();"><span>사용자로그 <i class="ic_new_win_01"></i></span></span></a></li>
                <li><a href="javascript:fn_egov_inqire_sysLog();"><span>시스템로그 <i class="ic_new_win_01"></i></span></span></a></li>
            </ul>
        </li>

        <li id="menu_2" class="submenu"><a href="#" data-toggle-state="false"><span>목공예관리</span></a>
            <ul>
                <li><a href='<c:url value="/mng/artist/artistList.do"/>'><span>목공예인관리</span></a></li>
                <li><a href='<c:url value="/mng/wcrf/wcrfList.do"/>'><span>목공예품관리</span></a></li>
                <li><a href='<c:url value="/mng/wcrf/wcrfReqList.do"/>'><span>목공예품(구매/결제)</span></a></li>
                <li><a href='<c:url value="/mng/wcrf/wcrfRefdList.do"/>'><span>목공예품(반품/취소)</span></a></li>
            </ul>
        </li>
        <li id="menu_3" class="submenu"><a href="#" data-toggle-state="false"><span>프로그램/체험</span></a>
            <ul>
                <li><a href='<c:url value="/mng/exprn/exprnList.do"/>'><span>일일체험관리</span></a></li>
                <li><a href='<c:url value="/mng/exprn/exprnLectureList.do"/>'><span>일일체험일정관리</span></a></li>
                <li><a href='<c:url value="/mng/exprn/exprnReqList.do"/>'><span>일일체험(구매/결제)</span></a></li>
                <li><a href='<c:url value="/mng/exprn/exprnRefdList.do"/>'><span>일일체험(반품/취소)</span></a></li>
                <li><a href='<c:url value="/mng/prgm/prgmList.do"/>'><span>프로그램관리</span></a></li>
                <li><a href='<c:url value="/mng/prgm/prgmList2.do"/>'><span>프로그램신청현황</span></a></li>
                <li><a href='<c:url value="/mng/prgm/prgmReqList.do"/>'><span>프로그램(구매/결제)</span></a></li>
                <li><a href='<c:url value="/mng/prgm/prgmRefdList.do"/>'><span>프로그램(반품/취소)</span></a></li>
            </ul>
        </li>
        <li id="menu_4" class="submenu"><a href="#" data-toggle-state="false"><span>게시판관리</span></a>
            <ul>
                <li><a href='<c:url value="/mng/community/list/000000000011.do"/>'><span>공지사항</span></a></li>
                <li><a href="<c:url value="/mng/community/list/000000000012.do"/>"><span>방문후기</span></a></li>
                <li><a href="<c:url value="/mng/community/list/000000000021.do"/>"><span>소통갤러리</span></a></li>
                <li><a href="<c:url value="/mng/community/list/000000000022.do"/>"><span>자유게시판</span></a></li>
            </ul>
        </li>
        <li id="menu_5" class="submenu"><a href="#" data-toggle-state="false"><span>팝업관리</span></a>
            <ul>
                <li><a href='<c:url value="/mng/popup/popupList.do"/>'><span>팝업관리</span></a></li>
            </ul>
        </li>-
        </sec:authorize>
    </ul>
</div>
</aside>

<script type="text/javascript">

    function fn_egov_inqire_loginLog(){
        var url = "<c:url value='/sym/log/clg/SelectLoginLogList.do' />";

        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=750,height=540,left=0,top=0";
        window.open(url,"p_loginGrant0", openParam);
    }

    function fn_egov_inqire_Grant(){
        var url = "<c:url value='/sec/rgm/EgovAuthorGroupList.do' />";
        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=750,height=540,left=0,top=0";
        window.open(url,"p_loginGrant1", openParam);
    }

    function fn_egov_inqire_userLog() {
        var url = "<c:url value='/sym/log/ulg/SelectUserLogList.do' />";
        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=750,height=540,left=0,top=0";
        window.open(url,"p_loginGrant2", openParam);
    }

    function fn_egov_inqire_sysLog(){
        var url = "<c:url value='/sym/log/lgm/SelectSysLogList.do' />";
        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=750,height=540,left=0,top=0";
        window.open(url,"p_loginGrant3", openParam);
    }

</script>