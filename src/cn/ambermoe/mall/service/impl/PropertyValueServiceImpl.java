package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.Property;
import cn.ambermoe.mall.pojo.PropertyValue;
import cn.ambermoe.mall.service.PropertyService;
import cn.ambermoe.mall.service.PropertyValueService;
@Service
public class PropertyValueServiceImpl extends BaseServiceImpl implements PropertyValueService {
    @Autowired
    PropertyService propertyService;
    
    @Override
    public void init(Product product) {
        //取出分类下的所有属性
        List<Property> propertys = propertyService.listByParent(product.getCategory());
        for(Property property : propertys) {
            //如果此产品不存在此属性 则 添加 该属性到数据库
            PropertyValue propertyValue = get(property, product);
            if(null == propertyValue){
                //为传入的product 设置所在分类的所有属性
                propertyValue = new PropertyValue();
                propertyValue.setProduct(product);
                propertyValue.setProperty(property);
                save(propertyValue);
            }
        }
    }
    
    private PropertyValue get(Property property, Product product) {
        List<PropertyValue> results = this.list("property", property, "product", product);
        if(results.isEmpty())
            return null;
        return results.get(0);
    }

}
