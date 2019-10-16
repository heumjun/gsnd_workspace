<%--
  Created by IntelliJ IDEA.
  User: ryanl
  Date: 2018-05-15
  Time: 오후 12:51
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
			<c:param name="menuNo" value="11401000"></c:param>
		</c:import>
	</layout:put>

	<layout:put block="title" type="REPLACE">
		<c:out value="${sessionScope.title1}"/> &gt; <c:out value="${sessionScope.title2}"/>
	</layout:put>

	<layout:put block="contents" type="REPLACE">

		<!-- 1. 등록된 내용이 없을 경우
		<div class="nopage">
		<img src='<c:url value="/assets/images/woodcraft/www/lib/nopage.png"/>' alt="" />
		<div class="t1">
		<h2>프로그램 준비중입니다.</h2>
		<p>
		현재 프로그램을 준비하고 있으니 조금만 기다려 주세요.<br />
		더욱 나은 모습으로 찾아뵙겠습니다.
		</p>
		</div>
		</div>-->

		<!-- 2. 등록된 내용이 있음 -->
		<div id="edu1">
			<!-- division -->
			<div class="division">
				<div class="division-tit">전문가반</div>
				<div class="division-cont">
					<!-- 내용 -->
					<!-- edu1list1 -->
					<div class="edu1list1">
						<ul>
							<c:if test="${retListCnt01 == 0}">
								<li class="tac"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</li>
							</c:if>

							<c:forEach var="result" items="${resultList01}" varStatus="status">
								<li><a href="javascript:;" data-exprn-id="${result.exprnId}" class="a1">
							<span class="edu1item1">
								<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.exprnIntrcn}" /></span>
								<span class="texts">
									<em class="c1">${result.exprnSeNm}</em>
									<strong class="t1">${result.exprnNm}</strong>
									<span class="t2">교육기간 : ${result.bgnDe} ~ ${result.endDe}</span>
									<span class="t3">
										<span class="t3t1">시간 : <b>${result.exprnTime}</b></span>
										<span class="t3t1">모집인원 : 각 ${result.exprnNmpr}명</span>
										<span class="t3t1">수강료 :
										<c:set var="price" value="${result.exprnBaseAmt + result.exprnMtrAmt}" />
                                        <fmt:formatNumber value="${price}" type="number" />원 (재료비별도)</span>
									</span>
									    <span  class="t3">
                                        <span class="t3t1">강사명 : ${result.teacherNm}</span>
                                    </span>
								</span>
							</span>
									<span class="now">
                                <c:if test="${result.exprnSttus == '01'}">
									<span class="sting st3">대기</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '02'}">
									<c:if test="${result.exprnNmpr > result.reqCnt}">
										<c:if test="${result.bgnDe > strDay}">
											<span class="sting st1">예약중</span>
										</c:if>
										<c:if test="${result.bgnDe <= strDay}">
											<span class="sting st2">예약완료</span>
										</c:if>
									</c:if>
									<c:if test="${result.exprnNmpr <= result.reqCnt}">
										<span class="sting st2">예약완료</span>
									</c:if>
								</c:if>
                                <c:if test="${result.exprnSttus == '03'}">
									<span class="sting st2">예약완료</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '04'}">
									<span class="sting st6">취소</span>
								</c:if>
										<!-- ★★ 색상변경 : st1, st2, st3, st4, st5, st6 ★★ -->
							</span>
								</a>
									<span class="btns">
							<a href="javascript:;" data-exprn-id="${result.exprnId}" class="button">상세정보</a>
							<a href="javascript:;" data-exprn-id2="${result.exprnId}" data-exprn-sttus="${result.exprnSttus}" data-exprn-nmpr='${result.exprnNmpr}' data-req-cnt='${result.reqCnt}' data-bgnDe='${result.bgnDe}' class="button">예약하기</a>
						</span>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- /edu1list1 -->
					<!-- // 내용 -->
				</div>
			</div>
			<!-- //division -->
			<!-- division -->
			<div class="division">
				<div class="division-tit">기초반</div>
				<div class="division-cont">
					<!-- 내용 -->
					<div class="edu1list1">
						<ul>

							<c:if test="${retListCnt02 == 0}">
								<li class="tac"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</li>
							</c:if>

							<c:forEach var="result" items="${resultList02}" varStatus="status">
								<li><a href="javascript:;" data-exprn-id01="${result.exprnId}" class="a1">
							<span class="edu1item1">
								<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.exprnIntrcn}" /></span>
								<span class="texts">
									<em class="c1">${result.exprnSeNm}</em>
									<strong class="t1">${result.exprnNm}</strong>
									<span class="t2">교육기간 : ${result.bgnDe} ~ ${result.endDe}</span>
									<span class="t3">
										<span class="t3t1">시간 : <b>${result.exprnTime}</b></span>
										<span class="t3t1">모집인원 : 각 ${result.exprnNmpr}명</span>
										<span class="t3t1">수강료 :
										<c:set var="price" value="${result.exprnBaseAmt + result.exprnMtrAmt}" />
                                        <fmt:formatNumber value="${price}" type="number" />원 (재료비별도)</span>
									</span>
									    <span  class="t3">
                                        <span class="t3t1">강사명 : ${result.teacherNm}</span>
                                    </span>
								</span>
							</span>
									<span class="now">
                                <c:if test="${result.exprnSttus == '01'}">
									<span class="sting st3">대기</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '02'}">
									<c:if test="${result.exprnNmpr > result.reqCnt}">
										<c:if test="${result.bgnDe > strDay}">
											<span class="sting st1">예약중</span>
										</c:if>
										<c:if test="${result.bgnDe <= strDay}">
											<span class="sting st2">예약완료</span>
										</c:if>
									</c:if>
									<c:if test="${result.exprnNmpr <= result.reqCnt}">
										<span class="sting st2">예약완료</span>
									</c:if>
								</c:if>
                                <c:if test="${result.exprnSttus == '03'}">
									<span class="sting st2">예약완료</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '04'}">
									<span class="sting st6">취소</span>
								</c:if>
										<!-- ★★ 색상변경 : st1, st2, st3, st4, st5, st6 ★★ -->
							</span>
								</a>
									<span class="btns">
							<a href="javascript:;" data-exprn-id01="${result.exprnId}" class="button">상세정보</a>
							<a href="javascript:;" data-exprn-id201="${result.exprnId}" data-exprn-sttus01="${result.exprnSttus}" data-exprn-nmpr01='${result.exprnNmpr}' data-req-cnt01='${result.reqCnt}' data-bgnDe01='${result.bgnDe}' class="button">예약하기</a>
						</span>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- // 내용 -->
				</div>
			</div>
			<!-- //division -->
			<!-- division -->
			<div class="division">
				<div class="division-tit">취미반</div>
				<div class="division-cont">
					<!-- 내용 -->
					<div class="edu1list1">
						<ul>
							<c:if test="${retListCnt03 == 0}">
								<li class="tac"><i class="ic1nodata1 bsContain"></i>등록된 내용이 없습니다.</li>
							</c:if>

							<c:forEach var="result" items="${resultList03}" varStatus="status">
								<li><a href="javascript:;" data-exprn-id02="${result.exprnId}" class="a1">
							<span class="edu1item1">
								<span class="f1"><img src="<c:url value="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}"/>" alt="${result.exprnIntrcn}" /></span>
								<span class="texts">
									<em class="c1">${result.exprnSeNm}</em>
									<strong class="t1">${result.exprnNm}</strong>
									<span class="t2">교육기간 : ${result.bgnDe} ~ ${result.endDe}</span>
									<span class="t3">
										<span class="t3t1">시간 : <b>${result.exprnTime}</b></span>
										<span class="t3t1">모집인원 : 각 ${result.exprnNmpr}명</span>
										<span class="t3t1">수강료 :
										<c:set var="price" value="${result.exprnBaseAmt + result.exprnMtrAmt}" />
                                        <fmt:formatNumber value="${price}" type="number" />원 (재료비별도)</span>
									</span>
									<span  class="t3">
                                        <span class="t3t1">강사명 : ${result.teacherNm}</span>
                                    </span>
								</span>
							</span>
									<span class="now">
                                <c:if test="${result.exprnSttus == '01'}">
									<span class="sting st3">대기</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '02'}">
									<c:if test="${result.exprnNmpr > result.reqCnt}">
										<c:if test="${result.bgnDe > strDay}">
											<span class="sting st1">예약중</span>
										</c:if>
										<c:if test="${result.bgnDe <= strDay}">
											<span class="sting st2">예약완료</span>
										</c:if>
									</c:if>
									<c:if test="${result.exprnNmpr <= result.reqCnt}">
										<span class="sting st2">예약완료</span>
									</c:if>
								</c:if>
                                <c:if test="${result.exprnSttus == '03'}">
									<span class="sting st2">예약완료</span>
								</c:if>
                                <c:if test="${result.exprnSttus == '04'}">
									<span class="sting st6">취소</span>
								</c:if>
										<!-- ★★ 색상변경 : st1, st2, st3, st4, st5, st6 ★★ -->
							</span>
								</a>
									<span class="btns">
							<a href="javascript:;" data-exprn-id02="${result.exprnId}" class="button">상세정보</a>
							<a href="javascript:;" data-exprn-id202="${result.exprnId}" data-exprn-sttus02="${result.exprnSttus}" data-exprn-nmpr02='${result.exprnNmpr}' data-req-cnt02='${result.reqCnt}' data-bgnDe02='${result.bgnDe}' class="button">예약하기</a>
						</span>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- // 내용 -->
				</div>
			</div>
			<!-- //division -->
		</div>

	</layout:put>

	<layout:put block="javascript" type="REPLACE">
		<script type="text/javascript">
            $(document).ready(function() {
                // 전문가
                $("a[data-exprn-id]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id");
                    var view_url = "<c:url value="/prgm/prgmView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

                $("a[data-exprn-id2]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id2");
                    var view_url = "<c:url value="/prgm/prgmPay.do"/>";
                    var exprnSttus = $(this).attr("data-exprn-sttus");
                    var exprnNmpr = $(this).attr("data-exprn-nmpr");
                    var reqCnt = $(this).attr("data-req-cnt");
                    var bgnDe = $(this).attr("data-bgnDe");

                    if(exprnSttus == '01') {
                        alert("대기중인 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '03') {
                        alert("예약이 완료된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '04') {
                        alert("취소된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '02') {
                        if(exprnNmpr <= reqCnt) {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                        if(bgnDe <= '${strDay}') {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

                // 기초반
                $("a[data-exprn-id01]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id01");
                    var view_url = "<c:url value="/prgm/prgmView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });


                $("a[data-exprn-id201]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id201");
                    var view_url = "<c:url value="/prgm/prgmPay.do"/>";
                    var exprnSttus = $(this).attr("data-exprn-sttus01");
                    var exprnNmpr = $(this).attr("data-exprn-nmpr01");
                    var reqCnt = $(this).attr("data-req-cnt01");
                    var bgnDe = $(this).attr("data-bgnDe01");

                    if(exprnSttus == '01') {
                        alert("대기중인 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '03') {
                        alert("예약이 완료된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '04') {
                        alert("취소된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '02') {
                        if(exprnNmpr <= reqCnt) {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                        if(bgnDe <= '${strDay}') {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

                // 취미반
                $("a[data-exprn-id02]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id02");
                    var view_url = "<c:url value="/prgm/prgmView.do"/>";

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

                $("a[data-exprn-id202]").click(function(event) {
                    event.preventDefault();
                    var exprnId = $(this).attr("data-exprn-id202");
                    var view_url = "<c:url value="/prgm/prgmPay.do"/>";
                    var exprnSttus = $(this).attr("data-exprn-sttus02");
                    var exprnNmpr = $(this).attr("data-exprn-nmpr02");
                    var reqCnt = $(this).attr("data-req-cnt02");
                    var bgnDe = $(this).attr("data-bgnDe02");

                    if(exprnSttus == '01') {
                        alert("대기중인 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '03') {
                        alert("예약이 완료된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '04') {
                        alert("취소된 프로그램입니다.");
                        return false;
                    } else if(exprnSttus == '02') {
                        if(exprnNmpr <= reqCnt) {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                        if(bgnDe <= '${strDay}') {
                            alert("예약이 완료된 프로그램입니다.");
                            return false;
                        }
                    }

                    $("<form />")
                        .attr("action", view_url)
                        .attr("method", "get")
                        .appendTo("#body_content")
                        .append($("<input />").attr("type","hidden").attr("name","exprnId").val(exprnId))
                        .submit();

                    return false;
                });

            });
		</script>
	</layout:put>

</layout:extends>