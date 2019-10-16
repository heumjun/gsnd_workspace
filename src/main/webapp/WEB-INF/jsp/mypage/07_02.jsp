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
            <c:param name="menuNo" value="11702000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">


            <!-- cart_cnb -->
            <div class="cart_cnb">
                <ul>
                    <li class="on"><a href="#"><i class="ic1 bsContain"></i>장바구니</a></li>
                    <li><a href="#"><i class="ic2 bsContain"></i>주문하기</a></li>
                    <li><a href="#"><i class="ic3 bsContain"></i>결재하기</a></li>
                    <li><a href="#"><i class="ic4 bsContain"></i>주문완료</a></li>
                </ul>
            </div>
            <!-- / cart_cnb -->

            <!-- cart_list -->
            <div class="cart_list">

                <!-- 작성 폼 -->
                <form action="?">
                    <!-- fieldset -->
                    <fieldset><legend class="blind">작성 폼</legend>
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">장바구니 목록</strong>
                            </caption>
                            <thead>
                            <tr>
                                <th class="cart_chk" scope="col"><input type="checkbox" id="allCheck" title="전체선택" /></th>
                                <th class="cart_title" scope="col">제품</th>
                                <th class="cart_num" scope="col">수량</th>
                                <th class="cart_price" scope="col">가격</th>
                                <!--<th class="cart_delivery" scope="col">배송비</th>-->
                                <th class="cart_btn" scope="col">취소</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:if test = "${resultCnt == 0}">
                                <tr>
                                    <td colspan="5"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</td>
                                </tr>
                            </c:if>

                            <c:forEach var="result" items="${resultList}" varStatus="status">

                                <tr>
                                    <td class="cart_chk"><input type="checkbox" class="tablein" value="${result.bsktId}" title="선택" /></td>
                                    <td class="cart_title">
                                        <a href="#" class="a1"><span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.wcrfDesc}" /></span>
                                            <span class="text1">${result.wcrfNm}</span></a>
                                    </td>
                                    <td class="cart_num"><input type="text" id="qy_${result.bsktId}" size="3" maxlength="3" title="수량" value="${result.qy}" />
                                        <a href="javascript:;" class="button tablein" update-bskt-id="${result.bsktId}" data-wcrf-cnt="${result.wcrfCnt}">변경</a>
                                    </td>
                                    <td class="cart_price">
                                        <c:set var="price" value="${result.wcrfAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />원
                                    </td>
                                    <!--<td class="cart_delivery">3,000</td>-->
                                    <td class="cart_btn"><a href="javascript:;" class="button tablein" delete-bskt-id="${result.bsktId}">삭제</a></td>
                                </tr>

                            </c:forEach>

                            </tbody>
                        </table>
                        <!-- infosection1 -->
                        <div class="infosection1">
                            <p class="left">
                                선택한 상품
                                <a href="#" id="btn_del" class="button">삭제하기</a>
                            </p>
                        </div>
                        <!-- /infosection1 -->

                        <div class="total_price">
                            <i class="ic1 bsContain"></i>
                            <p class="right">
                                <i class="ic2 bsContain"></i>
                                총 구매금액 :
                                <em><c:set var="price2" value="${sum}" />
                                    <fmt:formatNumber value="${price2}" type="number"  />원</em>
                            </p>
                        </div>
                    </fieldset>
                    <!-- //fieldset -->

                    <!-- infosection1 -->
                    <div class="infosection1 btn_group">
                        <p class="center">
                            <button id="btn_order" type="submit" value="submit" class="button submit">선택상품 주문하기</button>
                            <a href="#" id="btn_orderAll" class="button order">전체상품 주문하기</a>
                            <a href="#" class="button" page-index="1">쇼핑계속하기</a>
                        </p>
                    </div>
                    <!-- /infosection1 -->
                </form>
                <!-- //작성 폼 -->

            </div>
            <!-- /cart_list -->



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("a[delete-bskt-id]").click(function(event) {
                    event.preventDefault();
                    var bsktId = $(this).attr("delete-bskt-id");

                    var view_url = "<c:url value="/mypage/wcrfBsktDelete.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","bsktId").val(bsktId))
                        .submit();

                    return false;
                });

                $("a[update-bskt-id]").click(function(event) {
                    event.preventDefault();
                    var bsktId = $(this).attr("update-bskt-id");
                    var wcrfCnt = $(this).attr("data-wcrf-cnt");

                    var qy = $("#qy_"+bsktId).val();

                    if (qy > wcrfCnt) {
                        $("#qy_"+bsktId).val(wcrfCnt);
                        alert(wcrfCnt + "개 이상은 구입이 불가능한 상품입니다.");
                        return false;
                    }

                    var view_url = "<c:url value="/mypage/wcrfBsktUpdate.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","bsktId").val(bsktId))
                        .append($("<input />").attr("type","hidden").attr("name","qy").val(qy))
                        .submit();

                    return false;
                });

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

                $("#btn_del").click(function() {
                    var send_array = Array();
                    var send_cnt = 0;
                    var chkbox = $(".tablein");

                    for(i=0;i<chkbox.length;i++) {
                        if (chkbox[i].checked == true){
                            send_array[send_cnt] = chkbox[i].value;
                            send_cnt++;
                        }
                    }

                    if (send_cnt == 0) {
                        alert('선택된 상품이 없습니다.');
                        return false
                    }

                   //alert(send_array);

                    event.preventDefault();

                    var view_url = "<c:url value="/mypage/wcrfBsktDelete.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","bsktIdList").val(send_array))
                        .submit();

                    return false;
                });

                //전체선택 체크박스 클릭
                $("#allCheck").click(function(){ //만약 전체 선택 체크박스가 체크된상태일경우
                if($("#allCheck").prop("checked")) { //해당화면에 전체 checkbox들을 체크해준다
                     $("input[type=checkbox]").prop("checked",true); // 전체선택 체크박스가 해제된 경우
                    } else { //해당화면에 모든 checkbox들의 체크를해제시킨다.
                    $("input[type=checkbox]").prop("checked",false); } })

                $("#btn_order").click(function(event) {

                    var send_array = Array();
                    var send_cnt = 0;
                    var chkbox = $(".tablein");

                    for(i=0;i<chkbox.length;i++) {
                        if (chkbox[i].checked == true){
                            send_array[send_cnt] = chkbox[i].value;
                            send_cnt++;
                        }
                    }

                    if (send_cnt == 0) {
                        alert('선택된 상품이 없습니다.');
                        return false
                    }

                    event.preventDefault();
                    var view_url = "<c:url value="/wcrf/wcrfPayList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","bsktIdList").val(send_array))
                        .submit();

                    return false;
                });

                $("#btn_orderAll").click(function(event) {

                    var send_array = Array();
                    var send_cnt = 0;
                    var chkbox = $(".tablein");

                    for(i=0;i<chkbox.length;i++) {
                        send_array[send_cnt] = chkbox[i].value;
                        send_cnt++;
                    }

                    if (send_cnt == 0) {
                        alert('장바구니가 비어있습니다.');
                        return false
                    }

                    event.preventDefault();
                    var view_url = "<c:url value="/wcrf/wcrfPayList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","bsktIdList").val(send_array))
                        .submit();

                    return false;
                });

            });

        </script>

    </layout:put>

</layout:extends>
