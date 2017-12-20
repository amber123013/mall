<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
     
<div class="categoryMenu">
    <c:forEach items="${categorys}" var="c" varStatus="st">
        <c:if test="${st.count<=13}">
	        <div cid="${c.id}" class="eachCategory">
	            <span class="">
	             <i><img style="width: 22px;height: 22px;border-radius: 22px;" src="img/site/cookies.png"/></i>
	            </span>
	           
	            <a href="forecategory?category.id=${c.id}">
	                ${c.name}
	            </a>
	            <em>&gt;</em> 
	        </div>
        </c:if>
    </c:forEach>
</div>  