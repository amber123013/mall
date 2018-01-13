<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>个人中心</title>
    <div class="personalContent">
		<div class="m-baseinfo">
		    <a class="m-pic" href="information.html">
		        <img src="<%=request.getContextPath()%>/img/site/defaultImg1.jpg">
		    </a>
		    <div class="m-info">
		        <em class="s-name">${user.name}</em>
		        <div class="safeText"><a href="safety.html">账户安全:<em style="margin-left:20px ;">60</em>分</a>
		        </div>
		        <div class="m-address">
		            <a href="address.html" class="i-trigger">收货地址<i class="am-icon-angle-right" style="padding-left:5px ;"></i></a>
		        </div>
		    </div>
		</div>
		<div class="wallet">
			<div class="s-bar">
				<i class="s-icon"></i>食品商城
			</div>
			<p class="m-big squareS">
				<a href="#nowhere"> <i><img src="img/site/shopping.png"></i> <span
					class="m-title">能购物</span>
				</a>
			</p>
			<p class="m-big squareA">
				<a href="#nowhere"> <i><img src="img/site/safe.png"></i> <span
					class="m-title">够安全</span>
				</a>
			</p>
			<p class="m-big squareL">
				<a href="#nowhere"> <i><img src="img/site/profit.png"></i> <span
					class="m-title">很灵活</span>
				</a>
			</p>
		</div>
    </div> <!-- div.personalContent 的结束标签 -->

    <div class="personalContent">
		<div class="m-order">
			<div class="s-bar">
				<i class="s-icon"></i>我的订单 <a class="i-load-more-item-shadow"
					href="forebought">全部订单</a>
			</div>
			<c:forEach items="${orders}" var="o" varStatus="st">
			<c:if test="${st.count <= 4}">
			    <div class="orderContentBox">
	                <div class="orderContent">
	                    <div class="orderContentpic">
	                        <div class="imgBox">
	                            <a href="forebought"><img src="img/productSingle_small/${o.orderItems[0].product.firstProductImage.id}.jpg"></a>
	                        </div>
	                    </div>
	                    <div class="detailContent">
	                        <div class="orderID">
	                            <span class="time"><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	                        </div>
	                        <div class="orderID">
	                            <span class="num">共 ${fn:length(o.orderItems)} 件商品</span>
	                        </div>
	                    </div>
	                    <div class="state">
		                    <c:if test="${o.status=='waitConfirm' }">
		                                                                                       待收货
		                    </c:if>
		                    <c:if test="${o.status=='waitPay' }">
	                                                                                           待付款
	                        </c:if>
	                        <c:if test="${o.status=='waitDelivery' }">
	                                                                                           待发货
	                        </c:if>
	                        <c:if test="${o.status=='waitReview' }">
	                                                                                           待评价
	                        </c:if>
	                        <c:if test="${o.status=='finish' }">
	                                                                                           已完成
	                        </c:if>
	                    </div>
	                    <div class="price">
	                        <span class="sym">¥</span><fmt:formatNumber type="number" value="${o.total}" minFractionDigits="2"/>
	                    </div>
	    
	                </div>
	                <a href="foreproduct?product.id=${o.orderItems[0].product.id}" class="btnPay">再次购买</a>
	            </div>
	        </c:if>
			</c:forEach>
	
		</div>
	</div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 