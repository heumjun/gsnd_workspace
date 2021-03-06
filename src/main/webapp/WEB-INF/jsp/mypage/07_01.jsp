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
            <c:param name="menuNo" value="11701000"></c:param>
            <c:param name="hideSocialMenu" value="Y"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">


            <!-- bbs_write -->
            <div class="bbs_write">
                <p><em class="required" title="필수항목">*</em> 는 필수 입력 항목입니다.</p>

                <!-- 작성 폼 -->
                <form:form commandName="userVO" id="userVO" method="post">
                    <form:hidden path="id" value="${userVO.id}" />
                    <form:hidden path="uniqId" value="${userVO.uniqId}" />

                    <!-- fieldset -->
                    <fieldset><legend class="blind">작성 폼</legend>
                        <table class="t1">
                            <caption>
                                <strong class="h1 blind">나의정보 작성 폼</strong>
                                <span class="blind" title="요약(summary)">(아이디, 암호, 암호 확인, 이름, 메일주소, 휴대전화, 주소, 기타사항)</span>
                            </caption>
                            <col style="width:12em;" /><col />
                            <tbody>
                            <tr>
                                <th scope="row"><label for="txt_id">아이디</label></th>
                                <td>${userVO.id}</td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_password">암호 <em class="required" title="필수항목">*</em></label></th>
                                <td><div class="explain form-text1 dpb">* 8자 이상. 영문자 숫자 특수문자 혼용</div>
                                    <input type="password" id="txt_password" name="password" placeholder="a-z0-9!~)" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_passwordCheck">암호 확인 <em class="required" title="필수항목">*</em></label></th>
                                <td><input type="password" id="txt_passwordCheck" name="passwordCheck" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_name">이름 <em class="required" title="필수항목">*</em></label></th>
                                <td><input type="text" id="txt_name" name="name" placeholder="실명" value="${userVO.name}" /></td>
                            </tr>
                            <!--
                            <tr>
                                <th scope="row"><span class="form-static1">성별</span></th>
                                <td>
						<span class="nowrap">
							<input type="radio" name="f1gender1" id="f1gender1e0" checked="checked" /><label for="f1gender1e0">남성</label>
							<span class="form-static1">&nbsp;&nbsp;</span>
							<input type="radio" name="f1gender1" id="f1gender1e1" /><label for="f1gender1e1">여성</label>
						</span>
                                </td>
                            </tr>
                            -->
                            <!--
                            <tr>
                                <th scope="row"><label for="f1birthdate1">생년월일</label></th>
                                <td><input type="tel" id="f1birthdate1" placeholder="19880522" value=""/></td>
                            </tr>
                            -->
                            <tr>
                                <th scope="row"><label for="txt_email">메일주소</label></th>
                                <td>
                                    <input type="text" id="txt_email" name="email" placeholder="email" title="이메일 계정" value="${userVO.email}" />
                                    <!--<span class="vam">@</span>
                                    <input type="text" id="f1email3inputEmailServer" placeholder="email.com" title="이메일 서버 직접 입력" />
                                    <select id="f1email3selectEmailServer" title="이메일 서버">
                                        <option value="Option 1">직접 입력</option>
                                        <option value="Option 2">naver.com</option>
                                        <option value="Option 3">daum.net</option>
                                        <option value="Option 3">gmail.com</option>
                                    </select>-->
                                </td>
                            </tr>
                            <!--<tr>
                                <th scope="row"><label for="f1phone1">전화번호</label></th>
                                <td><input type="tel" id="f1phone1" placeholder="055-0000-0000" value="${userVO.hp}" /></td>
                            </tr>-->
                            <tr>
                                <th scope="row"><label for="txt_hp">휴대전화</label></th>
                                <td><input type="tel" id="txt_hp" name="hp" placeholder="010-0000-0000" value="${userVO.hp}" /></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="txt_zip">주소</label></th>
                                <td>
                                    <input type="text" id="txt_zip" name="zip" size="5" maxlength="5" placeholder="00000" title="우편번호 앞자리" value="${userVO.zip}" />
                                    &nbsp;
                                    <a href="javascript:;" onclick="sample6_execDaumPostcode();return false;" target="_blank" title="새 창" class="button btnpopup">우편번호 검색</a>
                                    <br />
                                    <input type="text" id="txt_adres" name="adres" placeholder="기본 주소" title="기본 주소" class="w100" value="${userVO.adres}" />
                                    <input type="text" id="txt_adresDtl" name="adresDtl" placeholder="상세 주소" title="상세 주소" class="w100" value="${userVO.adresDtl}" />
                                </td>
                            </tr>
                            <!--
                            <tr>
                                <th scope="row"><label for="f1textarea">기타사항</label></th>
                                <td><div class="explain form-text1 dpb">* 개인정보보호를 위해 주민번호, 주소, 전화번호 등은 내용에 남기지 마십시오.</div>
                                    <textarea id="f1textarea" rows="5" cols="80" class="w100"></textarea></td>
                            </tr>
                            -->
                            </tbody>
                        </table>
                    </fieldset>
                    <!-- //fieldset -->

                    <!-- infosection1 -->
                    <div class="infosection1">
                        <p class="tac">
                            <button id="btn_save" type="button" class="button submit">저장하기</button>
                            &nbsp;
                            <a href="<c:url value="/index.do"/>" class="button">취소하기</a>
                        </p>
                    </div>
                    <!-- /infosection1 -->
                </form:form>
                <!-- //작성 폼 -->
            </div>
            <!-- /bbs_write -->

            <div class="myinfo1q1out">
                <div class="q1">
                    <ul class="bu">
                        <li>홈페이지 회원을 탈퇴하시려면?</li>
                    </ul>
                </div>
                <div class="btns">
                    <a href="<c:url value="/mypage/userOutRegist.do"/>" class="button">회원탈퇴하기</a>
                </div>
            </div>



    </layout:put>

    <layout:put block="javascript" type="REPLACE">

        <script type="text/javascript">

            <c:if test="${msgCd != null}">
            if ("${msgCd}" == "OK") {
                alert("저장되었습니다.");
            }
            </c:if>

            $(document).ready(function() {

                $("#btn_save").click(function() {

                    if($("#txt_name").val().length == 0){
                        alert("이름을 입력하세요");
                        return false;
                    }
                    if($("#txt_password").val().length == 0){
                        alert("패스워드를 입력하세요");
                        return false;
                    }
                    if($("#txt_passwordCheck").val().length == 0){
                        alert("패스워드 확인을 입력하세요");
                        return false;
                    }
                    if($("#txt_password").val() != $("#txt_passwordCheck").val()){
                        alert("패스워드가 일치하지않습니다.");
                        return false;
                    }

                    var view_url = "<c:url value="/mypage/userInfoSave.do"/>";

                    $("#userVO")
                        .attr("action", view_url)
                        .submit();

                    return false;

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
                        document.getElementById('txt_zip').value = data.zonecode; //5자리 새우편번호 사용
                        document.getElementById('txt_adres').value = fullAddr;

                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById('txt_adresDtl').focus();
                    }
                }).open();
            }

        </script>

    </layout:put>

</layout:extends>
