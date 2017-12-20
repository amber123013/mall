package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Product;
/**
 * 综合比较器
 * 把 销量x评价 高的放前面
 * @author ASUS
 *
 */
public class ProductAllComparator implements Comparator<Product>{
    /**
     *  如果要按照升序排序，o1 > o2 return 正数
     *               o1 < o2 return 负数
     *               o1 = o2 return o
     *  如果要按照降序排序，o1 > o2 return 负数
     *               o1 < o2 return 正数
     *               o1 = o2 return o 
     */
    @Override  
    public int compare(Product o1, Product o2) {
        //降序
        return o2.getReviewCount() * o2.getSaleCount() - o1.getReviewCount() * o1.getSaleCount();
    }

}
