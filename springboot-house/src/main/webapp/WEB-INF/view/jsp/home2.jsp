<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扶贫户信息列表</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/js/datepicker/skin/WdatePicker.css" />

<link rel="stylesheet" type="text/css" href="/js/bootstrap-select/bootstrap-select.min.css" />

<style>

.nav-tabs-me>li {
    width: 20%;
    text-align: center;
   
}
.nav-tabs>li>a{
	font-size:14px;
    text-decoration: none;
    margin: 0;
    color:#555;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
	font-size:14px;
    text-decoration: none;
    color:#2a6496;
}

/* 重写下拉多选框的样式 start */
.bootstrap-select button .filter-option {
	font-size: 14px;
    line-height: 20px;
}

.h34px {
	height: 34px;
    width: 160px !important;
    color: #555 !important;
    background: none;
    border: 1px solid #ccc;
}
/* 重写下拉多选框的样式 end */

</style>

<%
String roleIds = session.getAttribute("user_role_ids")==null?"":session.getAttribute("user_role_ids").toString();
%>
<script type="text/javascript">
	var roleIds = '<%=roleIds %>';
	var roleLevel = '';
	if(roleIds.indexOf('1000') != -1 || roleIds.indexOf('999') != -1){
		roleLevel = 1;
	}else if(roleIds.indexOf('2000') != -1){
		roleLevel = 3;
	}else if(roleIds.indexOf('3000') != -1){
		roleLevel = 5;
	}
</script>

</head>
<body>


<%@ include file="/WEB-INF/view/common/header.jsp" %>
<div class="w1200 main">
	<div class="panel panel-default">
		<div>
			<form class="form-inline" role="form" id="searchForm">
				<div class="input-group">
					<span class="input-group-addon">户主姓名</span> 
					<input type="text" class="form-control" style="width:150px;" 
							placeholder="姓名" id="householderName">
				</div>
				<div class="input-group">
					<span class="input-group-addon">区/乡/镇</span> 
					<select class="form-control" id="address1" > 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">村委会</span> 
					<select class="form-control" id="address2" > 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">村民小组</span> 
					<select class="form-control" id="address3" > 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">贫困户属性</span>
					 <select class="form-control" id="poorAttributeCode"> 
				      </select>
				</div>
				
				<div class="input-group">
					<span class="input-group-addon">主要致贫原因</span>
					 <select class="form-control" id="mainPoorCauseCode" > 
				     </select>
				</div>
				
				<div class="input-group">
					<span class="input-group-addon">次要致贫原因</span>
					 <select class="form-control" id="secondaryPoorCauseCode" multiple data-live-search="true"> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">是否危房</span>
					 <select class="form-control" id="ifwf" >
					 	<option value="">全部</option> 
					 	<option value="0">否</option> 
					 	<option value="1">是</option> 
				     </select>
				</div>
				
				<div class="input-group">
					<span class="input-group-addon">是否生态补偿</span>
					 <select class="form-control" id="ifstbc" >
					 	<option value="">全部</option> 
					 	<option value="0">否</option> 
					 	<option value="1">是</option> 
				     </select>
				</div>
				
				
				<div class="input-group">
				    <span class="btn btn-primary" id="search">搜索</span>
				</div>
				<div class="input-group">
				    <span class="btn btn-primary" id="reset">重置</span>
				</div>
				
			
			</form>
			
			
		</div>
		<div>
			<table id="table"></table>
		</div>
		<div></div>
	    
	</div>
	
	
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 10%">
	<div class="modal-dialog"  style="width:1000px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					关联信息
				</h4>
			</div>
			<div id="test" class="modal-body" style="height:500px;">
				<!-- min-height: 500px;  -->
				<ul class="nav nav-tabs nav-tabs-me" id="myTab">
					<li class="active"><a tabId="#tab1" data-toggle="tab">家庭成员</a></li>
					<li><a tabId="#tab2" data-toggle="tab">生产生活现状</a></li>
					<li><a tabId="#tab3" data-toggle="tab">帮扶责任人</a></li>
					<li><a tabId="#tab4" data-toggle="tab">帮扶措施与成效</a></li>
					<li><a tabId="#tab5" data-toggle="tab">脱贫评估</a></li>
				</ul>
				
				<div id="myTabContent" class="tab-content" style="    padding-top: 18px;">
					<div class="tab-pane  in active" id="tab1">
				        <iframe id="myIframe" name="myIframe" src=""  
							scrolling="auto" frameborder="no" style="height: 100%; width: 100%; min-height: 440px;">
						</iframe>
				    </div>
				</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>



	
