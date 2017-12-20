package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Product;
/**
 * 人气比较器
 * @author ASUS
 *
 */
public class ProductReviewComparator implements Comparator<Product> {

    @Override
    public int compare(Product o1, Product o2) {
        //评价多的在前 降序
        return o2.getReviewCount() - o1.getReviewCount();
    }

}
