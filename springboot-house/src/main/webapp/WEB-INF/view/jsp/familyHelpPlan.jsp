<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	

<%@ page import="com.golden.util.UserAuthUtil" %> 
<% 
//添加帮扶责任人帮扶记录信息
boolean btn_8207 = UserAuthUtil.hasOperator(request, "8207");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮扶记录</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<div class="w1200 main">
	<div class="panel panel-default">
		<div>
			<form class="form-inline" role="form">
				<div class="input-group">
					<span class="input-group-addon">姓名</span> 
					<input type="text" class="form-control" style="width:150px;" 
							placeholder="姓名" id="name">
				</div>
				<div class="input-group">
					<span class="input-group-addon" style="display:none" >姓名</span> 
					<input type="text" class="form-control" style="width:150px;display:none" >
				</div>
				
				<div class="input-group">
				    <span class="btn btn-primary" id="search">查询</span>
				</div>
			</form>
		</div>
		<div>
			<table id="table"></table>
		</div>
		<div></div>
	</div>
	
	
<!-- 脱贫评估模态框（Modal） -->
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
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>


<div class="dn" id="validate-tip"> 
	<div class="tooltip fade top in tooltip-div" role="tooltip">
		<div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>
		<div class="tooltip-inner tooltip-inner-me"></div>
	</div>
</div>


