<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- 根据用户是否登录，决定是否显示退出按钮，或者登录注册按钮，以及购物车中的商品数量 -->
<nav class="top ">
    <div class="top_middle">
     
        <a href="${contextPath}">
            <span style="color:#FF0036;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
            商城首页
        </a>  
         
        <span>欢迎来到食品商城</span>
         <!-- el表达式可以直接获取到session中的内容 -->
 
        <span class="pull-right">
	        <c:if test="${!empty user}">
	            <a href="login.jsp" style="color:#ff4040;">Hi,${user.name}</a>
	            <a href="forelogout">退出</a>     
	        </c:if>
	         
	        <c:if test="${empty user}">
	            <a href="login.jsp" style="color:#ff4040;">Hi,请 登录</a>
	            <a href="register.jsp"  id="register">注册</a>     
	        </c:if>
            <a href="forebought">我的订单</a>
            <a href="forecart">
            <span style="color:#FF0036;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
            购物车<strong>${cartTotalItemNumber}</strong>件</a>       
        </span>
    </div>
</nav>