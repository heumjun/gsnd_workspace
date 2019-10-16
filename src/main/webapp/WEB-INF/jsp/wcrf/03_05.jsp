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
            <c:param name="menuNo" value="${menuNo}"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 목공예품주문하기
    </layout:put>

    <layout:put block="contents" type="REPLACE">



            <!-- cart_cnb -->
            <div class="cart_cnb">
                <c:if test="${menuNo == '11702000'}">
                    <ul class="col4">
                    <li><a href="#"><i class="ic1 bsContain"></i>장바구니</a></li>
                </c:if>
                <c:if test="${menuNo != '11702000'}">
                    <ul class="col3">
                </c:if>
                    <li class="on"><a href="#"><i class="ic2 bsContain"></i>주문하기</a></li>
                    <li><a href="#"><i class="ic3 bsContain"></i>결재하기</a></li>
                    <li><a href="#"><i class="ic4 bsContain"></i>주문완료</a></li>
                </ul>
            </div>
            <!-- / cart_cnb -->

            <!-- 주문/결재 작성 폼 -->
            <form:form commandName="WcrfBuyForm" id="WcrfBuyForm" method="post">
                <form:hidden path="wcrfId" value="${WcrfForm.wcrfId}" />
                <form:hidden path="purchsAmt" value="${WcrfForm.wcrfAmt}" />
                <form:hidden path="wcrfNm" value="${WcrfForm.wcrfNm}" />
                <form:hidden path="qy" value="${WcrfForm.wcrfCnt}" />
                <form:hidden path="setleSe"/>
                <form:hidden path="cashReceiptsOpt"/>
                <form:hidden path="menuNo" value="${menuNo}" />
                <form:hidden path="bsktIdList" value="${bsktIdList}" />

                <!-- fieldset -->
                <fieldset><legend class="blind">주문/결재 작성 폼</legend>
                    <h2 class="hb1 h2">주문리스트</h2>

                    <!-- cart_list -->
                    <div class="cart_list">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">장바구니 목록</strong>
                            </caption>
                            <thead>
                            <tr>
                                <th class="cart_title" scope="col">제품</th>
                                <th class="cart_num" scope="col">수량</th>
                                <th class="cart_price" scope="col">가격</th>
                                <!--<th class="cart_delivery" scope="col">배송비</th>-->
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="result" items="${resultList}" varStatus="status">
                                <tr>
                                    <td class="cart_title">
                                        <a href="#" class="a1"><span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.wcrfDesc}" /></span>
                                            <span class="text1">${result.wcrfNm}</span></a>
                                    </td>
                                    <td class="cart_num">${result.wcrfCnt}</td>
                                    <td class="cart_price">
                                        <c:set var="price" value="${result.wcrfAmt}" />
                                        <fmt:formatNumber value="${price}" type="number"  />
                                    </td>
                                    <!--<td class="cart_delivery">3,000</td>-->
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                    <!-- / cart_list -->

                    <h2 class="hb1 h2">주문자 정보</h2>
                    <span class="dpib">&nbsp;&nbsp;<em class="required" title="필수항목">*</em> 는 필수 입력 항목입니다.</span>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                                </caption>
                                <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label for="txt_byerNm">이름</label> <em class="required" title="필수항목">*</em></th>
                                <td><input type="text" id="txt_byerNm" name="byerNm" placeholder="실명" value="${WcrfBuyForm.byerNm}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_byerEmail">메일주소</label> <em class="required" title="필수항목">*</em></th>
                                <td><input type="text" id="txt_byerEmail" name="byerEmail" placeholder="email@email.com" class="w50" lang="en" value="${WcrfBuyForm.byerEmail}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_telNo">연락처</label> <em class="required" title="필수항목">*</em></th>
                                <td>
                                    <input type="text" id="txt_telNo" name="byerTelNo" size="3" maxlength="3" title="국번" value="${WcrfBuyForm.byerTelNo}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_telNo_mid" name="byerTelNoMid" size="4" maxlength="4" title="중간 번호" value="${WcrfBuyForm.byerTelNoMid}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_telNo_last" name="byerTelNoLast" size="4" maxlength="4" title="끝 번호" value="${WcrfBuyForm.byerTelNoLast}" />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">배송지 정보</h2>
                    <span class="dpib">&nbsp;&nbsp;<em class="required" title="필수항목">*</em> 는 필수 입력 항목입니다.</span>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label for="txt_orerNm">이름</label> <em class="required" title="필수항목">*</em></th>
                                <td><input type="text" id="txt_orerNm" name="orerNm" placeholder="실명" value="${WcrfBuyForm.orerNm}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_orerTelNo">전화번호</label> <em class="required" title="필수항목">*</em></th>
                                <td>
                                    <input type="text" id="txt_orerTelNo" name="orerTelNo" size="3" maxlength="3" title="국번" value="${WcrfBuyForm.orerTelNo}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_orerTelNoMid" name="orerTelNoMid" size="4" maxlength="4" title="중간 번호" value="${WcrfBuyForm.orerTelNoMid}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_orerTelNoLast" name="orerTelNoLast" size="4" maxlength="4" title="끝 번호" value="${WcrfBuyForm.orerTelNoLast}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_orerHp">연락처</label></th>
                                <td>
                                    <input type="text" id="txt_orerHp" name="orerHp" size="3" maxlength="3" title="국번" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_orerHpMid" name="orerHpMid" size="4" maxlength="4" title="중간 번호" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_orerHpLast" name="orerHpLast" size="4" maxlength="4" title="끝 번호" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_orerZip">주소</label> <em class="required" title="필수항목">*</em></th>
                                <td>
                                    <input type="text" id="txt_orerZip" name="orerZip" size="5" maxlength="5" placeholder="00000" title="우편번호 앞자리" value="${WcrfBuyForm.orerZip}" />
                                    <!--<span class="vam">-</span>
                                    <input type="text" id="txt_orerZip2" name="orerZip2" size="3" maxlength="3" placeholder="000" title="우편번호 뒷자리" />-->
                                    &nbsp;
                                    <a href="javascript:;" onclick="sample6_execDaumPostcode();return false;" target="_blank" title="새 창" class="button btnpopup">우편번호 검색</a>
                                    <br />
                                    <input type="text" id="txt_orerAddr" name="orerAddr" placeholder="기본 주소" title="기본 주소" class="w100" value="${WcrfBuyForm.orerAddr}" />
                                    <input type="text" id="txt_orerAddrDtl" name="orerAddrDtl" placeholder="상세 주소" title="상세 주소" class="w100" value="${WcrfBuyForm.orerAddrDtl}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_orderMessCn">주문메세지</label></th>
                                <td><div class="explain">* 개인정보보호를 위해 주민번호, 주소, 전화번호 등은 내용에 남기지 마십시오. (100자 내외)</div>
                                    <textarea id="txt_orderMessCn" name="orderMessCn" rows="5" cols="80" class="w100"></textarea></td>
                            </tr>
                            </tbody>
                        </table>

                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">결제 예정금액</h2>
                    <!-- order_list -->
                    <div class="order_list">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">결제 예정금액</strong>
                            </caption>
                            <col style="width:30%" />
                            <col style="width:5%" />
                            <!--<<col style="width:30%" />
                            <col style="width:5%" />-->
                            <col style="width:30%" />
                            <thead>
                            <tr>
                                <th scope="col">상품금액</th>
                                <th scope="col"></th>
                                <!--<th scope="col">배송비</th>
                                <th scope="col"></th>-->
                                <th scope="col">결제 예정금액</th>
                            </tr>
                            <thead>
                            <tbody>
                            <tr>
                                <td>
                                    <c:set var="price2" value="${sum}" />
                                    <fmt:formatNumber value="${price2}" type="number"  />원
                                </td>
                                <td><i class="ic1 bsContain"></i></td>
                                <!--<td>3,000원</td>
                                <td><i class="ic2 bsContain"></i></td>-->
                                <td class="order_total_price">
                                    <c:set var="price3" value="${sum}" />
                                    <fmt:formatNumber value="${price3}" type="number"  />원
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- / order_list -->

                    <h2 class="hb1 h2">결제 정보</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row">결제방법</th>
                                <td>
                                    <input type="radio" name="txt_setleSe" id="setleSe0" checked="checked" value="02"/><label for="setleSe0"> 무통장입금</label>
                                    &nbsp;&nbsp;
                                    <select id="setleSeAccount" title="입금 계좌번호 선택">
                                        <option value="">입금 계좌번호 선택(반드시 주문자 성함으로 입금)</option>
                                        <option value="01">301-0232-4310-31(농협) 진주시청</option>
                                    </select>
                                    <br />
                                    <input type="radio" name="txt_setleSe" name="setleSe1" value="01"/><label for="setleSe1"> 신용카드 <em>(카드결제는 정식운영부터 가능합니다. 무통장 입금을 이용해주십시요.)</em></label><br />
                                    <!--<input type="radio" name="txt_setleSe" name="setleSe2" value="02"/><label for="setleSe2"> 가상계좌</label><br />-->
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">현금영수증</th>
                                <td>
                                    <input type="radio" name="txt_cashReceiptsOpt" id="cashReceiptsOpte0" checked="checked" value="01"/><label for="cashReceiptsOpte0"> 신청</label>
                                    <input type="radio" name="txt_cashReceiptsOpt" id="cashReceiptsOpte1" value="02"/><label for="cashReceiptsOpte1"> 미신청</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_rcpmnyNm">무통장 입금자명</label></th>
                                <td><input type="text" id="txt_rcpmnyNm" name="rcpmnyNm" placeholder="실명" value="${WcrfBuyForm.rcpmnyNm}" />
                                    <span class="explain ">* 주문자와 같을 경우 생략 가능</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <!-- 배송/환불 -->
                    <%@include file="/inc/refund/01.jsp" %>
                    <!-- // 배송/환불 -->


                    <h2 class="hb1 h2">약관동의</h2>
                    <table class="t5">
                        <caption class="blind"><strong class="h1">동의여부</strong></caption>
                        <tbody>
                        <!--<tr>
                            <th class="tal" scope="row"><span class="com1agree1q1">진주목공예전수관 운영 및 관리 조례 시행규칙안</span></th>
                            <td class="tac com1agree1w1"><a href='<c:url value="/inc/agree/02.jsp"/>' class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                            <td class="tac com1agree1w1"><input type="checkbox" id="tosCheck1" name="tosCheck1" value="Y" /> <label for="tosCheck1"> 동의함</label></td>
                        </tr>
                        <tr>
                            <th class="tal" scope="row"><span class="com1agree1q1">진주목공예전수관 운영 및 관리 조례안</span></th>
                            <td class="tac"><a href='<c:url value="/inc/agree/03.jsp"/>' class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                            <td class="tac"><input type="checkbox" id="tosCheck2" name="tosCheck2" value="Y" /> <label for="tosCheck2"> 동의함</label></td>
                        </tr>-->
                        <tr>
                            <th class="tal" scope="row"><span class="com1agree1q1">예약약관</span></th>
                            <td class="tac com1agree1w1"><a href='<c:url value="/inc/agree/04.jsp"/>' class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                            <td class="tac"><input type="checkbox" id="tosCheck3" name="tosCheck3" value="Y" /> <label for="tosCheck3"> 동의함</label></td>
                        </tr>
                        <tr>
                            <th class="tal" scope="row"><span class="com1agree1q1">개인정보 수집 및 이용</span></th>
                            <td class="tac com1agree1w1"><a href='<c:url value="/inc/agree/05.jsp"/>' class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                            <td class="tac"><input type="checkbox" id="tosCheck4" name="tosCheck4" value="Y" /> <label for="tosCheck4"> 동의함</label></td>
                        </tr>
                        <tr>
                            <th class="tal" scope="row"><span class="com1agree1q1">구매 및 결제 개인정보취급방침</span></th>
                            <td class="tac com1agree1w1"><a href='<c:url value="/inc/agree/06.jsp"/>' class="ic_new_win" target="_blank" title="새 창">내용보기</a></td>
                            <td class="tac"><input type="checkbox" id="tosCheck5" name="tosCheck5" value="Y" /> <label for="tosCheck5"> 동의함</label></td>
                        </tr>
                        </tbody>
                    </table>

                    <h2 class="hb1 h2">주문자동의</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">주문자동의</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row">주문동의</th>
                                <td> <input type="checkbox" name="orderCheck" id="orderCheck" value="Y" /><label for="orderCheck"> 상기 결제정보를 확인하였으며, 구매진행에 동의합니다.</label> </td>
                            </tr>
                            <tr>
                                <th scope="row">최종 결제금액</th>
                                <td> <span class="order_total_price">
                                    <c:set var="price4" value="${sum}" />
                                    <fmt:formatNumber value="${price4}" type="number"  />원
                                </span></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->
                </fieldset>
                <!-- //fieldset -->
                <!-- infosection1 -->
                <div class="infosection1">
                    <p class="tac">
                        <button id="btn_save" class="button submit">주문하기</button>
                        <a href="<c:url value="/wcrf/wcrfPay.do?wcrfId=${WcrfForm.wcrfId}"/>" class="button">주문취소</a>
                    </p>
                </div>
                <!-- /infosection1 -->

            </form:form>
            <!-- //주문/결재 작성 폼 -->

            <%@include file="/inc/layerpopup/20180703_01.jsp" %>

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            $(document).ready(function() {

                $("#btn_save").click(function() {

                    //alert(view_url);
                    //alert($(":input:radio[name=txt_setleSe]:checked").val());
                    $("#setleSe").val($(":input:radio[name=txt_setleSe]:checked").val());

                    //alert($(":input:radio[name=txt_cashReceiptsOpt]:checked").val());
                    $("#cashReceiptsOpt").val($(":input:radio[name=txt_cashReceiptsOpt]:checked").val());

                    //if ($(":input:checkbox[name=tosCheck1]:checked").val() != 'Y') {
                    //    alert('진주목공예전수관 운영 및 관리 조례 시행규칙안에 동의해주세요.');
                    //    return false;
                    //} else if ($(":input:checkbox[name=tosCheck2]:checked").val() != 'Y') {
                    //    alert('진주목공예전수관 운영 및 관리 조례안에 동의해주세요.');
                    //    return false;
                    //} else
                    if ($(":input:checkbox[name=tosCheck3]:checked").val() != 'Y') {
                        alert('예약약관에 동의해주세요.');
                        return false;
                    } else if ($(":input:checkbox[name=tosCheck4]:checked").val() != 'Y') {
                        alert('개인정보 수집 및 이용에 동의해주세요.');
                        return false;
                    } else if ($(":input:checkbox[name=tosCheck5]:checked").val() != 'Y') {
                        alert('구매 및 결제 개인정보취급방침에 동의해주세요.');
                        return false;
                    } else if ($(":input:checkbox[name=orderCheck]:checked").val() != 'Y') {
                        alert('구매진행에 동의해주세요.');
                        return false;
                    } else {

                        if($("#txt_byerNm").val().length == 0){
                            alert("주문자정보 이름을 입력하세요");
                            return false;
                        }
                        if($("#txt_byerEmail").val().length == 0){
                            alert("주문자정보 메일주소를 입력하세요");
                            return false;
                        }
                        if($("#txt_telNo").val().length == 0){
                            alert("주문자정보 연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_telNo_mid").val().length == 0){
                            alert("주문자정보 연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_telNo_last").val().length == 0){
                            alert("주문자정보 연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerNm").val().length == 0){
                            alert("배송지정보 이름을 입력하세요");
                            return false;
                        }
                        if($("#txt_orerTelNo").val().length == 0){
                            alert("배송지정보 전화번호를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerTelNoMid").val().length == 0){
                            alert("배송지정보 전화번호를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerTelNoLast").val().length == 0){
                            alert("배송지정보 전화번호를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerZip").val().length == 0){
                            alert("배송지정보 우편번호를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerAddr").val().length == 0){
                            alert("배송지정보 주소를 입력하세요");
                            return false;
                        }
                        if($("#txt_orerAddrDtl").val().length == 0){
                            alert("배송지정보 상세정보를  입력하세요");
                            return false;
                        }

                        var view_url = "<c:url value="/wcrf/wcrfListSave.do"/>";

                        $("#WcrfBuyForm")
                            .attr("action", view_url)
                            .submit();

                        return false;
                    }

                });

            });

            function sample6_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var fullAddr = ''; // 최종 주소 변수
                        var extraAddr = ''; // 조합형 주소 변수

                        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            fullAddr = data.roadAddress;

                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            fullAddr = data.jibunAddress;
                        }

                        // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                        if(data.userSelectedType === 'R'){
                            //법정동명이 있을 경우 추가한다.
                            if(data.bname !== ''){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있을 경우 추가한다.
                            if(data.buildingName !== ''){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('txt_orerZip').value = data.zonecode; //5자리 새우편번호 사용
                        document.getElementById('txt_orerAddr').value = fullAddr;

                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById('txt_orerAddrDtl').focus();
                    }
                }).open();
            }

        </script>

    </layout:put>

</layout:extends>
