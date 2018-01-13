package cn.ambermoe.mall.action;

import java.util.Date;

import org.apache.struts2.convention.annotation.Action;

import cn.ambermoe.mall.pojo.Product;
import cn.ambermoe.mall.util.Page;

public class ProdcutAction extends Action4Result {
    @Action("admin_product_list")
    public String list() {
        if(page == null)
            page = new Page();
        int total = productService.total(category);
//        System.out.println(total);
        page.setTotal(total);
        page.setParam("&category.id=" + category.getId());
        products = productService.list(page, category);
        
        //设置产品图片缩略图
        for(Product product : products) {
            productImageService.setFirstProductImage(product);
        }
        //指向持久对象(面包屑导航需要分类名称
        t2p(category);
        return "listProduct";
    }

    @Action("admin_product_add")
    public String add() {
        product.setCreateDate(new Date());
        productService.save(product);
        return "listProductPage";
    }
    /**
     * 删除产品 直接将该产品设为下架状态
     */
    @Action("admin_product_delete")
    public String delete() {
        t2p(product);
        product.setSale(0);
        productService.update(product);;
        return "listProductPage";
    }

    @Action("admin_product_edit")
    public String edit() {
        //获得product.category.id 用于跳转到分类下的产品查询页
        t2p(product);
        return "editProduct";
    }
    
    @Action("admin_product_update")
    public String update() {
        Product productFormDB = (Product)productService.get(product.getId());
        product.setCreateDate(productFormDB.getCreateDate());
        productService.update(product);
        return "listProductPage";
    }
}
