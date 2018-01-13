package cn.ambermoe.mall.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.ambermoe.mall.pojo.DeliveryAddress;
import cn.ambermoe.mall.service.DeliveryAddressService;
@Service
public class DeliveryAddressServiceImpl extends BaseServiceImpl implements DeliveryAddressService {

    @Override
    public void setAddressDefault(DeliveryAddress deliveryAddress) {
        //将原先默认地址 取消
        List<DeliveryAddress> address = list("isDefault", 1);
        if(!address.isEmpty()) {
            address.get(0).setIsDefault(0);
            this.update(address.get(0));
        }
        //将传入的address设为默认
        deliveryAddress.setIsDefault(1);
        this.update(deliveryAddress);
    }

}
