<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%>


<link href="css/fore/demo.css" rel="stylesheet" type="text/css" />
<script>
	function tocart(){
		window.location.href='forecart';
	};

</script>
<div class=tip>
	<div id="sidebar">
		<div id="wrap">
			<div id="prof" class="item ">
				<a href="# "> <span class="setting "></span>
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
							<a href="# " class="login_order ">我的订单</a> 
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
			<div id="asset " class="item ">
				<a href="# "> <span class="view "></span>
				</a>
				<div class="mp_tooltip ">
					我的资产 <i class="glyphicon glyphicon-chevron-right"></i>
				</div>
			</div>

			<div id="foot " class="item ">
				<a href="# "> <span class="zuji "></span>
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
				<li class="qtitem "><a href="#top " class="return_top "><span
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
