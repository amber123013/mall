<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<title>在线食品商城</title>
 
<div class="homepageDiv">
    <div class="categoryContent">
        <%@include file="categoryAndcarousel.jsp"%>
        <div class="recommend">
		     <div class="row">
	             <li class="hover"><a><img src="img/site/row1.jpg"></a></li>
	             <li class=""><a><img src="img/site/row2.jpg"></a></li>
	             <li class=""><a><img src="img/site/row3.jpg"></a></li>
	         </div>
	    </div>
    </div>
    <%@include file="homepageCategoryProducts.jsp"%>
</div>