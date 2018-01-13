package cn.ambermoe.mall.interceptor;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.struts2.StrutsStatics;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import cn.ambermoe.mall.pojo.Category;
import cn.ambermoe.mall.service.CategoryService;
/**
 * 如果访问的前端页面则在session中设置需要在搜索宽下显示的分类
 * @author ASUS
 *
 */
public class CategoryNamesBelowSearchInterceptor extends AbstractInterceptor {

    @Autowired
    CategoryService categoryService;
    @Override
    public String intercept(ActionInvocation arg0) throws Exception {
        ActionContext ac = arg0.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest)ac.get(StrutsStatics.HTTP_REQUEST);
        ServletContext servletContext = (ServletContext)ac.get(StrutsStatics.SERVLET_CONTEXT);
  
        String contextPath = servletContext.getContextPath();
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, contextPath);
        if(uri.startsWith("/fore") || uri.startsWith("/personal")) {
            List<Category> categorys = categoryService.list();
            ac.getSession().put("cs", categorys);
        }
        return arg0.invoke();
    }

}
