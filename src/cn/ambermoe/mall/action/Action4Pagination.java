package cn.ambermoe.mall.action;

import cn.ambermoe.mall.util.Page;
/**
 * 处理分页
 * @author ASUS
 *
 */
public class Action4Pagination extends Action4Upload {

    protected Page page;

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }
}
