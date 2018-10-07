<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
   
<%@ page import="com.golden.util.UserAuthUtil" %> 
<% 
//添加扶贫信息
boolean btn_8002 = UserAuthUtil.hasOperator(request, "8002");
btn_8002 = "万书桓".equals(session.getAttribute("userName"));
//修改扶贫信息
boolean btn_8003 = UserAuthUtil.hasOperator(request, "8003");
btn_8003 = "万书桓".equals(session.getAttribute("userName"));
//导出扶贫信息
boolean btn_8004 = UserAuthUtil.hasOperator(request, "8004");
//打印
boolean btn_8005 = UserAuthUtil.hasOperator(request, "8005");
//PDF导出
boolean btn_8006 = UserAuthUtil.hasOperator(request, "8006");
// 扶贫信息管理——信息比对
boolean btn_8007 = UserAuthUtil.hasOperator(request, "8007");
// 扶贫信息管理——名单互比
boolean btn_8008 = UserAuthUtil.hasOperator(request, "8008");


%>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">

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
.boxlist {
	overflow: hidden;
	padding: 20px 20px 20px 125px;
}
.boxlist ul{
	
}
.boxlist ul li{
	float:left;
	width:30%;
	padding-left:30px;
}
.boxlist .dc_btn{
	text-align: center;
	margin:20px;
}

.div_fam {
    padding-left: 30px;
    margin-top: 15px;
}

/*  */

.input-group {
    width: 24%;
}

.form-inline .input-group .input-group-addon
{
	width: 50%;
}

li .checkbox-inline input {
	margin-top: 5px;
}


/*弹出框的表单样式*/
#showForm22 .input-group {
    width: auto;
}

/* 展开收起的样式 start */
.my-panel {
	padding-top: 5px !important;
}
.my-panel .zksq {
	height: 28px;
}
.my-panel .zksq #collapse_btn{
	float: right;
    padding: 2px;
    background-color: #C61D22;
    border-color: #C61D22;
}
/* 展开收起的样式 end */

</style>

<%
String userType = session.getAttribute("userType")==null?"":session.getAttribute("userType").toString();
%>
<script type="text/javascript">
	var userType = '<%=userType %>';
	var roleLevel = '';
	if(userType == 2){
		roleLevel = 1;
	}else if(userType == 3){
		roleLevel = 3;
	}else if(userType == 4){
		roleLevel = 5;
	}else if(userType == 99){
		roleLevel = 7;
	}
	
	/*
	录入人员		2
	区领导		3
	市领导		4
	市扶贫办               99
	*/
</script>

</head>
<body>



