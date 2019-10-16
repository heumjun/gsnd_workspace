<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:59
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
            <c:param name="menuNo" value="11403000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">


        <div class="notice1">
            <i class="ic2 bsContain"></i>
            <ul>
                <li><em>일일체험 프로그램 운영 계획에 따른 체험비로 변동사항이 있을 수 있습니다.</em></li>
                <li><em>일일체험 프로그램은 매주 교체 운영됩니다.</em></li>
            </ul>
        </div>


        <h2 class="hb1 h2">운영개요</h2>
        <div class="bbs_write">
            <table class="t1">
                <caption><span class="blind" title="표요약">체험프로그램을 일시, 시간, 인원, 신청, 장소, 작품으로 정리한 표</span></caption>
                <col style="width:15%" />
                <col />
                <tr>
                    <th scope="row">운영시기</th>
                    <td>2018. 12월부터 주말 일일체험 운영</td>
                </tr>
                <tr>
                    <th scope="row">운영일시</th>
                    <td>
                        <ul class="bu">
                            <li>주말(토, 일) : 10:00~13:00(1회)</li>
                            <li>평일(화~금) : 10:00~17:00(사전예약자에 한해 체험 운영)</li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th scope="row">체험인원</th>
                    <td>1회 20명 </td>
                </tr>
                <tr>
                    <th scope="row">체험대상</th>
                    <td>청소년 이상 일반시민, 단체</td>
                </tr>
                <tr>
                    <th scope="row">접수방법</th>
                    <td><em>홈페이지(주말 체험) 및 전화예약(평일 체험)</em><br />
                        ※ 체험인원수에 맞게 사전에 재료준비가 필요하므로 당일 현장접수 불가</td>
                </tr>
            </table>
        </div>


        <h2 class="hb1 h2">체험 프로그램 및 체험비</h2>
        <ul class="exprnIntro_list">
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_01.jpg"/>' alt="손잡이 수납박스" /></span>
                <span class="t1">손잡이 수납박스</span>
                <span class="t2">8,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_02.jpg"/>' alt="차탁" /></span>
                <span class="t1">차탁</span>
                <span class="t2">15,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_03.jpg"/>' alt="두칸 수납박스" /></span>
                <span class="t1">두칸 수납박스</span>
                <span class="t2">10,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_04.jpg"/>' alt="우드 트레이" /></span>
                <span class="t1">우드 트레이</span>
                <span class="t2">7,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_05.jpg"/>' alt="플레이팅 도마" /></span>
                <span class="t1">플레이팅 도마</span>
                <span class="t2">7,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_06.jpg"/>' alt="잡지 책꽂이" /></span>
                <span class="t1">잡지 책꽂이</span>
                <span class="t2">12,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_07.jpg"/>' alt="티코스터" /></span>
                <span class="t1">티코스터 (2개)</span>
                <span class="t2">3,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_08.jpg"/>' alt="티코스터 세트" /></span>
                <span class="t1">티코스터 세트</span>
                <span class="t2">7,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_09.jpg"/>' alt="연필꽂이" /></span>
                <span class="t1">연필꽂이</span>
                <span class="t2">7,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_10.jpg"/>' alt="모니터 받침대" /></span>
                <span class="t1">모니터 받침대</span>
                <span class="t2">12,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_11.jpg"/>' alt="각티슈함" /></span>
                <span class="t1">각티슈함</span>
                <span class="t2">12,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_12.jpg"/>' alt="커피믹스함" /></span>
                <span class="t1">커피믹스함</span>
                <span class="t2">17,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_13.jpg"/>' alt="혼차탁구름" /></span>
                <span class="t1">혼차탁구름</span>
                <span class="t2">17,000원</span>
            </li>
            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201812/edu_img_14.jpg"/>' alt="와인랙3구" /></span>
                <span class="t1">와인랙3구</span>
                <span class="t2">17,000원</span>
            </li>

            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201901/01_tea.jpg"/>' alt="티코스터 세트" /></span>
                <span class="t1">티코스터 세트</span>
                <span class="t2">7,000원</span>
            </li>

            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201901/02_wood.jpg"/>' alt="우드트레이 세트" /></span>
                <span class="t1">우드트레이 세트</span>
                <span class="t2">10,000원</span>
            </li>

            <li>
                <span class="p1"><img src='<c:url value="/assets/images/woodcraft/www/content/04/exprnIntro_201901/03_table.jpg"/>' alt="혼차탁[창]" /></span>
                <span class="t1">혼차탁[창]</span>
                <span class="t2">15,000원</span>
            </li>
        </ul>

        <!--
        <div class="btns tac">
        <a href="/exprn/exprnList.do" class="button submit">예약하기</a>
        </div> -->

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>