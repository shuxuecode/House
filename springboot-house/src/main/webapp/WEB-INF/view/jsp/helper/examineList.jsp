<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
   
<%@ page import="com.golden.util.UserAuthUtil" %> 
<% 
//审核通过
boolean btn_8301 = UserAuthUtil.hasOperator(request, "8301");
//审核驳回
boolean btn_8302 = UserAuthUtil.hasOperator(request, "8302");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扶贫户信息审核列表</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/js/datepicker/skin/WdatePicker.css" />

<link rel="stylesheet" type="text/css" href="/js/bootstrap-select/bootstrap-select.min.css" />
<!-- 美化单选多选 -->
<link rel="stylesheet" type="text/css" href="/css/magic-check.css" />

<link rel="stylesheet" type="text/css" href="/css/examine.css" />
<link rel="stylesheet" type="text/css" href="/css/timeline.css" />

<style>

.nav-tabs-me>li {
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

.btn-margin {
	margin: 10px 50px;
}


.shenhe-table-td {
	background-color: #f5f5f5;
	text-align: center;
}
</style>

<%
String userType = session.getAttribute("userType")==null?"":session.getAttribute("userType").toString();
%>
<script type="text/javascript">
	var userType = '<%=userType %>';
	var roleLevel = '';
	var roleLevelText = '';
	
	if(userType == 2 || userType == 5){
		roleLevel = 1;
		roleLevelText = '预审待审核';
	}else if(userType == 3){
		roleLevel = 3;
		roleLevelText = '区领导待审核';
	}else if(userType == 4){
		roleLevel = 5;
		roleLevelText = '市领导待审核';
	}else if(userType == 99){
		roleLevel = 7;
		roleLevelText = '市扶贫办待审核';
	}
</script>

</head>
<body>


<%@ include file="/WEB-INF/view/common/header.jsp" %>
<div class="w1200 main">
	<div class="panel panel-default">
		<div style="display:table">
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
					<span class="input-group-addon">证件号码</span>
				      <input type="text" class="form-control" style="width:150px;" 
							placeholder="证件号码" id="certificateNo">
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
				    <span class="btn btn-primary" id="search">搜索</span>
				</div>
				<div class="input-group">
				    <span class="btn btn-primary" id="reset">重置</span>
				</div>
			
			</form>
			
			
		</div>
		<!-- 审核状态查询条件 -->
		<input type="hidden" id="examineType" value="0" />
		<div class="panel" style="padding-top:0">
			<ul class="nav nav-tabs nav-tabs-me" id="myTab">
				<li class="active"><a href="#tab1" data-toggle="tab">未审核</a></li>
				<li><a href="#tab2" data-toggle="tab">已审核</a></li>
				<li><a href="#tab3" data-toggle="tab">全部</a></li>
			</ul>
			<div id="myTabContent" class="tab-content" style="padding-top: 18px;">
				<div class="tab-pane fade in active" id="">
					<table id="table"></table>
				</div>
			</div>
			
		</div>
	    
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
			
	<div style="padding: 20px 50px 20px;overflow:auto;">
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

<div class="modal fade" id="myModal10" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel10" aria-hidden="true" style="top: 10%;">
	<div class="modal-dialog"  style="width:1050px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel10">
					问题反馈
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;min-height:250px;">
    	<form class="bs-example bs-example-form" id="showForm10" role="form">
    		<div class="input-group">
    			<input id="showForm10_id" name="id" type="hidden">
    			<span class="input-group-addon" style="width:150px;">督导记录</span>
    			<textarea class="form-control" id="showForm10_feedback" name="feedback" style="width:760px;"></textarea>
    		</div>
    		<span class="btn btn-primary fr" onclick="submitForm10();">保存</span>
    	</form>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>



<!-- 审核操作弹出 -->
<div class="modal fade" id="shenheModal" tabindex="-1" role="dialog" 
		aria-labelledby="shenheModalLabel" aria-hidden="true">
	<div class="modal-dialog"  style="width:1200px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="shenheModalLabel">审核窗口</h4>
			</div>
			
			<div style="padding: 10px 20px 20px;overflow:auto;min-height:550px;">
		    	<!-- 主体 -->
		    	<div>
		    		<ul class="nav nav-tabs nav-tabs-me" id="shenheTab">
						<li class="active"><a href="#navtab1" data-toggle="tab">审核</a></li>
						<li><a href="#navtab2" data-toggle="tab">审核记录</a></li>
						<li><a href="#navtab3" data-toggle="tab">审核流程图</a></li>
					</ul>
					
					<div id="myTabContent" class="tab-content" style="padding-top: 18px;">
						<div class="tab-pane fade in active" id="navtab1">
							<!-- 审核 start -->
							<input type="hidden" id="exa_familyNo" />
							<div>
								<div class="input-group" style="margin:10px 120px; width:75%">
									<c:if test="<%=btn_8301 %>">
					    				<input class="magic-radio" type="radio" name="examine_radio" id="examine_yes" value="yes" checked>
										<label for="examine_yes">同意</label>
									</c:if>
									<c:if test="<%=btn_8302 %>">
										<input class="magic-radio" type="radio" name="examine_radio" id="examine_no" value="no">
										<label for="examine_no">不同意</label>
									</c:if>
					    		</div>
								<div class="input-group" style="margin:0px 80px;">
					    			<span class="input-group-addon" style="width:150px;">审核意见</span>
					    			<textarea class="form-control" id="opinion" name="" style="width:800px; height:200px;" maxlength="200"></textarea>
					    		</div>
					    		<div class="input-group" style="width: 89%; bottom: 28px">
					    			<p class="help-block" style="float: right">还可以输入<span id="exa_zise">200</span>字</p>
					    		</div>
					    		<div style="text-align: center;">
					    			<!-- 
					    				<span id="btn_ok" class="btn btn-success btn-lg btn-margin" onclick="newEexamine('yes');">同意</span>
					    				<span id="btn_no" class="btn btn-danger btn-lg btn-margin" onclick="newEexamine('no');">驳回</span>
									 -->
					    				<span id="btn_submit" class="btn btn-success btn-lg btn-margin" onclick="newEexamine('');">提交</span>
					    		</div>
					    		
							</div>
							<!-- 审核 end -->
						</div>
						<div class="tab-pane fade" id="navtab2">
							<!-- 记录 start -->
							
							<!-- 记录 end -->
						</div>
						<div class="tab-pane fade" id="navtab3" style="height:800px">
							<!-- 流程图 start -->
							<!-- <div style="height: 810px; background: url(/images/approval.png) no-repeat center top"> -->
							<div style="position: absolute;width: 900px;overflow: hidden;height: 800px;">
							
								<img src="/images/approval.png" style="position:absolute; left:0px; top:0px;" />
			
						        <div id="redLine" style="position:absolute;border:2px solid red;border-radius: 14px;"></div>
							
							</div>
							<!-- 流程图 end -->
						</div>
					</div>
		    	</div>
			</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>


<!--导出的表单  -->
<form id="formSubmit">
	<input type="hidden" id="householderNameForm" name="householderName">
	<input type="hidden" id="address1Form" name="address1">
	<input type="hidden" id="address2Form" name="address2">
	<input type="hidden" id="address3Form" name="address3">
	<input type="hidden" id="poorAttributeCodeForm" name="poorAttributeCode">
	<input type="hidden" id="address1pForm" name="address1p">
	<input type="hidden" id="address2pForm" name="address2p">
	<input type="hidden" id="address3pForm" name="address3p">
	<input type="hidden" id="poorAttributeCodepForm" name="poorAttributeCodep">
	<input type="hidden" id="certificateNoForm" name="certificateNo">
	<input type="hidden" id="startTimeForm" name="startTime">
	<input type="hidden" id="endTimeForm" name="endTime">
	<input type="hidden" id="secondaryPoorCauseCodeForm" name="secondaryPoorCauseCode">
	<input type="hidden" id="secondaryPoorCauseCodepForm" name="secondaryPoorCauseCodep">
	<input type="hidden" id="mainPoorCauseCodepForm" name="mainPoorCauseCodep">
	<input type="hidden" id="mainPoorCauseCodeForm" name="mainPoorCauseCode">
</form>

<%@ include file="/WEB-INF/view/common/footer.jsp" %>


	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/jsDateTimeUtil.js"></script>
	<script type="text/javascript" src="/js/template.js"></script>
	<script type="text/javascript" src="/js/templateHelper.js"></script>
	
	<!-- 下拉多选 -->
	<script type="text/javascript" src="/js/bootstrap-select/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-select/defaults-zh_CN.min.js"></script>
	<!-- 表单验证 -->
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	<!-- 文件上传 -->
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-process.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-validate.js"></script>
	
	<script type="text/javascript">
	
		var dn = ('${dn}' == '')? '' : 'dn';
	
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
					,
					certificateTypeCode : {
						required: true
					}
					,
					certificateNo : {
						required: true,
						idCardNew:true
					},
					perCapitaNetIncome: {
						required: true,
						income:true
					}
				}
				
			});
			
			// 审核按钮的逻辑
			var btn_html = '<c:if test="<%=btn_8301 %>"><button class="btn btn-success" onclick="examine(1)">审核通过</button>&nbsp;&nbsp;</c:if>';
			btn_html += '<c:if test="<%=btn_8302 %>"><button class="btn btn-danger" onclick="examine(0)">驳回</button></c:if>';
			
			
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
			    		hpId : '',
			    		certificateNo:$("#certificateNo").val(),
			    		startTime:'',
			    		endTime:'',
			    		examineType: $("#examineType").val()
			        }
			    },//参数
				sortName: 'id',
			    sortOrder: 'desc',
				clickToSelect: true,
				columns: [
					{
		//				checkbox: true,
		//				align: 'center'
		//			},{
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
						field: 'certificateNo',
						title: '证件号码',
						align: 'center',
						valign: 'middle'
					},{
						field: 'statusValue',
						title: '审核状态',
						align: 'center',
						valign: 'middle',
						formatter: function(value, row, index){
							return '<a onclick="showShenheModal(\'' + row.familyNo + '\',\'' + row.status + '\')">' + value + '</a>';
						}
					},
					{
						title: "操作", // btn_html,
						align: 'center',
						width: 200,
						formatter : function(value, row, index){
							var examineBtn = ($("#examineType").val() == 0)? "" : "dn";
							return '<button class="btn btn-info btn-sm '+ examineBtn +'" '
								+ 'onclick="showShenheModal(\'' + row.familyNo + '\',\'' + row.status + '\')">审核</button>'
								+ '&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="showMember(\'query\',' + row.id + ',' + row.familyNo + ')">详情</button>'
								+ '&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="openPage('+row.id+',' + row.familyNo +','+ row.poorAttributeCode+')">关联信息</button>';
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
			
			// 切换不同审核状态列表
			$('#myTab a').click(function (e) { 
		         e.preventDefault();//阻止a链接的跳转行为 
		         var tabId = $(this).attr("href");
		         if(tabId == '#tab1'){
		        	 $("#examineType").val("0");
		         }
		         else if(tabId == '#tab2'){
		        	 $("#examineType").val("1");
		         }
		         else if(tabId == '#tab3'){
		        	 $("#examineType").val("9");
		         }
	        	 $('#table').bootstrapTable("refresh");
		    });
			
			
			$("#opinion").on("keyup", function(){
				var len = $("#opinion").val().length;
				$("#exa_zise").html(200 - len);
			})
			
			
			
		});
		
		/* 回车搜索 
		$(document).keyup(function (e) {
	        if (e.keyCode == 13)
	        	$("#search").trigger("click");
	    });*/
		
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
			
			$('#address1').on('change', function () {
				var pcode = $('#address1').val();
				$.get("${basePath }/common/codeList?type=address2&pcode="+pcode,function(data){
					var html = '<option value="">全部</option>';
					for(var i=0; i<data.length; i++){
						html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
					}
					$('#address2').html(html);
					$('#address3').html('<option value="">全部</option>');
				},"JSON");
			});
			
			
			$('#address2').on('change', function () {
				var pcode = $('#address2').val();
				$.get("${basePath }/common/codeList?type=address3&pcode="+pcode,function(data){
					var html = '<option value="">全部</option>';
					for(var i=0; i<data.length; i++){
						html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
					}
					$('#address3').html(html);
				},"JSON");
			});
			
			/*
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
			*/
			
			$('#secondaryPoorCauseCode').selectpicker({
				style : "h34px"
			});
			// 主要和次要致贫原因
			$.get("${basePath }/common/codeList?type=poorCauseCode",function(data){
				var html = '';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#mainPoorCauseCode').html('<option value="">全部</option>' + html);
				$('#secondaryPoorCauseCode').html(html);
				
				$('#secondaryPoorCauseCode').selectpicker('refresh');
				
			},"JSON");
		}
		
		
		function openPage(id,familyNo,poorAttributeCode){
			window.open("${basePath }/pafam/familyInfoList/familyDetail?poorAttributeCode="+poorAttributeCode+"&familyNo=" + familyNo+"&id="+id+"&dn="+dn+"&zzz=");
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
					var html = '<div class="input-group" style="/*width:760px;*/"><a href="javascript:;" onclick="javascript:$(\'#tupian\').click();"><img src="/img/defPhoto.png" id="photoImg" style="width:100px;height:100px;"/></a><input type="hidden" id="photo" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
					
					html += '<div id="progress_1" class="progress dn" style="margin-bottom: 105px">';
					html += '<div class="progress-bar progress-bar-success progress-bar-striped active" style="width: 0;">';
					html += '<div class="progress-value"></div>';
					html += '</div></div>';
					
					for(var i=0; i<objArry.length; i++){
						 if(objArry[i].dataInputType=="img"){//过滤【用户照片】
							continue;
						}
						 if(objArry[i].colENName=='feedback'){
								continue;
							}
						 if(objArry[i].colENName=='birthday'){
								continue;
							}
						 if(objArry[i].colENName=='address1'){
								html+='<div class="input-group"><label style="width:400px;height:30px;"></label></div>';
							}
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span>';
						if(objArry[i].dataInputType=="text"){
							html +='<input type="text" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" />';
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
						}else if(objArry[i].dataInputType=="textarea"){
							html +='<textarea class="form-control" name="'+objArry[i].colENName+'"></textarea>';
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
				        
				        progressall: function(e, data){
				        	//var progress = parseInt(data.loaded / data.total * 100, 10);
				        	//$("#progress_1 .progress-bar").css('width', progress + '%');
				            //$('#progress_1 .progress-value').html(progress + '%');
				        },
				        
				        done: function (e, data) {
				        	$("#photo").val(data.result);
				        	$("#photoImg").attr("src", "data:image/.jpg;base64," + data.result);
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
						 if(objArry[i].colENName=='feedback'){
								continue;
							}
						 if(objArry[i].colENName=='birthday'){
								continue;
							}
						 if(objArry[i].colENName=='address1'){
								html+='<div class="input-group"><label style="width:400px;height:30px;"></label></div>';
							}
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span>';
						if(objArry[i].dataInputType=="text"){
							html +='<input type="text" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'" required data-bv-notempty-message="错啦"/>';
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
							html +='<textarea class="form-control" name="'+objArry[i].colENName+'">'+objArry[i].value+'</textarea>';
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
				        	$("#photo").val(data.result);;
				        	$("#photoImg").attr("src", "data:image/.jpg;base64," + data.result);
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
						if(objArry[i].colENName=='feedback'){
							continue;
						}
						if(objArry[i].colENName=='address1'||objArry[i].colENName=='address2'||objArry[i].colENName=='address3'){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:148px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}else if(objArry[i].colENName=='poorAttributeCode'||objArry[i].colENName=='mainPoorCauseCode'
								  ||objArry[i].colENName=='secondaryPoorCauseCode'||objArry[i].colENName=='povertyState'){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:760px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}else if(objArry[i].colENName=='birthday'){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:300px;">'+(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format("yyyy-MM-dd"))+'</span></div>';
						}else{
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:300px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}
						
					}
					$("#showForm22").html(photo+html);
					$("#myModalLabel22").html("详情");
					$('#myModal22').modal();
					
					$("#photo").val(photoImgSrc);
					if(photoImgSrc!=null&&photoImgSrc!=""){
						// $("#photoImg").attr("src", "data:image/.jpg;base64," + photoImgSrc);
						$("#photoImg").attr("src", photoImgSrc);
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
		function openNewWindow(){
						//
						var endTime = $("#endTime").val();
						var startTime =$("#startTime").val();
						//次要致贫原因
					    var selectSecondValue = $("button[data-id='secondaryPoorCauseCode']").text();// 数组转str
			    		
			    		var selectSecondValuep = "";
					 	if($("#secondaryPoorCauseCode").val() !== undefined && $("#secondaryPoorCauseCode").val() !== null){
							selectSecondValuep = $("#secondaryPoorCauseCode").val().join(","); // 数组转str
						} 
						//贫困户属性
			    		var poorAttributeCode = $("#poorAttributeCode").find("option:selected").text();
			    		var poorAttributeCodep= $("#poorAttributeCode").val();
			    		//主要致贫原因
			    		var mainPoorCauseCode = $("#mainPoorCauseCode").find("option:selected").text();
			    		var mainPoorCauseCodep = $("#mainPoorCauseCode").val();
			    		
			    		var address1 =$("#address1").find("option:selected").text();
			    		var address1p = $("#address1").val();
			    		var address2 =$("#address2").find("option:selected").text();
			    		var address2p = $("#address2").val();
			    		var address3 =$("#address3").find("option:selected").text();
			    		var address3p = $("#address3").val();
			    		
			    		var householderName = $("#householderName").val();
			    		var certificateNo = $("#certificateNo").val();
			    		/* var ifwf = $("#ifwf").val();
			    		var ifstbc =$("#ifstbc").val(); */
					
			    	/* var mm= "&address1="+address1+"&address2="+address2+"&address3="+address3+"&poorAttributeCode="+poorAttributeCode;
			    	//mm += "&mainPoorCauseCode="+mainPoorCauseCode;
			    	//+"&secondaryPoorCauseCode="+selectSecondValue;
			    	mm +="&address1p="+address1p+"&address2p="+address2p+"&address3p="+address3p;
			    	mm +="&poorAttributeCodep="+poorAttributeCodep;
			    	mm +="&certificateNo="+certificateNo;
			    	mm +="&startTime="+startTime+"&endTime="+endTime;
			    	mm +="&secondaryPoorCauseCode="+selectSecondValue+"&secondaryPoorCauseCodep="+selectSecondValuep+"&mainPoorCauseCodep="+mainPoorCauseCodep+"&mainPoorCauseCode="+mainPoorCauseCode;
					window.open("${basePath }/pafam/chaooseDownExcel?householderName="+householderName+mm ); */
					
					$("#householderNameForm").val(householderName);
					$("#address1Form").val(address1);
					$("#address2Form").val(address2);
					$("#address3Form").val(address3);
					$("#poorAttributeCodeForm").val(poorAttributeCode);
					$("#address1pForm").val(address1p);
					$("#address2pForm").val(address2p);
					$("#address3pForm").val(address3p);
					$("#poorAttributeCodepForm").val(poorAttributeCodep);
					$("#certificateNoForm").val(certificateNo);
					$("#startTimeForm").val(startTime);
					$("#endTimeForm").val(endTime);
					$("#secondaryPoorCauseCodeForm").val(selectSecondValue);
					$("#secondaryPoorCauseCodepForm").val(selectSecondValuep);
					$("#mainPoorCauseCodepForm").val(mainPoorCauseCodep);
					$("#mainPoorCauseCodeForm").val(mainPoorCauseCode);
					$("#formSubmit").attr("action","${basePath }/pafam/chaooseDownExcel");
					$("#formSubmit").attr("method","post");
					$("#formSubmit").attr("target","_blank");
					$("#formSubmit").submit();
		}
		function showFeedBack(id,feedback){
			$('#showForm10_id').val(id);
			$('#showForm10_feedback').val((feedback==null||feedback=="null")?"":feedback);
			$('#myModal10').modal();
		}
		function submitForm10(){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/pafb/savePaFamilyBasicInfo?hpId=${hpId}", 
		          data : $("#showForm10").serialize(),
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("保存成功");
		        	  $("#myModal10").modal('hide');
		        	  $('#table').bootstrapTable("refresh");
		          }  
		     });
		}
		
		
		
		
		function examine(yes){
			var selects = $('#table').bootstrapTable('getSelections');
			if(selects.length === 0){
				alert("请选择一条数据进行审核操作！");
				return;
			}else{
				
				if(roleLevel == ''){
					alert("您没有审核操作的权限！");
					return;
				}
				
				var hasRole = true;
				
				
				var ids = new Array();
				for(var i=0;i<selects.length;i++){
					ids.push(selects[i].id);
					if(selects[i].status != roleLevel){
						hasRole = false;
					}
				}
				
				
				if(!hasRole){
					alert("您只能对审核状态为  <span style='font-weight:800'>" + roleLevelText + "</span>  的数据进行审核操作！");
					return;
				}
				
				var curStatus = selects[0].status;
				
				if(yes == 1){
					if(confirm("确认要通过所选的数据吗？")){
						$.ajax({  
					          type : "post",  
					          url : "${basePath }/help/examine",  
					          data : {id:ids.join(','), yes : 1, status : curStatus},
					          dataType:"JSON",
					          success : function(data){  
					        	  alert("通过成功");
					        	  $('#table').bootstrapTable("refresh");
					          }  
					     });
					}
				}else{
					if(confirm("确认要驳回所选的数据吗？")){
						$.ajax({  
					          type : "post",  
					          url : "${basePath }/help/examine",
					          data : {id:ids.join(','), yes : 0, status : curStatus},
					          dataType:"JSON",
					          success : function(data){  
					        	  alert("驳回成功");
					        	  $('#table').bootstrapTable("refresh");
					          }  
					     });
					}
				}
			}
		}			
		
		
		
		function showShenheModal(familyNo, status){
			// 选取第一个标签页
			$('#shenheTab a:first').tab('show');
			/*添加一些判断按钮的逻辑
			*/
			var examineType = $("#examineType").val();
			// 1、审核窗口
			if(examineType == 0){
				$("#opinion").removeProp('disabled');
				$("#btn_submit").show();
				$("#examine_yes").removeProp('disabled');
				if(status == 1){
					//$("#btn_no").hide();
					$("#examine_no").prop('disabled', 'disabled');
				}else{
					//$("#btn_no").show();
					$("#examine_no").removeProp('disabled');
				}
				$("#exa_zise").parent().show();
			}else{
				$("#exa_zise").parent().hide();
				// 2、已审核 和 全部窗口
				$("#opinion").prop('disabled', 'disabled');
				$("#btn_submit").hide();
				//$("#btn_no").hide();
				
				$("#examine_yes").prop('disabled', 'disabled');
				$("#examine_no").prop('disabled', 'disabled');
			}
			
			/*
			*当前用户能打开审核窗口，那么肯定是审核通过的     TODO
			*/
			$("#examine_yes").prop("checked", "checked")
			
			$("#exa_familyNo").val(familyNo);
			$("#opinion").val(''); // 先清空
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/help/getOpinion",
		          data : {
		        	  familyNo : familyNo
		          },
		          dataType:"JSON",
		          success : function(data){  
		        	  if(data.code == 0) {
		        		  $("#opinion").val(data.data);
		        	  }
		        	  var len = $("#opinion").val().length;
	  				  $("#exa_zise").html(200 - len);
		          }  
		    });
			$("#shenheModal").modal({backdrop: 'static', keyboard: false});
			
			/* 加载审核记录
			*/
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/help/gethistory",
		          data : {
		        	  familyNo : familyNo
		          },
		          dataType:"JSON",
		          success : function(data){  
		        	  
		        	  if(data.code == 0 ) {
		        		  $("#navtab2").html(template('shenhe_temp', data.data));
		        	  }else {
		        		  $("#navtab2").html("查无审核记录！");
		        	  }
		          }  
		    });
			
			
			// 获取当前审核节点
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/help/step",
		          data : {
		        	  familyNo : familyNo
		          },
		          dataType:"JSON",
		          success : function(data){  
		        	  
		        	  console.log(data);
		        	  
		        	  if(data.code == 0 ) {
		        		  
		        	  	$("#redLine").css({
		        	  		'left' : data.data.x + "px",
		        	  		'top' : data.data.y + "px",
		        	  		'width' : data.data.width + "px",
		        	  		'height' : data.data.height + "px"
		        	  	});
		        	  }else {
		        		  $("#redLine").hide();
		        	  }
		          }
		    });
			
			
			
		}
		
		function newEexamine(yesNo){
			// 
			yesNo = $("input[name='examine_radio']:checked").val();
		
			if(yesNo == 'no' && $("#opinion").val().trim() == ''){
				alert("请填写审核意见！");
				return false;
			}
			/* 
			if($("#opinion").val().length > 200){
				alert("审核意见内容不得超过200字！");
				return false;
			}
		 	*/
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/help/nexamine",
		          data : {
		        	  familyNo : $("#exa_familyNo").val(),
		        	  opinion : $("#opinion").val(),
		        	  yesNo : yesNo
		          },
		          dataType:"JSON", 
		          success : function(data){  
		        	  alert(data.msg);
		        	  $("#shenheModal").modal('hide');
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
<!-- 审核记录模板 -->
<script id="shenhe_temp" type="text/html">
<div class="modal-body bodyBox">
	<div class="BoxL">
		<h3>贫困户基本信息</h3>
 		<div class="textarea">
			<div class="info"><span>户主姓名：</span>{{info.householderName}}</div>
			<div class="info"><span>性别：</span>{{if info.gender == '1'}}男{{else}}女{{/if}}</div>

			<div class="info"><span>证件号码：</span>{{info.certificateNo}}</div>
			<div class="info"><span>联系电话：</span>{{info.telNo}}</div>

			<div class="info"><span>贫困户属性：</span>{{info.poorAttributeValue}}</div>
			<div class="info"><span>家庭住址：</span>{{info.addressValue1}}{{info.addressValue2}}{{info.addressValue3}}</div>
			
			<div class="info"><span>主要致贫原因：</span>{{info.mainPoorCauseValue}}</div>
			<div class="info"><span>次要致贫原因：</span>{{info.secondaryPoorCauseValue}}</div>

		</div>
	 	<h3>录入人员审核意见</h3>
		<div class="BoxL-inps">
			<div class="opinion-div">{{opinion1}}</div>
	 		<ul class="BoxL-inp">
	 			<li>
	 				<span>签名</span>
	 				<div>{{lururenyuan}}</div>
	 			</li>
	 			<li>
	 				<span>时间</span>
	 				<div>{{dateFormat datetime1}}</div>
	 			</li>
	 		</ul>
	 	</div>

		
	 	<h3>区级审核意见</h3>
		<div class="BoxL-inps">
	 		<input type="hidden" placeholder="审核意见（盖电子章/人名章）"/>
			<div class="opinion-div">{{opinion2}}</div>
	 		<ul class="BoxL-inp">
	 			<li>
	 				<span>签名</span>
	 				<div>{{qulingdao}}</div>
	 			</li>
	 			<li>
	 				<span>时间</span>
	 				<div>{{dateFormat datetime2}}</div>
	 			</li>
	 		</ul>
	 	</div>

		
	 	<h3>市级审核意见</h3>
		<div class="BoxL-inps">
			<div class="opinion-div">{{opinion3}}</div>
	 		<ul class="BoxL-inp">
	 			<li>
	 				<span>签名</span>
	 				<div>{{shilingdao}}</div>
	 			</li>
	 			<li>
	 				<span>时间</span>
	 				<div>{{dateFormat datetime3}}</div>
	 			</li>
	 		</ul>
	 	</div>

		
	 	<h3>市扶贫办审核意见</h3>
		<div class="BoxL-inps">
			<div class="opinion-div">{{opinion4}}</div>
	 		<ul class="BoxL-inp">
	 			<li>
	 				<span>签名</span>
	 				<div>{{shifupinban}}</div>
	 			</li>
	 			<li>
	 				<span>时间</span>
	 				<div>{{dateFormat datetime4}}</div>
	 			</li>
	 		</ul>
	 	</div>



	</div>

	
	<div class="BoxR">
		<ul class="timeline">
		{{each array as item i}}
			{{if i%2 == 0}}
			<li>
			{{else}}
			<li class="timeline-inverted">
			{{/if}}
				<div class="tl-circ"></div>
				<div class="timeline-panel">
					<div class="tl-heading">
						<h4>{{item.title}}</h4>
						<p><small class="text-muted"><i></i>{{dateFormat item.time}}</small></p>
					</div>
					<div class="tl-body">
						<p>{{item.shenhe}}</p>
						<p>{{item.comment}}</p>
					</div>
				</div>
			</li>
		{{/each}}
		</ul>
	</div>


</div>

</script>
<script id="shenhe_temp3" type="text/html">
<div class="modal-body bodyBox" style="overflow: auto;">
	
	<div style="width: 63%; float: left;">
<!-- 表格  start -->
<div class="bootstrap-table">
	<div class="fixed-table-container" >
		<div class="fixed-table-body" >
			
<table class="table table-hover" >

<!-- table cellpadding="0" cellspacing="0" border="1" -->
	<tr>
		<td colspan=4 class="shenhe-table-td">贫困户基本信息</td>
	</tr>
	<tr>
		<td colspan=4 style="height: 70px;">
			<div class="fl ml40">户主姓名：{{info.householderName}}</div>
			<div class="fr mr20">证件号码：{{info.certificateNo}}</div>
			<br>
			<div class="fl ml40">贫困状态：{{info.povertyStateValue}}</div>
			<div class="fr mr20">主要致贫原因：{{info.mainPoorCauseValue}}</div>

		</td>
	</tr>

	<tr>
		<td colspan=4 class="shenhe-table-td">录入人员审核意见</td>
	</tr>
	<tr>
		<td colspan=4 style="height: 60px;">{{opinion1}}</td>
	</tr>
	<tr>
		<td class="shenhe-table-td">签名</td>
		<td>{{lururenyuan}}</td>
		<td class="shenhe-table-td">时间</td>
		<td>{{dateFormat datetime1}}</td>
	</tr>

	<tr>
		<td colspan=4 class="shenhe-table-td">区级领导审核意见</td>
	</tr>
	<tr>
		<td colspan=4 style="height: 60px;">{{opinion2}}</td>
	</tr>
	<tr>
		<td class="shenhe-table-td">签名</td>
		<td>{{qulingdao}}</td>
		<td class="shenhe-table-td">时间</td>
		<td>{{dateFormat datetime2}}</td>
	</tr>


	<tr>
		<td colspan=4 class="shenhe-table-td">市级领导审核意见</td>
	</tr>
	<tr>
		<td colspan=4 style="height: 60px;">{{opinion3}}</td>
	</tr>
	<tr>
		<td class="shenhe-table-td">签名</td>
		<td>{{shilingdao}}</td>
		<td class="shenhe-table-td">时间</td>
		<td>{{dateFormat datetime3}}</td>
	</tr>

	<tr>
		<td colspan=4 class="shenhe-table-td">市扶贫办审核意见</td>
	</tr>
	<tr>
		<td colspan=4 style="height: 60px;">{{opinion4}}</td>
	</tr>
	<tr>
		<td class="shenhe-table-td">签名</td>
		<td>{{shifupinban}}</td>
		<td class="shenhe-table-td">时间</td>
		<td>{{dateFormat datetime4}}</td>
	</tr>


	
</table>
</div></div></div>
<!-- 表格end -->

	</div>
	<div style="width: 33%; float: left; margin-left: 25px;">
		<ul class="timeline">
		{{each array as item i}}
			{{if i%2 == 0}}
			<li>
			{{else}}
			<li class="timeline-inverted">
			{{/if}}
				<div class="tl-circ"></div>
				<div class="timeline-panel">
					<div class="tl-heading">
						<h4>{{item.title}}</h4>
						<p><small class="text-muted"><i></i>{{dateFormat item.time}}</small></p>
					</div>
					<div class="tl-body">
						<p>{{item.shenhe}}</p>
						<p>{{item.comment}}</p>
					</div>
				</div>
			</li>
		{{/each}}
		</ul>
	</div>

</div>

</script>
<script id="shenhe_temp2" type="text/html">
<div class="modal-body bodyBox" style="overflow: auto;">
	
	<div style="width: 65%; float: left;">
		<div class="input-group">
			<span class="input-group-addon">贫困户基本信息</span>
			<textarea class="form-control"></textarea>
		</div>
		<div class="input-group">
			<span class="input-group-addon">录入人员审核意见</span>
			<textarea class="form-control"placeholder="审核意见（盖电子章/人名章）">
				{{opinion1}}
			</textarea>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">签名</span>
					<input type="text" class="form-control" value="{{lururenyuan}}">
				</div>
			</div>
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">时间</span>
					<input type="text" class="form-control" value="{{dateFormat datetime1 'yyyy-MM-dd hh:mm:ss'}}">
				</div>
			</div>
		</div><!-- /.row -->

		<div class="input-group">
			<span class="input-group-addon">区级领导审核意见</span>
			<textarea class="form-control"placeholder="审核意见（盖电子章/人名章）">{{opinion2}}</textarea>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">签名</span>
					<input type="text" class="form-control" value="{{qulingdao}}">
				</div>
			</div>
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">时间</span>
					<input type="text" class="form-control" value="{{dateFormat datetime2 'yyyy-MM-dd hh:mm:ss'}}">
				</div>
			</div>
		</div><!-- /.row -->

		<div class="input-group">
			<span class="input-group-addon">市级领导审核意见 </span>
			<textarea class="form-control"placeholder="审核意见（盖电子章/人名章）">{{opinion3}}</textarea>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">签名</span>
					<input type="text" class="form-control" value="{{shilingdao}}">
				</div>
			</div>
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">时间</span>
					<input type="text" class="form-control" value="{{dateFormat datetime3 'yyyy-MM-dd hh:mm:ss'}}">
				</div>
			</div>
		</div><!-- /.row -->

		<div class="input-group">
			<span class="input-group-addon">市扶贫办审核意见 </span>
			<textarea class="form-control"placeholder="审核意见（盖电子章/人名章）">{{opinion4}}</textarea>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">签名</span>
					<input type="text" class="form-control" value="{{shifupinban}}">
				</div>
			</div>
			<div class="col-lg-6">
				<div class="input-group">
					<span class="input-group-addon">时间</span>
					<input type="text" class="form-control" value="{{dateFormat datetime4 'yyyy-MM-dd hh:mm:ss'}}">
				</div>
			</div>
		</div><!-- /.row -->

	</div>
	<div style="width: 30%; float: left;">
		<ul class="timeline">
		{{each array as item i}}
			{{if i%2 == 0}}
			<li>
			{{else}}
			<li class="timeline-inverted">
			{{/if}}
				<div class="tl-circ"></div>
				<div class="timeline-panel">
					<div class="tl-heading">
						<h4>{{item.title}}</h4>
						<p><small class="text-muted"><i></i>{{dateFormat item.time 'yyyy-MM-dd hh:mm:ss'}}</small></p>
					</div>
					<div class="tl-body">
						<p>{{item.shenhe}}</p>
						<p>{{item.comment}}</p>
					</div>
				</div>
			</li>
		{{/each}}
		</ul>
	</div>

</div>

</script>

</html>