package cn.ambermoe.mall.service;

import java.util.List;

import cn.ambermoe.mall.util.Page;

public interface BaseService {
    public Integer save(Object object);
    public void update(Object object);
    public void delete(Object object);
    public Object get(Class clazz,int id);
    public Object get(int id);
     
    public List list();
    public List listByPage(Page page);
    public int total();
    
    // 根据父类查询所有子类对象
    public List listByParent(Object parent);
    //根据分类and分类查询子类对象(查询某一个分页
    public List list(Page page, Object parent);
    //根据分类查询子类对象数量
    public int total(Object parent);
    //多条件查询
    public List list(Object ...pairParms);
}
