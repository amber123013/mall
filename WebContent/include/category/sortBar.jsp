<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<script>
/* 显示商品中价格位于 beginPrice endPrice 之间的商品 */
$(function(){
    $("input.sortBarPrice").keyup(function(){
        var num= $(this).val();
        if(num.length==0){
            $("div.productUnit").show();
            return;
        }
             
        num = parseInt(num);
        if(isNaN(num))
            num= 1;
        if(num<=0)
            num = 1;
        $(this).val(num);       
         
        var begin = $("input.beginPrice").val();
        var end = $("input.endPrice").val();
        if(!isNaN(begin) && !isNaN(end)){
            console.log(begin);
            console.log(end);
            $("div.productUnit").hide();
            $("div.productUnit").each(function(){
                var price = $(this).attr("price");
                price = new Number(price);
                 
                if(price<=end && price>=begin)
                    $(this).show();
            });
        }
         
    });
});
</script> 
<div class="categorySortBar">
 
    <table class="categorySortBarTable categorySortTable">
        <tr>
            <td <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if> ><a href="?category.id=${category.id}&sort=all">综合排序</span></a></td>
            <td <c:if test="${'review'==param.sort}">class="grayColumn"</c:if> ><a href="?category.id=${category.id}&sort=review">人气为主</a></td>
            <td <c:if test="${'date'==param.sort}">class="grayColumn"</c:if>><a href="?category.id=${category.id}&sort=date">新品在前</a></td>
            <td <c:if test="${'saleCount'==param.sort}">class="grayColumn"</c:if>><a href="?category.id=${category.id}&sort=saleCount">销量排序</span></a></td>
            <td <c:if test="${'price'==param.sort}">class="grayColumn"</c:if>><a href="?category.id=${category.id}&sort=price">价格优先</a></td>
        </tr>
    </table>
    <table class="categorySortBarTable ">
        <tr>
            <td style="padding: 0px"><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
            <td class="grayColumn priceMiddleColumn">-</td>
            <td style="padding: 0px"><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
        </tr>
    </table>
</div>