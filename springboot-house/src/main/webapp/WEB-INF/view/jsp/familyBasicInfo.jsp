<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>家庭基本情况</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
</head>
<body>
<div class="container">

<%@ include file="/WEB-INF/view/common/header.jsp" %>

	<div style="padding: 50px 50px 10px;overflow:auto;">
    	<form class="bs-example bs-example-form" id="showForm" role="form">
        <!-- <div class="input-group">
            <span class="input-group-addon">@</span>
            <span class="form-control" style="width:150px;">
        </div>
        <br> -->
    	</form>
	</div>
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript">
		$(function(){
			showModel('${id}');
			
			 
		});
		function showModel(id){
//			$('#myModal').modal('show')
			$.get("${basePath }/pafb/paFamilyBasicInfo?id="+id,function(data){
				var objArry=data.data;
				var html = '';
				for(var i=0; i<objArry.length; i++){
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+objArry[i].value+'</span></div><br/>';
				}
				$("#showForm").html(html);
			},"JSON");
		}
	</script>
</body>
</html>