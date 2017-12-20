package cn.ambermoe.mall.action;

import org.apache.struts2.convention.annotation.Action;

import cn.ambermoe.mall.util.Page;

public class UserAction extends Action4Result {
    @Action("admin_user_list")
    public String list() {
        if(page == null)
            page = new Page();
        int total = userService.total();
        page.setTotal(total);
        users = userService.listByPage(page);
        return "listUser";
    }
}
