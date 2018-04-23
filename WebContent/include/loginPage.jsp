<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<script>
$(function(){
    <c:if test="${!empty msg}">
	    $("span.errorMessage").html("${msg}");
	    $("div.loginErrorMessageDiv").show();       
    </c:if>
     
    $("form.loginForm").submit(function(){
        if(0==$("#name").val().length||0==$("#password").val().length){
            $("span.errorMessage").html("请输入账号密码");
            $("div.loginErrorMessageDiv").show();           
            return false;
        }
        return true;
    });
     
    $("form.loginForm input").keyup(function(){
        $("div.loginErrorMessageDiv").hide();   
    });
     
    var left = window.innerWidth/2+162;
    $("div.loginSmallDiv").css("left",left);
});
function forget() {
	if(0==$("#name").val().length){
        $("span.errorMessage").html("请输入账号");
        $("div.loginErrorMessageDiv").show();           
        return false;
    }
	var name = $("#name").val();
	$.get(
        "forecheckNameAndEmail",
        {"user.name":name},
        function(result){
            if("fail" == result) {
            	$("span.errorMessage").html("无此账号或未绑定邮箱！");
                $("div.loginErrorMessageDiv").show();           
                return false;
            } else {
            	$("#forget").removeAttr('onclick');
            	$("#forget").css("cursor", "not-allowed");
            	$.get(
           	        "foreforgetPassword",
           	        {"user.name":name},
           	        function(result){
           	        	if("success" == result) {
           	        		$("span.errorMessage").html("密码已发送到绑定邮箱！");
           	                $("div.loginErrorMessageDiv").show();           
           	        	} else {
           	        		$("span.errorMessage").html("密码发送失败！");
                            $("div.loginErrorMessageDiv").show();           
           	        	}
           	        }
           	    )
            }
        }
	)
}
</script>

<div id="loginDiv" style="position: relative">
    <div class="loginboxtitle">
            <a href="${contextPath}"><img alt="logo" height="60%" src="img/site/logo4.png"></a>
    </div>
    <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/big.jpg">
     
    <form class="loginForm" action="forelogin" method="post">
        <div id="loginSmallDiv" class="loginSmallDiv">
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger" >
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="errorMessage"></span>
                </div>
            </div>
                 
            <div class="login_acount_text">账户登录</div>
            <div class="loginInput " >
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-user"></span>
                </span>
                <input id="name" name="user.name" placeholder="手机/会员名/邮箱" type="text">            
            </div>
             
            <div class="loginInput " >
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-lock"></span>
                </span>
                <input id="password" name="user.password" type="password" placeholder="密码" type="text">
            </div>
             
            <div>
				<label for="remember-me"> 
				<input	style="vertical-align: middle;margin:0px;" name="userAutoLogin"
					value="enable" id="remember-me" type="checkbox" /> 15天免登陆
				</label> 
				<a href="register.jsp" class="pull-right">注册</a>
				<a id="forget" href="#" onclick="forget()" class="pull-right" style="padding-right:10px">忘记密码</a> 
            </div>
            <div style="margin-top:20px">
                <button class="btn btn-block blueButton" type="submit">登录</button>
            </div>
        </div>    
    </form>
 
</div>