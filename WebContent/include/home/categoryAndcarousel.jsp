<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<script>
function showProductsAsideCategorys(cid){
    $("div.eachCategory[cid="+cid+"]").css("background-color","#fff");
    $("div.eachCategory[cid="+cid+"] a").css("color","#2B2B2B");
    $("div.productsAsideCategorys[cid="+cid+"]").show();
}
 
function hideProductsAsideCategorys(cid){
    $("div.eachCategory[cid="+cid+"]").css("background-color","#2B2B2B");
    $("div.eachCategory[cid="+cid+"] a").css("color","#fff");
    $("div.productsAsideCategorys[cid="+cid+"]").hide();
}
$(function(){
    $("div.eachCategory").mouseenter(function(){
        var cid = $(this).attr("cid");
        showProductsAsideCategorys(cid);
    });
    $("div.eachCategory").mouseleave(function(){
        var cid = $(this).attr("cid");
        hideProductsAsideCategorys(cid);
    });
    $("div.productsAsideCategorys").mouseenter(function(){
        var cid = $(this).attr("cid");
        showProductsAsideCategorys(cid);
    });
    $("div.productsAsideCategorys").mouseleave(function(){
        var cid = $(this).attr("cid");
        hideProductsAsideCategorys(cid);
    });
     
    $("div.rightMenu span").mouseenter(function(){
/*         var left = $(this).position().left;
        var top = $(this).position().top;
        var width = $(this).css("width");
        var destLeft = parseInt(left) + 110 + parseInt(width)/2;
        $("img#catear").css("left",destLeft);
        $("img#catear").css("top",top-31);
        $("img#catear").fadeIn(500); */
                 
    });
    $("div.rightMenu span").mouseleave(function(){
        $("img#catear").hide();
    });
     
    var left = $("div#carousel-of-product").offset().left;
   /*  $("div.categoryMenu").css("left",left-20); */
    /* $("div.categoryWithCarousel div.head").css("margin-left",left); */
    /* $("div.productsAsideCategorys").css("left",left-20); */
     
});
</script>
 
<!-- <img src="img/site/hand.png" id="catear" class="catear"/> -->
     
<div class="categoryWithCarousel">
 
	<div class="headbar show1">
	    <div class="head ">
	     
	        <span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
	        <span style="margin-left:10px" >商品分类</span>
	         
	    </div>
	     
	    <div class="rightMenu">
	        <c:forEach items="${categorys}" var="c" varStatus="st">
	            <c:if test="${st.count<=7}">
	                <span>
	                <a href="forecategory?category.id=${c.id}">
	                    ${c.name}
	                </a></span>         
	            </c:if>
	        </c:forEach>
	
	    </div>
	
	</div>
	            
	<div style="position: relative">
	    <%@include file="categoryMenu.jsp" %>
	</div>
	 
	<div style="position: relative;left: 0;top: 0;">
	    <%@include file="productsAsideCategorys.jsp" %>
	</div>
	<div style="position: relative;left: 0;top: 0; ">
	    <%@include file="carousel.jsp" %>
	</div>
	<%-- <%@include file="carousel.jsp" %> --%>
	 
	<div class="carouselBackgroundDiv">
	</div>
</div>