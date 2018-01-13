<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
  
<script>
$(function(){
    $("ul.pagination li.disabled a").click(function(){
        return false;
    });
});
  
</script>
  
<nav>
  <ul class="pagination">
    <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
      <a  href="?page.start=0${page.param}" aria-label="Previous" >
        <span aria-hidden="true">«</span>
      </a>
    </li>
  
    <li <c:if test="${!page.hasPreviouse}">class="disabled"</c:if>>
      <a  href="?page.start=${page.start-page.count}${page.param}" aria-label="Previous" >
        <span aria-hidden="true">‹</span>
      </a>
    </li>    
  
    <c:forEach begin="0" end="${page.totalPage-1}" varStatus="status">
      <!-- <=20 限制 包含当前页右侧只能有 20/page.count 个页导航（这里是4页 
           >=-10 限制 包含当前页左侧侧只能 4个页导航(也就是说 左侧会显示三页 其中的两页是10/page.count 
                  还有一页是 当page.start == 0 时 status.count = 1 这里多出来一页  -->
        <c:if test="${status.count*page.count-page.start<=20 && status.count*page.count-page.start>=-10}">
            <li <c:if test="${status.index*page.count==page.start}">class="disabled"</c:if>>
                <a 
                href="?page.start=${status.index*page.count}${page.param}"
                <c:if test="${status.index*page.count==page.start}">class="current"</c:if>
                >${status.count}</a>
            </li>
        </c:if>
    </c:forEach>
  
    <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
      <a href="?page.start=${page.start+page.count}${page.param}" aria-label="Next">
        <span aria-hidden="true">›</span>
      </a>
    </li>
    <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
      <a href="?page.start=${page.last}${page.param}" aria-label="Next">
        <span aria-hidden="true">»</span>
      </a>
    </li>
  </ul>
</nav>