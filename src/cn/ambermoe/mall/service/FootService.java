package cn.ambermoe.mall.service;

import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.User;

public interface FootService extends BaseService {
    public void changeToFirst(Product product, User user);
}
