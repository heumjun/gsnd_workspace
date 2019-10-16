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
            <c:param name="menuNo" value="11404000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/> &gt; 일일체험 예약
    </layout:put>

    <layout:put block="contents" type="REPLACE">


            <!-- 주문/결재 작성 폼 -->
            <form:form commandName="ReqForm" id="ReqForm" method="post">
                <form:hidden path="exprnId" value="${ExprnForm.exprnId}" />
                <form:hidden path="exprnDay" value="${ReqForm.exprnDay}" />
                <form:hidden path="exprnTime" value="${ReqForm.exprnTime}" />
                <form:hidden path="setleSe" />
                <form:hidden path="cashReceiptsOpt" />
                <form:hidden path="exprnNmpr" />
                <form:hidden path="exprnAmt" />
                <form:hidden path="exprnNm" value="${ExprnForm.exprnNm}" />

                <fmt:parseDate var="dateString" value="${ReqForm.exprnDay}" pattern="yyyyMMdd"/>
                <!-- fieldset -->
                <fieldset><legend class="blind">결재 작성 폼</legend>
                    <h2 class="hb1 h2">일일체험 정보</h2>
                    <!-- bbs_write -->
                    <div class="bbs_write">
                        <table class="t1">
                            <caption class="blind">
                                <strong class="h1">일일체험 정보 작성 폼</strong>
                            </caption>
                            <col class="order_td_w1" /><col />
                            <tbody>
                            <tr>
                                <th scope="row">일일체험명</th>
                                <td><em>${ExprnForm.exprnNm}</em></td>
                            </tr>
                            <tr>
                                <th scope="row">체험일</th>
                                <td><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                            <tr>
                                <th scope="row">체험시간</th>
                                <td>${ReqForm.exprnTime}</td>
                            </tr>
                            <tr>
                                <th scope="row">체험료</th>
                                <td>
                                    <c:set var="price" value="${ExprnForm.exprnBaseAmt + ExprnForm.exprnMtrAmt}" />
                                    <fmt:formatNumber value="${price}" type="number"  />원
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <h2 class="hb1 h2">예약자 정보</h2>
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
                                <th scope="row"><label for="txt_reqNm">예약자</label> <em class="required" title="필수항목">*</em></th>
                                <td><input type="text" id="txt_reqNm" name="reqNm" placeholder="실명" value="${ReqForm.reqNm}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_groupNm">단체명</label></th>
                                <td><input type="text" id="txt_groupNm" name="groupNm" value="${ReqForm.groupNm}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_telNo">연락처</label> <em class="required" title="필수항목">*</em></th>
                                <td>
                                    <input type="text" id="txt_telNo" name="telNo" size="3" maxlength="3" title="국번" value="${ReqForm.telNo}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_telNoMid" name="telNoMid" size="4" maxlength="4" title="중간 번호" value="${ReqForm.telNoMid}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_telNoLast" name="telNoLast" size="4" maxlength="4" title="끝 번호" value="${ReqForm.telNoLast}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_groupTelNo">단체연락처</label></th>
                                <td>
                                    <input type="text" id="txt_groupTelNo" name="groupTelNo" size="3" maxlength="3" title="국번" value="${ReqForm.groupTelNo}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_groupTelNoMid" name="groupTelNoMid" size="4" maxlength="4" title="중간 번호" value="${ReqForm.groupTelNoMid}" />
                                    <span class="vam">-</span>
                                    <input type="text" id="txt_groupTelNoLast" name="groupTelNoLast" size="4" maxlength="4" title="끝 번호" value="${ReqForm.groupTelNoLast}" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_reqEmail">메일주소</label> <em class="required" title="필수항목">*</em></th>
                                <td><input type="text" id="txt_reqEmail" name="reqEmail" placeholder="email@email.com" class="w50" lang="en" value="${ReqForm.reqEmail}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_exprnNmpr">인원</label> <em class="required" title="필수항목">*</em></th>
                                <td>
                                    <select id="txt_exprnNmpr" title="인원">
                                        <c:forEach var="i" begin="1" end="${ExprnForm.exprnNmpr - ExprnForm.reqCnt}" step="1">
                                            <c:if test="${i == 1}">
                                                <option value="${i}" selected="selected">${i}</option>
                                            </c:if>
                                            <c:if test="${i != 1}">
                                                <option value="${i}">${i}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
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
                            <col style="width:30%" />
                            <col style="width:5%" />
                            <col style="width:30%" />
                            <thead>
                            <tr>
                                <th scope="col">체험료기본금액</th>
                                <th scope="col"></th>
                                <th scope="col">재료비</th>
                                <th scope="col"></th>
                                <th scope="col">결제 예정금액</th>
                            </tr>
                            <thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span id="exprnPrice1">
                                    <c:set var="price2" value="${ExprnForm.exprnBaseAmt}" />
                                    <fmt:formatNumber value="${price2}" type="number"  />
                                    </span>원
                                </td>
                                <td><i class="ic1 bsContain"></i></td>
                                <td>
                                    <span id="exprnPrice2">
                                    <c:set var="price3" value="${ExprnForm.exprnMtrAmt}" />
                                    <fmt:formatNumber value="${price3}" type="number"  /></span>원</td>
                                <td><i class="ic2 bsContain"></i></td>
                                <td class="order_total_price">
                                    <span id="exprnPrice3">
                                    <c:set var="price4" value="${ExprnForm.exprnBaseAmt + ExprnForm.exprnMtrAmt}" />
                                    <fmt:formatNumber value="${price4}" type="number"  /></span>원
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

                                    <input type="radio" name="txt_setleSe" id="setleSe0" value="02"/><label for="setleSe0"> 무통장입금</label>
                                    &nbsp;&nbsp;
                                    <select id="setleSeAccount" title="입금 계좌번호 선택">
                                        <option value="">입금 계좌번호 선택(반드시 주문자 성함으로 입금)</option>
                                        <option value="01">301-0232-4310-31(농협) 진주시청</option>
                                    </select>
                                          <br />
                                         <input type="radio" name="txt_setleSe" name="setleSe1" value="01"/><label for="setleSe1"> 신용카드 <em>(카드결제는 정식운영부터 가능합니다. 무통장 입금을 이용해주십시요.)</em></label>
                                         <br />
                                        <%--  <input type="radio" name="txt_setleSe" name="setleSe2" checked="checked" value="03"/><label for="setleSe2"> 현장결제</label><br /> --%>
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
                                <td><input type="text" id="txt_rcpmnyNm" name="rcpmnyNm" placeholder="실명" value="${ReqForm.rcpmnyNm}" />
                                    <span class="explain ">* 예약자와 같을 경우 생략 가능</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /bbs_write -->

                    <!-- 배송/환불 -->
                    <%@include file="/inc/refund/02.jsp" %>
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
                        </tbody>
                    </table>

                    <h2 class="hb1 h2">신청자동의</h2>
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
                                     <span id="exprnPrice4">
                                    <c:set var="price5" value="${ExprnForm.exprnBaseAmt + ExprnForm.exprnMtrAmt}" />
                                         <fmt:formatNumber value="${price5}" type="number"  /></span>원
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
                        <button id="btn_save" class="button submit">예약하기</button>
                        <a href="<c:url value="/exprn/exprnList.do?pageIndex=1"/>" class="button">취소</a>
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

                $("#txt_exprnNmpr").change(function() {
                    //결제금액 변경
                    var cnt = $("#txt_exprnNmpr option:selected").val();
                    //alert(cnt);

                    $("#exprnPrice1").html(cnt*${ExprnForm.exprnBaseAmt});
                    $("#exprnPrice2").html(cnt*${ExprnForm.exprnMtrAmt});

                    $("#exprnPrice3").html(cnt*${ExprnForm.exprnBaseAmt+ExprnForm.exprnMtrAmt});
                    $("#exprnPrice4").html(cnt*${ExprnForm.exprnBaseAmt+ExprnForm.exprnMtrAmt});

                });

                $("#btn_save").click(function() {

                    //alert(view_url);
                    //alert($(":input:radio[name=txt_setleSe]:checked").val());
                    $("#setleSe").val($(":input:radio[name=txt_setleSe]:checked").val());

                    //alert($(":input:radio[name=txt_cashReceiptsOpt]:checked").val());
                    $("#cashReceiptsOpt").val($(":input:radio[name=txt_cashReceiptsOpt]:checked").val());

                    var cnt = $("#txt_exprnNmpr option:selected").val();
                    $("#exprnNmpr").val(cnt);
                    $("#exprnAmt").val(cnt*${ExprnForm.exprnBaseAmt+ExprnForm.exprnMtrAmt});

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
                    } else if ($(":input:checkbox[name=orderCheck]:checked").val() != 'Y') {
                        alert('구매진행에 동의해주세요.');
                        return false;
                    } else {

                        if($("#txt_reqNm").val().length == 0){
                            alert("예약자 이름을 입력하세요");
                            return false;
                        }
                        if($("#txt_telNo").val().length == 0){
                            alert("연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_telNoMid").val().length == 0){
                            alert("연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_telNoLast").val().length == 0){
                            alert("연락처를 입력하세요");
                            return false;
                        }
                        if($("#txt_reqEmail").val().length == 0){
                            alert("메일주소를 입력하세요");
                            return false;
                        }

                        var view_url = "<c:url value="/exprn/exprnListSave.do"/>";

                        $("#ReqForm")
                            .attr("action", view_url)
                            .submit();

                        return false;
                    }

                });

            });

        </script>

    </layout:put>

</layout:extends>
