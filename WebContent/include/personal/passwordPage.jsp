<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>修改密码</title>
<script>
    function submitCheck() {
    	if('' == $("#user-old-password").val()) {
    		warningInfo("请输入原始密码！");
    		return false;
    	} else if('' == $("#user-new-password").val()) {
    		warningInfo("请输入新密码！");
            return false;
    	} else if('' == $("#user-confirm-password").val()) {
    		warningInfo("请输入确认密码！");
            return false;
    	}else if($("#user-new-password").val() != $("#user-confirm-password").val()) {
    		warningInfo("确认密码不一致");
    		return false;
    	}
    	var password = $("#user-old-password").val();
    	var page = "personalcheckPassword"
    	$.get(
                page,
                {"user.password":password},
                function(result){
                    if("fail" == result) {
                    	warningInfo("密码错误！请重新输入！");
                    	return false;
                    } else {
                    	if($("#user-old-password").val() == $("#user-new-password").val()) {
                            warningInfo("新密码不能与原密码相同！");
                            return false;
                        } else {
                        	$("#updatePasswordForm").submit();
                        }
                    }
                }
        );
    }
</script>
    <div class="personalContent" style="min-height:606px">
        <div class="personalTitle">
            <strong>修改密码</strong> / <small>Password</small>
        </div>
        <hr/>
        <div class="m-progress">
	        <div class="m-progress-list">
	            <span class="step-1 step">
	                <em class="u-progress-stage-bg"></em>
	                <i class="u-stage-icon-inner">1<em class="bg"></em></i>
	                <p class="stage-name">重置密码</p>
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
        <form id="updatePasswordForm" class="am-form am-form-horizontal" action="personalupdatePassword">
             <div class="am-form-group">
                 <label for="user-old-password" class="am-form-label">原密码</label>
                 <div class="am-form-content">
                     <input type="password" id="user-old-password" name="user.password" placeholder="请输入原登录密码">
                 </div>
             </div>
             <div class="am-form-group">
                 <label for="user-new-password" class="am-form-label" >新密码</label>
                 <div class="am-form-content">
                     <input type="password" id="user-new-password" name="user.newPassword" placeholder="由数字、字母组合">
                 </div>
             </div>
             <div class="am-form-group">
                 <label for="user-confirm-password" class="am-form-label">确认密码</label>
                 <div class="am-form-content">
                     <input type="password" id="user-confirm-password" placeholder="请再次输入上面的密码">
                 </div>
             </div>
             <div class="info-btn">
                 <div class="am-btn am-btn-danger" onclick="submitCheck();">保存修改</div>
             </div>

         </form>
    </div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 