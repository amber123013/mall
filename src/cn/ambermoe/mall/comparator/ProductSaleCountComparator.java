package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Product;
/**
 * 销量比较器
 * @author ASUS
 *
 */
public class ProductSaleCountComparator implements Comparator<Product> {

    @Override
    public int compare(Product o1, Product o2) {
        //销量多的在前 降序
        return o2.getSaleCount() - o1.getSaleCount();
    }

}
