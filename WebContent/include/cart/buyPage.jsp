<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>结算页</title>
<script>

$(function(){
	var total = ${total}
	/* 文档加载完成时载入收货地址 */
	ajaxgetAddress();
	$("#addAddress").click(function(){
		$("#addressModal").modal('show');
	});
	/* 使用ajax 提交地址 */
	$("#addAddressForm").submit(function(){
		var formParam = $("#addAddressForm").serialize();//序列化表格内容为字符串  
		$.ajax({ 
	        type:'post',
	        url:'foreaddaddress',  
	        data:formParam,  
	        success:function(data){
	        	if("success" == data) {
	        		$("#addressModal").modal('hide');
	        		/* 清空表单 */
	        		$("#addAddressForm").get(0).reset();
	        		/* 从服务器获取收货地址信息 */
	        		ajaxgetAddress();
	        	}
	        }  
		});
	return false;
	});
	/* 提交收货地址  用于创建订单 */
	$("#forecreateOrder").submit(function(){
		var page = "foreAjaxcreateOrder";
		var address = $(".defaultAddr .default-address span").text();
		var userMessage = $(".leaveMessageTextarea").val();
		var post = $(".defaultAddr #post").text();
		var name = $(".defaultAddr #name").text();
		var phone = $(".defaultAddr #userPhone").text();
 	 	$.post(
			page,
			{"order.address":address,
			 "order.post":post,
			 "order.receiver":name,
			 "order.mobile":phone,
			 "order.userMessage":userMessage},
			 function(result){
				 window.location.href="forealipay?order.id=" + result.id + "&total="+total;
			 }
		);
 	 	return false;
	});
});
function ajaxgetAddress() {
	var page = "foreAjaxgetaddress"; 
	$.get(
         page,
         function(result){
             var str = "";
             for(var i=0; i<result.length;i++) {
                 if(result[i].isDefault == 1)
                     str += "<li class=\"user-addresslist defaultAddr\" onclick=\"addressSelected(this)\">";
                 else
                     str += "<li class=\"user-addresslist\" disabled=\"disabled\" onclick=\"addressSelected(this)\">";
	            str +=    "<div class=\"address-left\">" +
				"<div class=\"user\">" +
				"<span id=\"name\">" + result[i].userName + "</span>" + " "+"<span id=\"post\">"  + result[i].postCode +"</span>"+ "</div>" + "<div id=\"userPhone\">" + result[i].userPhone + 
				"</div>" +
				"<div class=\"default-address\">" +
				"收货地址："+ "<span>" + result[i].province+" "+result[i].city+" "+result[i].district+" "+result[i].address + "</span>" +
				"</div>" +
				"</div>" +
				"<div class=\"new-addr-btn\">" +
				"<a href=\"#\" class=\"hidden\">设为默认</a>" +
				"<span class=\"new-addr-bar hidden\">|</span>"  +
				"<a href=\"#\">编辑</a>"  +
				"<span class=\"new-addr-bar\">|</span>" + 
				"<a href=\"javascript:void(0);\" onclick=\"delClick(this);\">删除</a>" +
				"</div>" +
				"</li>";
            }
             $("#displayaddressul").html(str);
         }
    );  
}
function provinceChange(select) {
	if(select.value == -1) {
		$("#citys").css("visibility","hidden");
		$("#districts").css("visibility","hidden");
		return;
	}
    $("#citys").css("visibility","visible");
    $("#districts").css("visibility","hidden");
    var page = "foregetaddress"; 
    $("#citys").html("");
    $("#districts").html("");
    $.get(
            page,
            {"zone.addressId":select.value},
            function(result){

                var str;
            	for(var i=0; i<result.length;i++) {
            		str += "<option value='"+ result[i].addressId +"'>"+result[i].address+"</option> ";
            	}
                str = "<option value=\"-1\">请选择...</option>" + str;
            	$("#citys").html(str);
            }
    );  
}
function cityChange(select) {
    if(select.value == -1) {
    	$("#districts").css("visibility","hidden");
    	return;
    }
    var page = "foregetaddress";
    $("#districts").html("");
    $.get(
            page,
            {"zone.addressId":select.value},
            function(result){
                if(result.length > 0)
                    $("#districts").css("visibility","visible");
                var str;
                for(var i=0; i<result.length;i++) {
                    str += "<option value='"+ result[i].addressId +"'>"+result[i].address+"</option> ";
                }
                str = "<option value=\"-1\">请选择...</option>" + str;
                $("#districts").html(str);
            }
    );  
}
/* 切换地址 */
function addressSelected(click) {
	$(".user-addresslist").each(function(){
		$(this).attr("class", "user-addresslist");
		//设置disabled 为true 会使控件不可用（表单提交是选择忽略 。。还未验证
		$(this).attr("disabled", "true");
    });
	$(click).attr("class", "user-addresslist defaultAddr");
	$(click).removeAttr("disabled");
}
</script>
<div class="modal fade" id="addressModal" tabindex="-1" role="dialog" style="margin-top:6%">
    <div class="panel panel-warning addAddress">
          <div class="panel-heading" style="text-align: center">新增地址</div>
          <div class="panel-body">
              <form method="post" id="addAddressForm" action="">
                    <div class="addarea">
                        <label>收货人</label>
                        <input type="text" name="deliveryAddress.userName"  id="user-name" placeholder="收货人" required="required">
                    </div>
                    <div class="addarea">
                        <label >手机号码</label>
                        <input type="text" name="deliveryAddress.userPhone"  placeholder="手机号码" required="required">
                    </div>
                    <div class="addarea">
                        <label >邮编</label>
                        <input type="text" name="deliveryAddress.postCode"  placeholder="不知道填 0000" required="required">
                    </div>
                    <div class="addarea">
                        <label >地址</label>
                        <select id="provinces" name="deliveryAddress.province" style="visibility:visible" onchange="provinceChange(this)">
                            <option value="-1">请选择...</option>
                            <c:forEach items="${zones}" var="zone">
                                <option value="${zone.addressId}">${zone.address}</option>
                            </c:forEach>
                        </select>
                        <select id="citys" name="deliveryAddress.city" onchange="cityChange(this)">
                        </select>
                        <select id="districts" name="deliveryAddress.district">
                        </select>
                    </div>
                    <div class="addarea">
                        <label >详细地址</label>
                        <textarea rows="3"  name="deliveryAddress.address" placeholder="输入详细地址" required="required"></textarea><br/>
                        <small>100字以内写出你的详细地址...</small>
                    </div><br/>
                    <div class="addarea">
                        <input type="submit" class="btn btn-success" value="提交"/>
                        <input type="button" data-dismiss="modal" class="btn btn-default" value="取消"/>
                    </div>
              </form>
          </div>
    </div>
