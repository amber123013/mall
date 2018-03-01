<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>我的订单</title>
<!-- 这里是订单页 --> 
<script>
var deleteOrder = false;
var deleteOrderid = 0;
 
$(function(){
    $("a[orderStatus]").click(function(){
        var orderStatus = $(this).attr("orderStatus");
        if('all'==orderStatus){
            $("table[orderStatus]").show(); 
        }
        else{
            $("table[orderStatus]").hide();
            $("table[orderStatus="+orderStatus+"]").show();         
        }
         
        $("div.orderType div").removeClass("selectedOrderType");
        $(this).parent("div").addClass("selectedOrderType");
    });
     
    $("a.deleteOrderLink").click(function(){
        deleteOrderid = $(this).attr("oid");
        deleteOrder = false;
        $("#deleteConfirmModal").modal("show");
    });
     
    $("button.deleteConfirmButton").click(function(){
        deleteOrder = true;
        $("#deleteConfirmModal").modal('hide');
    }); 
     
    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
        if(deleteOrder){
            var page="foredeleteOrder";
            $.post(
                    page,
                    {"order.id":deleteOrderid},
                    function(result){
                        if("success"==result){
                            $("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
                        }
                        else{
                            location.href="login.jsp";
                        }
                    }
                );
             
        }
    })      
     
    $(".ask2delivery").click(function(){
        var link = $(this).attr("link");
        $(this).hide();
        page = link;
        $.ajax({
               url: page,
               success: function(result){
                alert("卖家已秒发，刷新当前页面，即可进行确认收货")
               }
            });
         
    });
});
 
</script>
     
<div class="boughtDiv">
    <div class="orderType">
        <!--这里的链接只是show 与链接项相同的订单状态 的order  -->
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
        <div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
        <div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
        <div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
        <div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </table>
     
    </div>
     
    <div class="orderListItem">
        <c:forEach items="${orders}" var="o">
            <table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                    <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b> 
                    <span>订单号: ${o.orderCode} 
                    </span>
                    </td>
                    <td  colspan="2"></td>
                    <td colspan="1">
                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
                            <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                         
                    </td>
                </tr>
                <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
                    <tr class="orderItemProductInfoPartTR" >
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?product.id=${oi.product.id}">${oi.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                            <img src="img/site/creditcard.png" title="支持信用卡支付">
                                            <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                            <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">                       
                                </div>
                            </div>
                        </td>
                        <td  class="orderItemProductInfoPartTD" width="100px">
                         
                            <div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></div>
                            <div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></div>
         
                        </td>
                        <c:if test="${st.count==1}">
                          
                            <td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <span class="orderListItemNumber">${o.totalNumber}</span>
                            </td>
                            <td valign="top" rowspan="${fn:length(o.orderItems)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                                <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/></div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <c:if test="${o.status!='waitReview'}">
	                            <td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
	                                <c:if test="${o.status=='waitConfirm' }">
	                                    <a href="foreconfirmPay?order.id=${o.id}">
	                                        <button class="orderListItemConfirm">确认收货</button>
	                                    </a>
	                                </c:if>
	                                <c:if test="${o.status=='waitPay' }">
	                                    <a href="forealipay?order.id=${o.id}&total=${o.total}">
	                                        <button class="orderListItemConfirm">付款</button>
	                                    </a>                              
	                                </c:if>
	                                 
	                                <c:if test="${o.status=='waitDelivery' }">
	                                    <span>待发货</span>
	                                     <br/>
	                                     <button style="margin-top:5px" class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?order.id=${o.id}">催卖家发货</button>
	                                     
	                                </c:if>
	 
	                                <c:if test="${o.status=='waitReview' }">
	                                 <td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
	                                    <a href="forereview?order.id=${o.id}">
	                                        <button  class="orderListItemReview">评价</button>
	                                    </a>
	                                
	                                </c:if>
	                                <c:if test="${o.status=='finish' }">
                                        <a href="#nowwhere">
                                            <button  class="btn success-btn" disabled="disabled">订单完成</button>
                                        </a>
                                    </c:if>
	                            </td>
                            </c:if>
                        </c:if>
                        <!-- 每个订单项 需要单独进行评论 且所有 订单项都完成评论时 才将 order状态置为 finish -->
                        <c:if test="${o.status=='waitReview'}">
	                        <c:if test="${oi.review == null}">
		                        <td>
		                            <a href="forereview?order.id=${o.id}&reviewNumber=${st.count - 1}">
		                                <button  class="orderListItemReview">评价</button>
		                            </a>
		                        </td>
	                        </c:if>
	                        <c:if test="${oi.review != null}">
	                            <td></td>
	                        </c:if>
	                    </c:if>                     
                    </tr>
                </c:forEach>      
                 
            </table>
        </c:forEach>
         
    </div>
    <c:if test="${empty orders}">
      <div class="empty">
          <div class="pic"></div>
          <div class="tips">您还没有下过订单！</div>
      </div>
    </c:if>
</div>