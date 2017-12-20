package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.service.UserService;
@Service
public class UserServiceImpl extends BaseServiceImpl implements UserService {

    @Override
    public boolean isExist(String name) {
        List l = list("name", name);
        //数据存在此用户名
        if(!l.isEmpty())
            return true;
        return false;
    }
    
    @Override
    public User get(String name, String password) {
        List<User> l  = list("name",name, "password",password);
        if(l.isEmpty())
            return null;
        return l.get(0);

    }

}
