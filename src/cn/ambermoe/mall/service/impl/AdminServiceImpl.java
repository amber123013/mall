package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.Admin;
import cn.ambermoe.mall.service.AdminService;
@Service
public class AdminServiceImpl extends BaseServiceImpl implements AdminService {

    @Override
    public Admin get(String name, String password) {
        List<Admin> l = list("name", name, "password", password);
        if(l.isEmpty())
            return null;
        return l.get(0);
    }

}
