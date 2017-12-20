package cn.ambermoe.mall.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.Category;
import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.service.OrderItemService;
import cn.ambermoe.mall.service.ProductImageService;
import cn.ambermoe.mall.service.ProductService;
import cn.ambermoe.mall.service.ReviewService;
@Service
public class ProductServiceImpl extends BaseServiceImpl implements ProductService {

    @Autowired
    ProductImageService productImageService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    OrderItemService orderItemService;
    

    @Override
    public void fill(List<Category> categorys) {
        for(Category category:categorys) {
            fill(category);
        }
    }
    //为分类填充产品集合
    @Override
    public void fill(Category category) {
        List<Product> products = listByParent(category);
        
        for(Product product:products) {
            productImageService.setFirstProductImage(product);
        }
        
        category.setProducts(products);
    }
    //填充 分类的推荐产品 一行八个
    @Override
    public void fillByRow(List<Category> categorys) {
        int productNumberEachRow = 8;
        for(Category category:categorys) {
            List<Product> products = category.getProducts();
            List<List<Product>> productsByRow = new ArrayList<>();
            for(int i=0; i<products.size(); i+=productNumberEachRow) {
                //将 分类的全部产品 分割成 n * 8 矩阵
                int size = i + productNumberEachRow;
                size = size > products.size() ? products.size():size;
                List<Product> productsOfEachRow = products.subList(i, size);
                productsByRow.add(productsOfEachRow);
            }
            
            category.setProductsByRow(productsByRow);
        }
    }
    @Override
    public void setSaleAndReviewNumber(Product product) {
        //获取含product的订单项
        int saleCount = orderItemService.total(product);
        product.setSaleCount(saleCount);
        int reviewCount = reviewService.total(product);
        product.setReviewCount(reviewCount);
    }
    @Override
    public void setSaleAndReviewNumber(List<Product> products) {
        for(Product product:products) {
            setSaleAndReviewNumber(product);
        }
    }
    @Override
    public List<Product> search(String keyword, int start, int count) {
        DetachedCriteria dc = DetachedCriteria.forClass(clazz);
        dc.add(Restrictions.like("name", "%" + keyword + "%"));
        return findByCriteria(dc, start, count);
    }

}
