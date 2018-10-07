<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>站内信</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<script>
	var basepath="${basepath}";
</script>
</head>
  
<body>
  <%@ include file="/WEB-INF/view/common/header.jsp" %>
  <div class="w1200 main">
  	<div class="panel panel-default">
  		<div style="">
			<form class="form-inline" role="form" id="searchForm">
					<div class="input-group" style="width:100px">
						<span class="btn btn-primary fl" onclick="readed();">标记为已阅</span>
					</div>
					<div class="input-group" style="width:166px">
						<span class="input-group-addon">标题</span> <input type="text"
							class="form-control" style="width:200px" name="title" id="title" placeholder="标题" />
					</div>
					<div class="input-group">
						<span class="input-group-addon">是否已阅</span> 
						<select class="form-control" name="sawStatus" id="sawStatus">
							<option value="">未选择</option>
							<option value="0">未阅</option>
							<option value="1">已阅</option>
						</select>
					</div>
					<div class="input-group">
						<span class="btn btn-primary" id="search">查询</span>
					</div>
					<div class="input-group">
						<span class="btn btn-primary" id="reset">重置</span>
					</div>
				</form>
			
		</div>
		<div>
			<table id="table"></table>
		</div>
  	</div>
  </div>
  
  
  
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm" role="form">
		    		<div class="input-group input-group-me" > 
						<span class="input-group-addon" style="">内容</span>
						<textarea class="form-control" rows=5 id="contentModel" disabled="disabled"></textarea>
					</div>
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
  
  <%@ include file="/WEB-INF/view/common/footer.jsp" %>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript">
		$(function(){
			var tableColumn = new Array();
			tableColumn.push(
			{
				checkbox: true,
				align: 'center'
			},{
				field: 'title',
				title: '标题',
				width: 350,
				align: 'left',
				halign:'center',
				formatter:function(value,rows){
					if(value.length>25){
						value=value.substring(0,25)+'...';
					}
					if(rows.sawstatus==1){
						return value;
					}else{
						return "<label>"+value+"</label>";
					}
				}
			});
			tableColumn.push({
				field: 'content',
				title: '内容',
				align: 'left',
				halign:'center',
				formatter:function(value,rows){
					if(value.length>45){
						value=value.substring(0,45)+'...';
					}
					if(rows.sawstatus==1){
						return "<span style='cursor:pointer;' onclick='openModel("+JSON.stringify(rows)+");'>"+value+"</span>";
					}else{
						return "<span style='cursor:pointer;font-weight:800' onclick='openModel("+JSON.stringify(rows)+");'>"+value+"</span>";
					}
				}
			});
			tableColumn.push({
				field: 'createtime',
				title: '时间',
				width: 150,
				align: 'center',
				formatter:function(value){
					return value==null?'-':new Date(value).Format("yyyy-MM-dd hh:mm:ss");
				}
			});
			
			
			
			
			$('#table').bootstrapTable({
				url: "${basePath }/message/queryMessagePageList",
				cache: false,
				pagination: true,
				pageList: [10,20],
				pageSize:10,
				pageNumber:1,
				sidePagination:'server',//设置为服务器端分页
				queryParams: function (params) {
			        return {
			            pageSize: params.limit,
			            offset: params.offset,
			            sortOrder: params.order,
			            title:$("#title").val(),
			            sawStatus:$("#sawStatus").val()
			            
			        }
			    },//参数
				sortName: 'id',
			    sortOrder: 'desc',
				minimumCountColumns: 2,
				clickToSelect: true,
				smartDisplay:true,
				columns: tableColumn
			});
			
			
			$("#search").click(function(){
//				$('#table').bootstrapTable("refresh",{query: {offset:0}});
				$('#table').bootstrapTable("refresh");
			});
			
			$("#reset").click(function(){
				$("#searchForm .form-control").val('');
				$("#searchForm .form-control option").prop("selected",false);
				$('#table').bootstrapTable("refresh",{query: {offset:0}});
			});
		});
		function readed(){
			var selects = $('#table').bootstrapTable('getSelections');
			if(selects.length === 0){
				alert("请选择一条数据进行操作！");
				return;
			}else{
				var ids = new Array();
				for(var i=0;i<selects.length;i++){
					ids.push(selects[i].id);
				}
				
				if(confirm("确认要对所选的数据批量标记为已阅吗？")){
					$.ajax({  
				          type : "post",  
				          url : "${basePath }/message/readed",  
				          data : {idSplit:ids.join(',')},
				          dataType:"JSON",
				          success : function(data){  
				        	  $('#table').bootstrapTable("refresh");
				        	  
				        	  $.get("${basePath }/message/unSawCount",function(data){
				        	        if(data.success){
				        	        	$(".W_new_count").html(data.data);
				        	        	$(".W_new_count").css({"display": "inline-block"});
				        	        }else{
				        	        	$(".W_new_count").hide();
				        	        }
				        	    }
				        	  );
				          }  
				     });
				}
			}
		}
		
		function openModel(jsonrow){
			$("#contentModel").text(jsonrow.content);
			$("#myModalLabel").text(jsonrow.title);
			$("#myModal").modal();
			
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/message/readed",  
		          data : {idSplit:jsonrow.id},
		          dataType:"JSON",
		          success : function(data){  
		        	  $('#table').bootstrapTable("refresh");
		        	  
		        	  $.get("${basePath }/message/unSawCount",function(data){
		        	        if(data.success){
		        	        	$(".W_new_count").html(data.data);
		        	        	$(".W_new_count").css({"display": "inline-block"});
		        	        }else{
		        	        	$(".W_new_count").hide();
		        	        }
		        	    }
		        	  );
		          }  
		     });
		}
		//对Date的扩展，将 Date 转化为指定格式的String   
		//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
		//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
		//例子：   
		//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
		//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
		Date.prototype.Format = function(fmt)   
		{ //author: meizz   
		var o = {   
		"M+" : this.getMonth()+1,                 //月份   
		"d+" : this.getDate(),                    //日   
		"h+" : this.getHours(),                   //小时   
		"m+" : this.getMinutes(),                 //分   
		"s+" : this.getSeconds(),                 //秒   
		"q+" : Math.floor((this.getMonth()+3)/3), //季度   
		"S"  : this.getMilliseconds()             //毫秒   
		};   
		if(/(y+)/.test(fmt))   
		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
		for(var k in o)   
		if(new RegExp("("+ k +")").test(fmt))   
		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
		return fmt;   
		}
	</script>
</body>
</html>