<%@ include file="/WEB-INF/view/common/header.jsp" %>
<div class="w1200 main">
	<div class="panel panel-default my-panel">
		<div>
			<div class="zksq">
				<button id="collapse_btn" type="button" class="btn btn-warning btn-sm" data-toggle="collapse" 
					data-target="#searchForm">-收起搜索</button>
			</div>
			
			<form class="form-inline panel-collapse collapse in" role="form" id="searchForm">
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
					 <select class="form-control" id="poorAttributeCode" multiple data-live-search="true"> 
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
				<div class="input-group" style="width:49%">
					<span class="input-group-addon" style="width:100px">督导时间</span>
					 <input id="startTime" name="startTime" class="Wdate form-control" type="text" onFocus="var endTime=$dp.$('endTime');WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',onpicked:function(){endTime.focus();},maxDate:'#F{$dp.$D(\'endTime\')}'})" value=""/>
					 <span class="input-group-addon" style="width:45px">至</span>
					 <input id="endTime" name="endTime" class="Wdate form-control" type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" value=""/>
				</div>
				<div class="input-group" style="width:49%">
					<span class="input-group-addon" style="width:100px">人员出生日期</span>
					 <input id="bornStartTime" name="bornStartTime" class="Wdate form-control" type="text" onFocus="var bornEndTime=$dp.$('bornEndTime');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){bornEndTime.focus();},maxDate:'#F{$dp.$D(\'bornEndTime\')}'})" value=""/>
					 <span class="input-group-addon" style="width:45px">至</span>
					 <input id="bornEndTime" name="bornEndTime" class="Wdate form-control" type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'bornStartTime\')}',dateFmt:'yyyy-MM-dd'})" value=""/>
				</div>
				<div class="input-group">
					<span class="input-group-addon">危房级别</span>
					 <select class="form-control" id="danger_house_level" multiple data-live-search="true">
					 	<option value="2">否</option> 
					 	<option value="levelC">C级</option> 
					 	<option value="levelD">D级</option> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">是否参加新农合</span>
					 <select class="form-control" id="isFarmCooperation" >
					 	<option value="">全部</option> 
					 	<option value="0">否</option> 
					 	<option value="1">是</option> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">是否参加新农保</span>
					 <select class="form-control" id="isFarmSecurity" >
					 	<option value="">全部</option> 
					 	<option value="0">否</option> 
					 	<option value="1">是</option> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">是否享受低保</span>
					 <select class="form-control" id="isIncomeSupport" >
					 	<option value="">全部</option> 
					 	<option value="0">否</option> 
					 	<option value="1">是</option> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">健康状况</span>
					 <select class="form-control" id="healthInfo" >
					 	<option value="">全部</option> 
					 	<option value="0">健康</option> 
					 	<option value="1">非健康</option> 
				     </select>
				</div>
				<div class="input-group">
					<span class="input-group-addon">是否在校</span>
					 <select class="form-control" id="collegeInfo" >
					 	<option value="">全部</option> 
					 	<option value="0">在校生</option> 
					 	<option value="1">非在校生</option> 
				     </select>
				</div>
				<!-- <div class="input-group">
					<span class="input-group-addon">年龄分档</span>
					 <select class="form-control" id="ageLevel" >
					 	<option value="">全部</option> 
					 	<option value="0">学龄前人员（3-6岁）</option> 
					 	<option value="1">在校生人员（6-22岁）</option> 
					 	<option value="2">16周岁以下</option>
					 	<option value="3">16周岁以上（包含16周岁）</option>  
				     </select>
				</div> -->
				<div class="input-group">
					<span class="btn btn-primary" id="search">搜索</span>
				    <span class="btn btn-primary ml5" id="reset">重置</span>
				    <c:if test="<%=btn_8007 %>">
				    	<span class="btn btn-primary ml5" id="duibiClick">对比</span>
				    </c:if>
				    <c:if test="<%=btn_8008 %>">
				    	<span class="btn btn-primary ml5" id="mdhb">名单互比</span>
				    </c:if>
				</div>
			
			</form>
			
			
		</div>
		<div>
			<table id="table"></table>
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
<div class="modal fade" id="mdhbModal" tabindex="-1" role="dialog" 
		aria-labelledby="mdhbModalLabel" aria-hidden="true" style="top: 10%;">
	<div class="modal-dialog"  style="width:400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="mdhbModalLabel">
					名单互比
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;min-height:200px;">
    	<form class="form-inline" id="mdhbForm" role="form" enctype="multipart/form-data">
						<div class="form-group" style="padding:10px 5px 0px 70px">
						名单一<input  type="file" name="upload" id="upload1" value="">
						名单二<input  type="file" name="upload" id="upload2" value="">
						</div>
						<div class="form-group" style="padding:50px">
						<span class="btn btn-primary ml10" onclick="mdhbSubmit();">提交</span>
						<a href="/duibiTemplate/templateHB.xls"><span class="btn btn-danger ml5">下载模板</span></a>
						</div>
						
    	</form>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="modal fade" id="duibiModal" tabindex="-1" role="dialog" 
		aria-labelledby="duibiModalLabel" aria-hidden="true" style="top: 10%;">
	<div class="modal-dialog"  style="width:400px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="duibiModalLabel">
					对比
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;min-height:150px;">
						<div class="form-group">
						 <span class="btn btn-primary ml5" id="duibi">对比</span>
				    	 <span class="btn btn-primary ml5" id="duibihz">对比户主</span>
				    	 <input name="media" id="duibiMedia"  type="file" style="width:250px;display:none" multiple>
				    	 <input name="media" id="duibihzMedia"  type="file" style="width:250px;display:none" multiple>
				    	  <a href="/duibiTemplate/templateDB.xls"><span class="btn btn-danger ml5">下载模板</span></a>
						</div>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<div class="modal fade" id="myModal1000" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel1000" aria-hidden="true">
	<div class="modal-dialog"  style="width:240px;">
		<div class="modal-content">
	<div style="overflow:auto;min-height:40px;">
    	<form class="bs-example bs-example-form" id="showForm1000" role="form">
    		<div style="text-align:center;vertical-align:middle">
    			<span style="font-size:20px">正在对比,请稍后...</span>
    		</div>
    	</form>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="modal fade" id="myModal100" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel100" aria-hidden="true" style="top: 10%;">
	<div class="modal-dialog"  style="width:1050px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel100">
					导出
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;min-height:250px;">
    	<div class="boxlist">
			<div style="margin-bottom:20px">
				<input type="button" id="chooseall" class="btn btn-warning btn-sm" onclick="allSelect()" value="全选" /> 
				<input type="button" id="encheckall" class="btn btn-warning btn-sm" onclick="otherSelect()" value="取消全选" /> 
			</div>
   			<ul>
				<li>
					<input name="v" id="chk_list_1" type="checkbox" value="1" onclick="return   false;" checked="checked" disabled/>序号 
				</li>
				<li><input name="v" id="chk_list_2" type="checkbox" value="2" onclick="return   false;" checked="checked" disabled/>省（自治区、直辖市） </li>
				<li><input name="v" id="chk_list_3" type="checkbox" value="3" onclick="return   false;" checked="checked" disabled/>市（盟、州）</li>
				<li><input name="v" id="chk_list_4" type="checkbox" value="4" onclick="return   false;" checked="checked" disabled/>县(市、区、旗) </li>
				<li><input name="v" id="chk_list_5" type="checkbox" value="5" onclick="return   false;" checked="checked" disabled/>行政村 </li>
				<li><input name="v" id="chk_list_100" type="checkbox" value="100" onclick="return   false;" checked="checked" disabled/>村小组</li>
				<li><input name="v" id="chk_list_6" type="checkbox" value="6" onclick="return   false;" checked="checked" disabled/>姓名</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="7" />性别 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="8" />证件号码  
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="9" />人数 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="10" />与户主关系 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="11" />民族 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="12" />文化程度
    				</label>
				 </li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="13" />在校生状况 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="14" />健康状况 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="15" />有无劳动能力 
    				</label>
				</li>
				<!-- <li style="display: none">
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="16" />是否计划生育户  
    				</label>
				</li> -->
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="17" />是否参加新农合 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="18" />是否参加新农保
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="19" />是否享受低保 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="20" />脱贫属性 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="21" />贫困户属性 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="22" />主要致贫原因
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="23" />人均纯收入
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="24" />联系电话
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="25" />开户银行名称
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="26" />银行卡号
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="27" />危房级别
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="28" />年龄
    				</label>
				</li>
				
			</ul>
			<div style="clear:both;"></div>
			<div class="div_fam div_fam1 div_fam2">
				<!-- <span >包含家庭成员</span>
				 <select  id="all" class="form-control">
				 	<option value="0" selected="selected">否</option> 
				 	<option value="1">是</option> 
			     </select> -->
			     <label class="checkbox-inline" style="font-size: 14px;font-weight: 800;">
     					<input type="checkbox"  id="all" style="margin-top: 5px;" /> 包含家庭成员
    			 </label>
			</div>
			<div class="div_fam div_fam1">
			     <label class="checkbox-inline" style="font-size: 14px;font-weight: 800;">
     					<input type="checkbox"  id="life" style="margin-top: 5px;" /> 包含生产生活现状
    			 </label>
			</div>
			<div class="div_fam div_fam2">
			     <label class="checkbox-inline" style="font-size: 14px;font-weight: 800;">
     					<input type="checkbox"  id="helpPerson" style="margin-top: 5px;" /> 包含帮扶责任人
    			 </label>
			</div>
			<div class="dc_btn">
				<button class="btn btn-warning" onclick="openNewWindowChoose()">导出</button>
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
<!--导出的表单  -->
<form id="formNew">
	<input type="hidden" id="nameNew" name="name">
	<input type="hidden" id="startTimeNew" name="startTime">
	<input type="hidden" id="endTimeNew" name="endTime">
	<input type="hidden" id="ifstbcpNew" name="ifstbcp">
	<input type="hidden" id="ifwfpNew" name="ifwfp">
	<input type="hidden" id="address1New" name="address1">
	<input type="hidden" id="address2New" name="address2">
	<input type="hidden" id="address3New" name="address3">
	<input type="hidden" id="poorAttributeCodeNew" name="poorAttributeCode">
	<input type="hidden" id="certificateNoNew" name="certificateNo">
	<input type="hidden" id="mainPoorCauseCodeNew" name="mainPoorCauseCode">
	<input type="hidden" id="secondaryPoorCauseCodeNew" name="secondaryPoorCauseCode">
	<input type="hidden" id="allNew" name="all">
	<input type="hidden" id="listNew" name="list">
	<input type="hidden" id="lifeNew" name="life">
	<input type="hidden" id="helpPersonNew" name="helpPerson">
	
	<input type="hidden" id="danger_house_levelNew" name="danger_house_level">
	<input type="hidden" id="isFarmCooperationNew" name="isFarmCooperation">
	<input type="hidden" id="isFarmSecurityNew" name="isFarmSecurity">
	<input type="hidden" id="isIncomeSupportNew" name="isIncomeSupport">
	<input type="hidden" id="ageLevelNew" name="ageLevel">
	
	<input type="hidden" id="bornStartTimeNew" name="bornStartTime">
	<input type="hidden" id="bornEndTimeNew" name="bornEndTime">
	
	<!-- 后加的条件 -->
	<input type="hidden" id="healthInfoNew" name="healthInfo">
	<input type="hidden" id="collegeInfoNew" name="collegeInfo">
	
