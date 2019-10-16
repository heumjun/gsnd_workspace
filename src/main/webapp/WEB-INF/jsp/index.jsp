<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2018-05-15
  Time: 오전 11:08
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

<layout:extends name="wwwBase">

	<layout:put block="title" type="REPLACE">
		진주목공예전수관
	</layout:put>

	<layout:put block="cssPart" type="REPLACE">
		<link rel="stylesheet" type="text/css" href="<c:url value="/assets/css/woodcraft/www/main.css"/>" />
	</layout:put>

	<layout:put block="contents" type="REPLACE">
		<!-- #main_visual1 -->
		<div id="main_visual1" class="init clearfix">
			<!-- ★★★ 비쥬얼 홍보 ★★★ -->
			<div id="vpr1">
				<div class="wrap1">
					<h3 class="blind">비주얼 홍보</h3>
					<!-- menu -->
					<div class="menu">
						<div class="menubg1">
							<div class="mControl">
								<button type="button" class="m stop"><i class="ic1 bsContain"></i> <span class="blind">비주얼 홍보. 순환 정지</span></button>
								<button type="button" class="m play"><i class="ic1 bsContain"></i> <span class="blind">비주얼 홍보. 순환 재생</span></button>
							</div>
							<div class="mNum">
								<a href="#vpr1c1" class="m m1"><i class="ic1 bsContain"></i> <span class="t1 blind">1</span></a>
							</div>
						</div>
					</div>
					<!-- /menu -->

					<!-- mView -->
					<div class="mView" id="vpr1s">
						<ul class="mCont" id="vpr1c">
							<!-- 1번 이미지 : #vpr1c1 -->
							<li class="mContC" id="vpr1c1">
								<a class="c">
									<div class="t1">
										<div class="container">
											<div class="t1t1">
												<span class="t1t1t1"><img src='<c:url value="/assets/images/woodcraft/www/main/t1t1t1.png"/>' alt="진주목공예전수관" /></span>
												<span class="t1t1t4"><img src='<c:url value="/assets/images/woodcraft/www/main/t1t1t4.png"/>' alt="오랜 전통을 가진 진주목공예를 계승ㆍ발전시키고자 합니다.진주목공예전수관은 목공예 전문 인력을 양성하고 시민여러분에게 다양한 취미활동을 제공합니다." /></span>
											</div>
										</div>
									</div>
									<div class="f1">
										<span class="f1p1">
											<span class="f1p1bg1 f1p1full"><img src='<c:url value="/assets/images/woodcraft/www/main/v1img1.jpg"/>' alt="" /></span>
											<span class="f1p1bg1 f1p1small"><img src='<c:url value="/assets/images/woodcraft/www/main/v1img1@1.jpg"/>' alt="" /></span>
										</span>
									</div>
								</a>
							</li>
							<!-- / 1번 이미지 -->
						</ul>
					</div>
					<!-- /mView -->

				</div>
			</div>
			<!-- /vpr1 -->
			<script type="text/javascript">/*<![CDATA[*/
            $(function(){
                $('#vpr1').jQmPR1({interval:6000, mTabindex:'-1'});
            });
            /*]]>*/</script>
			<!-- // ★★★ 비쥬얼 홍보 ★★★ -->

			<!-- ★★★ 팝업존 홍보 ★★★ -->
			<!-- epr1 -->
			<div id="epr1">
				<div class="wrap1">
					<h3 class="h1 blind">알림판</h3>
					<!-- menu -->
					<div class="menu">
						<div class="mPage">
							<span class="text" title="현재페이지 / 전체페이지"><b class="on"></b><span class="sep">/</span><b class="total"></b></span>
						</div>
						<div class="mControl">
							<button type="button" class="m stop"><i class="ic1 bsContain"></i> <span class="blind">알림판. 순환 정지</span></button>
							<button type="button" class="m prev"><i class="ic1 bsContain"></i> <span class="blind">알림판. 이전 보기</span></button>
							<button type="button" class="m next"><i class="ic1 bsContain"></i> <span class="blind">알림판. 다음 보기</span></button>
						</div>
					</div>
					<!-- /menu -->
					<!-- mView -->
					<div class="mView" id="epr1s">
						<ul class="mCont" id="epr1c">
							<li class="mContC" id="epr1c1">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000002950" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190408_02.png"/>' alt="정리왕수납함" /></span>
									</div>
								</a>
							</li>
							<li class="mContC" id="epr1c2">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000002951" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190408_03.png"/>' alt="보석함" /></span>
									</div>
								</a>
							</li> 							


							<li class="mContC" id="epr1c3">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003128" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190418_01.png"/>' alt="수납스툴" /></span>
									</div>
								</a>
							</li>

							
							<li class="mContC" id="epr1c4">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003132" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190418_02.png"/>' alt="디딤스툴" /></span>
									</div>
								</a>
							</li>

							
							<li class="mContC" id="epr1c5">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003133" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190418_03.png"/>' alt="날개통받이의자" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c6">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003258" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_01.png"/>' alt="손잡이 수납박스" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c7">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003259" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_02.png"/>' alt="두칸 수납박스" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c8">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003260" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_03.png"/>' alt="플레이팅 도마" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c9">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003261" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_04.png"/>' alt="x 스툴[stool]" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c10">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003262" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_05.png"/>' alt="우드 트레이(대)" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c11">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003263" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_06.png"/>' alt="우드 트레이 세트" /></span>
									</div>
								</a>
							</li>

							<li class="mContC" id="epr1c12">
								<a class="c" href="/mokgong/exprn/exprnView.do?exprnId=EXPRN0000003264" target="_blank" title="새 창">
									<div class="f1">
										<span class="f1p1"><img src='<c:url value="/assets/images/woodcraft/www/popup/20190425_07.png"/>' alt="혼차탁[창]" /></span>
									</div>
								</a>
							</li>
						</ul>
					</div>
					<!-- /mView -->
				</div>
			</div>
			<!-- /epr1 -->
			<script type="text/javascript">/*<![CDATA[*/
            $(function(){ // 20171017.
                $('#epr1').jQmPR1({interval:6000, mTabindex:'-1'});
            });
            /*]]>*/</script>
			<!-- // ★★★ 팝업존 홍보 ★★★ -->

		</div>
		<!-- #main_visual1 -->

		<!-- #main_body1 -->
		<div id="main_body1" class="init clearfix">
			<!-- container -->
			<div class="container">
				<div class="section1 wrap1">
					<h2>공지사항<i class="ic1 bsContain"></i></h2>
					<div class="mCont">
						<c:forEach var="result" items="${boardList}" varStatus="status">
							<a href="javascript:;" data-ntt-id="${result.nttId}">
								<span class="t1">${result.nttSj}</span>
								<span class="t2">${result.frstRegisterPnttm}</span>
								<!--<i class="new">새 글</i>-->
							</a>
						</c:forEach>
					</div>
					<a href='<c:url value="/community/list/000000000011.do"/>' class="more"><i class="ic1 bsContain"></i><span class="blind">더보기</span></a>
				</div>
				<div class="section2 wrap1">
					<h2>문의전화<i class="ic1 bsContain"></i></h2>
					<div class="mCont">
						<span class="t1"><a href="tel:055-746-3633" class="tel1" title="전화걸기">055-746-3633</a>~4</span>
						<span class="t2">운영시간 : 10:00 ~ 17:00</span>
					</div>
				</div>
			</div>
			<!--//  container -->
		</div>
		<!-- // #main_body1 -->


		<!-- #main_body2 -->
		<div id="main_body2" class="init clearfix">
			<!-- container -->
			<div class="container">
				<!-- section3 -->
				<div class="section3">
					<div class="wrap1">
						<h2>교육ㆍ체험 <a href='<c:url value="/exprn/exprnList.do"/>' class="more"><i class="ic1 bsContain"></i><span class="blind">더보기</span></a></h2>
						<div class="mCont">
							<ul>
								<c:forEach var="result" items="${exprnList}" varStatus="status">
									<li><a href="javascript:;" data-exprn-id="${result.exprnId}" data-type-cd="${result.typeCd}">
										<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.exprnIntrcn}" /></span>
										<span class="txt1">
											<span class="t1">${result.exprnNm}</span>
											<span class="t2">${result.exprnIntrcn}</span>
										</span>
									</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<!-- /section3 -->
				<!-- section4 -->
				<div class="section4">
					<div class="wrap1">
						<ul>
							<li class="m1"><a href='<c:url value="/WoodPageLink.do?link=1&qn=1"/>'><i class="ic1 bsContain"></i>예약안내</a></li>
							<li class="m2"><a href='<c:url value="/tour/buildingInfo.do"/>'><i class="ic1 bsContain"></i><!--(나중에 예약프로그램 완료후 변경예정)시설예약-->시설안내</a></li>
							<li class="m3"><a href='<c:url value="/prgm/prgmIntro.do"/>'><i class="ic1 bsContain"></i>교육 프로그램 안내</a></li>
							<li class="m4"><a href='<c:url value="/wcrf/wcrfList.do"/>'><i class="ic1 bsContain"></i>목공예품구매</a></li>
							<li class="m5"><a href='<c:url value="/mypage/exprnMyList.do"/>'><i class="ic1 bsContain"></i>확인 및 취소</a></li>
							<li class="m6"><a href='<c:url value="/WoodPageLink.do?link=1&qn=2"/>'><i class="ic1 bsContain"></i>이용요금</a></li>
							<li class="m7"><a href='<c:url value="/exprn/exprnIntro.do"/>'><i class="ic1 bsContain"></i>일일 체험 안내</a></li>
							<li class="m8"><a href='<c:url value="/artist/artistList.do"/>'><i class="ic1 bsContain"></i>목공예인 소개</a></li>
						</ul>
					</div>
				</div>
				<!-- /section4 -->
			</div>
			<!--//  container -->
		</div>
		<!-- // #main_body2 -->

		<!-- #main_body3 -->
		<div id="main_body3" class="init clearfix">
			<!-- #wood1 -->
			<div id="wood1">
				<div class="container wrap1">
					<h2 class="tab"><a href="#wood1c1">목공예품</a></h2>
					<div id="wood1c1" class="cont">
						<h3>목공예품<a href='<c:url value="/wcrf/wcrfList.do"/>' class="more"><i class="ic1 bsContain"></i><span class="blind">더보기</span></a></h3>
						<p>진주목공예품의 전시 또는 개인 소장을 위한 구매가 가능합니다.</p>
						<!-- contC -->
						<div class="gallery1product1 contC">
							<ul>
								<c:forEach var="result" items="${wcrfList}" varStatus="status">
									<li><a href="javascript:;" class="a1" data-wcrf-id="${result.wcrfId}">
										<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.wcrfDesc}" /></span>
										<span class="text1">
										<strong class="t1">${result.wcrfNm}</strong>
										<span class="t2"><c:set var="price" value="${result.wcrfAmt}" />
                                        <fmt:formatNumber value="${price}" type="number" />원</span>
									</span>
									</a></li>
								</c:forEach>
							</ul>
						</div>
						<!-- /contC -->
					</div>

					<h2 class="tab"><a href="#wood1c2">진주<br />목공예인</a></h2>
					<div id="wood1c2" class="cont">
						<h3>진주목공예인<a href='<c:url value="/artist/artistList.do"/>' class="more"><i class="ic1 bsContain"></i><span class="blind">더보기</span></a></h3>
						<p>오랜 전통을 가진 진주 목공예인들을 소개합니다.</p>
						<!-- contC -->
						<div class="gallery1artist1 contC">
							<ul>
								<c:forEach var="result" items="${artistList}" varStatus="status">
									<li>
										<a href="javascript:;" class="a1" data-artist-nm="${result.artistNm}">
											<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId2}"/>" alt="${result.artistNm} 인물사진" /></span>
											<span class="text1">
										<strong class="t1">${result.artistNm}</strong>
										<span class="t2">${result.crfShopNm}</span>
									</span>
										</a>
										<c:if test = "${result.telNo != null && result.telNo != ''}">
											<a href="tel:${result.telNo}" class="a2" title="전화걸기"><i class="ic1 bsContain"></i>${result.telNo}</a>
										</c:if>

										<c:if test = "${result.telNo == null || result.telNo == ''}">
											<a href="tel:${result.hpNo}" class="a2" title="전화걸기"><i class="ic1 bsContain"></i>${result.hpNo}</a>
										</c:if>

									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- /contC -->
					</div>
				</div>
			</div>
			<!-- // #wood1 -->
			<script type="text/javascript">/*<![CDATA[*/
            $(function(){
                fncTab1('click', '#wood1', '.tab', 1, '.cont');
            });
            /*]]>*/</script>

		</div>
		<!-- // #main_body3 -->

		<!-- #main_body4 -->
		<div id="main_body4" class="init clearfix">
			<!-- container -->
			<div class="container">
				<!-- section7 -->
				<div class="section7">
					<div class="wrap1">
						<h2>관광정보</h2>
						<p class="t1">아름다운 문화도시 진주시로 방문하세요.</p>
						<ul>
							<li class="m1"><a href="http://jinju.go.kr/03about/07_02.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">진주시소개</span></a></li>
							<li class="m2"><a href="http://tour.jinju.go.kr/01tour/00_00.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">문화관광</span></a></li>
							<li class="m3"><a href="http://tour.jinju.go.kr/02tourinfo/01_01.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">숙박시설</span></a></li>
							<li class="m4"><a href="http://tour.jinju.go.kr/02tourinfo/02_07.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">음식정보</span></a></li>
							<li class="m5"><a href="http://tour.jinju.go.kr/03tourinfo/01_01_01_02.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">교통정보</span></a></li>
							<li class="m6"><a href="http://www.jinju.go.kr/03about/06_01.jsp" target="_blank" title="새 창"><i class="ic1 bsContain"></i><span class="t2">오시는 길</span></a></li>
						</ul>
					</div>
				</div>
				<!-- /section7 -->
			</div>
			<!--//  container -->
		</div>
		<!-- // #main_body4 -->


	</layout:put>

	<layout:put block="javascript" type="REPLACE">

		<script type="text/javascript">

            $(document).ready(function() {


                $("a[data-wcrf-id]").click(function(event) {
                    event.preventDefault();
                    var wcrfId = $(this).attr("data-wcrf-id");
                    var view_url = "<c:url value="/wcrf/wcrfPay.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#main_visual1")
                        .append($("<input />").attr("type","hidden").attr("name","wcrfId").val(wcrfId))
                        .submit();
                });

                $("a[data-artist-nm]").click(function(event) {
                    event.preventDefault();
                    var artistNm = $(this).attr("data-artist-nm");
                    var view_url = "<c:url value="/artist/artistList.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#main_visual1")
                        .append($("<input />").attr("type","hidden").attr("name","searchOption").val('01'))
                        .append($("<input />").attr("type","hidden").attr("name","searchKeyword").val(artistNm))
                        .submit();
                });

                $("a[data-exprn-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id");
                    var typeCd = $(this).attr("data-type-cd");
                    var view_url = "<c:url value="/exprn/exprnView.do"/>";
                    if (typeCd == '02') {
                        view_url = "<c:url value="/prgm/prgmView.do"/>";
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#main_visual1")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();
                });

                $("a[data-ntt-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-ntt-id");
                    var view_url = "<c:url value="/community//view/000000000011.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "post")
                        .appendTo("#main_visual1")
                        .append($("<input />").attr("type","hidden").attr("name","nttId").val(exprnId))
                        .submit();
                });
            });

		</script>

	</layout:put>

</layout:extends>