<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>
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
	<div style="">
		<form class="form-inline" role="form">
			<div class="input-group">
				<span class="input-group-addon">户主姓名</span> <input type="text"
					class="form-control" placeholder="Username">
			</div>
			<div class="input-group">
				<span class="input-group-addon">家庭住址</span> <input type="text"
					class="form-control" placeholder="Username">
			</div>

			<div class="input-group">
				<span class="input-group-addon">贫困户属性</span>
				<div class="dropdown">
					<button type="button" class="btn dropdown-toggle"
						id="dropdownMenu1" data-toggle="dropdown">
						全部 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu"
						aria-labelledby="dropdownMenu1">
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">1111</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">22222</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">33333</a></li>

					</ul>

				</div>
			</div>
			<div class="input-group">
				<span class="input-group-addon">主要致贫原因</span>
				<div class="dropdown">
					<button type="button" class="btn dropdown-toggle"
						id="dropdownMenu1" data-toggle="dropdown">
						全部 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu"
						aria-labelledby="dropdownMenu1">
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">1111</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">22222</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="#">33333</a></li>

					</ul>

				</div>
			</div>


			<button class="btn btn-primary">搜索</button>
		</form>
	</div>

		
		
	<table id="table" data-toggle="table" data-url="${basePath }/getJsons/30"
		data-click-to-select="true"
		data-detail-view="true" data-detail-formatter="detailFormatter"
		data-show-refresh="true" data-pagination="true">
		<thead>
			<tr>
				<th data-checkbox="true">选择</th>
				<th data-field="zhao">ID</th>
				<th data-field="shu">Item Name</th>
				<th data-field="xue">Item Price</th>
				<th data-field="btns" data-formatter="btnsFormatter" data-align="center"></th>
			</tr>
		</thead>
	</table>




	

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					模态框（Modal）标题
				</h4>
			</div>
			<div class="modal-body" style="">
				在这里添加一些文本
				<!-- min-height: 500px;  -->
				<iframe id="myIframe" name="myIframe" src="${basePath }/jsp/modalList"  
					scrolling="auto" frameborder="no" style="height: 100%; width: 100%; ">
				</iframe>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary">
					提交更改
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>








</div>

	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/template.js"></script>
	<script type="text/javascript" >
	$(function () {
		var data = [];
		for (i = 0; i < 100; i++) {
            var row = {};
            row['zhao'] = 'asfasfasf';
            row['shu'] = 'asfasfasf';
            row['xue'] = 'asfasfasf';
            data.push(row);
        }

		$('#table').bootstrapTable('destroy')
				   .bootstrapTable({
            			//data: data
        });
		

	});


	function btnsFormatter(value, row, index){
		return '<button class="btn btn-link" data-toggle="modal" data-target="#myModal">编辑</button>'
		+ '<button type="button" class="btn btn-link">删除</button>';
	}
	
	function detailFormatter(index, row){
		console.log(row);
		var data = {
				url : "${basePath }/getJsons/8",
				items : [{field : 'zhao', name : 'z'},
				         {field : 'shu', name : 'sf'},
				         {field : 'xue', name : '**'}]
				
		};
		var html = template('test', data);
		
		return "<div>" + html + "</div>";
	}
	
	function expand(index){
		$('#table').bootstrapTable('expandRow', index);
	}
	
	//$("#contentIframe").attr("src","
			
	function setModalSize(h){
		$(".modal-body").height(h);
	}
	
	</script>
</body>

<script id="test" type="text/html">
	<table data-url="{{url}}" data-pagination="true" data-show-refresh="true">
		<thead>
			<tr>
				{{each items as item i}}
					<th data-field="{{item.field}}">{{item.name}}</th>
				{{/each}}
			</tr>
		</thead>
	</table>
</script>
</html>