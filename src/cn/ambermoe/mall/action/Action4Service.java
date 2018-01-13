package cn.ambermoe.mall.action;

import java.lang.reflect.Method;

import javax.annotation.Resource;

import org.apache.commons.lang3.text.WordUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.ambermoe.mall.service.DeliveryAddressService;
import cn.ambermoe.mall.service.FavoriteService;
import cn.ambermoe.mall.service.FootService;
import cn.ambermoe.mall.service.AdminService;
import cn.ambermoe.mall.service.BaseService;
import cn.ambermoe.mall.service.CategoryService;
import cn.ambermoe.mall.service.OrderItemService;
import cn.ambermoe.mall.service.OrderService;
import cn.ambermoe.mall.service.ProductImageService;
import cn.ambermoe.mall.service.ProductService;
/**
 * 服务的注入
 * @author ASUS
 *
 */
import cn.ambermoe.mall.service.PropertyService;
import cn.ambermoe.mall.service.PropertyValueService;
import cn.ambermoe.mall.service.ReviewService;
import cn.ambermoe.mall.service.UserService;
import cn.ambermoe.mall.service.ZoneService;
public class Action4Service extends Action4Pojo {

    @Autowired
    CategoryService categoryService;
    @Resource(name="base")
    BaseService baseService;
    
    @Autowired
    PropertyService propertyService;
    
    @Autowired
    ProductService productService;
    
    @Autowired
    ProductImageService productImageService;
    
    @Autowired
    PropertyValueService propertyValueService;
    
    @Autowired
    UserService userService;
    
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    
    @Autowired
    ReviewService reviewService;
    
    @Autowired
    AdminService adminService;
    
    @Autowired
    ZoneService zoneService;
    
    @Autowired
    DeliveryAddressService deliveryAddressService;
    
    @Autowired
    FootService footService;

    @Autowired
    FavoriteService favoriteService;
    /**
     * transient to persistent
     * 瞬时对象转换为持久对象
     * 根据传入对象的getId获取id-->根据id从数据库中获取到该数据 
     * -->根据setXX方法设置到ActionPojo的属性中
     * @param o
     */
    public void t2p(Object o){
            try {
                Class clazz = o.getClass();
                //根据反射调用传入对象(瞬时对象)的getId()方法获取Id
                int id = (Integer) clazz.getMethod("getId").invoke(o);
                //根据Id获取持久化对象(Service-->dao的get方法在数据库中根据id查出)
                Object persistentBean = baseService.get(clazz, id);
                String beanName = clazz.getSimpleName();
                //根据反射获取 Action4Pojo中的setXXX方法
                Method setMethod = getClass().getMethod("set" + WordUtils.capitalize(beanName), clazz);
                //调用set方法
                setMethod.invoke(this, persistentBean);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
    }
}
