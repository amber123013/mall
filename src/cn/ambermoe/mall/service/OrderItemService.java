package cn.ambermoe.mall.service;

import java.util.List;

import cn.ambermoe.mall.pojo.Order;

public interface OrderItemService extends BaseService {
    public void fill(List<Order> orders);
    public void fill(Order order);
    public int totalSale(Object parent);
}
