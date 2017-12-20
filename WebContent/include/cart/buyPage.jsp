<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>结算页</title>
<script>
$(function(){
	$("#addAddress").click(function(){
		$("#addressModal").modal('show');
	});
});
function provinceChange(select) {
    $("#citys").css("visibility","visible");
    $("#districts").css("visibility","hidden");
    var page = "foregetaddress"; 
    $("#citys").html("");
    $("#districts").html("");
    $.get(
            page,
            {"zone.addressId":select.value},
            function(result){
                var list = eval("("+result+")");
                alert
                var str;
            	for(var i=0; i<list.length;i++) {
            		str += "<option value='"+ list[i].addressId +"'>"+list[i].address+"</option> ";
            	}
                str = "<option>请选择...</option>" + str;
            	$("#citys").html(str);
            }
    );  
}
function cityChange(select) {
    $("#districts").css("visibility","visible");
    var page = "foregetaddress";
    $("#districts").html("");
    $.get(
            page,
            {"zone.addressId":select.value},
            function(result){
                var list = eval("("+result+")");
                alert
                var str;
                for(var i=0; i<list.length;i++) {
                    str += "<option value='"+ list[i].addressId +"'>"+list[i].address+"</option> ";
                }
                str = "<option>请选择...</option>" + str;
                $("#districts").html(str);
            }
    );  
}
</script>
<div class="buyPageDiv">
  <form action="forecreateOrder" method="post">
   
    <div class="buyFlow">
        <img class="pull-left" src="img/site/logo4.png" height="120px">
        <img class="pull-right" src="img/site/buyflow.png">
        <div style="clear:both"></div>
    </div>
    
    
    <div class="address">
        <div class="addressTip">确认收货地址&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" id="addAddress" class="btn btn-info" value="使用新地址"> </div>
        
        <div class="modal" id="addressModal" tabindex="-1" role="dialog" style="margin-top:6%">
            <div class="panel panel-warning addAddress">
                  <div class="panel-heading">新增地址</div>
		          <div class="panel-body">
		              <form method="post" id="" action="foreAddAddress">
		                    <div class="addarea">
	                            <label>收货人</label>
	                            <input type="text" id="user-name" placeholder="收货人">
                            </div>
                            <div class="addarea">
                                <label >手机号码</label>
                                <input type="text"  placeholder="手机号码">
                            </div>
                            <div class="addarea">
                                <label >地址</label>
                                <select id="provinces" style="visibility:visible" onchange="provinceChange(this)">
                                    <option value="">请选择...</option>
                                    <c:forEach items="${zone.provinces}" var="ps">
                                        <option value="${ps.addressId}">${ps.address}</option>
                                    </c:forEach>
                                </select>
                                <select id="citys" onchange="cityChange(this)">
                                </select>
                                <select id="districts">
                                </select>
                            </div>
		              </form>
		          </div>
            </div>
        </div>
   
        <div>
         
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
             
        </div>
 
    </div>
    
    
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
            <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
        </div>
    </div>
     
    <div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
    </div>
  </form>     
</div>