<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<c:if test="${empty param.categorycount}">
    <c:set var="categorycount" scope="page" value="100"/>
</c:if>
 
<c:if test="${!empty param.categorycount}">
    <c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>
 
<div class="homepageCategoryProducts">
        <!-- 该分类下无产品的话不显示该分类 -->
    <c:forEach items="${categorys}" var="c" varStatus="stc">
        <c:if test="${c.products.size() > 0}">
	        <c:if test="${stc.count<=categorycount}">
	            <div class="eachHomepageCategoryProducts">
	                <div class="shopTitle">
		                <div class="left-mark"></div>
		                <span class="categoryTitle">${c.name}</span>
		                <em class="glyphicon glyphicon-chevron-left"></em>
		                <h3>每一件商品都来自于自然的馈赠。</h3>
	                </div>
	                <br>
	                <c:forEach items="${c.products}" var="p" varStatus="st">
	                    <c:if test="${st.count<=5}">
	                        <div class="productItem" >
	                            <a href="foreproduct?product.id=${p.id}"><img width="100px" src="img/productSingle_middle/${p.firstProductImage.id}.jpg"></a>
	                            <a class="productItemDescLink" href="foreproduct?product.id=${p.id}">
	                                <span class="productItemDesc">
	                                ${fn:substring(p.name, 0, 20)}
	                                </span>
	                            </a>
	                            <span class="productPrice">
	                                <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
	                            </span>
	                        </div>
	                    </c:if>               
	                </c:forEach>
	              
	                <div style="clear:both"></div>
	            </div>
	        </c:if>
        </c:if>
    </c:forEach>
     
    <!-- <img id="endpng" class="endpng" src="img/site/end.png"> -->

</div>