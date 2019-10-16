<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="11303000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예품상세
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- product1view1 -->
            <div class="product1view1">
                <!-- info1 -->
                <div class="info1">
                    <div class="f1">

                        <!-- 사진 갤러리 -->
                        <div class="pic1list1">
                            <div class="figure pt1">
                                <p class="p1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${WcrfForm.atchFileId}"/>" alt="${WcrfForm.wcrfDesc}" /></p>
                            </div>
                            <div class="mNum">
                                <c:if test="${fn:length(fileResult) > 0}">
                                    <ul>
                                        <c:forEach var="fileVO" items="${fileResult}" varStatus="status">
                                            <li class="m">
                                                <a href="<c:url value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>"><span class="mf1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"/>" alt="${WcrfForm.wcrfDesc}" /></span></a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </div>
                        </div>
                        <!-- /사진 갤러리 -->

                    </div>
                    <div class="texts">
								<strong class="t1">${WcrfForm.wcrfNm}</strong>
								<div class="t2">
									<ul class="bu">
									<li>
										<span class="tit">작가</span> <b>${WcrfForm.artistNm}</b>
										&nbsp;
										<a href="#" class="ic1_user" data-artist-nm="${WcrfForm.artistNm}">작가소개 보기</a>
									</li>
									<li><span class="tit">가격</span>
                                        <em class="price">
                                            <c:set var="price" value="${WcrfForm.wcrfAmt}" />
                                            <fmt:formatNumber value="${price}" type="number"  />원
                                        </em>
                                    </li>
									<li><span class="tit">배송</span> 배송비별도</li>
                                   <li>
                                       <span class="tit">수량</span>
                                       <select id="txt_wcrfCnt" title="수량">
                                       <c:forEach var="i" begin="1" end="${WcrfForm.wcrfCnt}" step="1">
                                           <c:if test="${i == 1}">
                                               <option value="${i}" selected="selected">${i}</option>
                                           </c:if>
                                           <c:if test="${i != 1}">
                                               <option value="${i}">${i}</option>
                                           </c:if>
                                       </c:forEach>
                                       </select>
                                   </li>
									</ul>
								</div>
							</div>
                    <!-- btns -->
                    <!--
                    <div class="btns">
                        <a href="#" class="button b1buy" data-wcrf-id="${WcrfForm.wcrfId}">바로구매</a>
                        &nbsp;
                        <a href="#" class="button b1cart" bskt-wcrf-id="${WcrfForm.wcrfId}">장바구니</a>
                    </div>-->
                    <!-- /btns -->
                </div>
                <!-- /info1 -->

                <!-- substance -->
                <div class="substance">
                        ${WcrfForm.wcrfDesc}<br /><br />
                    <!--<div><img src="/assets/images/woodcraft/www/_sample/product_img_01@2x.jpg" alt="★대체텍스트필수" /></div>-->
                </div>
                <!-- /substance -->

            </div>
            <!-- /product1view1 -->

            <!-- infosection1 -->

            <div class="infosection1">
                <p class="tac">
                    <a href="#" class="button" page-index="1">목록</a>
                </p>
            </div>
            <!-- /infosection1 -->



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                changePic1('click', '.pic1list1', '.m', 1, '.pt1');

                $("a[page-index]").click(function(event) {
                    event.preventDefault();
                    var pageIndex = $(this).attr("page-index");
                    var view_url = "<c:url value="/wcrf/wcrfList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","pageIndex").val(pageIndex))
                        .submit();

                    return false;
                });

                $("a[data-wcrf-id]").click(function(event) {
                    event.preventDefault();
                    var wcrfId = $(this).attr("data-wcrf-id");
                    var wcrfCnt = $("#txt_wcrfCnt option:selected").val();

                    var view_url = "<c:url value="/wcrf/wcrfPayList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","wcrfId").val(wcrfId))
                        .append($("<input />").attr("type","hidden").attr("name","wcrfCnt").val(wcrfCnt))
                        .submit();

                    return false;
                });

                $("a[bskt-wcrf-id]").click(function(event) {
                    event.preventDefault();
                    var wcrfId = $(this).attr("bskt-wcrf-id");
                    var wcrfCnt = $("#txt_wcrfCnt option:selected").val();

                    // jQuery로 HTTP 요청
                    $.ajax({
                        url: "<c:url value='/mypage/wcrfBsktAdd.do' />"+"?wcrfId="+wcrfId+"&wcrfCnt="+wcrfCnt,
                        type: "POST",
                        dataType: "json",
                        contentType : "application/json",
                        data : {}
                    }).done(function (data) {
                        switch(data.status) {
                            case "success":
                                // 추가 성공 시 로직
                                alert('장바구니에 추가되었습니다.');
                                break;
                            case "fail":
                                // 추가 실패 시 로직
                                alert('로그인후 추가가 가능합니다.');
                                window.location.href='<c:url value="/login.do"/>';
                                break;
                            case "duplicate":
                                // 추가 실패 시 로직
                                alert('이미 추가된 상품입니다.');
                                break;
                        }
                    })

                });

                $("a[data-artist-nm]").click(function(event) {
                    event.preventDefault();
                    var artistNm = $(this).attr("data-artist-nm");

                    var view_url = "<c:url value="/artist/artistList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","pageIndex").val('1'))
                        .append($("<input />").attr("type","hidden").attr("name","searchOption").val('01'))
                        .append($("<input />").attr("type","hidden").attr("name","searchKeyword").val(artistNm))
                        .submit();

                    return false;

                });
            });

        </script>

    </layout:put>

</layout:extends>
