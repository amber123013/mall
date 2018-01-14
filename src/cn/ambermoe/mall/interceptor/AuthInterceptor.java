package cn.ambermoe.mall.interceptor;

import java.util.Arrays;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.StrutsStatics;
import org.apache.taglibs.standard.lang.jstl.NullLiteral;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.sun.xml.internal.bind.v2.runtime.reflect.Lister.CollectionLister;

import cn.ambermoe.mall.pojo.Admin;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.service.AdminService;
import cn.ambermoe.mall.service.UserService;


public class AuthInterceptor extends AbstractInterceptor {
    @Autowired
    UserService userService;
    @Autowired
    AdminService adminService;
    /**
     * authentication 身份验证
     * 这个过滤器就判断如果不是注册，登录，产品这些，就进行登录校验
     * 1. 准备字符串数组 noNeedAuthPage，存放哪些不需要登录也能访问的路径
     * 2. 获取contextPath： tmall_ssh
     * 2. 获取uri
     * 3. 去掉前缀/tmall_ssh
     * 4. 如果访问的地址是/fore开头
     *   4.1 取出fore后面的字符串，比如是forecart,那么就取出cart
     *   4.2 判断cart是否是在noNeedAuthPage 
     *   4.2 如果不在，那么就需要进行是否登录验证
     *   4.3 从session中取出"user"对象
     *   4.4 如果user对象不存在，就客户端跳转到login.jsp
     *   4.5 否则就正常执行
     */
    @Override
    public String intercept(ActionInvocation arg0) throws Exception {
        String[] noNeedAuthPage = new String[]{
                "home",
                "checkLogin",
                "register",
                "loginAjax",
                "login",
                "product",
                "category",
                "search"
        };
        ActionContext ac = arg0.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest) ac.get(StrutsStatics.HTTP_REQUEST);
        HttpServletResponse response = (HttpServletResponse) ac.get(StrutsStatics.HTTP_RESPONSE);
        //取出cookie
        Cookie[] cookies = request.getCookies();
        Cookie userCookie = null;
        Cookie adminCookie = null;
        if(null != cookies)
            for(Cookie c:cookies) {
                if("user.uuid".equals(c.getName())) {
                    userCookie = c;
                } else if("admin.uuid".equals(c.getName())) {
                    adminCookie = c;
                }
            }
        //user 自动登陆
        if(null == ac.getSession().get("user")) {
            if(null != userCookie) {
                //cookie存在的话 设置session 
                ac.getSession().put("user", userService.get(Integer.parseInt(userCookie.getValue())));
            }
        }
        //admin 自动登陆
        if(null == ac.getSession().get("admin")) {
            if(null != adminCookie) {
                //cookie存在的话 设置session 
                ac.getSession().put("admin", adminService.get(Integer.parseInt(adminCookie.getValue())));
            }
        }
        ServletContext servletContext = (ServletContext) ac.get(StrutsStatics.SERVLET_CONTEXT);
        String contextPath = servletContext.getContextPath();
        String url = request.getRequestURL().toString();
        String uri = request.getRequestURI();
        String address = request.getRemoteAddr() != null?request.getRemoteAddr():request.getHeader("x-forwarded-for");
        System.out.println("从:" + address + "发来了请求,地址为:" + url);
//        System.out.println(url);
//        System.out.println(uri);
        //3
        uri = StringUtils.remove(uri, contextPath);
        if(uri.startsWith("/fore")) {
            //取出/fore 后的字符
            String method = StringUtils.substringAfterLast(uri, "/fore");
            //需要进行验证
            if(!Arrays.asList(noNeedAuthPage).contains(method)) {
                User user = (User)ac.getSession().get("user");
                //未登录
                if(null == user) {
                    response.sendRedirect("login.jsp");
                    return null;
                }
            }
        } else if(uri.startsWith("/admin") && !uri.startsWith("/admin_admin")) {
            //不是登录的访问后台页面全部需要进行拦截
            if(!(uri.contains("admin_admin_login"))) {
                Admin admin = (Admin)ac.getSession().get("admin");
                if(null == admin) {
                    request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
    //                response.sendRedirect("adminLogin.jsp");
                    return null;
                }
            }
        } else if(uri.startsWith("/personal")) {
            //访问个人中心全部需要登录
            User user = (User)ac.getSession().get("user");
            //未登录
            if(null == user) {
                response.sendRedirect("login.jsp");
                return null;
            }
        }
        return arg0.invoke();
    }

}
