<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>验证邮箱</title>
<script>
    var email;
    function submitCheck() {
    	var code = $("#user-code").val();
    	var reg = /^\d{6}$/; 
    	if('' == code) {
    		warningInfo("请输入验证码！");
    		return false;
    	} else if(!reg.test(code)) {
    		warningInfo("验证码格式不正确！");
            return false;
    	}
    	/* 检查验证码是否正确 */
    	$.get(
            "personalcheckCode",
            {"verificationCode":code},
            function(result){
                if("fail" == result) {
                	warningInfo("验证码错误！请重新输入！");
                	return false;
                }
                if("success" == result) {
                	$("#user-email").val(email);
                    // 验证成功  提交绑定邮箱
                	$("#updateEmailForm").submit();
                }
            }
        );
    }
    /* 将验证码发送到邮箱 */
    function sendVerificationCode(click) {
    	 email = $("#user-email").val();
    	 var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
    	 var page = "personalsendVerificationCode";
    	 if(!reg.test(email)) {
    		 warningInfo("邮箱格式不正确！");
    		 return false;
    	 }
    	 // 先向后台查询此邮箱 是否 被其他用户使用
    	 $.get(
                 "personalcheckEmail",
                 {"user.email":$("#user-email").val()},
                 function(result){
                     if("success" == result) {
                         infoInfo("此邮箱未被其他用户绑定，可以使用！");
                         /* 发送验证码 */
                         $.get(
                                 page,
                                 {"user.email":$("#user-email").val()},
                                 function(result){
                                     if("success" == result) {
                                         infoInfo("已成功发送邮件，请到邮箱接收！");
                                         //设置按钮不可点击
                                         $("#sendMobileCode").attr("disabled","disabled");
                                         $("#sendMobileCode .am-btn-danger").css("cursor","not-allowed");
                                     } else {
                                         infoInfo("邮件发送失败， 稍后再来试试吧！");
                                     }
                                 }
                         );
                     } else {
                         infoInfo("此邮箱已被其他用户绑定，请更换邮箱或解除绑定！");
                         return false;
                     }
                 }
         );
    }
</script>
    <div class="personalContent" style="min-height:606px">
        <div class="personalTitle">
            <strong>绑定邮箱</strong> / <small>Email</small>
        </div>
        <hr/>
        <div class="m-progress">
	        <div class="m-progress-list">
	            <span class="step-1 step">
	                <em class="u-progress-stage-bg"></em>
	                <i class="u-stage-icon-inner">1<em class="bg"></em></i>
	                <p class="stage-name">验证邮箱</p>
	            </span>
	            <span class="step-2 step">
	                <em class="u-progress-stage-bg"></em>
	                <i class="u-stage-icon-inner">2<em class="bg"></em></i>
	                <p class="stage-name">完成</p>
	            </span>
	            <span class="u-progress-placeholder"></span>
	        </div>
	        <div class="u-progress-bar total-steps-2">
	            <div class="u-progress-bar-inner"></div>
	        </div>
	    </div>
        <form id="updateEmailForm" class="am-form am-form-horizontal" action="personalupdateEmail">
             <div class="am-form-group">
                 <label for="user-email" class="am-form-label">验证邮箱</label>
                 <div class="am-form-content">
                     <input type="email" id="user-email" name="user.email" placeholder="请输入邮箱地址">
                 </div>
             </div>
             <div class="am-form-group code">
                 <label for="user-code" class="am-form-label">验证码</label>
                 <div class="am-form-content">
                     <input type="tel" name="code" id="user-code" placeholder="输入获得的6位验证码">
                 </div>
                 <a class="btn" href="javascript:void(0);" onclick="sendVerificationCode(this)" id="sendMobileCode">
                     <div class="am-btn am-btn-danger">获取验证码</div>
                 </a>
             </div>
             <div class="info-btn">
                 <div class="am-btn am-btn-danger" onclick="submitCheck();">保存修改</div>
             </div>

         </form>
    </div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 