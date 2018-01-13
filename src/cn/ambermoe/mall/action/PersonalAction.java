package cn.ambermoe.mall.action;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.struts2.components.Password;
import org.apache.struts2.convention.annotation.Action;

import com.opensymphony.xwork2.ActionContext;

import cn.ambermoe.mall.comparator.OrderComparator;
import cn.ambermoe.mall.pojo.DeliveryAddress;
import cn.ambermoe.mall.pojo.Favorite;
import cn.ambermoe.mall.pojo.Foot;
import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.pojo.Zone;
import cn.ambermoe.mall.util.EmailUtil;

public class PersonalAction extends Action4Result {
    @Action("personalindex")
    public String index() {
        user = (User)ActionContext.getContext().getSession().get("user");
        orders = orderService.listByUserWithoutDelete(user);
        orderItemService.fill(orders);
        Collections.sort(orders, new OrderComparator());
        return "index.jsp";
    }
    @Action("personalinformation")
    public String informatin() {
        return "information.jsp";
    }
    @Action("personalsafety")
    public String safety() {
        return "safety.jsp";
    }
    @Action("personalpassword")
    public String password() {
        return "password.jsp";
    }
    @Action("personalemail")
    public String email() {
        return "email.jsp";
    }
    /* 向邮箱发送验证码 */
    @Action("personalsendVerificationCode")
    public String sendVerificationCode() {
        //生成6位随机数字
        int verificationCode = (int)((Math.random()*9+1)*100000);
        // 放入session 中 供之后 使用
        ActionContext.getContext().getSession().put("verificationCode", verificationCode+"");
        //发送邮件
        try {
            EmailUtil.sendVerificationCodeEmail(verificationCode+"", user.getEmail());
        } catch (MessagingException e) {
            return "fail.jsp";
        }
        return "success.jsp";
        
    }
    /* 查询邮箱是否已被其他用户绑定 */
    @Action("personalcheckEmail")
    public String checkEmail() {
        users = userService.list("email", user.getEmail());
        if(users.isEmpty())
            return "success.jsp";
        return "fail.jsp";
    }
    /* 查看用户提交的验证码是否正确 */
    @Action("personalcheckCode")
    public String checkCode() {
        String code = (String)ActionContext.getContext().getSession().get("verificationCode");
        if(code.equals(verificationCode))
            return "success.jsp";
        return "fail.jsp";
    }
    /* 为当前登陆用户绑定邮箱  */
    @Action("personalupdateEmail")
    public String updateEmail() {
        User user_session = (User)ActionContext.getContext().getSession().get("user");
        user_session.setEmail(user.getEmail());
        userService.update(user_session);
        ActionContext.getContext().getSession().put("user", user_session);
        user = user_session;
        return "safety.jsp";
    }
    @Action("personalupdatePassword")
    public String updatePassword() {
        User session_user = (User)ActionContext.getContext().getSession().get("user");
        session_user.setPassword(user.getNewPassword());
        userService.update(session_user);
        //修改完成后  需要用户重新登陆
        return "logout";
    }
    /* 检查修改密码时 输入的原密码是否正确  */
    @Action("personalcheckPassword")
    public String checkPassword() {
        User session_user = (User)ActionContext.getContext().getSession().get("user");
        System.out.println(session_user.getPassword());
        if(session_user.getPassword().equals(user.getPassword()))
            return "success.jsp";
        return "fail.jsp";
    }
    @Action("personaladdress")
    public String address() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        deliveryAddresss = deliveryAddressService.list("user", user, "addressFlag", 1);
        //下拉款省份
        zones = zoneService.list("parentId", 0);
        return "address.jsp";
    }
    @Action("personalsetAddressDefault")
    public String setAddressDefault() {
        t2p(deliveryAddress);
        deliveryAddressService.setAddressDefault(deliveryAddress);
        return "addressPage";
    }
    /* 通过id获取要进行修改的地址在 以json字符串的形式返回 */
    public String getUpdateAddress() {
        t2p(deliveryAddress);
        return "success";
    }
    @Action("personaladdOrUpdateAddress")
    public String addOrUpdateAddress() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        // 无id新增地址 有id 更新地址
        if(-1 == deliveryAddress.getId()) {
            deliveryAddress.setAddressFlag(1);
            deliveryAddress.setCreateTime(new Date());
            deliveryAddress.setUser(user);
          //addressId --> name
            Zone province = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getProvince())).get(0);
            deliveryAddress.setProvince(province.getAddress());
            Zone city = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getCity())).get(0);
            deliveryAddress.setCity(city.getAddress());
            Zone district = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getDistrict())).get(0);
            deliveryAddress.setDistrict(district.getAddress());

            deliveryAddressService.save(deliveryAddress);
        }
        else {
            DeliveryAddress address = (DeliveryAddress) deliveryAddressService.get(deliveryAddress.getId());
          //addressId --> name
            Zone province = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getProvince())).get(0);
            Zone city = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getCity())).get(0);
            Zone district = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getDistrict())).get(0);

            address.setAddress(deliveryAddress.getAddress());
            address.setProvince(province.getAddress());
            address.setCity(city.getAddress());
            address.setDistrict(district.getAddress());

            address.setPostCode(deliveryAddress.getPostCode());
            address.setUserName(deliveryAddress.getUserName());
            address.setUserPhone(deliveryAddress.getUserPhone());
            deliveryAddressService.update(address);
        }
        return "addressPage";
    }
    @Action("personaldeleteAddress")
    public String deleteAddress() {
        //将addressFlag 置为0 表示删除
        t2p(deliveryAddress);
        deliveryAddress.setAddressFlag(0);
        deliveryAddressService.update(deliveryAddress);
        return "addressPage";
    }
    /* 我的足迹 */
    @Action("personalfoot")
    public String foot() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        foots = footService.listByParent(user);
        for(Foot foot : foots) {
            productImageService.setFirstProductImage(foot.getProduct());
        }
        return "foot.jsp";
    }
    /* 删除单条浏览记录  */
    @Action("personaldeleteFoot")
    public String deleteFoot() {
        footService.delete(foot);
        return "footPage";
    }
    @Action("personalfavorite")
    public String favorite() {
        User u = (User)ActionContext.getContext().getSession().get("user");
        favorites = favoriteService.listByParent(u);
        for(Favorite favorite : favorites) {
            productImageService.setFirstProductImage(favorite.getProduct());
        }
        return "favorite.jsp";
    }
    
    @Action("personaldeleteFavorite")
    public String deleteFavorite() {
        favoriteService.delete(favorite);
        return "favoritePage";
    }
    @Action("personaladdFavorite")
    public String addFavorite() {
        User u = (User)ActionContext.getContext().getSession().get("user");
        List<Favorite> fa = favoriteService.list("user", u, "product", favorite.getProduct());
        //如果该产品已经在该用户的收藏中 则 直接返回
        if(!fa.isEmpty())
            return "favoritePage"; 
        favorite.setCtreateDate(new Date());
        favorite.setUser(u);
        favoriteService.save(favorite);
        return "favoritePage";
    }
}
