<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- search1 -->
<div class="search1">
    <form id="f1s1" action="?">
        <fieldset><legend class="blind">게시물 검색</legend>
            <select id="f1s1select1" title="선택옵션1" class="select1">
                <option value="">제목</option>
            </select><input type="text" id="f1s1text1" value="" title="검색어" class="text1" />
            <button type="submit" value="submit" class="button submit search"><span class="t1">검색</span></button>
        </fieldset>
    </form>
</div>
<!-- /search1 -->

<!-- infosection1 -->
<div class="infosection1">
    <div class="left">
        <div class="info_list1">
            * 총 <b class="em"> 1</b>건의 게시물이 있습니다.  (<b class="em">1</b>/1 페이지)
        </div>
    </div>
</div>
<!-- /infosection1 -->


<!-- bbs_list -->
<div class="bbs_list">

    <table class="t1">
        <caption class="blind">
            <strong class="h1">공지사항 목록</strong>
        </caption>
        <thead>
        <tr>
            <th scope="col" class="bbs_num">번호</th>
            <th scope="col" class="bbs_title">제목</th>
            <th scope="col" class="bbs_author">작성자</th>
            <th scope="col" class="bbs_date">작성일</th>
            <th scope="col" class="bbs_attach">첨부</th>
            <th scope="col" class="bbs_view">조회수</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="bbs_num">1</td>
            <td class="bbs_title tal"><a href='<c:url value="/community/view/11501000.do"/>'>진주목공예전수관 홈페이지가 오픈하였습니다. <i class="ic1 new">새 글</i></a></td>
            <td class="bbs_author">관리자</td>
            <td class="bbs_date">2018.06.12</td>
            <td class="bbs_attach">-</td>
            <td class="bbs_view">12</td>
        </tr>
        </tbody>
    </table>
</div>
<!-- /bbs_list -->

<!-- infosection1 -->
<div class="infosection1">

    <!-- pagination -->
    <div class="pagination" title="페이지 수 매기기">
        <span class="m pages on"><a title="현재 1 페이지">1</a></span>
    </div>
    <!-- /pagination -->



</div>
<!-- /infosection1 -->