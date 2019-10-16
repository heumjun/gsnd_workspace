<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:28
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
            <c:param name="menuNo" value="11105000"></c:param>
        </c:import>
    </layout:put>

    <layout:put block="title" type="REPLACE">
        <c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
    </layout:put>

    <layout:put block="contents" type="REPLACE">


        <!-- 100% 용 --></div></div></div><!-- //100% 용 -->
        <!-- 100% 용 --><div><div><div><!-- //100% 용 -->

        <!-- m1s5 -->
        <div class="m1s5">
            <div class="map1">
                <!-- .skicnav -->
                <div class="skicnav">
                    <a href="#m1i1">하단에 제공된 다음 지도는 일부 웹접근성을 준수하지 못한 콘텐츠가 존재합니다. 지도에 대한 대체 정보는 지도하단에 제공되고 있으므로 지도를 건너뛰시려면 본 링크를 선택해주세요.</a>
                </div>
                <!-- //.skicnav -->
                <!-- * Daum 지도 - 지도퍼가기 -->
                <!-- 1. 지도 노드 -->
                <div id="daumRoughmapContainer1527820069722" class="root_daum_roughmap root_daum_roughmap_landing"></div>

                <!--
                    2. 설치 스크립트
                    * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
                -->
                <script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script>

                <!-- 3. 실행 스크립트 -->
                <script type="text/javascript">/*<![CDATA[*/
                new daum.roughmap.Lander({
                    "timestamp" : "1527820069722",
                    "key" : "oeph",
                    "mapWidth" : "1300",
                    "mapHeight" : "379"
                }).render();
                /*]]>*/</script>
            </div>

            <div class="info1" id="m1i1">
                <div class="container">
                    <div class="txt1">
                        <i class="bsContain"></i>
                        <h2>주소</h2>
                        <p>경남 진주시 명석면 광제산로 367 (우)52641 [지번] 명석면 관지리 767</p>
                    </div>
                    <div class="txt2">
                        <i class="bsContain"></i>
                        <h2>연락처</h2>
                        <p>055-746-3633~4</p>
                    </div>
                    <a href="http://place.map.daum.net/1733562139" target="_blank" class="btn1"><i class="bsContain"></i>길찾기</a>
                </div>
            </div>

        </div>
        <!-- // m1s5 -->



        <div class="container">
            <!-- m1s5_traffic -->
            <div class="m1s5_traffic">

                <h2 class="hb1 h2 s-bus-tit">시내버스</h2>
                &nbsp;&nbsp;
                <a href="http://bis.jinju.go.kr" target="_blank" title="새창" class="button ic_new_win s-bus-btn">진주시내버스정보 사이트 바로가기</a>

                <div class="scroll1wrap mgtm1"><div class="scroll1cont">
                    <table class="t3">
                        <caption><span class="blind" title="표요약">시내버스의 버스정류장, 거리, 일반, 첫차, 막차, 배차간격으로 정리한 표</span></caption>
                        <col span="4" style="width:10%" />
                        <col />
                        <col span="4" style="width:10%" />
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">종류</th>
                            <th scope="col">출발</th>
                            <th scope="col">도착</th>
                            <th scope="col">버스정류장</th>
                            <th scope="col">거리</th>

                            <th scope="col">첫차</th>
                            <th scope="col">막차</th>
                            <th scope="col">배차간격</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row"><span class="busbg1">142</span></th>
                            <td>일반</td>
                            <td>신기마을</td>
                            <td>공영차고지</td>
                            <td>관지마을 (14081)</td>
                            <td>99m</td>
                            <td>06:45</td>
                            <td>21:40</td>
                            <td>64분</td>
                        </tr>
                        <tr>
                            <th scope="row"><span class="busbg1">142</span></th>
                            <td>일반</td>
                            <td>공영차고지</td>
                            <td>신기마을</td>
                            <td>관지마을 (14111)</td>
                            <td>106m</td>
                            <td>06:45</td>
                            <td>21:40</td>
                            <td>64분</td>
                        </tr>
                        </tbody>
                    </table>
                </div></div>

                <h2 class="hb1 h2">시외버스</h2>
                <div class="scroll1wrap mgtm1"><div class="scroll1cont">
                    <table class="t3">
                        <caption><span class="blind" title="표요약">진주로 오는 시외버스의 출발지역, 출발지, 도착지, 소요시간, 요금으로 정리한 표</span></caption>
                        <col style="width:10%" />
                        <col span="3" style="width:30%" />
                        <thead>
                        <tr>
                            <th scope="col">출발지역</th>
                            <th scope="col">출발지</th>
                            <th scope="col">도착지</th>
                            <th scope="col">소요시간</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row">서울</th>
                            <td>서울남부터미널</td>
                            <td>진주시외버스터미널</td>
                            <td>3시간 30분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">인천</th>
                            <td>인천종합터미널</td>
                            <td>진주시외버스터미널</td>
                            <td>4시간 10분</td>
                        </tr>
                        <tr>
                            <td>인천공항정류소10C</td>
                            <td>개양정류소</td>
                            <td>4시간 20분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">대전</th>
                            <td>유성시외버스정류소</td>
                            <td>진주시외버스터미널</td>
                            <td>2시간 10분</td>
                        </tr>
                        <tr>
                            <td>대전복합터미널</td>
                            <td>진주시외버스터미널</td>
                            <td>2시간 10분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">대구</th>
                            <td>서부정류장</td>
                            <td>진주시외버스터미널</td>
                            <td>1시간 40분</td>
                        </tr>
                        <tr>
                            <th scope="row">동대구터미널</th>
                            <td>금곡정류소</td>
                            <td>2시간</td>
                        </tr>
                        <tr>
                            <th scope="row">울산</th>
                            <td>울산시외버스터미널</td>
                            <td>진주시외버스터미널</td>
                            <td>2시간 40분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">부산</th>
                            <td>부산서부버스터미널</td>
                            <td>진주시외버스터미널</td>
                            <td>1시간 30분</td>
                        </tr>
                        <tr>
                            <th scope="row">부산종합버스터미널</th>
                            <td>진주시외버스터미널</td>
                            <td>2시간</td>
                        </tr>
                        </tbody>
                    </table>
                </div></div>

                <h2 class="hb1 h2">고속버스</h2>
                <div class="scroll1wrap mgtm1"><div class="scroll1cont">
                    <table class="t3">
                        <caption><span class="blind" title="표요약">진주로 오는 고속버스의 출발지역, 출발지, 시간, 소요시간, 요금으로 정리한 표</span></caption>
                        <col style="width:10%" />
                        <col style="width:15%" />
                        <col style="width:15%" />
                        <col />
                        <col style="width:30%" />
                        <thead>
                        <tr>
                            <th scope="col" colspan="2">출발지역</th>
                            <th scope="col">출발지</th>
                            <th scope="col">도착지</th>
                            <th scope="col">시간</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row" rowspan="2">서울</th>
                            <td>동서울종합터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:00<br />10:00<br />13:00<br />16:10<br />19:00</td>
                            <td>3시간 50분</td>
                        </tr>
                        <tr>
                            <td>서울고속버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>06:00부터 16:25까지<br />20~30분 간격운행</td>
                            <td>3시간 30분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>고양종합터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:50<br />11:30<br />15:00<br />18:00</td>
                            <td>4시간 30분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>성남종합버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:30<br />10:00<br />13:00<br />15:30<br />18:30</td>
                            <td>3시간 40분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>수원종합버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>06:40<br />08:10<br />09:40 <br />11:30<br />13:00<br />14:30<br />16:20<br />17:10<br />18:10<br />19:20 </td>
                            <td>3시간 45분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>신갈고속시외버스정류소</td>
                            <td>진주고속버스터미널</td>
                            <td>07:20<br />10:30 <br />13:30<br />16:20<br />19:20</td>
                            <td>3시간 20분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>용인공용버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:00<br />10:10<br />13:10<br />16:00<br />19:00</td>
                            <td>3시간 40분</td>
                        </tr>
                        <tr>
                            <th scope="row">경기</th>
                            <td>화정터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>08:05<br />11:45<br />15:15<br />18:45</td>
                            <td>4시간 20분</td>
                        </tr>
                        <tr>
                            <th scope="row">인천</th>
                            <td>인천종합터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:00<br />09:00<br />11:00<br />12:40<br />14:50<br />16:50<br />18:00</td>
                            <td>3시간 55분</td>
                        </tr>
                        <tr>
                            <th scope="row">대전</th>
                            <td>대전복합터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>09:00<br />12:00<br />15:00<br />18:00</td>
                            <td>2시간</td>
                        </tr>
                        <tr>
                            <th scope="row">대구</th>
                            <td>동대구터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>06:40부터 20:00까지<br />50~60분 간격운행</td>
                            <td>2시간 10분</td>
                        </tr>
                        <tr>
                            <th scope="row">대구</th>
                            <td>서대구고속버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>06:40부터 20:00까지<br />50~60분 간격운행</td>
                            <td>2시간 10분</td>
                        </tr>
                        <tr>
                            <th scope="row">광주</th>
                            <td>광주종합버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>07:05<br />08:45<br />10:05<br />11:45<br />13:05<br />14:40<br />16:10<br />17:40<br />19:10</td>
                            <td>2시간</td>
                        </tr>
                        <tr>
                            <th scope="row">원주</th>
                            <td>워주고속버스터미널</td>
                            <td>진주고속버스터미널</td>
                            <td>10:10<br />18:10</td>
                            <td>4시간</td>
                        </tr>
                        </tbody>
                    </table>
                </div></div>

                <h2 class="hb1 h2">기차</h2>
                <div class="scroll1wrap mgtm1"><div class="scroll1cont">
                    <table class="t3">
                        <caption><span class="blind" title="표요약">진주로 오는 기차의 출발지역, 출발지, 도착지, 소요시간, 요금으로 정리한 표</span></caption>
                        <col style="width:10%" />
                        <col span="3" style="width:30%" />
                        <thead>
                        <tr>
                            <th scope="col">출발지역</th>
                            <th scope="col">출발지</th>
                            <th scope="col">도착지</th>
                            <th scope="col">소요시간</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row">서울</th>
                            <td>서울역</td>
                            <td>진주역</td>
                            <td>무궁화 : 6시간 30분<br />
                                ITX 새마을 : 5시간 25분<br />
                                KTX : 3시간 30분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="3">인천</th>
                            <td>검암역</td>
                            <td>진주역</td>
                            <td>KTX : 3시간 51분</td>
                        </tr>
                        <tr>
                            <td>인천공항T1역</td>
                            <td>진주역</td>
                            <td>KTX : 4시간 11분</td>
                        </tr>
                        <tr>
                            <td>인천공항T2역</td>
                            <td>진주역</td>
                            <td>KTX : 4시간 21분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">대전</th>
                            <td>대전역</td>
                            <td>진주역</td>
                            <td>무궁화 : 4시간 23분<br />
                                ITX : 3시간 36분<br />
                                KTX : 2시간 20분</td>
                        </tr>
                        <tr>
                            <td>신탄진역</td>
                            <td>진주역</td>
                            <td>무궁화 : 4시간 36분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="3">광주</th>
                            <td>서광주역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 8분</td>
                        </tr>
                        <tr>
                            <td>광주송정역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 17분</td>
                        </tr>
                        <tr>
                            <td>효천역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 2분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="2">대구</tH>
                            <td>동대구역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 14분<br />
                                ITX : 1시간 49분<br />
                                KTX : 1시간 33분</td>
                        </tr>
                        <tr>
                            <td>대구역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 20분<br />
                                ITX : 1시간 55분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="4">울산</th>
                            <td>태화강역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 35분</td>
                        </tr>
                        <tr>
                            <td>덕하역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 25분</td>
                        </tr>
                        <tr>
                            <td>호계역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 47분</td>
                        </tr>
                        <tr>
                            <td>남창역</td>
                            <td>진주역</td>
                            <td>무궁화 : 3시간 15분</td>
                        </tr>
                        <tr>
                            <th scope="row" rowspan="7">부산</th>
                            <td>부전역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 13분</td>
                        </tr>
                        <tr>
                            <td>센텀역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 31분</td>
                        </tr>
                        <tr>
                            <td>구포역</td>
                            <td>진주역</td>
                            <td>무궁화 : 1시간 56분</td>
                        </tr>
                        <tr>
                            <td>사상역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 2분</td>
                        </tr>
                        <tr>
                            <td>화명역</td>
                            <td>진주역</td>
                            <td>무궁화 : 1시간 51분</td>
                        </tr>
                        <tr>
                            <td>신해운대역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 39분</td>
                        </tr>
                        <tr>
                            <td>기장역</td>
                            <td>진주역</td>
                            <td>무궁화 : 2시간 49분</td>
                        </tr>
                        </tbody>
                    </table>
                </div></div>

            </div>
            <!-- //m1s5_traffic -->

        </div>

    </layout:put>

    <layout:put block="javascript" type="REPLACE">

    </layout:put>

</layout:extends>
