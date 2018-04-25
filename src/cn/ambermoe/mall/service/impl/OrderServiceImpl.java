package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.ambermoe.mall.pojo.Order;
import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.service.OrderItemService;
import cn.ambermoe.mall.service.OrderService;
import cn.ambermoe.mall.service.ProductService;
@Service
public class OrderServiceImpl extends BaseServiceImpl implements OrderService {
    @Autowired
    OrderItemService orderItemService;
    
    @Autowired
    ProductService productService;
    /**
     * 1. 把订单插入到数据库中
     * 2. 为每个OrderItem设置其订单
     * 3. 累计金额并返回
     * --事务注解 插入订单和修改订单项 应同时成功或失败
     */
    @Transactional(propagation=Propagation.REQUIRED,rollbackForClassName="Exception")
    @Override
    public float createOrder(Order order, List<OrderItem> ois) {
        this.save(order);
        float total = 0;
        for(OrderItem oi: ois) {
            oi.setOrder(order);
            orderItemService.update(oi);
            total += oi.getProduct().getPromotePrice() * oi.getNumber();
            oi.getProduct().setStock(oi.getProduct().getStock() - oi.getNumber());
            productService.update(oi.getProduct());
        }
        return total;
    }
    @Override
    public List<Order> listByUserWithoutDelete(User user) {
        DetachedCriteria dc = DetachedCriteria.forClass(clazz);
        dc.add(Restrictions.eq("user", user));
        //因为用到ne(非条件 所有不能使用baseservice的list(Object pairParms)
        dc.add(Restrictions.ne("status", OrderService.delete));
        return findByCriteria(dc);
    }

}
