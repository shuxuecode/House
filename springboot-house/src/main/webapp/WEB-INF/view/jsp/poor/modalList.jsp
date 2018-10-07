<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
</head>
<body>
<div class="container">

	<table id="table1" data-toggle="table" data-url="${basePath }/getJsons/30"
		data-click-to-select="true"
		
		data-show-refresh="true" data-pagination="true">
		<thead>
			<tr>
				<th data-checkbox="true">选择</th>
				<th data-field="zhao">ID</th>
				<th data-field="shu">Item Name</th>
				<th data-field="xue" data-align="center">Item Price</th>
			</tr>
		</thead>
	</table>
	
	<table id="table"></table>





</div>





	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript">
		$(function(){
			
			$('#table').bootstrapTable({
				url: "${basePath }/getJsons/10/123",
				cache: false,
				pagination: true,
				pageList: [10,20],
				pageSize:10,
				pageNumber:1,
				sidePagination:'server',//设置为服务器端分页
				queryParams: function (params) {
					console.log(params);
			        return {
			            pageSize: params.limit,
			            offset: params.offset,
			            sortOrder: params.order
			        }
			    },//参数
				sortName: 'id',
			    sortOrder: 'desc',
				minimumCountColumns: 2,
				clickToSelect: true,
				smartDisplay:true,
				columns: [
					{
						field: 'zhao',
						title: '资金通道编码',
						align: 'center',
						width: '180',
						valign: 'bottom',
						sortable: true
					}, {
						field: 'shu',
						title: '资金退回批次号',
						align: 'center',
						width: '200',
						valign: 'middle',
						sortable: true
					}]
				});
					
			
			
			
			
			
			
			
			
			
			/* 
			setInterval(function(){
		  		var height = $("#table").height();
		  		window.parent.setModalSize(height);
		  	},500);
			 */
			 
			 
			 
			
		});
	</script>
	
	
</body>
</html>