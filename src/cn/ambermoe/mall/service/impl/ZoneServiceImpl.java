package cn.ambermoe.mall.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import cn.ambermoe.mall.service.ZoneService;
@Service
public class ZoneServiceImpl extends BaseServiceImpl implements ZoneService {

    @Override
    public List<String> getAddress(int parentId) {
        String sqlFormat = "select address from Zone where parentId = ?";
        String hql = String.format(sqlFormat, parentId);
        List<String> list = this.find(hql, parentId);
        return list;
    }
    @Override
    public List list(Object... pairParms) {
        HashMap<String, Object> m = new HashMap<>();
        for(int i = 0; i < pairParms.length; i = i + 2)
            m.put(pairParms[i].toString(), pairParms[i+1]);
        DetachedCriteria dc = DetachedCriteria.forClass(clazz);
        Set<String> ks = m.keySet();
        for(String key : ks) {
            if(null == m.get(key))
                dc.add(Restrictions.isNull(key));
            else
                dc.add((Restrictions.eq(key, m.get(key))));
        }
        dc.addOrder(Order.asc("id"));
        return this.findByCriteria(dc);
    }
    

}