<!-- 模态框（Modal） -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel2" aria-hidden="true" style="top: 10%">
	<div class="modal-dialog"  style="width:878px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel2">
					详情
				</h4>
			</div>
			<div id="detailDiv" class="modal-body" style="min-height:500px;">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>


<!-- 家庭成员弹出 -->
<div class="modal fade" id="myModal22" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1100px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel22">
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;">
    	<form class="bs-example bs-example-form" id="showForm22" role="form">
    	</form>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>


<!-- 帮扶责任人弹出 -->
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel3" aria-hidden="true" style="top: 10%;">
	<div class="modal-dialog"  style="width:1050px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel3">
					帮扶责任人情况
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;min-height:550px;">
    	<form class="bs-example bs-example-form" id="showForm3" role="form">
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
	
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload.js"></script>
	
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-process.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-validate.js"></script>
	
	<script type="text/javascript">
	
		var dn = ('${dn}' == '')? '' : 'dn';
	
		// var newFamilyNo=parseInt(Math.random()*1000);
		$(function(){
			
			
			
			
			$("#showForm22").validate({
				
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
					householderName : {
						required: true,
						minlength:1,
				        maxlength:20
					},
					populationNum : {
						required: true,
						number : true,
						range:[1,999]
					},
					gender : {
						required: true
					},
					nationCode : {
						required: true
					},
					birthday : {
						required: true,
					},
					//telNo: "phone",
					telNo : {
						required: true,
						tm : true
					},
					address1 : {
						required: true
					},
					address2 : {
						required: true
					},
					address3 : {
						required: true
					},
					poorAttributeCode : "required",
					mainPoorCauseCode : "required",
					secondaryPoorCauseCode : "required",
					bankName : {
						required: true
					},
					cardNo : {
						required: true,
						number : true
					}
				}
				
			});
			
			
			$('#table').bootstrapTable({
				url: "${basePath }/paInfo/familyList",
				cache: false,
				pagination: true,
				pageList: [10,20],
				pageSize:10,
				pageNumber:1,
				sidePagination:'server',//设置为服务器端分页
				queryParams: function (params) {
					var selectSecondValue = "";
					if($("#secondaryPoorCauseCode").val() !== undefined && $("#secondaryPoorCauseCode").val() !== null){
						selectSecondValue = $("#secondaryPoorCauseCode").val().join(",") // 数组转str
					}
			        return {
			            pageSize: params.limit,
			            offset: params.offset,
			            sort: params.sort,
			            sortOrder: params.order,
			            householderName : $("#householderName").val(),
			    		poorAttributeCode : $("#poorAttributeCode").val(),
			    		mainPoorCauseCode : $("#mainPoorCauseCode").val(),
			    		secondaryPoorCauseCode : selectSecondValue,
			    		address1 : $("#address1").val(),
			    		address2 : $("#address2").val(),
			    		address3 : $("#address3").val(),
			    		ifwf : $("#ifwf").val(),
			    		ifstbc : $("#ifstbc").val(),
			    		hpId : '${hpId}'
			        }
			    },//参数
				sortName: 'id',
			    sortOrder: 'desc',
				clickToSelect: true,
				columns: [
					{
//						checkbox: true,
//						align: 'center'
//					},{
						field: 'householderName',
						title: '户主姓名',
						align: 'center',
						valign: 'middle'
					}, {
						title: '家庭住址',
						align: 'center',
						valign: 'middle',
						formatter : function(value, row, index){
							var addressValue=(row.addressValue1==null?"":row.addressValue1)+(row.addressValue2==null?"":row.addressValue2)+(row.addressValue3==null?"":row.addressValue3);
							if(addressValue==null||addressValue==''){
								return '-';
							}else{
								return addressValue;
							}
						}
						//sortable: true
					},{
						field: 'povertyStateValue',
						title: '贫困状态',
						align: 'center',
						valign: 'middle',
						formatter : function(value, row, index){
							// 这个逻辑不好，待优化
							if( parseInt(row.status) <= parseInt(roleLevel) ){
								value +='<span style="color:#C61D22">(待查实)</span>';
							}
							return value;
						}
					},{
						field: 'poorAttributeValue',
						title: '贫困户属性',
						align: 'center',
						valign: 'middle',
						formatter : function(value, row, index){
							return showColor(row.poorAttributeCode, value);
						}
					},{
						field: 'mainPoorCauseValue',
						title: '主要致贫原因',
						align: 'center',
						valign: 'middle'
					},{
						field: 'secondaryPoorCauseValue',
						title: '次要致贫原因',
						align: 'center',
						valign: 'middle'
					},{
						field: 'indexCodeValue',
						title: '是否危房',
						align: 'center',
						valign: 'middle'
					},{
						field: 'projectTypeCodeValue',
						title: '是否生态补偿',
						align: 'center',
						valign: 'middle'
					},
					/*{
						field: 'createtime',
						title: '登记时间',
						align: 'center',
						valign: 'middle',
						formatter : function(value, row, index){
							return dateFormat(value, 'yyyy-MM-dd hh:mm:ss');
						}
					},*/
					{
						title: '<button class="btn btn-success ' + dn + '" onclick="showMember(\'insert\')">添加</button>&nbsp;&nbsp;'
//								+'<button class="btn btn-danger dn" onclick="deleteById()">删除</button>',
								+'<button class="btn btn-warning" onclick="exportExcel()">导出</button>',
						align: 'center',
						width: 200,
						formatter : function(value, row, index){
							return '<button class="btn btn-info btn-sm ' + dn + '" '
							+ 'onclick="showMember(\'update\',' + row.id + ',' + row.familyNo + ')">编辑</button>'
							+ '&nbsp;&nbsp;'+'<button class="btn btn-info btn-sm" '
								+ 'onclick="showMember(\'query\',' + row.id + ',' + row.familyNo + ')">详情</button>'
								+ '&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="openPage('+row.id+',\'' + row.familyNo + '\')">关联信息</button>';
						}
					}]
				});
					
			//
			loadSelectDiv();
			
			
			$(document).on("click",".checkbox-inline input[name='poorAttributeCode']",function(){
				var v=$(this).val();
				if(v==4){
					$(this).parent().siblings().find("input[name='poorAttributeCode']").eq(0).prop("checked",false);
					$(this).parent().siblings().find("input[name='poorAttributeCode']").eq(1).prop("checked",false);
					$(this).parent().siblings().find("input[name='poorAttributeCode']").eq(2).prop("checked",false);
				}else{
					$(this).parent().parent().find("input[name='poorAttributeCode']").eq(3).prop("checked",false);
				}
			});
			
			
			
			 
			$("#search").click(function(){
//				$('#table').bootstrapTable("refresh",{query: {offset:0}});
				$('#table').bootstrapTable("refresh");
			});
			
			
			$("#reset").click(function(){
				$("#searchForm .form-control").val('');
				$("#searchForm .form-control option").prop("selected",false);
				$('#secondaryPoorCauseCode').selectpicker('deselectAll');
				$('#table').bootstrapTable("refresh",{query: {offset:0}});
			});
			$('#myTab a').click(function (e) { 
		         e.preventDefault();//阻止a链接的跳转行为 
		         var tabId = $(this).attr("tabId");
		         if(tabId == '#tab1'){
		        	 $("#myIframe").attr("src","${basePath }/paMInfo/familyMemberPageInner?familyNo=1");
		         }
		         else if(tabId == '#tab2'){
		        	 $("#myIframe").attr("src","${basePath }/paInfo/familyProductLifeInfoPage");
		         }
		         else if(tabId == '#tab3'){
		        	 $("#myIframe").attr("src","${basePath }/pahp/paHelpPersonPageInner?familyNo=1");
		         }
		         else if(tabId == '#tab4'){
		        	 $("#myIframe").attr("src","${basePath }/pafhp/familyHelpPlanPage?familyNo=1");
		         }
		         else if(tabId == '#tab5'){
		        	 $("#myIframe").attr("src","${basePath }/paInfo/familyAssessmentInfoPage");
		         }
		    });
			
			
			
			
		});
		
		$(document).keyup(function (e) {
	        if (e.keyCode == 13)
	        	$("#search").trigger("click");
	    });
		
		function loadSelectDiv(){
			$.get("${basePath }/common/codeList?type=poorAttributeCode",function(data){
				var html = '<option value="">全部</option>';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#poorAttributeCode').html(html);
			},"JSON");
			$.get("${basePath }/common/codeList?type=address1",function(data){
				var html = '<option value="">全部</option>';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#address1').html(html);
			},"JSON");
			$.get("${basePath }/common/codeList?type=address2",function(data){
				var html = '<option value="">全部</option>';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#address2').html(html);
			},"JSON");
			$.get("${basePath }/common/codeList?type=address3",function(data){
				var html = '<option value="">全部</option>';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#address3').html(html);
			},"JSON");
			
			// 主要和次要致贫原因
			$.get("${basePath }/common/codeList?type=poorCauseCode",function(data){
				var html = '';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#mainPoorCauseCode').html('<option value="">全部</option>' + html);
				$('#secondaryPoorCauseCode').html(html);
				$('#secondaryPoorCauseCode').selectpicker({
					style : "h34px"
				});
				$('#secondaryPoorCauseCode').selectpicker('refresh');
				
			},"JSON");
		}
		
		
		function showModel(obj, familyNo){
			/* var tr = $(obj).parent().parent();
			console.log(tr);
			
			var html = $("#test").html();
			
			$(tr).after('<tr><td id="zhao" colspan="6"></td></tr>');
			$("#zhao").html(html);
			
			return; */
			$('#myTab a:first').tab('show');
			
			$('#myModal').modal();
			$("#myIframe").attr("src","${basePath }/paMInfo/familyMemberPageInner?familyNo=" + familyNo);
			
		}
		
		function openPage(id,familyNo){
			window.open("${basePath }/pafam/familyInfoList/familyDetail?familyNo=" + familyNo+"&id="+id+"&dn="+dn);
		}
		
		
		function showDetail(familyNo){
			$.get("${basePath }/pafb/paFamilyBasicInfo?id="+familyNo,function(data){
				var objArry=data.data;
				var html = '';
				for(var i=0; i<objArry.length; i++){
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:300px;">'+objArry[i].value+'</span></div>';
				}
				$("#detailDiv").html(html);
			},"JSON");
			$('#detailModal').modal();
		}
		
		
		
		function childShowModel(id){
			$.get("${basePath }/paMInfo/familyMemberInfo?id="+id,function(data){
				var objArry=data.data;
				var html = '';
				for(var i=0; i<objArry.length; i++){
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:300px;">'+objArry[i].value+'</span></div>';
				}
				$("#showForm2").html(html);
				$('#myModal2').modal();
			},"JSON");
		}
		
		
		function childShowModel3(id){
			$.get("${basePath }/pahp/paHelpPersonInfo?id="+id,function(data){
				var objArry=data.data;
				var html = '';
				for(var i=0; i<objArry.length; i++){
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:300px;">'+objArry[i].value+'</span></div>';
				}
				$("#showForm3").html(html);
				$('#myModal3').modal();
			},"JSON");
		}
		
		
		
		function showMember(flag,id,familyNo){
			if(flag=="insert"){
				$.get("${basePath }/pafb/paFamilyBasicInfo",function(data){
					var objArry=data.data;
//					var html = '<input type="hidden" name="familyNo" value="'+newFamilyNo+'">';
					var html = '<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian\').click();"><img src="/img/defPhoto.png" id="photoImg" style="width:100px;height:100px;"/></a><input type="hidden" id="photo" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
					for(var i=0; i<objArry.length; i++){
						 if(objArry[i].dataInputType=="img"){//过滤【用户照片】
							continue;
						}
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span>';
						if(objArry[i].dataInputType=="text"){
							html +='<input type="text" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" />';
							
							
							/* 
							html +='<div class="tooltip fade top in tooltip-div dn" role="tooltip">';
							html +='<div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>';
							html +='<div class="tooltip-inner tooltip-inner-me"></div>';
							html +='</div>';
							
							 */
							
							
						
							
							
							
						}else if(objArry[i].dataInputType=="select"){
							if(objArry[i].colENName=='address1'||objArry[i].colENName=='address2'||objArry[i].colENName=='address3'){
								html+= '<select class="form-control" style="width:148px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
							}else{
								html+= '<select class="form-control" style="width:300px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
							}
							
							if(objArry[i].colENName=="gender"){
								html += '<option value="' + '0' + '">' + '女' + '</option>';
								html += '<option value="' + '1' + '">' + '男' + '</option>';
							}else{
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objArry[i].colENName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  for(var j=0; j<data.length; j++){
												html += '<option value="' + data[j].code + '">' + data[j].name + '</option>';
											} 
							          }  
							     });
							}
							html+='</select>';
						}else if(objArry[i].dataInputType=="textArea"){
							html +='<input type="textArea" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'"></input>';
						}else if(objArry[i].dataInputType=="radio"){
							var objEnName=objArry[i].colENName;
							if(objEnName=="mainPoorCauseCode"){
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:"poorCauseCode"},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;height:50px">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(j==0){
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
							        		  }else{
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}else{
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objEnName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(j==0){
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
							        		  }else{
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}
							 
						}else if(objArry[i].dataInputType=="date"){
							html+='<input name="'+objArry[i].colENName+'" class="form-control" style="width:300px;" type="text" onFocus="WdatePicker()"/>';
						}else if(objArry[i].dataInputType=="checkbox"){
							var objEnName=objArry[i].colENName;
							if(objEnName=="secondaryPoorCauseCode"){
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:"poorCauseCode"},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;height:50px">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(j==0){
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
							        		  }else{
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}else{
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objEnName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(j==0){
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
							        		  }else{
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}
						}else{
							html +='<span class="form-control" style="width:300px;">'+objArry[i].value+'</span>';
						}
						html+='</div>';
					}
					html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
					$("#showForm22").html(html);
					$("#myModalLabel22").html("添加");
					$('#myModal22').modal();
					
					
					
					$('#tupian').fileupload({
						url : '/pafb/upload',
//				        dataType: 'json',
						add: function (e, data) {
							//console.log(data);
				            //data.context = $('<p/>').text('Uploading...').appendTo(document.body);
				           var uploadErrors = [];
       						 console.log(data.originalFiles[0]['size']) ;
        					if (data.originalFiles[0]['size'] > 1*1024*1024) {
           						 uploadErrors.push('上传文件不能超过1M');
        						}
       						 if(uploadErrors.length > 0) {
            				alert(uploadErrors.join("\n"));
        					} else {
          					  data.submit();
       						 }
				        },
				        done: function (e, data) {
				        	$("#photo").val(data.result);;
				        	$("#photoImg").attr("src", "data:image/.jpg;base64," + data.result);
//				            $.each(data.result.files, function (index, file) {
//				                $('<p/>').text(file.name).appendTo(document.body);
//				            });
				        }
				    });
				},"JSON");
			}else if(flag=="update"){
				$.get("${basePath }/pafb/paFamilyBasicInfo?id="+id,function(data){
					var objArry=data.data;
					var html = '<input type="hidden" name="familyNo" value="'+familyNo+'"><input type="hidden" name="id" value="'+id+'"/>';
					html+='<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian\').click();"><img src="/img/defPhoto.png" id="photoImg" style="width:100px;height:100px;"/></a><input type="hidden" id="photo" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
					var photoImgSrc='';
					for(var i=0; i<objArry.length; i++){
						 if(objArry[i].dataInputType=="img"){//过滤【用户照片】
							 photoImgSrc=objArry[i].value;
						 	continue;
						}
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span>';
						if(objArry[i].dataInputType=="text"){
							html +='<input type="text" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'" required data-bv-notempty-message="错啦"/>';
						}else if(objArry[i].dataInputType=="select"){
							if(objArry[i].colENName=='address1'||objArry[i].colENName=='address2'||objArry[i].colENName=='address3'){
								html+= '<select class="form-control" style="width:148px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
							}else{
								html+= '<select class="form-control" style="width:300px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
							}
							if(objArry[i].colENName=="gender"){
								if(objArry[i].value.trim()=="女"){
									html += '<option value="' + '0' + '" selected="selected">' + '女' + '</option>';
									html += '<option value="' + '1' + '">' + '男' + '</option>';
								}else{
									html += '<option value="' + '0' + '">' + '女' + '</option>';
									html += '<option value="' + '1' + '" selected="selected">' + '男' + '</option>';
								}
								
							}else{
								var val=objArry[i].value;
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objArry[i].colENName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  for(var j=0; j<data.length; j++){
//							        		  if(val.trim()==data[i].name.trim()){
							        		  if(val == data[j].name){
							        			  html += '<option value="' + data[j].code + '" selected="selected">' + data[j].name + '</option>';
							        		  }else{
							        			  html += '<option value="' + data[j].code + '">' + data[j].name + '</option>'; 
							        		  }
												
											} 
							          }  
							     });
							}
							html+='</select>';
						}else if(objArry[i].dataInputType=="textArea"){
							html +='<input type="textArea" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'"></input>';
						}else if(objArry[i].dataInputType=="radio"){
							var objEnName=objArry[i].colENName;
							var val=objArry[i].value;
							if(objEnName=="mainPoorCauseCode"){
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:"poorCauseCode"},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;height:50px">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(val==data[j].name){
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>';
							        		  }else{
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>';
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}else{
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objEnName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;">';
							        	  for(var j=0; j<data.length; j++){
							        		  if(val==data[j].name){
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>';
							        		  }else{
							        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>';
							        		  }
												
											} 
							        	  html+='</div>';
							          }  
							     });
							}
							 
						}else if(objArry[i].dataInputType=="date"){
							html+='<input name="'+objArry[i].colENName+'" class="form-control" style="width:300px;" type="text" onFocus="WdatePicker()" value="'+(objArry[i].value==null?"":objArry[i].value)+'"/>';
						}else if(objArry[i].dataInputType=="checkbox"){
							var objEnName=objArry[i].colENName;
							var val=objArry[i].value;
							var valArr=val.split(",");
							if(objEnName=="secondaryPoorCauseCode"){
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:"poorCauseCode"},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;height:50px">';
							        	  for(var k=0; k<data.length; k++){
							        		  var flag=true;
							        		  for(var j=0;j<valArr.length;j++){
							        			  if(valArr[j]==data[k].name){
							        				  flag=false;
								        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[k].code+'" checked>'+data[k].name+'</label>';
							        			  }
							        		  }
							        		  if(flag){
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[k].code+'">'+data[k].name+'</label>';
							        		  }
							        		 
											} 
							        	  html+='</div>';
							          }  
							     });
							}else{
								$.ajax({  
							          type : "post",  
							          url : "${basePath }/common/codeList",  
							          data : {type:objEnName},
							          dataType:"JSON",
							          async : false,  
							          success : function(data){  
							        	  html+='<div class="form-control" style="width:760px;">';
							        	  for(var k=0; k<data.length; k++){
							        		  var flag=true;
							        		  for(var j=0;j<valArr.length;j++){
							        			  if(valArr[j] ==data[k].name){
							        				  flag=false;
								        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[k].code+'" checked>'+data[k].name+'</label>';
							        			  }
							        		  }
							        		  if(flag){
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[k].code+'">'+data[k].name+'</label>';
							        		  }
							        		 
											} 
							        	  html+='</div>';
							          }  
							     });
							}
						}else{
							html +='<span class="form-control" style="width:300px;">'+objArry[i].value+'</span>';
						}
						html+='</div>';
					}
					html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
					$("#showForm22").html(html);
					$("#myModalLabel22").html("编辑");
					$('#myModal22').modal();
					
					$('#tupian').fileupload({
						url : '/pafb/upload',
//				        dataType: 'json',
						add: function (e, data) {
							var uploadErrors = [];
      						 console.log(data.originalFiles[0]['size']) ;
       					if (data.originalFiles[0]['size'] > 1*1024*1024) {
          						 uploadErrors.push('上传文件不能超过1M');
       						}
      						 if(uploadErrors.length > 0) {
           				alert(uploadErrors.join("\n"));
       					} else {
         					  data.submit();
      						 }
				        },
				        done: function (e, data) {
				        	console.log(e);
				        	console.log(data);
				        	console.log(data.result);
				        	$("#photo").val(data.result);;
				        	$("#photoImg").attr("src", "data:image/.jpg;base64," + data.result);
//				            $.each(data.result.files, function (index, file) {
//				                $('<p/>').text(file.name).appendTo(document.body);
//				            });
				        }
				    });
					$("#photo").val(photoImgSrc);
					if(photoImgSrc!=null&&photoImgSrc!=""){
						$("#photoImg").attr("src", "data:image/.jpg;base64," + photoImgSrc);	
					}
		        	
				},"JSON");
			}else{
				$.get("${basePath }/pafb/paFamilyBasicInfo?id="+id,function(data){
					var objArry=data.data;
					var html = '';
					var photo='<div class="input-group" style="width:760px;"><img  id="photoImg" src="/img/defPhoto.png" style="width:100px;height:100px;"/><input type="hidden" id="photo" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
					var photoImgSrc='';
					for(var i=0; i<objArry.length; i++){
						if(objArry[i].colENName=='photo'){
							photoImgSrc=objArry[i].value;
							continue;
						}
						if(objArry[i].colENName=='address1'||objArry[i].colENName=='address2'||objArry[i].colENName=='address3'){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:148px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}else if(objArry[i].colENName=='poorAttributeCode'||objArry[i].colENName=='mainPoorCauseCode'
								  ||objArry[i].colENName=='secondaryPoorCauseCode'||objArry[i].colENName=='povertyState'){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:760px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}else{
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:300px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}
						
					}
					$("#showForm22").html(photo+html);
					$("#myModalLabel22").html("详情");
					$('#myModal22').modal();
					
					$("#photo").val(photoImgSrc);
					if(photoImgSrc!=null&&photoImgSrc!=""){
						$("#photoImg").attr("src", "data:image/.jpg;base64," + photoImgSrc);
					}
				},"JSON");
			}
			
			
		}
		
		function submitForm2(){
			
			if(!$("#showForm22").valid()){
				return false;
			}
			
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/pafb/savePaFamilyBasicInfo?hpId=${hpId}", 
		          data : $("#showForm22").serialize(),
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("保存成功");
		        	  $("#myModal22").modal('hide');
		        	  $('#table').bootstrapTable("refresh");
		          }  
		     });
		}
		function deleteById(){
			var selects = $('#table').bootstrapTable('getSelections');
			if(selects.length === 0){
				alert("请选择一条数据进行删除操作！");
				return;
			}else{
				var ids = new Array();
				for(var i=0;i<selects.length;i++){
					ids.push(selects[i].id);
				}
				confirm("确认要删除所选的数据吗？", function(){
					$.ajax({  
				          type : "post",  
				          url : "${basePath }/pafb/deleteById",  
				          data : {id:ids.join(',')},
				          dataType:"JSON",
				          success : function(data){  
				        	  alert("删除成功");
				        	  $('#table').bootstrapTable("refresh");
				          }  
				     });
				})
			}
		}
		
		function showColor(v1, v2){
			if(v1 == '4'){
				return '<span style="color:#005ec6">' + v2 + '</span>';
			}else{
				return '<span style="color:#c61d22">' + v2 + '</span>';
			}
		}
		
		function exportExcel(){
			window.open("${basePath }/pafam/familyBaseInfoDownExcel");
		}
	</script>
</body>
</html>