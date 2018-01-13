<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<title>地址管理</title>
<script>
$(function(){
	/*  */
	/* 提交前验证 */
	$("#addAddressForm").submit(function(){
		//手机号码正则
		var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
        if(!myreg.test($("#deliveryAddressuserPhone").val())) {
        	warningInfo('手机号码格式不正确!');
            return false;
        }
        if(-1 == $("#provinces").val() || -1 == $("#citys").val()){
        	warningInfo('省份或城市未选择!');
            return false;
        }
        return true;
    });
	/* 点击添加新地址 */
    $(".add_address").click(function(){
    	$("#addAddressForm").get(0).reset();
    	$("#deliveryAddressid").val("-1");
    	var findStrProvince = "option:contains(请选择...)";
        $("#provinces").find(findStrProvince).attr("selected",true);
        $('#provinces').trigger("onchange");//模拟触发onchange事件
        $("#addressModal").modal('show');
    });
});
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
function getUpdateAddress(link) {
	var page = $(link).attr("location");
	//设为同步 onchange 方法执行完成后才能 进行选中操作 
	$.ajaxSettings.async = false;
    $.get(
            page,
            function(result){
                $("#deliveryAddressid").val(result.id);
                $("#deliveryAddressuserName").val(result.userName)
                $("#deliveryAddressuserPhone").val(result.userPhone);
                $("#deliveryAddresspostCode").val(result.postCode);
                $("#deliveryAddressaddress").val(result.address);
                /* 为地址设置选中  省*/
                var findStrProvince = "option:contains(" + result.province + ")";
                $("#provinces").find(findStrProvince).attr("selected",true);
                $('#provinces').trigger("onchange");//模拟触发onchange事件
                /* 城市 */
                var finStrCity = "option:contains(" + result.city + ")";
                $("#citys").find(finStrCity).attr("selected",true);
                $('#citys').trigger("onchange");//模拟触发onchange事件
                /* 区 */
                var findStrDistrict = "option:contains(" + result.district + ")";
                $("#districts").find(findStrDistrict).attr("selected",true);
            }
    );
    //设置回来
    $.ajaxSettings.async = true;
    function showDeleteConfigModal() {
    	$("#deleteConfirmModal").modal("show");
    }
    $("#addressModal").modal('show');
}
</script>
<div class="modal fade" id="addressModal" tabindex="-1" role="dialog" style="margin-top:6%">
    <div class="panel panel-warning addAddress">
          <div class="panel-heading" style="text-align: center">新增地址/更新地址</div>
          <div class="panel-body">
              <form method="post" id="addAddressForm" action="personaladdOrUpdateAddress">
                    <div class="addarea">
                        <label>收货人</label>
                        <input type="hidden" id="deliveryAddressid" name="deliveryAddress.id" value="-1">
                        <input type="text" id="deliveryAddressuserName" name="deliveryAddress.userName"  id="user-name" placeholder="收货人" required="required">
                    </div>
                    <div class="addarea">
                        <label >手机号码</label>
                        <input type="text" id="deliveryAddressuserPhone" name="deliveryAddress.userPhone"  placeholder="手机号码" required="required" pattern="^(13[0-">
                    </div>
                    <div class="addarea">
                        <label >邮编</label>
                        <input type="text" id="deliveryAddresspostCode" name="deliveryAddress.postCode"  placeholder="不知道填 0000" required="required">
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
                        <textarea rows="3" id="deliveryAddressaddress"  name="deliveryAddress.address" placeholder="输入详细地址" required="required"></textarea><br/>
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
    <div class="personalContent"  style="min-height:606px">
		<div class="personalTitle">
			<strong>地址管理</strong> / <small>Address&nbsp;list</small>
		</div>
	    <hr/>
		<div class="addressarea">
	            <ul id="displayaddressul" style="display:block;">
	                <c:forEach items="${deliveryAddresss}" var="address">
	                    <c:if test="${address.isDefault == 1}">
	                        <li class="user-addresslist defaultAddr">
	                    </c:if>
						<c:if test="${address.isDefault == 0}">
                            <li class="user-addresslist">
                        </c:if>
							<div class="address-left">
								<div class="user DefaultAddr">
									<span class="buy-address-detail"> <span class="buy-user">${address.userName}
									</span> <span class="buy-phone">${address.userPhone}</span>
									</span>
								</div>
								<div class="default-address DefaultAddr">
									<span class="buy-line-title buy-line-title-type">收货地址：</span> <span
										class="buy--address-detail">${address.province}&nbsp;
										                            ${address.city}&nbsp;
										                            ${address.district}&nbsp;
										                            ${address.address} </span>
								</div>
								<c:if test="${address.isDefault == 1}">
								    <ins class="deftip">默认地址</ins>
                                </c:if>
							</div>
							<div class="clear"></div>
							<div class="new-addr-btn">
							    <c:if test="${address.isDefault == 0}">
							        <a href="personalsetAddressDefault?deliveryAddress.id=${address.id}">设为默认</a> 
							        <span class="new-addr-bar">|</span> 
                                </c:if>
								<a href="#nowhere" location="personalgetUpdateAddress?deliveryAddress.id=${address.id}" onclick="getUpdateAddress(this)"><i class="glyphicon glyphicon-edit"></i>编辑</a> 
								    <span class="new-addr-bar">|</span> 
								<a href="personaldeleteAddress?deliveryAddress.id=${address.id}" onclick="showDeleteConfigModal();">
								    <i class="glyphicon glyphicon-trash"></i>删除</a>
							</div>
						</li>
					</c:forEach>
	            </ul>
	            <c:if test="${empty deliveryAddresss}">
	               <div class="empty">
			            <div class="pic"></div>
			            <div class="tips">最近无浏览记录</div>
			        <div>
	            </c:if>
	        </div>
            <a href="javascript:;" class="add_address"><i class="glyphicon glyphicon-plus"></i>添加新地址</a>
			<div class="clear"></div>
			&nbsp;
    </div>
</div> <!-- div.col-main 的标签结束 -->

</div> <!-- div.center 的结束标签 --> 