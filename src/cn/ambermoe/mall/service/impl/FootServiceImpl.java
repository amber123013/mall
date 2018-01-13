package cn.ambermoe.mall.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.Foot;
import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.service.FootService;
@Service
public class FootServiceImpl extends BaseServiceImpl implements FootService {

    /* 
     * 如果用户浏览里不存在此产品 则添加 
     * 如果存在 则删掉 存在的，重新添加 
     * 
     */
    @Override
    public void changeToFirst(Product product, User user) {
        List<Foot> fs = this.list("user", user, "product", product);
        Foot f = new Foot();
        f.setCreateDate(new Date());
        f.setProduct(product);
        f.setUser(user);
        if(fs.isEmpty()) {
            //只保存最近的15条历史记录
            if(this.total(user) >= 15) {
                this.delete(this.list("user", user).get(14));
            }
            this.save(f);
        } else {
            this.delete(fs.get(0));
            this.save(f);
        }
    }
    
}
