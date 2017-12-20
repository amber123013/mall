<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<script>
$(function(){
     
    $("#addForm").submit(function(){
    	//设置提交按钮不可用
        $("#submitButton").attr("disabled","true"); //设置变灰按钮   
        if(checkEmpty("name","分类名称"))
            return true;
        if(checkEmpty("categoryPic","分类上传图片"))
            return true;
      //验证未通过 复原提交按钮
        $("#submitButton").removeAttr("disabled");
        return false;
    });
	$("#addCategory").click(function(){
		$("#addCategoryModal").modal('show');
	});
});

 
</script>
 
<title>分类管理</title>
 
<div class="workingArea">
    <h1 class="label label-info">分类管理</h1> 
    <input style="margin-left:12px;padding: 3px 8px;" id="addCategory" type="button" class="btn btn-success" value="新增分类">
    <br>
    <br>
     
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>图片</th>
                    <th>分类名称</th>
                    <th>属性管理</th>
                    <th>产品管理</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${categorys}" var="c">
                 
                <tr>
                    <td>${c.id}</td>
                    <td><img height="40px" src="img/category/${c.id}.jpg"></td>
                    <td>${c.name}</td>
                         
                    <td><a href="admin_property_list?category.id=${c.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>                    
                    <td><a href="admin_product_list?category.id=${c.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>                   
                    <td><a href="admin_category_edit?category.id=${c.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true" href="admin_category_delete?category.id=${c.id}"><span class="  glyphicon glyphicon-trash"></span></a></td>
     
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
     
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>
    <div class="modal" id="addCategoryModal" tabindex="-1" role="dialog" style="margin-top:10%">
	    <div class="panel panel-warning addDiv">
	      <div class="panel-heading">新增分类</div>
	      <div class="panel-body">
	            <form method="post" id="addForm" action="admin_category_add" enctype="multipart/form-data">
	                <table class="addTable">
	                    <tr>
	                        <td>分类名称</td>
	                        <td><input  id="name" name="category.name" type="text" class="form-control"></td>
	                    </tr>
	                    <tr>
	                        <td>分类图片</td>
	                        <td>
	                            <!-- 选择图片后立即进行 判断 -->
	                            <input id="categoryPic" type="file" name="img" onchange="checkIsImage(id);"/>
	                        </td>
	                    </tr>
	                    <tr class="submitTR">
	                        <td colspan="2" align="center">
	                            <button id="submitButton" type="submit" class="btn btn-success">提 交</button>&nbsp;&nbsp;&nbsp;&nbsp;
	                            <button type="button" data-dismiss="modal" class="btn btn-default">取消</button>
	                        </td>
	                    </tr>
	                </table>
	            </form>
	      </div>
	    </div>
    </div>
     
</div>
 
<%@include file="../include/admin/adminFooter.jsp"%>