<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<script>
$(function(){
	var date = new Date();
	/* 四天后 */
	date.setDate(date.getDate() + 4); 
	var month = date.getMonth() + 1;
	var day = date.getDate();
	$("#arriveDate").html("预计" + month + "月"+ day +"日送达");
});
</script>
<div class="payedDiv">
    <div class="payedTextDiv">
        <img src="img/site/paySuccess.png">
        <span>您已成功付款</span> 
         
    </div>
    <div class="payedAddressInfo">
        <ul>
            <li>收货地址：${order.address} ${order.receiver} ${order.mobile }</li>
            <li>实付款：<span class="payedInfoPrice">
            ￥<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/>
            </li>
            <li id="arriveDate">预计08月08日送达    </li>
        </ul>
                 
        <div class="paedCheckLinkDiv">
            您可以
            <a class="payedCheckLink" href="forebought">查看已买到的宝贝</a>
            <a class="payedCheckLink" href="forebought">查看交易详情 </a>
        </div>
             
    </div>
     
    <div class="payedSeperateLine">
    </div>
     
    <div class="warningDiv">
        <img src="img/site/warning.png">
        <b>安全提醒：</b>下单后，<span class="redColor boldWord">用QQ给您发送链接办理退款的都是骗子！</span>
    </div>
 
</div>