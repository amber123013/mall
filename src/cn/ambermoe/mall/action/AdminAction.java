package cn.ambermoe.mall.action;

import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;

import com.opensymphony.xwork2.ActionContext;

import cn.ambermoe.mall.pojo.Admin;

public class AdminAction extends Action4Result {
    @Action("admin_admin_login")
    public String login() {
        System.out.println(adminAutoLogin);
        if(null == admin)
            return "adminLogin.jsp";
        Admin admin_session = adminService.get(admin.getName(), admin.getPassword());
        if(null == admin_session){
            msg= "账号密码错误";
            return "adminLogin.jsp"; 
        }
        ActionContext.getContext().getSession().put("admin", admin_session);
        if("enable".equals(adminAutoLogin))
            addAdminCookie(admin_session.getId());
        return "listCategoryPage";
    }
    @Action("admin")
    public String jump() {
        return "listCategoryPage";
    }
  //管理员退出登录
    @Action("admin_admin_logout")
    public String logout() {
        ActionContext.getContext().getSession().remove("admin");
//        ActionContext.getContext().getSession().remove("admin.uuid");
        Cookie cookie = new Cookie("admin.uuid", null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        ServletActionContext.getResponse().addCookie(cookie);
        
        return "adminLogin.jsp";  
    }
    
    public void addAdminCookie(int id) {
        Cookie userCookie = new Cookie("admin.uuid",Integer.toString(id));
        System.out.println(userCookie.getValue() + " " + userCookie.getName());
        userCookie.setMaxAge(60 * 60 * 24 *15); //15天
        //只有 通过path的路径访问 才向服务器提交cookie
        userCookie.setPath("/");
        ServletActionContext.getResponse().addCookie(userCookie);
    }
}
