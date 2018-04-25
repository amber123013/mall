package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.Order;
import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.service.OrderItemService;
import cn.ambermoe.mall.service.ProductImageService;
@Service
public class OrderItemServiceImpl extends BaseServiceImpl implements OrderItemService {

    @Autowired
    ProductImageService productImageService;
    
    /**
     * 为多个订单填充
     */
    @Override
    public void fill(List<Order> orders) {
        for(Order order : orders)
            fill(order);
    }                   

    /**
     * 为订单对象填充其orderItems字段，并且计算出订单总金额，订单总购买数量
     */
    @Override
    public void fill(Order order) {
        List<OrderItem> orderItems = this.listByParent(order);
        order.setOrderItems(orderItems);
        
        float total = 0;
        int totalNumber = 0;
        for(OrderItem oi:orderItems) {
            total += oi.getNumber() * oi.getProduct().getPromotePrice();
            totalNumber += oi.getNumber();
            
            productImageService.setFirstProductImage(oi.getProduct());
        }
        order.setTotal(total);
        order.setOrderItems(orderItems);
        order.setTotalNumber(totalNumber);
    }
    /**
     * 返回销量
     */
    @Override
    public int totalSale(Object parent) {
        String parentName = parent.getClass().getSimpleName();
        String parentNameWithFirstLeterLower = StringUtils.uncapitalize(parentName);
        
        String sqlFormat = "select sum(number) from %s bean where bean.%s = ?";
        String hql = String.format(sqlFormat, clazz.getName(), parentNameWithFirstLeterLower);
        List<Long> l = this.find(hql, parent);
        if(l.isEmpty())
            return 0;
        Long result= l.get(0);
        if(null == result)
            result = 0L;
        return result.intValue();
    }

}
