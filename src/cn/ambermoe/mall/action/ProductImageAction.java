package cn.ambermoe.mall.action;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;

import cn.ambermoe.mall.pojo.ProductImage;
import cn.ambermoe.mall.service.ProductImageService;
import cn.ambermoe.mall.util.ImageUtil;

public class ProductImageAction extends Action4Result {
    
    @Action("admin_productImage_list")
    public String list() {
        productSingleImages = productImageService.list("product", product, "type", ProductImageService.type_single);
        productDetailImages = productImageService.list("product", product, "type", ProductImageService.type_detail);
        t2p(product);
        return "listProductImage";
    }

    @Action("admin_productImage_add")
    public String add() {
        for(int i=0; i<img.length; i++) {
            productImageService.save(productImage);
            String folder = "img/";
            //根据图片type 确定图片的存放路径
            if(ProductImageService.type_single.equals(productImage.getType()))
                folder += "productSingle";
            else
                folder += "productDetail";
            //wen jian jia
            File imageFoler = new File(ServletActionContext.getServletContext().getRealPath(folder));
            
            System.out.println(imageFoler);
            File file = new File(imageFoler, productImage.getId() + ".jpg");
            String fileName = file.getName();
            //间接地继承了上传专用 Action4Upload类，
            //所以提供了一个img对象以接受上传的文件 
            try {
                //从临时文件 img --> file
                FileUtils.copyFile(img[i] ,file);
                //将 file(jpg or png or ..) --> img(img)
                BufferedImage img = ImageUtil.change2jpg(file);
                // img --> file
                ImageIO.write(img, "jpg", file);
            } catch (IOException e) {
                e.printStackTrace();
            }
            //如果图片类型是single 需要 复制两次 大小为 small middle
            if(ProductImageService.type_single.equals(productImage.getType())) {
                String imageFoler_small = ServletActionContext.getServletContext().getRealPath("img/productSingle_small");
                String imageFoler_middle = ServletActionContext.getServletContext().getRealPath("img/productSingle_middle");
                File f_small = new File(imageFoler_small, fileName);
                File f_middle = new File(imageFoler_middle, fileName);
                f_small.getParentFile().mkdirs();
                f_middle.getParentFile().mkdirs();
                ImageUtil.resizeImage(file, 56, 56, f_small);
                ImageUtil.resizeImage(file, 217, 190, f_middle);
            }
        }
        return "listProductImagePage";
    }
    
    @Action("admin_productImage_delete")
    public String delete() {
        t2p(productImage);
        String folder = "img/";
        //根据图片type 确定图片的存放路径
        if(ProductImageService.type_single.equals(productImage.getType()))
            folder += "productSingle";
        else
            folder += "productDetail";
        productImageService.delete(productImage);
        File imageFoler = new File(ServletActionContext.getServletContext().getRealPath(folder));
        File file = new File(imageFoler, productImage.getId() + ".jpg");
        String fileName = file.getName();
        //删除图片
        file.delete();
      //如果图片类型是single 需要将 small middle中的图片也删除
        if(ProductImageService.type_single.equals(productImage.getType())) {
            String imageFoler_small = ServletActionContext.getServletContext().getRealPath("img/productSingle_small");
            String imageFoler_middle = ServletActionContext.getServletContext().getRealPath("img/productSingle_middle");
            File f_small = new File(imageFoler_small, fileName);
            File f_middle = new File(imageFoler_middle, fileName);
            f_small.delete();
            f_middle.delete();

        }
        return "listProductImagePage";
    }
}
