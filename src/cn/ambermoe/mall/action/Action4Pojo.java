package cn.ambermoe.mall.action;

import java.util.List;

import cn.ambermoe.mall.pojo.DeliveryAddress;
import cn.ambermoe.mall.pojo.Favorite;
import cn.ambermoe.mall.pojo.Foot;
import cn.ambermoe.mall.pojo.Admin;
import cn.ambermoe.mall.pojo.Category;
import cn.ambermoe.mall.pojo.Order;
import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.pojo.ProductImage;
/**
 * 提供实体对象 and 实体对象集合
 * setter 接收注入
 * getter 提供数据到JSP（VIEW）
 * @author ASUS
 *
 */
import cn.ambermoe.mall.pojo.Property;
import cn.ambermoe.mall.pojo.PropertyValue;
import cn.ambermoe.mall.pojo.Review;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.pojo.Zone;
public class Action4Pojo extends Action4Pagination {

    protected Category category;
    protected Property property;
    protected Product product;
    protected ProductImage productImage;
    protected PropertyValue propertyValue;
    protected User user;
    protected Order order;
    protected Review review;
    protected OrderItem orderItem;
    protected Admin admin;
    protected Zone zone;
    protected DeliveryAddress deliveryAddress;
    protected Foot foot;
    protected Favorite favorite;

    protected List<Category> categorys;
    protected List<Property> propertys;
    protected List<Product> products;
    protected List<PropertyValue> propertyValues;
    protected List<User> users;
    protected List<Order> orders;
    protected List<Review> reviews;
    protected List<OrderItem> orderItems;
    protected List<Zone> zones;
    protected List<DeliveryAddress> deliveryAddresss;
    protected List<Foot> foots;
    protected List<Favorite> favorites;
    
    protected List<ProductImage> productSingleImages;
    protected List<ProductImage> productDetailImages;

    

    public Favorite getFavorite() {
        return favorite;
    }
    public void setFavorite(Favorite favorite) {
        this.favorite = favorite;
    }
    public List<Favorite> getFavorites() {
        return favorites;
    }
    public void setFavorites(List<Favorite> favorites) {
        this.favorites = favorites;
    }
    public Foot getFoot() {
        return foot;
    }
    public void setFoot(Foot foot) {
        this.foot = foot;
    }
    public List<Foot> getFoots() {
        return foots;
    }
    public void setFoots(List<Foot> foots) {
        this.foots = foots;
    }
    public DeliveryAddress getDeliveryAddress() {
        return deliveryAddress;
    }
    public void setDeliveryAddress(DeliveryAddress deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
    public List<DeliveryAddress> getDeliveryAddresss() {
        return deliveryAddresss;
    }
    public void setDeliveryAddresss(List<DeliveryAddress> deliveryAddresss) {
        this.deliveryAddresss = deliveryAddresss;
    }
    public List<Zone> getZones() {
        return zones;
    }
    public void setZones(List<Zone> zones) {
        this.zones = zones;
    }
    public Zone getZone() {
        return zone;
    }
    public void setZone(Zone zone) {
        this.zone = zone;
    }
    public Admin getAdmin() {
        return admin;
    }
    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
    public OrderItem getOrderItem() {
        return orderItem;
    }
    public void setOrderItem(OrderItem orderItem) {
        this.orderItem = orderItem;
    }
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    public Review getReview() {
        return review;
    }
    public void setReview(Review review) {
        this.review = review;
    }
    public List<Review> getReviews() {
        return reviews;
    }
    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }
    public Order getOrder() {
        return order;
    }
    public void setOrder(Order order) {
        this.order = order;
    }
    public List<Order> getOrders() {
        return orders;
    }
    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    public List<User> getUsers() {
        return users;
    }
    public void setUsers(List<User> users) {
        this.users = users;
    }
    public PropertyValue getPropertyValue() {
        return propertyValue;
    }
    public void setPropertyValue(PropertyValue propertyValue) {
        this.propertyValue = propertyValue;
    }
    public List<PropertyValue> getPropertyValues() {
        return propertyValues;
    }
    public void setPropertyValues(List<PropertyValue> propertyValues) {
        this.propertyValues = propertyValues;
    }
    public ProductImage getProductImage() {
        return productImage;
    }
    public void setProductImage(ProductImage productImage) {
        this.productImage = productImage;
    }
    public List<ProductImage> getProductSingleImages() {
        return productSingleImages;
    }
    public void setProductSingleImages(List<ProductImage> productSingleImages) {
        this.productSingleImages = productSingleImages;
    }
    public List<ProductImage> getProductDetailImages() {
        return productDetailImages;
    }
    public void setProductDetailImages(List<ProductImage> productDetailImages) {
        this.productDetailImages = productDetailImages;
    }
    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }
    public List<Category> getCategorys() {
        return categorys;
    }
    public void setCategorys(List<Category> categorys) {
        this.categorys = categorys;
    }
    public Property getProperty() {
        return property;
    }
    public void setProperty(Property property) {
        this.property = property;
    }
    public List<Property> getPropertys() {
        return propertys;
    }
    public void setPropertys(List<Property> propertys) {
        this.propertys = propertys;
    }
    public Product getProduct() {
        return product;
    }
    public void setProduct(Product product) {
        this.product = product;
    }
    public List<Product> getProducts() {
        return products;
    }
    public void setProducts(List<Product> products) {
        this.products = products;
    }
    
}
