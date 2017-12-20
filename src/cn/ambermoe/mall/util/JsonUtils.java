package cn.ambermoe.mall.util;

import java.util.List;

import cn.ambermoe.mall.pojo.Zone;

public class JsonUtils {
    public static String toJson(List<Zone> list) {
        String json = "[";
        for(Zone zone: list) {
            json += "{\"addressId\":" + zone.getAddressId() + ",\"address\":\"" + zone.getAddress() + "\"},";
        }
        json = json.substring(0, json.length() - 1);
        json += "]";
        return json;
    }
}
