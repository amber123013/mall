package cn.ambermoe.mall.service;

import java.util.List;

import cn.ambermoe.mall.pojo.Category;
import cn.ambermoe.mall.pojo.Product;

public interface ProductService extends BaseService {
    //为分类list中的每一个分类填充产品
    public void fill(List<Category> categorys);
    //为分类填充产品
    public void fill(Category category);
    //为分类填充推荐产品
    public void fillByRow(List<Category> categorys);
    //设置传入产品的销量数和评论数
    public void setSaleAndReviewNumber(Product product);
    public void setSaleAndReviewNumber(List<Product> products);
    //模糊查找  keyword
    public List<Product> search(String keyword, int start, int count);
}
