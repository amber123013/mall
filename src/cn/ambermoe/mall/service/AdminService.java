package cn.ambermoe.mall.service;

import cn.ambermoe.mall.pojo.Admin;

public interface AdminService extends BaseService {
    //根据名字密码获取用户
    Admin get(String name, String password);
}
