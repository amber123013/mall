package cn.ambermoe.mall.action;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import cn.ambermoe.mall.pojo.Category;
import cn.ambermoe.mall.util.ImageUtil;
import cn.ambermoe.mall.util.Page;

public class CategoryAction extends Action4Result{

    @Action("admin_category_list")
    public String list() {
        if(page==null)
            page = new Page();
        int total = categoryService.total();
        page.setTotal(total);
        categorys = categoryService.listByPage(page);
        return "listCategory";
    }
    @Action("admin_category_add")
    public String add() {
        categoryService.save(category);
        File  imageFolder= new File(ServletActionContext.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder,category.getId()+".jpg");
        //另存一份在项目文件下
//        File  tmpimageFolder = new File("E:\\project\\WebContent\\img\\category");
//        File tmpfile = new File(tmpimageFolder,category.getId()+".jpg");
        
        try {
            FileUtils.copyFile(img[0], file);
            BufferedImage img = ImageUtil.change2jpg(file);
            ImageIO.write(img, "jpg", file);
//            ImageIO.write(img, "jpg", tmpfile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "listCategoryPage";
    }   
    @Action("admin_category_delete")
    public String delete() {
        categoryService.delete(category);
        //移除图片
        File  imageFolder= new File(ServletActionContext.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder,category.getId()+".jpg");
        
//        File tmpimageFolder = new File("E:\\project\\WebContent\\img\\category");
//        File tmpFile = new File(tmpimageFolder, category.getId() + ".jpg");
        file.delete();
//        tmpFile.delete();
        return "listCategoryPage";
    }
    @Action("admin_category_edit")
    public String edit() {
        t2p(category);
        return "editCategory";
    }
    @Action("admin_category_update")
    public String update() {
        categoryService.update(category);
        //更新时判断是否更新了图片
        if(null != img) {
            File  imageFolder= new File(ServletActionContext.getServletContext().getRealPath("img/category"));
            System.out.println(imageFolder.getAbsolutePath());
            File file = new File(imageFolder,category.getId()+".jpg");
            
//            File tmpimageFolder = new File("E:\\project\\WebContent\\img\\category");
//            File tmpFile = new File(tmpimageFolder, category.getId() + ".jpg");
            
            try {
                FileUtils.copyFile(img[0], file);
                BufferedImage img = ImageUtil.change2jpg(file);
                ImageIO.write(img, "jpg", file);
//                ImageIO.write(img, "jpg", tmpFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "listCategoryPage";
    }

}
