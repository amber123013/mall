package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Product;
/**
 * 价格比较器
 * @author ASUS
 *
 */
public class ProductPriceComparator implements Comparator<Product> {

    @Override
    public int compare(Product o1, Product o2) {
        //价格低的在前面 升序
        return (int) (o1.getPromotePrice() - o2.getPromotePrice());
    }

}
