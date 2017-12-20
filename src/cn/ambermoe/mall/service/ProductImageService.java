package cn.ambermoe.mall.service;

import java.util.List;

import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.ProductImage;

public interface ProductImageService extends BaseService {
    public static final String type_single = "type_single";
    public static final String type_detail = "type_detail";
    
    public void setFirstProductImage(Product product);
    
}
