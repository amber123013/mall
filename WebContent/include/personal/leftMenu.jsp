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
    <script src="<%=request.getContextPath()%>/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="<%=request.getContextPath()%>/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link rel="shortcut icon" href="../img/site/favicon.ico" mce_href="img/site/favicon.ico" type="image/x-icon" /> 
    <!-- 自定义前端样式 -->
    <link href="<%=request.getContextPath()%>/css/fore/style.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/fore/personal.css" rel="stylesheet">
    <!-- 提示框 -->
    <script src="<%=request.getContextPath()%>/js/toastr/toastr.min.js"></script>
    <link href="<%=request.getContextPath()%>/css/toastr/toastr.css" rel="stylesheet">
</head>
 
<body>
    <script type="text/javascript">
        $(function(){
		    //参数设置，若用默认值可以省略以下面代
			toastr.options = {
				"closeButton" : false, //是否显示关闭按钮
				"debug" : false, //是否使用debug模式
				"positionClass" : "toast-top-right",//弹出窗的位置
				"showDuration" : "300",//显示的动画时间
				"hideDuration" : "300",//消失的动画时间
				"timeOut" : "1500", //展现时间
				"showEasing" : "swing",//显示时的动画缓冲方式
				"hideEasing" : "linear",//消失时的动画缓冲方式
				"showMethod" : "fadeIn",//显示时的动画方式
				"hideMethod" : "fadeOut" //消失时的动画方式
			};
			//成功提示绑定
			$("#success").click(function() {
				/* toastr.success("祝贺你成功了");
				toastr.error
				toastr.warning
				toastr.info */
			})
		});
        function successInfo(message) {
        	toastr.success(message);
        }
        function errorInfo(message) {
            toastr.success(message);
        }
        function warningInfo(message) {
            toastr.warning(message);
        }
        function infoInfo(message) {
            toastr.info(message);
        }
	</script>
    <%@include file="../../include/top.jsp"%>
    <%@include file="../../include/search.jsp"%>
    <%@include file="../../include/side.jsp"%>
	<div class="center">
	    
	    <aside class="menu">
	    <ul>
	        <li class="person active">
	            <a href="personalindex"></i>个人中心</a>
	        </li>
	        <li class="person">
	            <p><i class="glyphicon glyphicon-tasks"></i>个人资料</p>
	            <ul>
	                <li> <a href="personalindex">个人信息</a></li>
	                <li> <a href="personalsafety">安全设置</a></li>
	                <li> <a href="personaladdress">地址管理</a></li>
	                <li> <a href="#personalcardlist" class="undo"  onclick="return false" title="此功能暂未开放">快捷支付</a></li>
	            </ul>
	        </li>
	        <li class="person">
	            <p><i class="glyphicon glyphicon-globe"></i>我的交易</p>
	            <ul>
	                <li><a href="forebought">订单管理</a></li>
	                <li> <a href="change.html" class="undo" onclick="return false" title="此功能暂未开放">退款售后</a></li>
	                <li> <a href="comment.html" class="undo" onclick="return false" title="此功能暂未开放">评价商品</a></li>
	            </ul>
	        </li>
	
	        <li class="person">
	            <p><i class="glyphicon glyphicon-briefcase"></i>我的收藏</p>
	            <ul>
	                <li> <a href="personalfavorite ">收藏</a></li>
	                <li> <a href="personalfoot">足迹</a></li>                                                        
	            </ul>
	        </li>
	
	        <li class="person">
	            <p><i class="glyphicon glyphicon-leaf"></i>在线客服</p>
	            <ul>
	                <li> <a href="consultation.html" class="undo" onclick="return false" title="此功能暂未开放">商品咨询</a></li>
	                <li> <a href="suggest.html" class="undo" onclick="return false" title="此功能暂未开放">意见反馈</a></li>                           
	                
	                <li> <a href="news.html" class="undo" onclick="return false" title="此功能暂未开放">我的消息</a></li>
	            </ul>
	        </li>
	    </ul>
	    </aside>
        <div class="col-main">
