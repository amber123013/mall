package cn.ambermoe.mall.util;

public class Page {

    // 当前页开始位置(默认初始化int 为0
    private int start;
    //每页显示记录条数
    private int count;
    //总共的记录条数
    private int total;
    private String param;
    //默认每页显示条数
    private static final int defaultCount = 5;
    
    public Page (){
        count = defaultCount;
    }
    public Page(int start, int count) {
        super();
        this.start = start;
        this.count = count;
    }
    
    //是否有前一页
    public boolean isHasPreviouse(){
        if(start==0)
            return false;
        return true;
        
    }
    //是否有下一页
    public boolean isHasNext(){
        if(start==getLast())
            return false;
        return true;
    }
    /**
     * 返回共有几页
     * @return 总共页数
     */
    public int getTotalPage() {
        int totalPage;
        if(0 == total % count) {
            totalPage = total / count;
        } else {
            totalPage = total / count + 1;
        }
        if (0 == totalPage) {
            totalPage = 1;
        }
        return totalPage;
    }
    /**
     * 得到 最后一页开始的地方
     * @return 最后一页开始的条数
     */
    public int getLast() {
        int last;
        if(0 == total % count) {
            last = total - count;
        } else {
            last = total - total % count; 
        }
        last = last<0?0:last;
        
        return last;
    }
    public int getStart() {
        return start;
    }
    public void setStart(int start) {
        this.start = start;
    }
    public int getCount() {
        return count;
    }
    public void setCount(int count) {
        this.count = count;
    }
    @Override
    public String toString() {
        return "Page [start=" + start + ", count=" + count + ", total=" + total + ", param=" + param + "]";
    }
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public String getParam() {
        return param;
    }
    public void setParam(String param) {
        this.param = param;
    }
}
