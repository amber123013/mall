<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<style>
	nav>.btn-group>li>a{
	    float: left;
	    height: 50px;
	    padding: 15px 15px;
	    font-size: 18px;
	    line-height: 20px;
	}
	.nav-right{
	    border: 1px solid #d53;
	    margin-top: 10px;
	    padding: 4px 8px;
	    color: #ccc;
	    background: none;
	    border-radius: 5px;
	}
	.navbar-inverse .navbar-toggle{
	    padding: 5px 10px;
	    border-color: red;
	    color: #ccc;
	    margin-top: 10px;
	} 
</style>
<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <div class="btn-group pull-right">
                    <button data-toggle="dropdown" class="navbar-toggle" aria-haspopup="true" >
                        <span class="glyphicon glyphicon-user"></span>&nbsp;
                        <span>${admin.name}</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a href="#">用户管理</a></li>
                        <li><a href="#">修改密码</a></li>
                        <li><a href="admin_admin_logout">安全退出</a></li>
                    </ul>
                </div>
                <button class="navbar-toggle" data-toggle="collapse" data-target="#aaa">
                    <span class="glyphicon glyphicon-align-justify"></span>
                </button>
                
                <a href="#" class="navbar-brand">购物商城后台</a>
            </div>
            <div class="collapse navbar-collapse" id="aaa">
                <ul class="nav navbar-nav">
                    <li><a href="/">首页</a></li>
                    <li><a href="admin_category_list">分类管理</a></li>
                    <li><a href="admin_user_list">用户管理</a></li>
                    <li><a href="admin_order_list">订单管理</a></li>
                    <li><a href="#">地址管理</a></li>
                </ul>
                <div class="btn-group pull-right hidden-xs">
                    <button data-toggle="dropdown" class="nav-right" aria-haspopup="true" >
                        <span class="glyphicon glyphicon-user"></span>&nbsp;
                        <span>${admin.name}</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a href="#">用户管理</a></li>
                        <li><a href="#">修改密码</a></li>
                        <li><a href="admin_admin_logout">安全退出</a></li>
                    </ul>
                </div>
            </div>
            
        </div>
    </nav>
