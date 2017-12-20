package cn.ambermoe.mall.service;

import cn.ambermoe.mall.pojo.Product;

public interface PropertyValueService extends BaseService {
    //通过初始化来进行自动地增加属性
    public void init(Product product);
}
