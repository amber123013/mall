package cn.ambermoe.mall.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.xwork.math.RandomUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.tomcat.jni.OS;
import org.springframework.jdbc.object.UpdatableSqlQuery;
import org.springframework.web.util.HtmlUtils;

import com.opensymphony.xwork2.ActionContext;
import com.sun.net.httpserver.Authenticator.Success;

import cn.ambermoe.mall.comparator.OrderComparator;
import cn.ambermoe.mall.comparator.ProductAllComparator;
import cn.ambermoe.mall.comparator.ProductDateComparator;
import cn.ambermoe.mall.comparator.ProductPriceComparator;
import cn.ambermoe.mall.comparator.ProductReviewComparator;
import cn.ambermoe.mall.comparator.ProductSaleCountComparator;
import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.pojo.Zone;
import cn.ambermoe.mall.service.OrderService;
import cn.ambermoe.mall.service.ProductImageService;
import cn.ambermoe.mall.util.JsonUtils;
import cn.ambermoe.mall.util.Page;

public class ForeAction extends Action4Result {
    /**
     * 查找出分类列表 并填充所需显示的 产品集合
     * 跳转到主页
     */
    @Action("forehome")
    public String home() {
        categorys = categoryService.list();
        //fillByRow 会用到fill() 填充的product 列表 
        productService.fill(categorys);
        productService.fillByRow(categorys);
        return "home.jsp";
    }
    //前台注册
    @Action("foreregister")
    public String register() {
        //HtmlUtils.htmlEscape 对特殊字符进行转义 如   < --> &lt
        user.setName(HtmlUtils.htmlEscape(user.getName()));
        
        boolean exist = userService.isExist(user.getName());
        if(exist) {
            msg = "此用户名已经被使用";
            return "register.jsp";
        }
        userService.save(user);
        return "registerSuccessPage";
    }
    //前台登录
    @Action("forelogin")
    public String login() {
        user.setName(HtmlUtils.htmlEscape(user.getName()));
        User user_session = userService.get(user.getName(),user.getPassword());
        if(null == user_session){
            msg= "账号密码错误";
            return "login.jsp"; 
        }
        ActionContext.getContext().getSession().put("user", user_session);
        //勾选了15天免登陆
        if("enable".equals(userAutoLogin))
            addUserCookie(user_session.getId());
        return "homePage";
    }
    //设置cookie 用于保持登录状态
    public void addUserCookie(int id) {
        Cookie userCookie = new Cookie("user.uuid",Integer.toString(id));
        System.out.println(userCookie.getValue() + " " + userCookie.getName());
        userCookie.setMaxAge(60 * 60 * 24 *15); //15天
        //只有 通过path的路径访问 才向服务器提交cookie
        userCookie.setPath("/");
        ServletActionContext.getResponse().addCookie(userCookie);
    }
    //前台退出登录
    @Action("forelogout")
    public String logout() {
        ActionContext.getContext().getSession().remove("user");

        Cookie cookie = new Cookie("user.uuid", null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        ServletActionContext.getResponse().addCookie(cookie);
        return "homePage";  
    }
    /**
     * 1. 把product 指向持久化对象
     * 2. 设置首张图片
     * 3. 设置单个和详情图片集合
     * 4. 获取本产品的属性值集合
     * 5. 获取本产品的评价集合
     * 6. 设置销售数量和评价数量
     * 7. 服务端跳转到 product.jsp
     */
    @Action("foreproduct")
    public String product() {
        t2p(product);
        if(0 == product.getSale()) {
            // 跳转到提示 当前产品已下架的页面 
        }
        productImageService.setFirstProductImage(product);

        productSingleImages = productImageService.list("product", product, "type", ProductImageService.type_single);
        productDetailImages = productImageService.list("product", product, "type", ProductImageService.type_detail);
        product.setProductSingleImages(productSingleImages);
        product.setProductDetailImages(productDetailImages);

        propertyValues = propertyValueService.listByParent(product);

        reviews = reviewService.listByParent(product);

        productService.setSaleAndReviewNumber(product);
        //如果登陆 记录浏览历史
        User u = (User)ActionContext.getContext().getSession().get("user");
        if(null != u) {
            footService.changeToFirst(product, u);
        }
        return "product.jsp";
    }
    //检查是否登陆
    @Action("forecheckLogin")
    public String checkLogin() {
        User u = (User)ActionContext.getContext().getSession().get("user");
        if(null == u)
            return "fail.jsp";
        return "success.jsp";
    }
    /**
     * 前台 模态框使用ajax提交账号密码登陆时 调用
     * 1. 通过HtmlUtils.htmlEscape将账号转义，因为数据库里保存的是转义过后的
     * 2. 通过账号密码获取User对象
     *   2.1 如果User对象为空，那么就返回"fail"字符串。
     *   2.2 如果User对象不为空，那么就把User对象放在session中，并返回"success" 字符串
     */
    @Action("foreloginAjax")
    public String loginAjax() {
        user.setName(HtmlUtils.htmlEscape(user.getName()));
        User user_session = userService.get(user.getName(), user.getPassword());
        if(null == user_session) {
            return "fail.jsp";
        }
        ActionContext.getContext().getSession().put("user", user_session);
        /*addUserCookie(user_session.getId());*/
        return "success.jsp";

    }
    /**
     * 前台分类页 
     */
    @Action("forecategory")
    public String category() {
        if(null == page)
            page = new Page();
        t2p(category);
        productService.fill(category);
        productService.setSaleAndReviewNumber(category.getProducts());
        //页面传回sort参数
        if(null != sort) {
            switch (sort) {
                case "review":
                    Collections.sort(category.getProducts(), new ProductReviewComparator());
                    break;
                case "date":
                    Collections.sort(category.getProducts(), new ProductDateComparator());
                    break;
                case "saleCount":
                    Collections.sort(category.getProducts(), new ProductSaleCountComparator());
                    break;
                case "price":
                    Collections.sort(category.getProducts(), new ProductPriceComparator());
                    break;
                case "all":
                    Collections.sort(category.getProducts(), new ProductAllComparator());
                    break;
            }
        }
        return "category.jsp";
    }
    /**
     * 1. 获取参数keyword
     * 2. 根据keyword进行模糊查询，获取满足条件的前20个产品
     * 3. 为这些产品设置销量和评价数量
     * 4. 服务端跳转到 searchResult.jsp 页面
     */
    @Action("foresearch")
    public String search() {
        products = productService.search(keyword, 0, 20);
        productService.setSaleAndReviewNumber(products);
        for(Product product:products) {
            productImageService.setFirstProductImage(product);
        }
        return "searchResult.jsp";
    }
    /**
     * a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
        a.1 基于用户对象user，查询没有生成订单的订单项集合
        a.2 遍历这个集合
        a.3 如果产品是一样的话，就进行数量追加
        a.4 获取这个订单项的 id
        
      * b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        b.1 生成新的订单项
        b.2 设置数量，用户和产品
        b.3 插入到数据库
        b.4 获取这个订单项的 id
                             最后， 基于这个订单项id客户端跳转到结算页面的 对应的/forebuy
     */
    @Action("forebuyone")
    public String buyone() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        boolean found = false;
        //查找出该用户 未创建订单的订单项
        List<OrderItem> ois = orderItemService.list("user", user, "order", null);
        for(OrderItem oi:ois) {
            if(oi.getProduct().getId() == product.getId()) {
                //a.3
                oi.setNumber(oi.getNumber() + num);
                orderItemService.update(oi);
                found = true;
                oiid = oi.getId();
                break;
            }
        }
        //b
        if(!found) {
            OrderItem oi = new OrderItem();
            oi.setNumber(num);
            oi.setProduct(product);
            oi.setUser(user);
            orderItemService.save(oi);
            oiid = oi.getId();
        }
        return "buyPage";
    }
    /**
     * 只能返回String
     * 将list 转为 json 返回
     * 返回json字符串的话 需要 struts2-json-plugin-2.1.8.1.jar 包
     * 返回格式是 json 
     * 这个action 直接在 struts.xml 中配置 
     */
    public String getaddress() {
        zones = zoneService.list("parentId", zone.getAddressId());
        //json = JsonUtils.toJson(zoneService.list("parentId", zone.getAddressId()));
        return "success";
    }
    /**
     *  1. 获取参数：数组 oiid
        2. 让orderItems 指向一个新的ArrayList
        3. 根据前面步骤获取的oiids，从数据库中取出OrderItem对象，并放入orderItems 集合中
        4. 累计这些ois的价格总数，赋值在total上
        5. 把订单项集合放在session的属性 "orderItems" 上， 后续生成订单的时候，还会用到它。
        6. 服务端跳转到buy.jsp
     */
    @Action("forebuy")
    public String buy() {
        ArrayList<OrderItem> orderItems = new ArrayList<>();
        for(int oiid:oiids) {
            OrderItem oi = (OrderItem) orderItemService.get(oiid);
            total += oi.getProduct().getPromotePrice() * oi.getNumber();
            orderItems.add(oi);
            productImageService.setFirstProductImage(oi.getProduct());
        }
        ActionContext.getContext().getSession().put("orderItems", orderItems);
        //下拉款省份
        zones = zoneService.list("parentId", 0);
        
        return "buy.jsp";
    }
    /**
     *  a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
            a.1 基于用户对象user，查询没有生成订单的订单项集合
            a.2 遍历这个集合
            a.3 如果产品是一样的话，就进行数量追加
            a.4 获取这个订单项的 id
        b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
            b.1 生成新的订单项
            b.2 设置数量，用户和产品
            b.3 插入到数据库
            b.4 获取这个订单项的 id
                           与 ForeAction.buyone() 客户端跳转到结算页面不同的是， 最后返回字符串"success"，表示添加成功
     */
    @Action("foreaddCart")
    public String addCart() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        boolean found = false;
        List<OrderItem> ois = orderItemService.list("user", user, "order", null);
        for(OrderItem oi:ois) {
            if(oi.getProduct().getId() == product.getId()) {
                //a.3
                oi.setNumber(oi.getNumber() + num);
                orderItemService.update(oi);
                found = true;
                break;
            }
        }
        //b
        if(!found) {
            OrderItem oi = new OrderItem();
            oi.setNumber(num);
            oi.setProduct(product);
            oi.setUser(user);
            orderItemService.save(oi);
        }
        return "success.jsp";
    }
    /**
     * 1. 通过session获取当前用户
                                所以一定要登录才访问，否则拿不到用户对象
       2. 获取这个用户未关联的订单的订单项集合 orderItems
       3. 为每个订单项添加图片
       4. 服务端跳转到cart.jsp
     */
    @Action("forecart")
    public String cart() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        orderItems = orderItemService.list("user", user, "order", null);
        for(OrderItem orderItem:orderItems) {
            productImageService.setFirstProductImage(orderItem.getProduct());
        }
        return "cart.jsp";
    }
    /**
     * 调整购物车中商品数量
     */
    @Action("forechangeOrderItem")
    public String changeOrderItem() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        List<OrderItem> ois = orderItemService.list("user", user, "product", product, "order", null);
        OrderItem oi = ois.get(0);
        oi.setNumber(num);
        orderItemService.update(oi);
        return "success.jsp";
    }
    /**
     * 删除订单项 
     */
    @Action("foredeleteOrderItem")
    public String deleteOrderItem() {
        orderItemService.delete(orderItem);
        return "success.jsp";
    }
    /**
     * 1. 从session获取订单项集合. ( 在结算功能的ForeAction.buy()订单项集合被放到了session中 )
     * 2. 如果订单项集合是空，则跳转到登陆页面
     * 3. 从session中获取user对象
     * 4. 根据当前时间加上一个4位随机数生成订单号
     * 4. 根据上述参数，创建订单对象
     * 5. 把订单状态设置为等待支付
     *　6. 调用OrderServiceImpl.createOrder() 把订单插入到数据库，并设置每个订单项的Order属性，更新到数据库
     * 7. 获取本次订单的总金额
     * 8. 客户端跳转到确认支付页forealipay
     */
    @Action("forecreateOrder")
    public String createOrder() {
        List<OrderItem> ois = (ArrayList<OrderItem>) ActionContext.getContext().getSession().get("orderItems");
        if(ois.isEmpty())
            return "login.jsp";
        User user = (User) ActionContext.getContext().getSession().get("user");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUser(user);
        order.setStatus(OrderService.waitPay);
        total = orderService.createOrder(order, ois);
        System.out.println(order.toString());
        return "alipayPage";
    }
    public String ajaxcreateOrder() {
        List<OrderItem> ois = (ArrayList<OrderItem>) ActionContext.getContext().getSession().get("orderItems");
        if(ois.isEmpty())
            return "login.jsp";
        User user = (User) ActionContext.getContext().getSession().get("user");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUser(user);
        order.setStatus(OrderService.waitPay);
        total = orderService.createOrder(order, ois);
        System.out.println(order.toString());
        return "success";
    }
    //跳转到页面
    @Action("forealipay")
    public String alipay() {
        return "alipay.jsp";
    }
    /**
     * 支付成功页
     * 1.1 让order引用指向持久化对象
     * 1.2 修改订单对象的状态和支付时间
     * 1.3 更新这个订单对象到数据库
     * 1.4 服务端跳转到payed.jsp
     */
    @Action("forepayed")
    public String payed() {
        t2p(order);
        //更改订单状态为待收
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        return "payed.jsp";
    }
    /**
     * 1. 通过session获取用户user
     * 2. 查询user所有的状态不是"delete" 的订单集合os
     * 3. 为这些订单填充订单项
     * 4. 服务端跳转到bought.jsp
     */
    @Action("forebought")
    public String bought() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        orders = orderService.listByUserWithoutDelete(user);
        orderItemService.fill(orders);
        Collections.sort(orders, new OrderComparator());
        return "bought.jsp";
    }
    //为order填充orderItem 并跳转到 确认收货页面
    @Action("foreconfirmPay")
    public String confirmPay() {
        t2p(order);
        orderItemService.fill(order);
        return "confirmPay.jsp";
    }
    //确认收货
    @Action("foreorderConfirmed")
    public String orderConfirmed() {
        t2p(order);
        //更改订单状态为待评价
        order.setStatus(OrderService.waitReview);
        order.setConfirmDate(new Date());
        orderService.update(order);
        return "orderConfirmed.jsp";
    }
    //标记订单为删除
    @Action("foredeleteOrder")
    public String deleteOrder(){
        t2p(order);
        order.setStatus(OrderService.delete);
        orderService.update(order);
        return "success.jsp";       
    }
    //跳转到评价页面
    @Action("forereview")
    public String review() {
        t2p(order);
        // 填充在review 页面所需的数据
        orderItemService.fill(order);
        product = order.getOrderItems().get(reviewNumber).getProduct();
        reviews = reviewService.listByParent(product);
        productService.setSaleAndReviewNumber(product);
        return "review.jsp";
    }
    
    @Action("foredoreview")
    public String doreview() {
        t2p(order);
        t2p(product);
        
        //取出评论进行转义 使特殊字符失效
        String content = review.getContent();
        content = HtmlUtils.htmlEscape(content);
        review.setContent(content);
        User user = (User)ActionContext.getContext().getSession().get("user");
        //设置评论的全部信息 并存入数据库
        review.setProduct(product);
        review.setCreateDate(new Date());
        review.setUser(user);
        reviewService.save(review);
        // 为orderItem 设置 review
        orderItemService.fill(order);
        orderItem = (OrderItem)order.getOrderItems().get(reviewNumber);
        orderItem.setReview(review);
        orderItemService.update(orderItem);
        
        //当订单的所有订单项都 评论完成后 更新订单状态为 完成
        if(orderItemService.list("order", order, "review", null).size() == 0) {
            order.setStatus(OrderService.finish);
            orderService.update(order);
        }
        //只显示评论
        showonly = true;
        return "reviewPage";
    }
    
    @Action("foreaddaddress")
    public String ajaxAddAddress() {
        deliveryAddress.setCreateTime(new Date());
        User user = (User)ActionContext.getContext().getSession().get("user");
        deliveryAddress.setUser(user);
        deliveryAddress.setAddressFlag(1);
        //addressId --> name
        Zone province = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getProvince())).get(0);
        deliveryAddress.setProvince(province.getAddress());
        Zone city = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getCity())).get(0);
        deliveryAddress.setCity(city.getAddress());
        Zone district = (Zone)zoneService.list("addressId",Integer.parseInt(deliveryAddress.getDistrict())).get(0);
        deliveryAddress.setDistrict(district.getAddress());
        
        deliveryAddressService.save(deliveryAddress);
        return "success.jsp";
    }
    
    public String ajaxGetAddress() {
        User user = (User)ActionContext.getContext().getSession().get("user");
        deliveryAddresss = deliveryAddressService.list("user", user, "addressFlag", 1);
        return "success";
    }
}
