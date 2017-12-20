<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
 
<script>
$(function(){
     
    <c:if test="${!empty msg}">
        $("span.errorMessage").html("${msg}");
        $("div.registerErrorMessageDiv").css("visibility","visible");       
    </c:if>
     
    $(".registerForm").submit(function(){  
        if(0==$("#name").val().length){
            $("span.errorMessage").html("请输入用户名");
            $("div.registerErrorMessageDiv").css("visibility","visible");           
            return false;
        }       
        if(0==$("#password").val().length){
            $("span.errorMessage").html("请输入密码");
            $("div.registerErrorMessageDiv").css("visibility","visible");           
            return false;
        }       
        if(0==$("#repeatpassword").val().length){
            $("span.errorMessage").html("请输入重复密码");
            $("div.registerErrorMessageDiv").css("visibility","visible");           
            return false;
        }       
        if($("#password").val() !=$("#repeatpassword").val()){
            $("span.errorMessage").html("重复密码不一致");
            $("div.registerErrorMessageDiv").css("visibility","visible");           
            return false;
        }       
 
        return true;
    });
})
</script>
<div id="registerDivOut">
    <div class="loginboxtitle">
            <a href="${contextPath}"><img alt="logo" height="60%" src="img/site/logo4.png"></a>
    </div>
    <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/big.jpg">
	<form method="post" action="foreregister" class="registerForm"> 
		<div class="registerDiv">
		    <div class="registerErrorMessageDiv">
		        <div class="alert alert-danger" role="alert">
		          <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
		            <span class="errorMessage"></span>
		        </div>        
		    </div>
		    <div class="login_acount_text">账户注册</div>
            <!-- 用户名 -->
            <div class="registerInput " >
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-user"></span>
                </span>
                <input id="name" name="user.name" placeholder="手机/会员名/邮箱" type="text">            
            </div>
            <div class="registerInput " >
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-lock"></span>
                </span>
                <input id="password" name="user.password" type="password" placeholder="密码" type="text">
            </div>
            <div class="registerInput " >
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-lock"></span>
                </span>
                <input id="repeatpassword" type="password" placeholder="确认密码" type="text">
            </div>
            <div style="margin-top:20px">
                <button class="btn btn-block blueButton" type="submit">注册</button>
            </div>
		</div>
	</form>
</div>