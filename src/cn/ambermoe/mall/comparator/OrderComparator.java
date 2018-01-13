package cn.ambermoe.mall.comparator;

import java.util.Comparator;

import cn.ambermoe.mall.pojo.Order;
import cn.ambermoe.mall.pojo.Product;
/* 对显示order进行排序 */
public class OrderComparator implements Comparator<Order>{

    @Override
    public int compare(Order o1, Order o2) {
        // TODO Auto-generated method stub
        return o2.getId() - o1.getId();
    }

}
