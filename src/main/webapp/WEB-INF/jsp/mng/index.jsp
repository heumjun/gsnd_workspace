
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<c:import url="/mng/include/header.do">
    <c:param name="pageTitle" value="진주목공예전수관"/>
</c:import>

<c:import url="/mng/include/top_nav.do"></c:import>

<c:import url="/mng/include/sidebar.do"></c:import>
<!-- Main -->
<article>
    <div class="article-header">
        <nav class="curr-nav">
        <ul>
        <li><a class="home" href="#">홈</a></li>
        <li><a href="#"></a></li>
        <li><a class="on" href="#"></a></li>
        </ul>
        </nav>
    </div>
    <section class="sub-body">
     <!--
          contents
     -->
        <h2 class="title-h2">관리자페이지</h2>
    </section>
</article>
<script type="text/javascript">
    $(function() {
        var item1 = $("div.vNav > ul > li > a")[3];
        var item2 = $(item1).siblings("ul").find(" > li")[1];
        var item3 = $(item2).find(" > a").siblings("ul").find("li");

        item1.click();
        $(item2).find(" > a").click();
        $(item3[0]).addClass("active");
    });
</script>
<!-- /Main -->



