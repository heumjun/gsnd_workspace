<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="layout" uri="http://kwonnam.pe.kr/jsp/template-inheritance" %>

<layout:extends name="wwwSub">

    <layout:put block="sidebar" type="REPLACE">
        <c:import url="/inc/sidebar.do">
            <c:param name="menuNo" value="11301000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">

        <!-- 100% 용 --></div></div></div><!-- //100% 용 -->
        <!-- 100% 용 --><div><div><div><!-- //100% 용 -->


        <!-- m3s1 -->
        <div class="m3s1">

            <div class="p1 bsCover">

                <div class="txt1">
                    <div class="container">
                    <span class="t1">목공예란?</span>
                    <span class="t2">나무를 이용하여 물건을 만드는 기예(技藝) 및 제품을 총칭한다.</span>
                    </div>
                </div>

            </div>

            <!-- container -->
            <div class="container">
            <p style="padding-top:15px;">
                나무는 그 성질이 다양하고 느낌이 담백하여 예부터 많이 사용되는 재료이다.<br />
                목공예는 주로 생활주변의 가구나 의자 등으로 많이 사용 했는데 특히 우리 나라 목공예는 조선시대 미술에서 빠뜨릴 수 없는 공예품이다.<br />
                우리나라 전래의 전통을 계승한 진주의 목공예는 나무가 지닌 자연적 색상과 무늬 등을 접목하고 상감기법 등으로 제작한 조각 공예품과 전통문양을 현대인의 기호에 알맞게 제작한 생활 공예품이 있다.</p>

            <h2 class="hb1 h2">목공예의 특성</h2>

            <div class="scroll1wrap mgtm1"><div class="scroll1cont">
                <table class="t3">
                    <caption><span class="blind" title="표요약">목공예의 장점과 단점</span></caption>
                    <col span="2" style="width:50%" />
                    <thead>
                    <tr>
                        <th scope="col">장점</th>
                        <th scope="col">단점</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="tal">
                            <ul class="init">
                                <li>㉠ 공급이 풍부하고 자연재로서 성장하기 때문에 공급이 지속적이다.</li>
                                <li>㉡ 수공업과 기계 가공이 비교적 용이하다.</li>
                                <li>㉢ 나무의 종류에 따라 다양한 재질감을 준다.</li>
                            </ul>
                        </td>
                        <td class="tal">
                            <ul class="init">
                            <li>㉠ 수축과 팽창이 심하여 변형이 심하다.</li>
                            <li>㉡ 불에 잘 타는 성질이 있다.</li>
                            <li>㉢ 재질의 균질성이 부족하다.</li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div></div>


            <h2 class="hb1 h2">목공예의 종류</h2>
                <ul class="bu">
                <li>무른목재 : 오동나무, 느티나무, 벚나무 등</li>
                <li>단단한 목재 : 참나무, 단풍나무, 회양목 등</li>
                </ul>

            <h2 class="hb1 h2">관련행사</h2>
            <div class="scroll1wrap mgtm1"><div class="scroll1cont">
            <table class="t3">
            <caption><span class="blind" title="표요약">진주목공예관련 행사</span></caption>
                <col style="width:30%" />
                <col style="width:15%" />
                <col />
                <col style="width:20%" />
                <thead>
                <tr>
                    <th scope="col">행사명</th>
                    <th scope="col">개최일</th>
                    <th scope="col">주최</th>
                    <th scope="col">주관</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">진주 공예품대전</th>
                    <td>매년 5월 ~ 6월</td>
                    <td>진주시</td>
                    <td>진주공예인협회</td>
                </tr>
                <tr>
                    <th scope="row">경남 공예품대전</th>
                    <td>매년 6월 ~ 7월</td>
                    <td>경상남도</td>
                    <td>경상남도공예협동조합</td>
                </tr>
                <tr>
                    <th scope="row">대한민국 공예품대전</th>
                    <td>매년 11월 ~ 12월</td>
                    <td>문화재청국립무형유산원,한국공예협동조합연합회</td>
                    <td>한국공예협동조합연합회</td>
                </tr>
                </tbody>
            </table>
            </div></div>
            </div>
            <!-- //container -->

        </div>
        <!-- //m3s1 -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
