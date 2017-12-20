package cn.ambermoe.mall.pojo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "zone")
public class Zone {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id")
    private int id;
    private int addressId;
    private String address;
    private int parentId;
    //省
    @Transient
    List<Zone> provinces;
    //市
    @Transient
    List<Zone> citys;
    //区
    @Transient
    List<Zone> districts;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getAddressId() {
        return addressId;
    }
    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public int getParentId() {
        return parentId;
    }
    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
    public List<Zone> getProvinces() {
        return provinces;
    }
    public void setProvinces(List<Zone> provinces) {
        this.provinces = provinces;
    }
    public List<Zone> getCitys() {
        return citys;
    }
    public void setCitys(List<Zone> citys) {
        this.citys = citys;
    }
    public List<Zone> getDistricts() {
        return districts;
    }
    public void setDistricts(List<Zone> districts) {
        this.districts = districts;
    }
    @Override
    public String toString() {
        return "Zone [id=" + id + ", addressId=" + addressId + ", address=" + address + ", parentId=" + parentId
                + ", provinces=" + provinces + ", citys=" + citys + ", districts=" + districts + "]";
    }
    
}