</div>
<div class="buyPageDiv">
  <form id="forecreateOrder" action="forecreateOrder" method="post">
   
    <div class="buyFlow">
        <img class="pull-left" src="img/site/logo4.png" height="120px">
        <img class="pull-right" src="img/site/buyflow.png">
        <div style="clear:both"></div>
    </div>
    
    
    <div class="address">
        <div class="addressTip">确认收货地址&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" id="addAddress" class="btn btn-info" value="使用新地址"> 
            <input type="button" onclick="ajaxgetAddress()" class="btn btn-info" value="显示地址">
        </div>
        <div class="addressarea">
			<ul id="displayaddressul" style="display:block;">
				<!-- <li class="user-addresslist defaultAddr" onclick="addressSelected(this)">
					<div class="address-left">
						<div class="user DefaultAddr">
							<span class="buy-address-detail"> <span class="buy-user">艾迪
							</span> <span class="buy-phone">15888888888</span>
							</span>
						</div>
						<div class="default-address DefaultAddr">
							<span class="buy-line-title buy-line-title-type">收货地址：</span> 
							<span
								class="buy--address-detail"> 湖北省
								武汉市 洪山区 
								雄楚大道666号(中南财经政法大学)
							</span>
						</div>
						<ins class="deftip">默认地址</ins>
					</div>
					<div class="clear"></div>
					<div class="new-addr-btn">
						<a href="#" class="hidden">设为默认</a> <span
							class="new-addr-bar hidden">|</span> <a href="#">编辑</a> <span
							class="new-addr-bar">|</span> <a href="javascript:void(0);"
							onclick="delClick(this);">删除</a>
					</div>
				</li>
				<li class="user-addresslist"  onclick="addressSelected(this)">
					<div class="address-left">
						<div class="user">
							艾迪
							15888888888
						</div>
						<div class="default-address">
							收货地址：湖北省 武汉市 洪山区雄楚大道666号(中南财经政法大学)
						</div>
					</div>
					<div class="new-addr-btn">
						<a href="#" class="hidden">设为默认</a> 
						<span class="new-addr-bar hidden">|</span> 
						<a href="#">编辑</a> 
						<span class="new-addr-bar">|</span> 
						<a href="javascript:void(0);" onclick="delClick(this);">删除</a>
					</div>
				</li> -->
			</ul>
		</div>
		<div class="clear"></div>
		<br/>
        <!-- <div>
         
            <table class="addressTable">
                <tr>
                    <td class="firstColumn">详细地址<span class="redStar">*</span></td>
                     
                    <td><textarea name="order.address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea></td>
                </tr>
                <tr>
                    <td>邮政编码</td>
                    <td><input  name="order.post" placeholder="如果您不清楚邮递区号，请填写000000" type="text"></td>
                </tr>
                <tr>
                    <td>收货人姓名<span class="redStar">*</span></td>
                    <td><input  name="order.receiver"  placeholder="长度不超过25个字符" type="text"></td>
                </tr>
                <tr>
                    <td>手机号码 <span class="redStar">*</span></td>
                    <td><input name="order.mobile"  placeholder="请输入11位手机号码" type="text"></td>
                </tr>
            </table>
             
        </div> -->
 
    </div>
    
    <div class="clear"></div>
    <div class="productList">
        <div class="productListTip">确认订单信息</div>
         
        <table class="productListTable">
            <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn">
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td  colspan="2" ></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </thead>
            <tbody class="productListTableTbody">
                <c:forEach items="${orderItems}" var="oi" varStatus="st" >
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
                        <td class="orderItemProductInfo">
                        <a  href="foreproduct?product.id=${oi.product.id}" class="orderItemProductLink">
                            ${oi.product.name}
                        </a>
                         
                            <img src="img/site/creditcard.png" title="支持信用卡支付">
                            <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                            <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                         
                        </td>
                        <td>
                         
                        <span class="orderItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></span>
                        </td>
                        <td>
                        <span class="orderItemProductNumber">${oi.number}</span>
                        </td>
                        <td><span class="orderItemUnitSum">
                        ￥<fmt:formatNumber type="number" value="${oi.number*oi.product.promotePrice}" minFractionDigits="2"/>
                        </span></td>
                        <c:if test="${st.count==1}">
                        <td rowspan="5"  class="orderItemLastTD">
                        <label class="orderItemDeliveryLabel">
                            <input type="radio" value="" checked="checked">
                            普通配送
                        </label>
                         
                        <select class="orderItemDeliverySelect" class="form-control">
                            <option>快递 免邮费</option>
                        </select>
 
                        </td>
                        </c:if>
                         
                    </tr>
                </c:forEach>              
                 
            </tbody>
             
        </table>
        <div class="orderItemSumDiv">
            <div class="pull-left">
                <span class="leaveMessageText">给卖家留言:</span>
                <span>
                    <img class="leaveMessageImg" src="img/site/leaveMessage.png">
                </span>
                <span class="leaveMessageTextareaSpan">
                    <textarea name="order.userMessage" class="leaveMessageTextarea"></textarea>
                    <div>
                        <span>还可以输入200个字符</span>
                    </div>
                </span>
            </div>
             
            <span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
        </div>
         
    </div>
    <div class="orderItemTotalSumDiv">
        <div class="pull-right"> 
            <span>实付款：</span> 
            <span class="orderItemTotalSumSpan">￥<span><fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span></span>
        </div>
    </div>
     
    <div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
    </div>
  </form>     
</div>