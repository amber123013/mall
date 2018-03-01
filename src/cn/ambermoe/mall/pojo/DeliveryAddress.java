package cn.ambermoe.mall.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
@Entity
@Table(name = "deliveryaddress")
public class DeliveryAddress implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    /* 拥有此地址的用户 */
    @ManyToOne
    @JoinColumn(name = "uid")
    private User user;
    /* 收货人姓名 与用户名可以不同 */
    private String userName;
    /* 收货人手机 */
    private String userPhone;
    /* 收货地址 省 */
    private String province;
    /* 收货地址 市 */
    private String city;
    /* 收货地址 区 */
    private String district;
    /* 详细地址  */
    private String address;
    /* 邮编  */
    private String postCode;
    /* 是否 默认地址 1 默认 0 非默认 (默认数值为0 */
    private int isDefault;
    /* 标记地址是否删除 1 未删除  -1 删除 默认1 */
    private int addressFlag;
    private Date createTime;

    public int getId() {
        return id;
    }
    @Override
    public String toString() {
        return "DeliveryAddress [id=" + id + ", user=" + user + ", userName=" + userName + ", userPhone=" + userPhone
                + ", province=" + province + ", city=" + city + ", district=" + district + ", address=" + address
                + ", postCode=" + postCode + ", isDefault=" + isDefault + ", addressFlag=" + addressFlag
                + ", createTime=" + createTime + "]";
    }
    public void setId(int id) {
        this.id = id;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getUserPhone() {
        return userPhone;
    }
    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }
    public String getProvince() {
        return province;
    }
    public void setProvince(String province) {
        this.province = province;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getDistrict() {
        return district;
    }
    public void setDistrict(String district) {
        this.district = district;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getPostCode() {
        return postCode;
    }
    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }
    public int getIsDefault() {
        return isDefault;
    }
    public void setIsDefault(int isDefault) {
        this.isDefault = isDefault;
    }
    public int getAddressFlag() {
        return addressFlag;
    }
    public void setAddressFlag(int addressFlag) {
        this.addressFlag = addressFlag;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
}
