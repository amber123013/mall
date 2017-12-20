<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆系统</title>
<style>
	body{
		background-color: #F5F8FA;
		background-size:100%;
	}
	h2{
		font-weight: 400;
		font-size: 20px;
	}
	.admin_login{
		background-color: #FFFFFF;
		width: 405px;
		height:410px;
		margin:5% auto;
		text-align: right;
	}
	.admin_login dt{
		margin: 20px;
    	padding: 20px 0 5px 0;
    	text-align: center;
    	color: #222;
    	font-weight: 400;
    	font-size: 20px;
	}
	.admin_login dd{
		height:50px;
		width: 325px;
		margin-top: 15px;
		margin-bottom: 15px;
		padding: 5px;
		position:relative;
	}
	.admin_login dd .login_txtbx{
		font-size:14px;
		height:50px;
		width: 325px;
		line-height:50px;
		text-indent:2em;
		background:white;
		border: 1px solid #D9D9D9; 
	}
	.admin_login dd .login_txtbx::-webkit-input-placeholder {
		background-color: white;
		line-height:inherit;
	} 
	.admin_login dd .submit_btn{
		width:100%;
		height:50px;
		font-size:16px;
		background:#387EE8;
		color:white;
		border:none;
	}
	.admin_login label{
		font-size: 12px;
		margin-right: 35px;
		margin-bottom: 10px;
		text-align: right;
	}
	.registerOrmiss .register{
		font-size: 12px;
		margin-left: 48px;
		/*margin-bottom: 10px;*/

	}
	.registerOrmiss .miss{
		font-size: 12px;
		margin-right: 35px;
		float:right;
	}
	a{
		text-decoration: none;
	}
</style>
<script type="text/javascript">
	function aclick(par) {
		alert("请联系 系统管理员")
	}
	window.onload = function() {
		document.getElementById("username").focus();
	}
</script>
</head>
<body>
	<form method="post" action="admin_admin_login">
		<dl class="admin_login">

			<dt>
	  			<h2>登陆后台</h2>
 			</dt>
			<dd class="user_icon">
				<input type="text" id="username"  name="admin.name" placeholder="账号" class="login_txtbx"  required/>
			</dd>
			<dd class="pwd_icon">
				<input type="password" name="admin.password" placeholder="密码" class="login_txtbx" required/>
			</dd>
			<label for="remember-me">
				<input style="vertical-align: middle;" name="adminAutoLogin" value="enable" id="remember-me" type="checkbox"/> 15天免登陆
			</label>
			<dd>
				<input type="submit" value="立即登陆" class="submit_btn" />
			</dd>
			<div class="registerOrmiss" style="text-align: left">
				<span class="register">还没有账号？<a href="#" onclick="aclick(this)">注册</a></span>
				<span class="miss"><a href="#" onclick="aclick(this)">忘记密码？</a></span>
			</div>

		</dl>
	</form>
</body>
</html>