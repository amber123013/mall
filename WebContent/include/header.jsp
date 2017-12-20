<!DOCTYPE html>
<!-- 本页面的中文文字采用UTF-8编码，启动EL表达式  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<!-- c通常用于条件判断和遍历
     fmt用于格式化日期和货币
     fn用于校验长度 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
 
<head>
    <!-- 引入bootstrap和jquery -->
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="shortcut icon" href="img/site/favicon.ico" mce_href="img/site/favicon.ico" type="image/x-icon" /> 
    <!-- 自定义前端样式 -->
    <link href="css/fore/style.css" rel="stylesheet">
	<script>
		function formatMoney(num){
		    num = num.toString().replace(/\$|\,/g,'');  
		    if(isNaN(num))  
		        num = "0";  
		    sign = (num == (num = Math.abs(num)));  
		    num = Math.floor(num*100+0.50000000001);  
		    cents = num%100;  
		    num = Math.floor(num/100).toString();  
		    if(cents<10)  
		    cents = "0" + cents;  
		    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
		    num = num.substring(0,num.length-(4*i+3))+','+  
		    num.substring(num.length-(4*i+3));  
		    return (((sign)?'':'-') + num + '.' + cents);  
		}
		function checkEmpty(id, name){
		    var value = $("#"+id).val();
		    if(value.length==0){
		         
		        $("#"+id)[0].focus();
		        return false;
		    }
		    return true;
		}
		 
		$(function(){
			  /* 产品页  产品详情与评论两个div之间的相互切换 */
		    $("a.productDetailTopReviewLink").click(function(){
		        $("div.productReviewDiv").show();
		        $("div.productDetailDiv").hide();
		    });
		    $("a.productReviewTopPartSelectedLink").click(function(){
		        $("div.productReviewDiv").hide();
		        $("div.productDetailDiv").show();       
		    });
		     
		    $("span.leaveMessageTextareaSpan").hide();
		    $("img.leaveMessageImg").click(function(){
		         
		        $(this).hide();
		        $("span.leaveMessageTextareaSpan").show();
		        $("div.orderItemSumDiv").css("height","100px");
		    });
		    $("a.notImplementLink").click(function(){
		        alert("这个功能未完成");
		    });
		     
		});
	 
	</script> 
</head>
 
<body>