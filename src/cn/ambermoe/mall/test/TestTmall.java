package cn.ambermoe.mall.test;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.ambermoe.mall.dao.impl.DAOImpl;
import cn.ambermoe.mall.pojo.Category;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestTmall {
    @Autowired
    DAOImpl dao;
 
    @Test
    public void delete() {
        DetachedCriteria dc = DetachedCriteria.forClass(Category.class);
        List<Category> cs = dao.findByCriteria(dc);
        for (Category c : cs) {
            dao.delete(c);
        }
    }
 
    @Test
    public void test() {
        DetachedCriteria dc = DetachedCriteria.forClass(Category.class);
        List<Category> cs = dao.findByCriteria(dc);
        if (cs.isEmpty()) {
            for (int i = 0; i < 10; i++) {
                Category c = new Category();
                c.setName("测试分类" + (i + 1));
                dao.save(c);
            }
            System.out.println("成功添加10个测试分类");
        }
    }
}