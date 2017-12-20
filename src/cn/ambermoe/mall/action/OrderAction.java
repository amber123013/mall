package cn.ambermoe.mall.action;

import java.util.Date;

import org.apache.struts2.convention.annotation.Action;

import cn.ambermoe.mall.service.OrderService;
import cn.ambermoe.mall.util.Page;

public class OrderAction extends Action4Result {
    @Action("admin_order_list")
    public String list() {
        if(page == null)
            page = new Page();
        int total = orderService.total();
        page.setTotal(total);
        orders = orderService.listByPage(page);
        orderItemService.fill(orders);
        return "listOrder";
    }
    @Action("admin_order_delivery")
    public String delivery() {
        t2p(order);
        order.setDeliveryDate(new Date());
        //更改订单状态为代收
        order.setStatus(OrderService.waitConfirm);
        orderService.update(order);
        return "listOrderPage";
    }
}
