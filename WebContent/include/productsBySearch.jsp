<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--   
1. 遍历products，把每个产品的图片，价格，标题等信息显示出来
2. 如果products为空，则显示 "没有满足条件的产品"
    -->
<div class="searchProducts">
     
    <c:forEach items="${products}" var="p">
        <div class="productUnit" price="${p.promotePrice}">
            <div class="productUnitFrame">
	            <a href="foreproduct?product.id=${p.id}">
	                <img class="productImage" src="img/productSingle/${p.firstProductImage.id}.jpg">
	            </a>
	            <span class="productPrice">¥<fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/></span>
	            <a class="productLink" href="foreproduct?product.id=${p.id}">
	             ${fn:substring(p.name, 0, 50)}
	            </a>
	             
	            <div class="show1 productInfo">
	                <span class="monthDeal ">成交 <span class="productDealNumber">${p.saleCount}笔</span></span>
	                <span class="productReview" style="border-right: none">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
	            </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty products}">
        <div class="noMatch">没有满足条件的产品<div>
    </c:if>
     
        <div style="clear:both"></div>
</div>