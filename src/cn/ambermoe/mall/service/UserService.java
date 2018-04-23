package cn.ambermoe.mall.service;

import cn.ambermoe.mall.pojo.User;

public interface UserService extends BaseService {
    //判断用户是否存在
    boolean isExist(String name);
    //根据用户名密码获取用户
    User get(String name, String password);
    User get(String name);
}
