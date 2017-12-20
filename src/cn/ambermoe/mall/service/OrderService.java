package cn.ambermoe.mall.service;

import java.util.List;

import cn.ambermoe.mall.pojo.Order;
import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.pojo.User;

public interface OrderService extends BaseService {
    //待支付
    public static final String waitPay = "waitPay";
    //待发货
    public static final String waitDelivery = "waitDelivery";
    //待确认收货
    public static final String waitConfirm = "waitConfirm";
    //待评价
    public static final String waitReview = "waitReview";
    //完成
    public static final String finish = "finish";
    //已删除
    public static final String delete = "delete";
    
    //生成订单
    public float createOrder(Order order, List<OrderItem> ois);
    //查询所有订单 除被标记为删除的
    public List<Order> listByUserWithoutDelete(User user);
}