</form>
<form id="duibiForm" action="/exportDuibi" method="post" target="_blank">
	<input type="hidden" id="fileNameDuibi" name="fileName"></input>
</form>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>


	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/jsDateTimeUtil.js"></script>
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
					//secondaryPoorCauseCode : "required",
					/* bankName : {
						required: true
					}, */
					cardNo : {
						//required: true,
						number : true,
				        maxlength:19
					}
					,
					certificateTypeCode : {
						required: true
					}
					,
					certificateNo : {
						idCardRequireNew:true //,
						// idCardNew:true
					},
					perCapitaNetIncome: {
						//required: true,
						income:true
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
					var danger_house_level="";
					var poorAttributeCode="";
					if($("#secondaryPoorCauseCode").val() !== undefined && $("#secondaryPoorCauseCode").val() !== null){
						selectSecondValue = $("#secondaryPoorCauseCode").val().join(",") // 数组转str
					}
					if($("#danger_house_level").val() !== undefined && $("#danger_house_level").val() !== null){
						danger_house_level = $("#danger_house_level").val().join(",") // 数组转str
					}
					if($("#poorAttributeCode").val() !== undefined && $("#poorAttributeCode").val() !== null){
						poorAttributeCode = $("#poorAttributeCode").val().join(",") // 数组转str
					}
			        return {
			            pageSize: params.limit,
			            offset: params.offset,
			            sort: params.sort,
			            sortOrder: params.order,
			            householderName : $("#householderName").val(),
			    		poorAttributeCode : poorAttributeCode,
			    		mainPoorCauseCode : $("#mainPoorCauseCode").val(),
			    		secondaryPoorCauseCode : selectSecondValue,
			    		address1 : $("#address1").val(),
			    		address2 : $("#address2").val(),
			    		address3 : $("#address3").val(),
			    		//ifwf : $("#ifwf").val(),
			    		//ifstbc : $("#ifstbc").val(),
			    		hpId : '${hpId}',
			    		certificateNo:$("#certificateNo").val(),
			    		startTime:$("#startTime").val(),
			    		endTime:$("#endTime").val(),
			    		danger_house_level:danger_house_level,
			    		isFarmCooperation:$("#isFarmCooperation").val(),
			    		isFarmSecurity:$("#isFarmSecurity").val(),
			    		isIncomeSupport:$("#isIncomeSupport").val(),
			    		ageLevel:$("#ageLevel").val(),
			    		bornStartTime:$("#bornStartTime").val(),
			    		bornEndTime:$("#bornEndTime").val(),
			    		healthInfo:$("#healthInfo").val(),
			    		collegeInfo:$("#collegeInfo").val()
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
						field: 'certificateNo',
						title: '证件号码',
						align: 'center',
						valign: 'middle'
					},{
						field: 'feedback',
						title: '督导记录',
						align: 'center',
						valign: 'middle',
						formatter: function(value, row, index){
							if(value==null){
								return "-";
							}else{
								var dots='';
								if(value.length>20){
									dots='...';
								}
								return "<span  data-toggle='tooltip' title='"+value+"'>"+(value==null?"-":(value.substring(0,20)+dots))+"</span>";
							}
						}
					},{
						field: 'feedbackTime',
						title: '督导时间',
						align: 'center',
						valign: 'middle',
						formatter : function(value, row, index){
							return value==null?"-":(new Date(value)).Format("yyyy-MM-dd hh:mm:ss");
						}
					},
					/* {
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
					}, */
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
						title:'<c:if test="<%=btn_8002 %>"><button class="btn btn-success" onclick="showMember(\'insert\')">添加</button>&nbsp;&nbsp;</c:if>'
//								+'<button class="btn btn-danger dn" onclick="deleteById()">删除</button>',
								+'<c:if test="<%=btn_8004 %>"><button class="btn btn-warning" onclick="javascript:$(\'#myModal100\').modal();">导出</button></c:if>',
						align: 'center',
						valign: 'middle',
						width: 350,
						formatter : function(value, row, index){
							return '<c:if test="<%=btn_8003 %>"><button class="btn btn-info btn-sm" '
							+ 'onclick="showMember(\'update\',' + row.id + ',' + row.familyNo + ')">编辑</button></c:if>'
							+ '&nbsp;&nbsp;'+'<button class="btn btn-info btn-sm" '
								+ 'onclick="showMember(\'query\',' + row.id + ',' + row.familyNo + ')">详情</button>'
								+ '&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="openPage('+row.id+',' + row.familyNo +','+ row.poorAttributeCode+')">关联信息</button>'
								+ '<c:if test="<%=btn_8005 %>">&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="openPrintPage('+row.id+',\'' + row.familyNo + '\',\''+row.poorAttributeCode+'\')">打印</button></c:if>'
								+ '<c:if test="<%=btn_8006 %>">&nbsp;&nbsp;'
								+ '<button class="btn btn-info btn-sm" '
								+ 'onclick="openPDFPage('+row.id+',\'' + row.familyNo + '\',\''+row.poorAttributeCode+'\')">PDF导出</button></c:if>'
								;
								<%-- +
								'<c:if test="<%=btn_8005 %>"><button class="btn btn-info btn-sm" '
								+ 'onclick="showFeedBack(' + row.id + ',\''+row.feedback+'\')">问题反馈</button></c:if>' --%>
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
				$('#danger_house_level').selectpicker('deselectAll');
				$('#poorAttributeCode').selectpicker('deselectAll');
				$('#table').bootstrapTable("refresh",{query: {offset:0}});
			});
			
			/* $(document).on("click",".div_fam1 input",function(){
				var checkF=$(this).is(":checked");
				$(".div_fam1 input").prop("checked",false);
				if(checkF){
					$(this).prop("checked",true);
				}else{
					$(this).prop("checked",false);
				}
			});
			$(document).on("click",".div_fam2 input",function(){
				var checkF=$(this).is(":checked");
				$(".div_fam2 input").prop("checked",false);
				if(checkF){
					$(this).prop("checked",true);
				}else{
					$(this).prop("checked",false);
				}
			}); */
			
			
			
			
			$("#duibi").click(function(){
				$('#duibiMedia').fileupload({
					url : '/duibi',
					formData:{
						householderName : $("#householderName").val(),
			    		poorAttributeCode :  $("#poorAttributeCode").val(),
			    		mainPoorCauseCode : $("#mainPoorCauseCode").val(),
			    		secondaryPoorCauseCode :  $("#secondaryPoorCauseCode").val(),
			    		address1 : $("#address1").val(),
			    		address2 : $("#address2").val(),
			    		address3 : $("#address3").val(),
			    		certificateNo:$("#certificateNo").val(),
			    		startTime:$("#startTime").val(),
			    		endTime:$("#endTime").val(),
			    		danger_house_level:$("#danger_house_level").val() ,
			    		isFarmCooperation:$("#isFarmCooperation").val(),
			    		isFarmSecurity:$("#isFarmSecurity").val(),
			    		isIncomeSupport:$("#isIncomeSupport").val(),
			    		ageLevel:$("#ageLevel").val(),
			    		bornStartTime:$("#bornStartTime").val(),
			    		bornEndTime:$("#bornEndTime").val()
					},
					dataType: 'json',
					add: function (e, data) {
						 var name='';
						 if(data.originalFiles[0]['name'].length){
							 name=data.originalFiles[0]['name'];
							 name=name.substring(name.lastIndexOf('.')+1);
							if(name!='xls'){
								 alert("文件类型只能为xls！");
						          return;
							}
						 }
						$("#myModal1000").modal({backdrop: 'static', keyboard: false});
						console.log(data);
						data.submit();
			       },
			       done: function (e, data) {
			    	   var flag=data.result.data.flag;
			    	   if(flag!=null&&flag==false){
			    		   $("#myModal1000").modal('hide');
			    		   alert("对比模板格式不正确，请选择正确模板！");
			    	   }else{
			    		   $("#myModal1000").modal('hide');
				    	   $("#fileNameDuibi").val(data.result.data.fileName);
				    	   $("#duibiForm").submit(); 
			    	   }
			       }
			   });
				
				$("#duibiMedia").click();
			});
			$("#duibihz").click(function(){
				$('#duibihzMedia').fileupload({
					url : '/duibihz',
					formData:{
						householderName : $("#householderName").val(),
			    		poorAttributeCode :  $("#poorAttributeCode").val(),
			    		mainPoorCauseCode : $("#mainPoorCauseCode").val(),
			    		secondaryPoorCauseCode :  $("#secondaryPoorCauseCode").val(),
			    		address1 : $("#address1").val(),
			    		address2 : $("#address2").val(),
			    		address3 : $("#address3").val(),
			    		certificateNo:$("#certificateNo").val(),
			    		startTime:$("#startTime").val(),
			    		endTime:$("#endTime").val(),
			    		danger_house_level:$("#danger_house_level").val() ,
			    		isFarmCooperation:$("#isFarmCooperation").val(),
			    		isFarmSecurity:$("#isFarmSecurity").val(),
			    		isIncomeSupport:$("#isIncomeSupport").val(),
			    		ageLevel:$("#ageLevel").val(),
			    		bornStartTime:$("#bornStartTime").val(),
			    		bornEndTime:$("#bornEndTime").val()
					},
					dataType: 'json',
					add: function (e, data) {
						var name='';
						 if(data.originalFiles[0]['name'].length){
							 name=data.originalFiles[0]['name'];
							 name=name.substring(name.lastIndexOf('.')+1);
							if(name!='xls'){
								 alert("文件类型只能为xls！");
						          return;
							}
						 }
						$("#myModal1000").modal({backdrop: 'static', keyboard: false});
						console.log(data);
						data.submit();
			       },
			       done: function (e, data) {
			    	   var flag=data.result.data.flag;
			    	   if(flag!=null&&flag==false){
			    		   $("#myModal1000").modal('hide');
			    		   alert("对比模板格式不正确，请选择正确模板！");
			    	   }else{
			    		   $("#myModal1000").modal('hide');
				    	   $("#fileNameDuibi").val(data.result.data.fileName);
				    	   $("#duibiForm").submit(); 
			    	   }
			       }
			   });
				$("#duibihzMedia").click();
			});
			
			
			
			$('#searchForm').on('show.bs.collapse', function () {
				$("#collapse_btn").html("-收起搜索");
			});
			$('#searchForm').on('hide.bs.collapse', function () {
				$("#collapse_btn").html("+展开搜索");
			});
			
			
		});
		
		$("#mdhb").click(function(){
			$("#mdhbModal").modal();
		});
		$("#duibiClick").click(function(){
			$("#duibiModal").modal();
		});
		
		/* 回车搜索 */
		$(document).keyup(function (e) {
	        if (e.keyCode == 13)
	        	$("#search").trigger("click");
	    });
		
		function loadSelectDiv(){
			$.get("${basePath }/common/codeList?type=poorAttributeCode",function(data){
				//var html = '<option value="">全部</option>';
				var html = '';
				for(var i=0; i<data.length; i++){
					html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
				}
				$('#poorAttributeCode').html(html);
				$('#poorAttributeCode').selectpicker('refresh');
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
			$('#danger_house_level').selectpicker({
				style : "h34px"
			});
			$('#poorAttributeCode').selectpicker({
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
		
		function openPage(id,familyNo,poorAttributeCode){
			window.open("${basePath }/pafam/familyInfoList/familyDetail?poorAttributeCode="+poorAttributeCode+"&familyNo=" + familyNo+"&id="+id+"&dn="+dn+"&zzz=");
		}
		
		function openPrintPage(id,familyNo,poorAttributeCode){
			window.open("${basePath }/pafam/familyInfo/preview?familyNo=" + familyNo+"&id="+id+"&poorAttributeCode="+poorAttributeCode);
		}
		function openPDFPage(id,familyNo,poorAttributeCode){
			window.open("${basePath }/pafam/familyInfo/pdf?familyNo=" + familyNo+"&id="+id+"&poorAttributeCode="+poorAttributeCode);
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
								
								// 
								if(objArry[i].colENName!='address2' && objArry[i].colENName!='address3'){
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
							        		/*   if(j==0){
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
							        		  }else{
							        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
							        		  } */
							        		  
							        		  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>';
												
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
					
					
					/*
					* 给添加或修改表单中的地址下拉选框添加级联查询的方法
					*/
					$("#showForm22 select[name='address1']").change(function(){
						var pcode = $("#showForm22 select[name='address1']").val();
						$.get("${basePath }/common/codeList?type=address2&pcode="+pcode,function(data){
							var html = '<option value="">未选择</option>';
							for(var i=0; i<data.length; i++){
								html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
							}
							$("#showForm22 select[name='address2']").html(html);
							$("#showForm22 select[name='address3']").html('<option value="">未选择</option>');
						},"JSON");
					});
					
					$("#showForm22 select[name='address2']").change(function(){
						var pcode = $("#showForm22 select[name='address2']").val();
						$.get("${basePath }/common/codeList?type=address3&pcode="+pcode,function(data){
							var html = '<option value="">未选择</option>';
							for(var i=0; i<data.length; i++){
								html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
							}
							$("#showForm22 select[name='address3']").html(html);
						},"JSON");
					});
					
					/*
					* 主要致贫原因的逻辑控制
					*/
					$("#showForm22 input[name='mainPoorCauseCode']").change(function(){
						var v = $(this).val();
						$("#showForm22 input[name='secondaryPoorCauseCode'][value='" + v + "']").prop("checked", false);
					});
					
					/*
					* 次要致贫原因的验证
					*/
					$("#showForm22 input[name='secondaryPoorCauseCode']").change(function(){
						// 不能与主要致贫原因重复
						var mainPoorCauseCode_val = $("#showForm22 input[name='mainPoorCauseCode']:checked").val();
						$("#showForm22 input[name='secondaryPoorCauseCode']").each(function(i){
							// 
						   if($(this).is(":checked")){
							   if($(this).val() == mainPoorCauseCode_val){
								   alert("次要致贫原因不能与主要致贫原因重复！");
								   $(this).prop("checked", false);
							   }
						   }
					    });
						if($("#showForm22 input[name='secondaryPoorCauseCode']:checked").length > 2){
							alert("次要致贫原因不能超过两项！");
							$(this).prop("checked", false);
						}
					});
					
					// 修改证件类型时，将证件号码设置焦点，用于校验
					$("#showForm22 select[name='certificateTypeCode']").change(function(){
						$("#showForm22 input[name='certificateNo']").focus().blur();
					});
					
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
				        	var obj=data.result.data;
				        	$("#photo").val(obj.filePath);;
				        	$("#photoImg").attr("src", obj.filePath);
				        }
				    });
				},"JSON");
			}else if(flag=="update"){
				$.get("${basePath }/pafb/paFamilyBasicInfo?id="+id,function(data){
					
					// 把地址的code记录下来，方便循环时使用
					var address1code = '';
					var address2code = '';
					var address3code = '';
					
				
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
							html +='<input type="text" class="form-control" style="width:300px;" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'"/>';
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
								//
								if(objArry[i].colENName=='address1'){
									address1code = objArry[i].code;
								}else if(objArry[i].colENName=='address2'){
									address2code = objArry[i].code;
								}
								//else if(objArry[i].colENName=='address3'){
								//	address3code = objArry[i].code;
								//}
								
								if(objArry[i].colENName=='address2'||objArry[i].colENName=='address3'){
									var pcode = '';
									if(objArry[i].colENName=='address2'){
										pcode = address1code;
									}else if(objArry[i].colENName=='address3'){
										pcode = address2code;
									}
									$.ajax({  
								          type : "post",  
								          url : "${basePath }/common/codeList",
								          data : {type:objArry[i].colENName, pcode:pcode},
								          dataType:"JSON",
								          async : false,  
								          success : function(data){  
								        	  for(var j=0; j<data.length; j++){
//								        		  if(val.trim()==data[i].name.trim()){
								        		  if(val == data[j].name){
								        			  html += '<option value="' + data[j].code + '" selected="selected">' + data[j].name + '</option>';
								        		  }else{
								        			  html += '<option value="' + data[j].code + '">' + data[j].name + '</option>'; 
								        		  }
													
												} 
								          }  
								     });
								}else{
									$.ajax({  
								          type : "post",  
								          url : "${basePath }/common/codeList",  
								          data : {type:objArry[i].colENName},
								          dataType:"JSON",
								          async : false,  
								          success : function(data){  
								        	  for(var j=0; j<data.length; j++){
//								        		  if(val.trim()==data[i].name.trim()){
								        		  if(val == data[j].name){
								        			  html += '<option value="' + data[j].code + '" selected="selected">' + data[j].name + '</option>';
								        		  }else{
								        			  html += '<option value="' + data[j].code + '">' + data[j].name + '</option>'; 
								        		  }
													
												} 
								          }  
								     });
								}
								
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
					
					
					/*
					* 给添加或修改表单中的地址下拉选框添加级联查询的方法
					*/
					$("#showForm22 select[name='address1']").change(function(){
						var pcode = $("#showForm22 select[name='address1']").val();
						$.get("${basePath }/common/codeList?type=address2&pcode="+pcode,function(data){
							var html = '<option value="">未选择</option>';
							for(var i=0; i<data.length; i++){
								html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
							}
							$("#showForm22 select[name='address2']").html(html);
							$("#showForm22 select[name='address3']").html('<option value="">未选择</option>');
						},"JSON");
					});
					
					$("#showForm22 select[name='address2']").change(function(){
						var pcode = $("#showForm22 select[name='address2']").val();
						$.get("${basePath }/common/codeList?type=address3&pcode="+pcode,function(data){
							var html = '<option value="">未选择</option>';
							for(var i=0; i<data.length; i++){
								html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
							}
							$("#showForm22 select[name='address3']").html(html);
						},"JSON");
					});
					
					
					/*
					* 主要致贫原因的逻辑控制
					*/
					$("#showForm22 input[name='mainPoorCauseCode']").change(function(){
						var v = $(this).val();
						$("#showForm22 input[name='secondaryPoorCauseCode'][value='" + v + "']").prop("checked", false);
					});
					
					/*
					* 次要致贫原因的验证
					*/
					$("#showForm22 input[name='secondaryPoorCauseCode']").change(function(){
						// 不能与主要致贫原因重复
						var mainPoorCauseCode_val = $("#showForm22 input[name='mainPoorCauseCode']:checked").val();
						$("#showForm22 input[name='secondaryPoorCauseCode']").each(function(i){
							// 
						   if($(this).is(":checked")){
							   if($(this).val() == mainPoorCauseCode_val){
								   alert("次要致贫原因不能与主要致贫原因重复！");
								   $(this).prop("checked", false);
							   }
						   }
					    });
						if($("#showForm22 input[name='secondaryPoorCauseCode']:checked").length > 2){
							alert("次要致贫原因不能超过两项！");
							$(this).prop("checked", false);
						}
					});
					
					// 修改证件类型时，将证件号码设置焦点，用于校验
					$("#showForm22 select[name='certificateTypeCode']").change(function(){
						$("#showForm22 input[name='certificateNo']").focus().blur();
					});
					
					$('#tupian').fileupload({
						url : '/pafb/upload',
//				        dataType: 'json',
						add: function (e, data) {
							var uploadErrors = [];
      						 console.log(data.originalFiles[0]['size']);
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
				        	var obj=data.result.data;
				        	$("#photo").val(obj.filePath);;
				        	$("#photoImg").attr("src", obj.filePath);
				        }
				    });
					$("#photo").val(photoImgSrc);
					if(photoImgSrc!=null&&photoImgSrc!=""){
						$("#photoImg").attr("src", photoImgSrc);	
					}
		        	
					/* $("#showForm22 input[name='householderName']").attr("disabled","disabled");
					$("#showForm22 input[name='certificateNo']").attr("disabled","disabled");
					$("#showForm22 select[name='certificateTypeCode']").attr("disabled","disabled"); */
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
						}else{
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].showName+'</span><span class="form-control" style="width:300px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
						}
						
					}
					$("#showForm22").html(photo+html);
					$("#myModalLabel22").html("详情");
					$('#myModal22').modal();
					
					$("#photo").val(photoImgSrc);
					if(photoImgSrc!=null&&photoImgSrc!=""){
						$("#photoImg").attr("src", photoImgSrc);
					}
				},"JSON");
			}
			
			
		}
		
		function submitForm2(){
			
			if(!$("#showForm22").valid()){
				return false;
			}
			$("#myModal22").modal('hide');
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/pafb/savePaFamilyBasicInfo?hpId=${hpId}", 
		          data : $("#showForm22").serialize(),
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("保存成功");
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
			$("#myModal10").modal('hide');
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/pafb/savePaFamilyBasicInfo?hpId=${hpId}", 
		          data : $("#showForm10").serialize(),
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("保存成功");
		        	  $('#table').bootstrapTable("refresh");
		          }  
		     });
		}
		
		function openNewWindowChoose(){
			//alert($('input:checkbox[name="checkname"]:checked')); 
			// var all = $("#all").val();
			//var all = $("#all").prop("checked") ? 1 : 0;
			var all=$("#all").is(":checked")?1 : 0;
			var life=$("#life").is(":checked")?1 : 0;
			var helpPerson=$("#helpPerson").is(":checked")?1 : 0;
			var question3='';
			
			var must = $('input:checkbox[name="v"]:checked');
			must.each(function() { 
				var isCheck = this.value;
				if(question3==''){
					question3 += isCheck; 
				}else{
					question3 += ','+isCheck; 
				}
				
			});
			
			var ob = $('input:checkbox[name="checkname"]:checked');
			ob.each(function() { 
				var isCheck = this.value;
				if(question3==''){
					question3 += isCheck; 
				}else{
					question3 += ','+isCheck; 
				}
				
			});
			
			/* if(question3==''){
				alert('请选择导出项');
				return false;
			} */
			
			$.confirm({
			    title: '提示',
			    content: '确定要下载吗?',
			    confirmButton: '确定',
			    cancelButton: '取消',
			    confirm: function(){
			    	$("#listNew").val(question3);
					$("#nameNew").val($("#householderName").val());
					$("#startTimeNew").val($("#startTime").val());
					$("#endTimeNew").val($("#endTime").val());
					$("#address1New").val($("#address1").val());
					$("#address3New").val($("#address3").val());
					$("#address2New").val($("#address2").val());
					$("#poorAttributeCodeNew").val($("#poorAttributeCode").val());
					$("#certificateNoNew").val($("#certificateNo").val());
					$("#mainPoorCauseCodeNew").val($("#mainPoorCauseCode").val());
					$("#secondaryPoorCauseCodeNew").val($("#secondaryPoorCauseCode").val());
					
					$("#danger_house_levelNew").val($("#danger_house_level").val());
					$("#isFarmCooperationNew").val($("#isFarmCooperation").val());
					$("#isFarmSecurityNew").val($("#isFarmSecurity").val());
					$("#isIncomeSupportNew").val($("#isIncomeSupport").val());
					$("#ageLevelNew").val($("#ageLevel").val());
					
					$("#bornStartTimeNew").val($("#bornStartTime").val());
					$("#bornEndTimeNew").val($("#bornEndTime").val());
					
					$("#healthInfoNew").val($("#healthInfo").val());
					$("#collegeInfoNew").val($("#collegeInfo").val());
					
					if(all==1){
				   		$("#allNew").val(1);
					}else{
						$("#allNew").val(0);
					}
					if(life==1){
				   		$("#lifeNew").val(1);
					}else{
						$("#lifeNew").val(0);
					}
					if(helpPerson==1){
				   		$("#helpPersonNew").val(1);
					}else{
						$("#helpPersonNew").val(0);
					}
					
					$("#formNew").attr("action","/pafam/familyBaseInfoDownExcel");
					$("#formNew").attr("method","post");
					$("#formNew").submit();
					$("#myModal100").modal('hide');
			    },
			    cancel: function(){}
			});
		}
		
		 //全选，全不选
        function allSelect() {
        	//$(":checkbox").prop("checked", true);
        	//$(".div_fam input").prop("checked",false);
        	$("input:checkbox[name='checkname']").prop("checked", true);
        	$("#all").prop("checked", true);
        	$("#life").prop("checked", true);
        	$("#helpPerson").prop("checked", true);
        	
        }
        //反选
        function otherSelect() {
            $("input:checkbox[name='checkname']").prop("checked", false);
            $("#life").prop("checked", false);
        	$("#helpPerson").prop("checked", false);
        	$("#all").prop("checked", false);
        }
        function mdhbSubmit(){
        	var upload1=$('#upload1').val();
        	var upload2=$('#upload2').val();
        	if(upload1==null||upload2==null||upload1==''||upload2==''){
        		alert("两个名单不能为空！");
        		return;
        	}
        	upload1=upload1.substring(upload1.lastIndexOf('.')+1);
        	upload2=upload2.substring(upload2.lastIndexOf('.')+1);
        	if(upload1!='xls'){
        		alert("附件只支持xls，名单一附件类型不为xls！");
        		return;
        	}
        	if(upload2!='xls'){
        		alert("附件只支持xls，名单二附件类型不为xls！");
        		return;
        	}
        	//$('#mdhbModal').modal('hide');
        	//$("#myModal1000").modal({backdrop: 'static', keyboard: false});
        	//$('#mdhbForm').submit();
        	//$("#myModal1000").modal('hide');
        	
        	var form = new FormData(document.getElementById("mdhbForm"));
            $.ajax({  
            url:"/mdhb",  
            type:"post",  
            data:form,  
            cache: false,  
            processData: false,  
            contentType: false,  
            success:function(data){ 
				console.log(data);            	
            	var flag=data.data.flag;
		    	   if(flag!=null&&flag==1){
		    		   alert("名单一的模板不正确，请重新选择模板！");
		    	   }else if(flag!=null&&flag==2){
		    		   alert("名单二的模板不正确，请重新选择模板！");
		    	   }else if(flag!=null&&flag==3){
		    		   alert("名单一与名单二的列数不匹配！");
		    	   }else{
			    	   $("#fileNameDuibi").val(data.data.fileName);
			    	   $("#duibiForm").submit(); 
		    	   } 
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