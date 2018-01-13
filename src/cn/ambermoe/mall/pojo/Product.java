package cn.ambermoe.mall.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "product")
public class Product implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    /**
     * 
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    int id;
    @ManyToOne
    @JoinColumn(name = "cid")
    private Category category;
    //hibenate 会自动识别字段 可以省略 @Column(name = "xxx")
    //产品名
    private String name;
    //产品小标题
    private String subTitle;
    //原价
    private float originalPrice;
    //促销价
    private float promotePrice;
    //库存量
    private int stock;
    //创建日期
    private Date createDate;
    //是否上架 1代表上架 0代表下架 
    private int sale = 1;
    
    @Transient  //瞬时字段 不会被保存到数据库中
    private ProductImage firstProductImage;
    @Transient
    private List<ProductImage> productSingleImages;
    @Transient
    private List<ProductImage> productDetailImages;
    //评论数
    @Transient
    private int reviewCount;
    //销量
    @Transient
    private int saleCount;
    

    public int getSale() {
        return sale;
    }
    public void setSale(int sale) {
        this.sale = sale;
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
    public int getReviewCount() {
        return reviewCount;
    }
    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }
    public int getSaleCount() {
        return saleCount;
    }
    public void setSaleCount(int saleCount) {
        this.saleCount = saleCount;
    }
    public ProductImage getFirstProductImage() {
        return firstProductImage;
    }
    public void setFirstProductImage(ProductImage firstProductImage) {
        this.firstProductImage = firstProductImage;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public Category getCategory() {
        return category;
    }
    public void setCategory(Category category) {
        this.category = category;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSubTitle() {
        return subTitle;
    }
    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }
    public float getOriginalPrice() {
        return originalPrice;
    }
    public void setOriginalPrice(float originalPrice) {
        this.originalPrice = originalPrice;
    }
    public float getPromotePrice() {
        return promotePrice;
    }
    public void setPromotePrice(float promotePrice) {
        this.promotePrice = promotePrice;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public Date getCreateDate() {
        return createDate;
    }
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
}
