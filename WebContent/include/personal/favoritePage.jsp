<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(function() {

});
function addCart(click) {
    var addCartpage = $(click).attr("attr");
    $.get(
        addCartpage,
        function(result){
           if("success"==result){
                infoInfo("加入购物车成功");
                return false;
           }
           else{
                infoInfo("加入购物车失败");
                return false;
           }
           return false;
        }
    );
    
}
</script>
<title>我的足迹</title>
    <div class="personalContent" style="min-height:606px">
        <div class="personalTitle">
            <strong>我的收藏</strong> / <small>My Collection</small>
        </div>
        <hr/>
        <c:forEach items="${favorites }" var="favorite">
	        <div class="goods">
	            <div class="goods-box">
	                <a href="foreproduct?product.id=${favorite.product.id}">
	                    <img class="goods-pic" src="img/productSingle_middle/${favorite.product.firstProductImage.id}.jpg">
	                </a>
	                <span class="productPrice">¥<fmt:formatNumber type="number" value="${favorite.product.promotePrice}" minFractionDigits="2"/></span>
	                <a class="productLink" href="foreproduct?product.id=${favorite.product.id}">
	                 ${fn:substring(favorite.product.name, 0, 40)}
	                </a>
	                <a class="goods-delete" href="personaldeleteFavorite?favorite.id=${favorite.id}">
	                    <i class="glyphicon glyphicon-trash"></i>
	                </a>
	                <c:if test="${favorite.product.sale == 1}">
		                <a class="goods-addCart" href="#nowhere" attr="foreaddCart?product.id=${favorite.product.id}&num=1" onclick="addCart(this)">
		                   <span class="desc">加入购物车</span>
		                </a>
	                </c:if>
	                <c:if test="${favorite.product.sale == 0}">
                        <a class="goods-addCart" href="#nowhere">
                           <span class="desc">此产品已下架</span>
                        </a>
                    </c:if>
	            </div>
	        </div>
        </c:forEach>
        <c:if test="${empty favorites}">
	        <div class="empty">
	            <div class="pic"></div>
	            <div class="tips">还没有收藏过商品呢</div>
	        <div>
        </c:if>
        <div class="clear"></div>
    </div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 