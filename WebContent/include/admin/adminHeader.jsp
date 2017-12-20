<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %> 
  
<html>
  
<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/back/style.css" rel="stylesheet">
      
<script>
function checkEmpty(id, name){
    var value = $("#"+id).val();
    if(value.length==0){
        alert(name+ "不能为空");
        $("#"+id)[0].focus();
        return false;
    }
    return true;
}
function checkIsImage(id) {
	 var value = $("#" + id)[0];
	 //上传文件路径（含名称
	 var name = value.value;
	 //alert(value.value);
	 var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
	//首先判断是否是图片
	 if(fileName !="jpg" && fileName !="jpeg" && fileName !="pdf" && fileName !="png" && fileName !="dwg" && fileName !="gif" ){
         alert("请选择图片格式文件上传(jpg,png,gif,dwg,pdf,gif。。)！");
           value.value="";
           return false;
     }
	//图片大小应不大于2m
	var imgSize = value.files[0].size;
	var size = imgSize / (1024 * 1024);
	if(size > 2) {
		alert("图片不能大于2M");
		value.value="";
        return false;
	}
	return true;
}
function checkNumber(id, name){
    var value = $("#"+id).val();
    if(value.length==0){
        alert(name+ "不能为空");
        $("#"+id)[0].focus();
        return false;
    }
    if(isNaN(value)){
        alert(name+ "必须是数字");
        $("#"+id)[0].focus();
        return false;
    }
      
    return true;
}
function checkInt(id, name){
    var value = $("#"+id).val();
    if(value.length==0){
        alert(name+ "不能为空");
        $("#"+id)[0].focus();
        return false;
    }
    if(parseInt(value)!=value){
        alert(name+ "必须是整数");
        $("#"+id)[0].focus();
        return false;
    }
      
    return true;
}
  
$(function(){
    $("a").click(function(){
        var deleteLink = $(this).attr("deleteLink");
        console.log(deleteLink);
        if("true"==deleteLink){
            var confirmDelete = confirm("确认要删除");
            if(confirmDelete)
                return true;
            return false;
              
        }
    });
})
</script> 
</head>
<body>