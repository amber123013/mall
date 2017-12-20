package cn.ambermoe.mall.action;

import org.apache.struts2.convention.annotation.Action;

import cn.ambermoe.mall.util.Page;

public class PropertyAction extends Action4Result {

    @Action("admin_property_list")
    public String list(){
        if(page == null)
            page = new Page();
        int total = propertyService.total(category);
        page.setTotal(total);
        page.setParam("&category.id=" + category.getId());
        propertys = propertyService.list(page, category);
        t2p(category);
        return "listProperty";
    }

    @Action("admin_property_add")
    public String add() {
        propertyService.save(property);
        return "listPropertyPage";
    }

    /**
     * 只传递了property.id过来，但是删除结束之后，
     * 要跳转到property对应的分类下的属性查询界面，
     * 所以需要通过t2p()方法把其对应的分类信息查询出来 (category.id
     * @return
     */
    @Action("admin_property_delete")
    public String delete() {
        t2p(property);
        propertyService.delete(property);
        return "listPropertyPage";
    }

    @Action("admin_property_edit")
    public String edit() {
        t2p(property);
        return "editProperty";
    }

    @Action("admin_property_update")
    public String update() {
        propertyService.update(property);
        return "listPropertyPage";
    }
}
