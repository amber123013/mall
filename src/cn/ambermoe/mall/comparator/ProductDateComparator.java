package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Product;
/**
 * 新品比较器
 * @author ASUS
 *
 */
public class ProductDateComparator implements Comparator<Product> {

    @Override
    public int compare(Product o1, Product o2) {
        //时间新的在前面
        return o1.getCreateDate().compareTo(o2.getCreateDate());
    }

}
