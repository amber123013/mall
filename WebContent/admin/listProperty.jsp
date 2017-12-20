<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>
 
<script>
    $(function() {
 
        $("#addForm").submit(function() {
        	//设置提交按钮不可用
            $("#submitButton").attr("disabled","true"); //设置变灰按钮    
            if (checkEmpty("name", "属性名称"))
                return true;
            //验证未通过 复原提交按钮
            $("#submitButton").removeAttr("disabled");
            return false;
        });
    });
</script>
 
<title>属性管理</title>
 
<div class="workingArea">
 
    <ol class="breadcrumb">
      <li><a href="admin_category_list">所有分类</a></li>
      <li><a href="admin_property_list?category.id=${category.id}">${category.name}</a></li>
      <li class="active">属性管理</li>
    </ol>
 
    <div class="listDataTableDiv">
        <table
            class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${propertys}" var="p">
 
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td><a href="admin_property_edit?property.id=${p.id}"><span
                                class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true"
                            href="admin_property_delete?property.id=${p.id}"><span
                                class="     glyphicon glyphicon-trash"></span></a></td>
 
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
 
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>
 
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增属性</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_property_add">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input id="name" name="property.name" type="text"
                            class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="property.category.id" value="${category.id}">
                            <button id="submitButton" type="submit" class="btn btn-success">提 交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
 
</div>
 
<%@include file="../include/admin/adminFooter.jsp"%>