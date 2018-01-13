package cn.ambermoe.mall.interceptor;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.StrutsStatics;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import cn.ambermoe.mall.pojo.OrderItem;
import cn.ambermoe.mall.pojo.User;
import cn.ambermoe.mall.service.OrderItemService;

public class CartTotalItemNumberInterceptor extends AbstractInterceptor {

    /**
     * 购物车中商品数量
     * 1. 判断是否是以/fore开头的访问
     * 2. 是否登陆
     *  2.1 如果登陆了，那么就把当前用户的未设置订单的订单项取出来，并累计其中的数量，然后放在session的"cartTotalItemNumber" 上
     *  2.2 如果未登陆，则把session的cartTotalItemNumber设置为0.
     */
    @Autowired
    OrderItemService orderItemService;
    @Override
    public String intercept(ActionInvocation arg0) throws Exception {
        ActionContext ac = arg0.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest)ac.get(StrutsStatics.HTTP_REQUEST);
        ServletContext servletContext = (ServletContext)ac.get(StrutsStatics.SERVLET_CONTEXT);
        String contextPath = servletContext.getContextPath();
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, contextPath);
        if(uri.startsWith("/fore") || uri.startsWith("/personal")) {
            User user = (User)ac.getSession().get("user");
            //未登录显示0件
            if(null == user) {
                ac.getSession().put("cartTotalItemNumber", 0);
            } else {
                int cartTotalItemNumber = 0;
                List<OrderItem> ois = orderItemService.list("user", user, "order", null);
                for (OrderItem oi : ois)
                    cartTotalItemNumber += oi.getNumber();
                ac.getSession().put("cartTotalItemNumber", cartTotalItemNumber);
            }
        }
        return arg0.invoke();
    }

}
