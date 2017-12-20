package cn.ambermoe.mall.service;

import java.util.List;


public interface ZoneService extends BaseService {
    public List<String> getAddress(int parentId);
}
