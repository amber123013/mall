<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%>


<link href="css/fore/demo.css" rel="stylesheet" type="text/css" />
<script>
    var t1;
	function tocart(){
		window.location.href='forecart';
	};
	function hideFavoriteBox() {
		$(".ibar_favorite_box").css("display", "none");
	}
	function showFavoriteBox() {
		//如果未显示 提示 面板 则显示 并在一定时间后关闭
		if("none" == $(".ibar_favorite_box").css("display")) {
			/* $(".ibar_favorite_box").css("left", "-327px"); */
			$(".ibar_favorite_box").css("display", "block");
			// 4 秒后关闭弹出的提示框
			t1 = setTimeout(hideFavoriteBox, 4000);
		} else {
			//已经在显示的话 则 刷新 显示时间
			//清除定时器 并重新设置
			clearTimeout(t1);
			t1 = setTimeout(hideFavoriteBox, 4000);
		}
	}

</script>
<div class=tip>
	<div id="sidebar">
		<div id="wrap">
			<div id="prof" class="item ">
				<a href="personalindex"> <span class="setting "></span>
				</a>
				<div class="ibar_login_box status_login ">
					<c:if test="${!empty user}">
						<div class="avatar_box ">
							<p class="avatar_imgbox ">
								<img src="img/site/defaultImg1.jpg"  width="100"/>
							</p>
							<ul class="user_info ">
								<li>用户名：${user.name}</li>
								<li>级&nbsp;别：普通会员</li>
							</ul>
						</div>
						<div class="login_btnbox ">
							<a href="forebought" class="login_order ">我的订单</a> 
							<a href="# " class="login_favorite ">我的收藏</a>
						</div>
						<i class="icon_arrow_white "></i>
					</c:if>
					
					<c:if test="${empty user}">
						<div class="avatar_box ">
							<p class="avatar_imgbox ">
								<img src="img/site/akari.jpg" width="100"/>
							</p>
							<ul class="user_info ">
                                <li style="color:red;">还没有登录呢</li>
                                <li>先登录吧</li>
                            </ul>
						</div>
						<div class="login_btnbox ">
							<a href="login.jsp" class="login_order " >登录</a> 
							<a href="register.jsp" class="login_favorite ">注册</a>
						</div>
					</c:if>
				</div>

			</div>
			<div id="shopCart " class="item " onclick="tocart()")>
				<a href="#"> <span class="message "></span>
				</a>
				<p>购物车</p>
				<p class="cart_num ">${cartTotalItemNumber}</p>
			</div>
			<div id="brand " class="item ">
                <a href="personalfavorite">
                    <span class="wdsc "><img src="img/site/wdsc.png "></span>
                </a>
                <div class="mp_tooltip " style="left: -121px; visibility: hidden;">
                                                                                 我的收藏
                    <i class="glyphicon glyphicon-chevron-right"></i>
                </div>
            </div>
            <div class="ibar_favorite_box status_login " style="left: -267px;">
                <i class="glyphicon glyphicon-chevron-right"></i>
                <div class="bar-close glyphicon glyphicon-remove" onclick="hideFavoriteBox()"></div>
                <div class="bar-content-head">
                    <span class="bar-logo"></span><div class="success_info">成功加入收藏夹！</div>
                    <div class="content"> 您可以
	                    <a href="personalfavorite" target="_blank">查看收藏夹</a>
                    </div>
                 </div>
            </div>

			<div id="foot " class="item ">
				<a href="personalfoot"> <span class="zuji "></span>
				</a>
				<div class="mp_tooltip ">
					我的足迹 <i class="glyphicon glyphicon-chevron-right"></i>
				</div>
			</div>

			

			<div class="quick_toggle ">
				<li class="qtitem "><a href="# "><span class="kfzx "></span></a>
					<div class="mp_tooltip ">
						客服中心<i style="left:21px;" class="glyphicon glyphicon-chevron-right "></i>
					</div></li>
				<!--二维码 -->
				<li class="qtitem "><a href="#none "><span
						class="mpbtn_qrcode "></span></a>
					<div class="mp_qrcode " style="display: none;">
						<img src="../images/weixin_code_145.png " /><i
							class="icon_arrow_white "></i>
					</div></li>
				<li class="qtitem "><a href="javascript: scroll(0, 0) " class="return_top "><span
						class="top "></span></a></li>
			</div>

			<!--回到顶部 -->
			<div id="quick_links_pop " class="quick_links_pop hide "></div>

		</div>

	</div>
	<div id="prof-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>我</div>
	</div>
	<div id="shopCart-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>购物车</div>
	</div>
	<div id="asset-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>资产</div>

		<div class="ia-head-list ">
			<a href="# " target="_blank " class="pl ">
				<div class="num ">0</div>
				<div class="text ">优惠券</div>
			</a> <a href="# " target="_blank " class="pl ">
				<div class="num ">0</div>
				<div class="text ">红包</div>
			</a> <a href="# " target="_blank " class="pl money ">
				<div class="num ">￥0</div>
				<div class="text ">余额</div>
			</a>
		</div>

	</div>
	<div id="foot-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>足迹</div>
	</div>
	<div id="brand-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>收藏</div>
	</div>
	<div id="broadcast-content " class="nav-content ">
		<div class="nav-con-close ">
			<i class="am-icon-angle-right am-icon-fw "></i>
		</div>
		<div>充值</div>
	</div>
</div>
<script type="text/javascript " src="js/quick_links.js "></script>
