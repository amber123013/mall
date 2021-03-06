package cn.ambermoe.mall.action;

public class Action4Parameter extends Action4Service {

    //错误信息
    protected String msg;
    //分类页面的排序变量
    protected String sort;
    //当前所处于的web应用名称
    protected String contextPath;
     
    //搜索关键字
    protected String keyword;
     
    //购物数量
    protected int num;
     
    //立即购买生成的订单项id
    protected int oiid;
     
    //通过购物车选中的多个订单项id
    protected int[] oiids;
     
    //结算页面显示的总金额
    protected float total;
     
    //在进行评论的页面，是否只显示评论记录，而不提供输入
    protected boolean showonly;
    
    //管理员15天免登陆
    protected String adminAutoLogin;
    
    //用户15天免登陆 值为enable的话
    protected String userAutoLogin;
    //此参数暂时弃用
    protected String json;

    //订单存在多个产品时 评价的是排序数
    protected int reviewNumber; 
    //用户提交的 验证码 （邮箱
    protected String verificationCode;

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public int getReviewNumber() {
        return reviewNumber;
    }

    public void setReviewNumber(int reviewNumber) {
        this.reviewNumber = reviewNumber;
    }

    public String getJson() {
        return json;
    }

    public void setJson(String json) {
        this.json = json;
    }

    public String getUserAutoLogin() {
        return userAutoLogin;
    }

    public void setUserAutoLogin(String userAutoLogin) {
        this.userAutoLogin = userAutoLogin;
    }

    public String getAdminAutoLogin() {
        return adminAutoLogin;
    }

    public void setAdminAutoLogin(String adminAutoLogin) {
        this.adminAutoLogin = adminAutoLogin;
    }


    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getContextPath() {
        return contextPath;
    }

    public void setContextPath(String contextPath) {
        this.contextPath = contextPath;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getOiid() {
        return oiid;
    }

    public void setOiid(int oiid) {
        this.oiid = oiid;
    }

    public int[] getOiids() {
        return oiids;
    }

    public void setOiids(int[] oiids) {
        this.oiids = oiids;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public boolean isShowonly() {
        return showonly;
    }

    public void setShowonly(boolean showonly) {
        this.showonly = showonly;
    } 
    
}
