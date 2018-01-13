<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>安全设置</title>
    <div class="personalContent" style="min-height:606px">
        <div class="personalTitle">
            <strong>账户安全</strong> / <small>Set up Safety</small>
        </div>
        <hr/>
        <div class="check">
	        <ul>
	            <li>
	                <i class="i-safety-lock"></i>
	                <div class="m-left">
	                    <div class="fore1">登录密码</div>
	                    <div class="fore2"><small>为保证您购物安全，建议您定期更改密码以保护账户安全。</small></div>
	                </div>
	                <div class="fore3">
	                    <a href="personalpassword">
	                        <div class="am-btn am-btn-secondary">修改</div>
	                    </a>
	                </div>
	            </li>
	            <li style="margin-top: 35px">
                    <i class="i-safety-mail"></i>
                    <div class="m-left">
                        <div class="fore1">邮箱验证</div>
                        <c:if test="${empty user.email}">
                            <div class="fore2"><small>您还未绑定邮箱，绑定邮箱可以用于找回密码。</small></div>
                        </c:if>
                        <c:if test="${!empty user.email}">
                            <div class="fore2"><small>您验证的邮箱：${user.email} 可用于快速找回登录密码</small></div>
                        </c:if>
                    </div>
                    <div class="fore3">
                        <a href="personalemail">
                            <c:if test="${empty user.email}">
                                <div class="am-btn am-btn-secondary">绑定邮箱</div>
                            </c:if>
                            <c:if test="${!empty user.email}">
                                <div class="am-btn am-btn-secondary">换绑</div>
                             </c:if>
                        </a>
                    </div>
                </li>
                <div class="clear"></div>
	        </ul>
	    </div>
    </div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 