</div>






	<%@ include file="/WEB-INF/view/common/footer.jsp" %>


	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/jsDateTimeUtil.js"></script>
	
	<script type="text/javascript" src="/js/bootstrap-select/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-select/defaults-zh_CN.min.js"></script>
	
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	<script type="text/javascript">
	var basepath = "${basePath}";
	$(function(){
		$("#showForm").validate({
			
			errorPlacement: function(error, element) {
				var ddd = element.next("div");
				if(ddd.length == 0){
					var html = $("#validate-tip").html();
					element.after(html);
					var dd = element.next("div");
					var d2 = dd.children().last();
					d2.html(error.html());
					dd.show();
				}else{
					var dd = element.next("div");
					var d2 = dd.children().last();
					d2.html(error.html());
					dd.show();
				}
				
			},
			success: function(label, element) {
				var dd = $(element).next("div");
				dd.hide();
			},
			
			rules : {
				projectTypeCode : {
					required: true
				},
				startTime : {
					required: true
				},
				endTime : {
					required: true
				},
				institutionName : {
					required: true,
					minlength:1,
			        maxlength:50
				},
				supportMoney : {
					required: true,
					number:true
				},
				selfRaise : {
					required: true,
					number:true
				},
				helpContent : {
					//required: true,
					minlength:1,
			        maxlength:100
				},
				helpResult : {
					//required: true,
					minlength:1,
			        maxlength:100
				}
			}
			
		});
	});
	
		
	
		var btn_8207 = <%=btn_8207 %>;
	
		var tableColumn = new Array();
		tableColumn.push({
			field: 'householderName',
			title: '姓名',
			align: 'center'
		});
		tableColumn.push({
			field: 'newStartTime',
			title: '最新帮扶时间',
			align: 'center',
			formatter:function(value){
				return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd');
			}
		});
		tableColumn.push({
			field: 'newHelpContent',
			title: '最新帮扶内容',
			align: 'center'
		});
		
		if(btn_8207){
			tableColumn.push({
				title: '操作',
				align: 'center',
				width: '280px',
				formatter: function(value, row, index){
					return "<button class='btn btn-sm btn-primary' onclick='javascript:showInsert("+row.familyNo+");'>添加</button>";
				}
			});
		}
			
		
	
	
		$(function(){
			$('#table').bootstrapTable({
				url: "${basePath }/pafhp/paHelpPlanNew",
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
			            familyNo:'${familyNo}',
			            name:$("#name").val(),
			            helpPersonId:'${helpPersonId}'
			            
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
				//$('#table').bootstrapTable("refresh",{query: {offset:0}});
				$('#table').bootstrapTable("refresh");
			});
		});
		
		
		
		
		function showInsert(familyNo){
			$.get(basepath+"/pafhp/familyHelpPlanInfo",function(data){
				var objArry=data.data;
				var html = '<input type="hidden" name="familyNo" value="'+familyNo+'">';
				html += '<input type="hidden" name="helpPersonId" value="'+${helpPersonId}+'">';
				for(var i=0; i<objArry.length; i++){
					if(objArry[i].colENName=="helpPersonId"){
						continue;
					}
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
					if(objArry[i].dataInputType=="text"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" required data-bv-notempty-message="错啦"/>';
					}else if(objArry[i].dataInputType=="select"){
						html+= '<select class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
						if(objArry[i].colENName=="gender"){
							html += '<option value="' + '0' + '">' + '女' + '</option>';
							html += '<option value="' + '1' + '">' + '男' + '</option>';
						}else{
							$.ajax({  
						          type : "post",  
						          url : basepath+"/common/codeList",  
						          data : {type:objArry[i].colENName},
						          dataType:"JSON",
						          async : false,  
						          success : function(data){  
						        	  for(var i=0; i<data.length; i++){
											html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
										} 
						          }  
						     });
						}
						html+='</select>';
					}else if(objArry[i].dataInputType=="textArea"){
						html +='<textArea  class="form-control" style="width:660px;" name="'+objArry[i].colENName+'"></textArea>';
					}else if(objArry[i].dataInputType=="radio"){
						var objEnName=objArry[i].colENName;
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objEnName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:660px;height:50px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  if(i==0){
					        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>'; 
					        		  }else{
					        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>'; 
					        		  }
										
									} 
					        	  html+='</div>';
					          }  
					     }); 
					}else if(objArry[i].dataInputType=="date"){
						html+='<input id="'+objArry[i].colENName+'" name="'+objArry[i].colENName+'" class="form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd\'})"/>';
					}else if(objArry[i].dataInputType=="checkbox"){
						var objEnName=objArry[i].colENName;
							$.ajax({  
						          type : "post",  
						          url : basepath+"/common/codeList",  
						          data : {type:objEnName},
						          dataType:"JSON",
						          async : false,  
						          success : function(data){  
						        	  html+='<div class="form-control" style="width:660px;height:50px;">';
						        	  for(var i=0; i<data.length; i++){
						        		  if(i==0){
						        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>'; 
						        		  }else{
						        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>'; 
						        		  }
											
										} 
						        	  html+='</div>';
						          }  
						     });
					}else{
						html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
					}
					html+='</div>';
				}
				html+='<span class="btn btn-primary fr" onclick="submitForm();">保存</span>';
				$("#showForm").html(html);
				$("#myModalLabel").html("添加");
				$('#myModal').modal();
				
				// 添加长度的控制
				$("#showForm input[name='institutionName']").prop("maxlength", 50);
				$("#showForm input[name='helpContent']").prop("maxlength", 100);
				$("#showForm input[name='helpResult']").prop("maxlength", 100);
				//$("#startTime").attr("onFocus", "var endTime=$dp.$('endTime');WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',onpicked:function(){endTime.focus();},maxDate:'#F{$dp.$D(\\'endTime\\')}'})");
				//$("#endTime").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'startTime\\')}',dateFmt:\'yyyy-MM-dd HH:mm:ss\'})");
			},"JSON");

			
		}
		
		
		function submitForm(){
			if(!$("#showForm").valid()){
				return false;
			}
			$("#myModal").modal('hide');
			$.ajax({  
		        type : "post",  
		        url : basepath+"/pafhp/saveFamilyHelpPlanInfo",  
		        data : $("#showForm").serialize(),
		        dataType:"JSON",
		        success : function(data){  
		      	  alert("保存成功");
//		      	  getTableData();
		      	  //$('#table').bootstrapTable("refresh",{query: {offset:0}});
		      	  $('#table').bootstrapTable("refresh");
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