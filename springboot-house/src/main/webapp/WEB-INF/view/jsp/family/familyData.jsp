<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/common/com.jsp" %>
    
<%@ page import="com.golden.util.UserAuthUtil" %> 
<% 
//添加家庭成员信息
boolean btn_8102 = UserAuthUtil.hasOperator(request, "8102");
// 修改家庭成员信息	
boolean btn_8103 = UserAuthUtil.hasOperator(request, "8103");
// 添加生产生活现状信息
boolean btn_8104 = UserAuthUtil.hasOperator(request, "8104");
// 修改生产生活现状信息
boolean btn_8105 = UserAuthUtil.hasOperator(request, "8105");
//添加家庭帮扶责任人信息
boolean btn_8106 = UserAuthUtil.hasOperator(request, "8106");
//修改家庭帮扶责任人信息
boolean btn_8107 = UserAuthUtil.hasOperator(request, "8107");
//添加家庭帮扶措施与成效
boolean btn_8108 = UserAuthUtil.hasOperator(request, "8108");
//修改家庭帮扶措施与成效
boolean btn_8109 = UserAuthUtil.hasOperator(request, "8109");
//添加家庭脱贫评估信息
boolean btn_8110 = UserAuthUtil.hasOperator(request, "8110");
//修改家庭脱贫评估信息
boolean btn_8111 = UserAuthUtil.hasOperator(request, "8111");
//添加家庭问题反馈信息
boolean btn_8112 = UserAuthUtil.hasOperator(request, "8112");
//修改家庭问题反馈信息
boolean btn_8113 = UserAuthUtil.hasOperator(request, "8113");


// 多媒体上传——家庭基本情况
boolean btn_8114 = UserAuthUtil.hasOperator(request, "8114");
// 多媒体上传——生产生活情况
boolean btn_8115 = UserAuthUtil.hasOperator(request, "8115");
// 多媒体上传——帮扶措施
boolean btn_8116 = UserAuthUtil.hasOperator(request, "8116");
// 多媒体上传——帮扶成效
boolean btn_8131 = UserAuthUtil.hasOperator(request, "8131");
// 多媒体上传——问题反馈
boolean btn_8117 = UserAuthUtil.hasOperator(request, "8117");


// 修改分析与计划
boolean btn_8118 = UserAuthUtil.hasOperator(request, "8118");
// 添加自我发展成效
boolean btn_8119 = UserAuthUtil.hasOperator(request, "8119");
// 修改自我发展成效
boolean btn_8120 = UserAuthUtil.hasOperator(request, "8120");
// 删除自我发展成效
boolean btn_8121 = UserAuthUtil.hasOperator(request, "8121");


// 扶贫户关联信息——删除家庭成员信息
boolean btn_8122 = UserAuthUtil.hasOperator(request, "8122");
// 扶贫户关联信息——删除家庭帮扶责任人信息
boolean btn_8123 = UserAuthUtil.hasOperator(request, "8123");
// 扶贫户关联信息——删除家庭帮扶措施
boolean btn_8124 = UserAuthUtil.hasOperator(request, "8124");


// 扶贫户关联信息——添加家庭主要社会关系
boolean btn_8125 = UserAuthUtil.hasOperator(request, "8125");
// 扶贫户关联信息——修改家庭主要社会关系
boolean btn_8126 = UserAuthUtil.hasOperator(request, "8126");
// 扶贫户关联信息——删除家庭主要社会关系
boolean btn_8127 = UserAuthUtil.hasOperator(request, "8127");


// 扶贫户关联信息——添加家庭帮扶成效
boolean btn_8128 = UserAuthUtil.hasOperator(request, "8128");
// 扶贫户关联信息——修改家庭帮扶成效
boolean btn_8129 = UserAuthUtil.hasOperator(request, "8129");
// 扶贫户关联信息——删除家庭帮扶成效
boolean btn_8130 = UserAuthUtil.hasOperator(request, "8130");


%>    
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扶贫户信息列表</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrapValidator.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<link href="/css/j.autocomplete.css" rel="stylesheet" type="text/css"/>

<link rel="stylesheet" type="text/css" href="/js/toastr/toastr.min.css" />

<!-- 多媒体 -->
<link rel="stylesheet" type="text/css" href="/js/cxscroll/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/js/zoom/css/zoom.css" />

<style>
.nav-tabs-me>li {
    width: 9%;  /* 有多少个标签就拿100除以标签个数得到百分比 */
    text-align: center;
}
.nav-tabs>li>a{
	font-size:13px;
    text-decoration: none;
    margin: 0;
    color:#555;
    padding: 10px 6px;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
	font-size:13px;
    text-decoration: none;
    color:#2a6496;
}

/* 生产生活样式start */
.my-item{
	width: 48%;
    float: left;
}

.my-item .input-group-addon {
	width: 36%;
	height: 34px;
}

.my-item .my-item-span-me  {
	font-size: 15px;
	float:right;
	position: absolute;
    right: 5px;
    top: 4px;
    z-index: 999999;
}

.input-group .radio-inline,.input-group .checkbox-inline{
	float:left;
	margin:0 6px 0 0;
}
.input-group .radio-inline input,.input-group .checkbox-inline input{
	margin-top:6px;
}



/* 生产生活样式 end */

.panel {
  margin-bottom: 120px;
}

#tab6 th, td{
	text-align: center; 
	vertical-align: middle; 
}
#tab6 th{
	font-size: 15px;
}

/* 脱贫评估样式  start */
.input-group-me {
	width : 48%;
}

.input-group-me .input-group-addon {
	width: 70%;
}

.input-group-span-me  {
	font-size: 15px;
	float:right;
	position: absolute;
    right: 5px;
    top: 5px;
    z-index: 999999;
}

#tab6 .fixed-table-container tbody td {
    border-left: 1px solid #ccc;
}

#tab6 .table>thead>tr>th, 
#tab6 .table>tbody>tr>th, 
#tab6 .table>tfoot>tr>th, 
#tab6 .table>thead>tr>td, 
#tab6 .table>tbody>tr>td, 
#tab6 .table>tfoot>tr>td {
    border-top: 1px solid #ccc;
}

#tab6 .bootstrap-table .table {
    border-bottom: 1px solid #ccc;
}

#tab6 .fixed-table-body {
    border-right: 1px solid #ccc;
}

#tab6 .bootstrap-table .table>thead>tr>th {
    border-bottom: 1px solid #ccc;
    border-right: 1px solid #ccc;
}

#tab6 .bootstrap-table .table>thead>tr>th:last-child {
    border-right: none;
}
/* 脱贫评估样式  end */

/* 视频加载样式 start */
.loading-me-z {
	/* position: fixed; */
    z-index: 999999;
    pointer-events: none;
    top: 50%;
    left: 50%;
}

.caseBlanche {
    background-color: #C2C2C2;
    height: 140px;
    width: 150px;
    padding-top: 10px;
    /* float: left;
    position: relative; */
}

.caseBlanche .rond {
    height: 100px;
    width: 100px;
    border: 1px solid #fff;
    border-radius: 50%;
    position: absolute;
    top: 20px;
    left: 25px;
    animation: rond 2s infinite;
    -webkit-animation: rond 2s infinite;
}

@keyframes rond {
  0% {transform : rotate(0deg);}
  100% {transform : rotate(360deg);}
}

@-webkit-keyframes rond {
  0% {-webkit-transform : rotate(0deg);}
  100% {-webkit-transform : rotate(360deg);}
}

.caseBlanche .rond .test {
    height: 10px;
    width: 10px;
    position: absolute;
    background-color: #fff;
    border-radius: 50%;
    top: 0px;
    left: 20px;
}

.caseBlanche .load {
    color: #fff;
    font-family: calibri;
    text-align: center;
    position: absolute;
    top: 55px;
    left: 57px;
}
/* 视频加载样式 end */
</style>
<%
String roleIds = session.getAttribute("user_role_ids")==null?"":session.getAttribute("user_role_ids").toString();
%>
<script type="text/javascript">
	var roleIds = '<%=roleIds %>';
	var roleType = '';
	if(roleIds.indexOf('1000') != -1){
		roleType = 1;
	}else if(roleIds.indexOf('2000') != -1){
		roleType = 3;
	}else if(roleIds.indexOf('3000') != -1){
		roleType = 5;
	}
	
	var dnClass = '${dn }';
	
	// 需要在js里判断的按钮
	var btn_8107 = <%=btn_8107 %>;
	var btn_8109 = <%=btn_8109 %>;
	var btn_8110 = <%=btn_8110 %>;
	var btn_8111 = <%=btn_8111 %>;
	var btn_8113 = <%=btn_8113 %>;

	var btn_8114 = <%=btn_8114 %>;
	var btn_8115 = <%=btn_8115 %>;
	var btn_8116 = <%=btn_8116 %>;
	var btn_8117 = <%=btn_8117 %>;
	
	var btn_8120 = <%=btn_8120 %>;
	var btn_8121 = <%=btn_8121 %>;
	
	var btn_8131 = <%=btn_8131 %>;
	
	
	var btn_8123 = <%=btn_8123 %>;
	var btn_8124 = <%=btn_8124 %>;
	

	var btn_8126 = <%=btn_8126 %>;
	var btn_8127 = <%=btn_8127 %>;


	var btn_8129 = <%=btn_8129 %>;
	var btn_8130 = <%=btn_8130 %>;

	
	<% 
	String disString = "disabled";
	if("万书桓".equals(session.getAttribute("userName"))){
		disString = "";
	}%>
	var isDisabled = "<%=disString%>";
</script>
</head>
<body>

<%@ include file="/WEB-INF/view/common/header.jsp" %>
	<div class="w1200 main">
	<div class="panel panel-default">
		<div>
			
			<ul class="nav nav-tabs nav-tabs-me" id="myTab">
				<li class="active"><a href="#tab1" data-toggle="tab">家庭基本情况</a></li>
				<li><a href="#tab3" data-toggle="tab">生产生活情况</a></li>
				<li><a href="#tab2" data-toggle="tab">家庭成员</a></li>
				<li><a href="#tab10" data-toggle="tab">主要社会关系</a></li>
				<li><a href="#tab4" data-toggle="tab">帮扶责任人</a></li>
				<li><a href="#tab8" data-toggle="tab">分析与计划</a></li>
				<li><a href="#tab5" data-toggle="tab">帮扶措施</a></li>
				<li><a href="#tab11" data-toggle="tab">帮扶成效</a></li>
				<li><a href="#tab9" data-toggle="tab">自我发展成效</a></li>
				<li><a href="#tab7" data-toggle="tab">问题反馈</a></li>
				<li><a href="#tab6" data-toggle="tab">脱贫评估</a></li>
			</ul>
	
			<div id="myTabContent" class="tab-content" style="padding-top: 18px;">
				
				<div class="tab-pane fade in active" id="tab1">
					<div style="padding: 10px 100px 10px;overflow:auto;">
				    	<form class="bs-example bs-example-form" id="formTab1" role="form">
				        <!-- <div class="input-group">
				            <span class="input-group-addon">@</span>
				            <span class="form-control" style="width:150px;">
				        </div>
				        <br> -->
				    	</form>
					</div>
				</div>
				<div class="tab-pane fade" id="tab2">
					<!-- 家庭基本情况 start -->
					<div>
						<form class="form-inline" role="form">
							<div class="input-group" style="width: 189px;">
								<span class="input-group-addon">姓名</span> 
								<input type="text" class="form-control names" name="memberName" id="memberName" placeholder="请输入姓名"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">性别</span>
								 <select class="form-control" name="gender" id="gender"> 
							        <option value="">全部</option> 
							        <option value="0">女</option> 
							        <option value="1">男</option> 
							      </select>
							</div>
							<div class="input-group" style="width:160px">
								<span class="input-group-addon">职业</span> 
								<input type="text" class="form-control names" name="profession" id="profession" placeholder="请输入职业"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">文化程度</span>
								 <select class="form-control" name="educationCode" id="educationCode"> 
							      </select>
							</div>
							<div class="input-group" style="width:270px">
								<span class="input-group-addon">有无劳动能力</span>
								<input type="text" class="form-control" name="workAbility" id="workAbility" placeholder="有无劳动能力"/>
								<!--  <select class="form-control" name="workAbility" id="workAbility"> 
							        <option value="">全部</option> 
							        <option value="0">无</option> 
							        <option value="1">有</option> 
							      </select> -->
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="search">查询</span>
							</div>
						</form>
					</div>
					<c:if test="<%=btn_8102 %>">
					<span type="button" class="btn btn-success fr" onclick="showMember('insert');">添加</span>
					</c:if>
					<div>
						<table id="table"></table>
					</div>
					<!-- 家庭基本情况end -->
				</div>
				<div class="tab-pane fade" id="tab3">
					<!-- 生产生活现状start -->
					<input type="hidden" id="indexCode3" />
					<div>
						<div class="dn" style="text-align: center;" id="div3_add">
							<span>暂无记录</span>
							<c:if test="<%=btn_8104 %>">
							<span>，请</span><a class="btn" onclick="form3_add()">添加</a>
							</c:if>
						</div>
					</div>
					
					<div id="div3" class="dn" style="padding: 0px 20px 10px;overflow:auto;">
						<!-- 展示区域 -->
					</div>
					<div id="div3_edit" class="dn" style="padding: 0px 20px 10px;overflow:auto;">
						<form class="bs-example bs-example-form" id="form3_edit" role="form">
							<!-- 编辑区域 -->
						</form>
					</div>
					<div style="text-align: center;">
						<button type="submit" class="btn btn-primary btn-lg dn" id="form3_btn1" onclick="saveForm3('save')" style="width:200px;">保存</button>
						<c:if test="<%=btn_8105 %>">
						<button type="button" class="btn btn-primary btn-lg dn" id="form3_btn2" onclick="updateForm3()" style="width:200px;">修改</button>
						</c:if>
						<button type="submit" class="btn btn-primary btn-lg dn" id="form3_btn3" onclick="saveForm3('update')" style="width:200px;">保存</button>
					</div>
					<!-- 生产生活现状end -->
				</div>
				<div class="tab-pane fade" id="tab4">
					<!-- 帮扶责任人start -->
					<div class="panel panel-default">
						<div>
							<form class="form-inline" role="form">
								<div class="input-group" style="width: 189px;">
									<span class="input-group-addon">姓名</span> 
									<input type="text" class="form-control" name="name" id="name4" placeholder="请输入姓名"/>
								</div>
								<div class="input-group">
									<span class="input-group-addon">类别</span> 
									<select class="form-control" name="personposition" id="personposition4" >
									</select>
								</div>
								<div class="input-group">
									<span class="input-group-addon">工作单位</span> 
									<input type="text" class="form-control" name="institutionName" id="institutionName4" placeholder="请输入工作单位"/>
								</div>
								<div class="input-group">
									<span class="input-group-addon">职务</span> 
									<input type="text" class="form-control" name="postCode" id="postCode4" placeholder="请输入职务"/>
								</div>
								<div class="input-group">
								    <span class="btn btn-primary" id="search4">查询</span>
								</div>
							</form>
							
						</div>
						<c:if test="<%=btn_8106 %>">
						<span class="btn btn-success fr" onclick="showModel4('insert');">添加</span>
						</c:if>
						<div>
							<table id="table4"></table>
						</div>
					</div>
					<!-- 帮扶责任人end -->
				</div>
				<div class="tab-pane fade" id="tab5">
					<!-- 帮扶措施与成效start -->
					<div class="panel panel-default">
						<div>
							<form class="form-inline" role="form">
								<div class="input-group">
									<span class="input-group-addon">项目类型</span> 
									<select class="form-control" name="projectTypeCode" id="projectTypeCode5" style="width:130px;"> 
							      </select>
								</div>
								<div class="input-group">
									<span class="input-group-addon">帮扶单位</span> 
									<input type="text" class="form-control" name="institutionName" id="institutionName5" placeholder="请输入帮扶单位" style="width:190px;"/>
								</div>
								<div class="input-group">
									<span class="input-group-addon">帮扶内容</span> 
									<input type="text" class="form-control" name="helpContent" id="helpContent5" placeholder="请输入帮扶内容" style="width:190px;"/>
								</div>
								<!-- <div class="input-group">
									<span class="input-group-addon">帮扶成效</span> 
									<input type="text" class="form-control" name="helpResult" id="helpResult5" placeholder="请输入帮扶成效" style="width:130px;"/>
								</div> -->
								<div class="input-group">
								    <span class="btn btn-primary" id="search5">查询</span>
								</div>
							</form>
							
						</div>
						<c:if test="<%=btn_8108 %>">
							<span type="button" class="btn btn-success fr" onclick="showInsert5();">添加</span>
						</c:if>
						<div style="margin-top: 50px;">
							<table id="table5"></table>
						</div>
					</div>
					<!-- 帮扶措施与成效end -->
				</div>
				<div class="tab-pane fade" id="tab6">
					<!-- 脱贫评估start -->
					<%-- <span class="btn btn-success fr ${dn }" onclick="showModel6('insert');" >添加</span> --%>
							<!-- style="position: relative; top: 30px; z-index: 99;right: 25px;height: 30px;" -->
					
					<div>
						<div class="bootstrap-table">
							<div class="fixed-table-container">
								<div class="fixed-table-body">
								
									<table class="table table-hover">
										<thead id="th"></thead>
										<tbody id="tb"></tbody>
									</table>
								</div>
							</div>
						</div>
						
						<div class="bootstrap-table" style="margin-top: 18px;width:95%">
							<div class="fixed-table-container">
								<div class="fixed-table-body">
								
									<table class="table table-hover">
										<thead></thead>
										<tbody id="tb2"></tbody>
									</table>
								</div>
							</div>
						</div>
						
						<c:if test="<%=btn_8111 %>">
						<div style="float: right; position: relative; bottom: 36px;">
							<a class="btn ${dn }" style="" onclick="showModel9()">编辑</a>
						</div>
						</c:if>
						
					</div>
					<!-- 脱贫评估end -->
				</div>
				<div class="tab-pane fade" id="tab7">
					<!-- 问题反馈 start -->
					<div class="panel panel-default">
						<div>
							<form class="form-inline" role="form">
								<div class="input-group">
									<span class="input-group-addon">督导时间</span> <input
										id="startTime7" name="startTime" class="Wdate form-control"
										type="text"
										onFocus="var endTime7=$dp.$('endTime7');WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',onpicked:function(){endTime7.focus();},maxDate:'#F{$dp.$D(\'endTime7\')}'})"
										value="" /> <span class="input-group-addon">至</span> <input
										id="endTime7" name="endTime" class="Wdate form-control"
										type="text"
										onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime7\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
										value="" />
								</div>
								<div class="input-group">
									<span class="btn btn-primary" id="search7">查询</span>
								</div>
							</form>
						</div>
						
						<c:if test="<%=btn_8112 %>">
							<span class="btn btn-success fr" onclick="showInsert7();">添加</span>
						</c:if>
					
						<div style="margin-top: 50px;">
							<table id="table7"></table>
						</div>
					</div>
					<!-- 问题反馈 end -->
				</div>
				<div class="tab-pane fade" id="tab8">
					<!-- 致贫原因分析与计划 start -->
					<div class="panel panel-default">
						<div>
							<form role="form" id="form8">
								<input type="hidden" name="familyNo" value="${familyNo }">
								<div class="form-group">
									<span class="input-group-addon" style="width:120px;">
									<c:if test="${poorAttributeCode==4 }">巩固提升需求</c:if>
									<c:if test="${poorAttributeCode!=4 }">致贫原因分析</c:if>
									</span>
									<textarea class="form-control" rows="5" id="poorCase8" name="poorCase"
											<c:if test="<%=!btn_8118 %>">disabled</c:if> ></textarea>
								</div>
								<div class="form-group">
									<span class="input-group-addon" style="width:120px;">帮扶计划</span>
									<textarea class="form-control" rows="5" id="plan8" name="plan"
											<c:if test="<%=!btn_8118 %>">disabled</c:if> ></textarea>
								</div>
							</form>
						</div>
						<c:if test="<%=btn_8118 %>">
							<span class="btn btn-primary fr" onclick="submit8();">保存</span>
						</c:if>
						<div class="clearfix"></div>
					</div>
					<!-- 致贫原因分析与计划end -->
				</div>
				<div class="tab-pane fade" id="tab9">
				<!-- 自我发展成效 start -->
					<div class="panel panel-default">
						<div>
							<form class="form-inline" role="form">
								<div class="input-group">
									<span class="input-group-addon">时间</span> <input
										id="startTime9" name="startTime" class="Wdate form-control"
										type="text"
										onFocus="var endTime9=$dp.$('endTime9');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){endTime9.focus();},maxDate:'#F{$dp.$D(\'endTime9\')}'})"
										value="" /> <span class="input-group-addon">至</span> <input
										id="endTime9" name="endTime" class="Wdate form-control"
										type="text"
										onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime9\')}',dateFmt:'yyyy-MM-dd'})"
										value="" />
								</div>
								<div class="input-group">
									<span class="btn btn-primary" id="search9">查询</span>
								</div>
							</form>
						</div>
						<c:if test="<%=btn_8119 %>">
							<span class="btn btn-success fr" onclick="showInsert9();">添加</span>
						</c:if>
					
						<div style="margin-top: 50px;">
							<table id="table9"></table>
						</div>
					</div>
					<!-- 自我发展成效 end -->
				
				</div>
				<div class="tab-pane fade" id="tab10">
				<!-- 家庭主要社会关系 start -->
					<div>
						<form class="form-inline" role="form">
							<div class="input-group" style="width: 189px;">
								<span class="input-group-addon">姓名</span> 
								<input type="text" class="form-control names" name="memberName" id="memberName10" placeholder="请输入姓名"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">性别</span>
								 <select class="form-control" name="gender" id="gender10"> 
							        <option value="">全部</option> 
							        <option value="0">女</option> 
							        <option value="1">男</option> 
							      </select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">职业</span> 
								<input type="text" class="form-control names" name="profession" id="profession10" placeholder="请输入职业"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">文化程度</span>
								 <select class="form-control" name="educationCode" id="educationCode10"> 
							      </select>
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="search10">查询</span>
							</div>
						</form>
					</div>
					
					<c:if test="<%=btn_8125 %>">
						<span class="btn btn-success fr" onclick="showMember10('insert');">添加</span>
					</c:if>
					
					<div>
						<table id="table10"></table>
					</div>
					<!-- 家庭主要社会关系 end -->
				</div>
				<div class="tab-pane fade" id="tab11">
					<!-- 帮扶成效  start -->
					<div class="panel panel-default">
						<div>
							<form class="form-inline" role="form">
								<div class="input-group">
									<span class="input-group-addon">帮扶成效</span> 
									<input type="text" class="form-control" name="helpResult" id="helpResult11" placeholder="请输入帮扶成效" style="width:250px;"/>
								</div>
								<div class="input-group">
									<span class="input-group-addon">时间</span> 
									<input id="startTime11"  class="Wdate form-control" type="text"
										onFocus="var endTime11=$dp.$('endTime11');WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){endTime11.focus();},maxDate:'#F{$dp.$D(\'endTime11\')}'})"  /> 
									<span class="input-group-addon">至</span> 
									<input id="endTime11" class="Wdate form-control" type="text"
										onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime11\')}',dateFmt:'yyyy-MM-dd'})" />
								</div>
								<div class="input-group">
								    <span class="btn btn-primary" id="search11">查询</span>
								</div>
							</form>
						</div>
						<c:if test="<%=btn_8128 %>">
							<span class="btn btn-success fr" onclick="showInsert11();">添加</span>
						</c:if>
						<div style="margin-top: 50px;">
							<table id="table11"></table>
						</div>
					</div>
					<!-- 帮扶成效  end -->
				</div>
			</div>
		</div>
	</div>



</div>




<!-- 家庭成员弹出 -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:990px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel2">
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;">
    	<form class="bs-example bs-example-form" id="showForm2" role="form">
    	</form>
	</div>

		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>



<!-- 帮扶责任人情况模态框（Modal） -->
<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel4">
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;">
    	<form class="bs-example bs-example-form" id="showForm4" role="form">
        <!-- <div class="input-group">
            <span class="input-group-addon">@</span>
            <span class="form-control" style="width:150px;">
        </div>
        <br> -->
    	</form>
	</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="modal fade" id="myModal5" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel5">
				</h4>
			</div>
			
	<div style="padding: 40px 50px 20px;overflow:auto;">
    	<form class="bs-example bs-example-form" id="showForm5" role="form">
        <!-- <div class="input-group">
            <span class="input-group-addon">@</span>
            <span class="form-control" style="width:150px;">
        </div>
        <br> -->
    	</form>
	</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	
</div>



<!-- 脱贫评估模态框（Modal） -->
<div class="modal fade" id="myModal6" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel6">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm6" role="form">
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<!-- 反馈模态框（Modal） -->
<div class="modal fade" id="myModal7" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel7">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm7" role="form">
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>



<!-- 脱贫评估模态框（Modal） -->
<div class="modal fade" id="myModal9" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel9" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel9">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm9" role="form">
		    		<div class="input-group input-group-me" > 
						<span class="input-group-addon" style="">是否完成危房改造</span>
						<label class="radio-inline">
        					<input type="radio" name="isCardcastleTurn" id="isCardcastleTurn1" value="1"/> 是
    				   	</label>
						<label class="radio-inline">
        					<input type="radio" name="isCardcastleTurn" id="isCardcastleTurn2" value="0" /> 否
    				   	</label>
					</div>
		    		<div class="input-group input-group-me" > 
						<span class="input-group-addon" style="">补助金额</span>
						<input type="text" class="form-control" name="allowanceSum" id="allowanceSum3" value="" />
					</div>
		    		<div class="input-group input-group-me" > 
						<span class="input-group-addon" style="">脱贫年份</span>
						<input type="hidden" id="cur_paYear4">
						<select class="form-control" name="paYear" id="paYear4" >
						 	<option value="">全部</option> 
						 	<option value="0">否</option> 
						 	<option value="1">是</option> 
					     </select>
					</div>
					<span class="btn btn-primary fr" onclick="submitForm9();">保存</span>
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<!-- 自身发展成效（Modal） -->
<div class="modal fade" id="myModal99" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel99">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm99" role="form">
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<!-- 家庭主要社会关系（Modal） -->
<div class="modal fade" id="myModal10" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel10">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm10" role="form">
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<!-- 帮扶成效（Modal） -->
<div class="modal fade" id="myModal11" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel11" aria-hidden="true" style="top: 2%;">
	<div class="modal-dialog"  style="width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel11">
				</h4>
			</div>
			<div style="padding: 40px 50px 20px;overflow:auto;">
		    	<form class="bs-example bs-example-form" id="showForm11" role="form">
		    	</form>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<div class="dn" id="validate-tip"> 
	<div class="tooltip fade top in tooltip-div" role="tooltip" data-placement="right">
		<div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>
		<div class="tooltip-inner tooltip-inner-me"></div>
	</div>
</div>	


<%@ include file="/WEB-INF/view/common/footer.jsp" %>


	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/jsDateTimeUtil.js"></script>
	<script type="text/javascript" src="/js/template.js"></script>
	
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload.js"></script>
	
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-process.js"></script>
	<script type="text/javascript" src="/js/jquery-fileupload/jquery.fileupload-validate.js"></script>
	
	<script type="text/javascript" src="/js/artDialog4.1.6/jquery.artDialog.js?skin=idialog"></script>
	<script type="text/javascript" src="/js/artDialog4.1.6/plugins/iframeTools.js"></script>
	
	<script type="text/javascript" src="/js/j.autocomplete.js"></script>
	
	<script type="text/javascript" src="/js/toastr/toastr.min.js"></script>
	
	<!-- 多媒体  -->
	<script type="text/javascript" src="/js/cxscroll/js/jquery.cxscroll.js"></script>
	<script type="text/javascript" src="/js/zoom/js/zoom.js"></script>
	
	<script type="text/javascript">
	
	// 
	//toastr.options.positionClass = "toast-top-right";
	toastr.options.positionClass = "toast-top-full-width";
	toastr.options.closeButton = true;
	
	var basepath = "${basePath}";
	var familyNo=${familyNo};
	var id=${id};
	var poorAttributeCode=${poorAttributeCode};
	
	// 扩展一个startsWith和endsWith方法
	if (typeof String.prototype.startsWith != 'function') {
		String.prototype.startsWith = function (prefix){
			return this.slice(0, prefix.length) === prefix;
		};
	}	
	if (typeof String.prototype.endsWith != 'function') {
		String.prototype.endsWith = function(suffix) {
			return this.indexOf(suffix, this.length - suffix.length) !== -1;
		};
	}
	
	$(function(){
	/* 	$(".tab-pane").click(function(){
			$(".slick").slickNext();
		});*/		
		<%-- $("#myTab a[href='#<%=tabsId %>']").trigger("click"); --%>
		$("#showForm2").validate({
			
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
				memberName : {
					required: true,
					minlength:1,
			        maxlength:20
				},
				relationshipCode : {
					required: true
				},
				gender : {
					required: true
				},
				nationCode : {
					required: true
				},
				educationCode : {
					required: true
				},
				collegeInfo : {
					required: true,
					minlength:1,
			        maxlength:100
				},
				workAbility : {
					required: true,
					maxlength:25
				},
				healthInfo : {
					required: true,
					minlength:1,
			        maxlength:100
				},
				certificateNo : {
					idCardRequireNew:true
				},
				certificateTypeCode : {
					required: true
				},
				isfamilyPlanning : {
					required: true
				},
				isFarmCooperation : {
					required: true
				},
				isFarmSecurity : {
					required: true
				},
				isIncomeSupport : {
					required: true
				},
				age : {
					required: true,
					age:true
				},
				profession : {
					required: true
				},
				income : {
					required: true,
					number:true
				},
				livingTimeYear : {
					required: true,
					maxlength:4
				}
			}
			
		});
		
		$('#table').bootstrapTable({
			url: "${basePath }/paMInfo/familyMemberList",
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
		            memberName:$("#memberName").val(),
		            gender:$("#gender").val(),
		            educationCode:$("#educationCode").val(),
		            profession:$("#profession").val(),
		            workAbility:$("#workAbility").val()
		            
		        }
		    },//参数
			sortName: 'id',
		    sortOrder: 'desc',
			minimumCountColumns: 2,
			clickToSelect: true,
			smartDisplay:true,
			columns: [
				{
					field: 'memberName',
					title: '姓名',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'relationshipCodeName',
					title: '与户主关系',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'genderName',
					title: '性别',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'age',
					title: '年龄',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'educationCodeName',
					title: '文化程度',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'collegeInfo',
					title: '在校生情况',
					align: 'center',
					valign: 'middle'
				}, {
					field: 'workAbilityName',
					title: '有无劳动能力',
					align: 'center',
					valign: 'middle'
				}, {
					title: '操作',
					align: 'center',
					valign: 'middle',
					width: '280px',
					formatter: function(value, row, index){
						var disabled = (row.relationshipCode == '1') ? "disabled" : "";
						
						<% if("".equals(disString)) {%>
							disabled = "";
						<% } %>
						return "<c:if test="<%=btn_8103 %>"><button class='btn btn-sm btn-primary ${dn } "+disabled+"' onclick='javascript:showMember(\"update\","+row.id+","+row.familyNo+");'>编辑</button>&nbsp;</c:if>"+
						"<c:if test="<%=btn_8122 %>"><button class='btn btn-sm btn-primary "+disabled+"' onclick='javascript:deleteById("+row.id+");'>删除</button>&nbsp;</c:if>"+
						"<button class='btn btn-sm btn-primary' onclick='javascript:showMember(\"query\","+row.id+");'>查看详情</button>";
					}
				}]
			});
		
		
		
		loadSelectDiv();
		
		$("#search").click(function(){
//			$('#table').bootstrapTable("refresh",{query: {offset:0}});
			$('#table').bootstrapTable("refresh");
		});
		showBasicInfo('${id}');
		
		showTab8();
	});
	function showBasicInfo(id){
		$.get("${basePath }/pafb/paFamilyBasicInfo?id="+id,function(data){
			var objArry=data.data;
			var  html= '';
			var photo='<div class="input-group noused" style="width:100px;">';
				photo +='<a href="/img/defPhoto.png" type="">';
				photo +='<img  id="photoImg" src="/img/defPhoto.png" style="width:100px;height:100px;"/>';
				photo +='</a>';
				photo +='<input type="hidden" id="photo" name="photo"/>';
				photo +='</div>';
			html+='<div id="mediaDiv" class="input-group" style="margin-left:45px;margin-bottom:10px;"></div>';
			html+='<div class="btn-group-vertical">'+
			'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia1(1);">图片</span>'+
			'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia1(2);">音频</span>'+
			'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia1(3);">视频</span>';
			if(btn_8114){
				html+='<span class="btn btn-primary btn-sm fr" onclick="javascript:$(\'#media\').click();">上传</span>';
			}
			html+='<input name="media" id="media"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
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
			$("#formTab1").html(photo+html);
			$("#photo").val(photoImgSrc);
        	if(photoImgSrc!=null&&photoImgSrc!=""){
				$("#photoImg").attr("src", photoImgSrc);
				$("#photoImg").parent().attr("href", photoImgSrc);
			}
        	// 
        	zoomOpen('.noused a');
        	
        	queryMedia(id,familyNo,"pa_family_basic_info", 1);// 默认显示图片
        	
        	$('#media').fileupload({
				url : '/pafb/uploadMedia',
				add: function (e, data) {
					var uploadErrors = [];
						 console.log(data.originalFiles[0]['size']) ;
					/* if (data.originalFiles[0]['size'] > 1*1024*1024) {
 						 uploadErrors.push('上传文件不能超过1M');
						} */
						 var acceptFileTypes = /(\.|\/)(mp3|jpe?g|png|mp4)$/i;
				        if(!acceptFileTypes.test(data.originalFiles[0]['name'])) {
				            uploadErrors.push('文件类型不正确(mp3|mp4|jpg|jpeg|png)！');
				        }
						 if(uploadErrors.length > 0) {
  							alert(uploadErrors.join("\n"));
						 } else {
					  		data.submit();
						 }
		        },
		        done: function (e, data) {
		        	var obj=data.result.data;
		        	$.ajax({  
				          type : "post",  
				          url : "${basePath }/pafb/saveMedia",  
				          data : {id:id,familyNo:familyNo,tableName:"pa_family_basic_info",fileName:obj.fileName,filePath:obj.filePath},
				          dataType:"JSON",
				          success : function(data){  
				        	  if(obj.fileName.endsWith(".mp3")) {
				        		  queryMedia(id,familyNo,"pa_family_basic_info", 2);
				        	  } else if(obj.fileName.endsWith(".mp4")) {
				        		  queryMedia(id,familyNo,"pa_family_basic_info", 3);
				        	  }else {
				        		  queryMedia(id,familyNo,"pa_family_basic_info", 1);
				        	  }
				          }  
				     });
		        }
		        // 进度条
		        ,progressall: function(e, data){
		        	var progress = parseInt(data.loaded / data.total * 100, 10);
					$('#progress1').css('width', progress + '%');
					// 
					if(progress == 100){
						setTimeout(function(){
							$('#progress1').css('width', '0');
						},2000);
					}
		        }
		    });
        	
        	
		},"JSON");
	}
	
	function turnMedia1(turnMediaFlag){
		queryMedia(id,familyNo,"pa_family_basic_info",turnMediaFlag);
	}
	
	function queryMedia(pkId,familyNo,tableName,turnMediaFlag){
		$.ajax({  
	          type : "post",  
	          url : "${basePath }/pafb/queryMedia",  
	          data : {pkId:pkId,familyNo:familyNo,tableName:tableName,turnMediaFlag:turnMediaFlag},
	          dataType:"JSON",
	          success : function(data){  
	        	  var result=data.data;
	        	  /*
	        	  var html="<div class='slick' style='width:650px;'>";
	        	  if(result.length==0){
	        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
	        	  }else{
	        		  for(var i=0;i<result.length;i++){
	        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
	        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='/images/timg.jpg' alt='' style='height:100px;' type='"+result[i].fileType+"' url='"+result[i].filePath+"'></a><span>"+result[i].fileName+"</span></div>"; 
	        			  }else{
	        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='"+result[i].filePath+"' alt='' style='height:100px;'  type='"+result[i].fileType+"'></a><span>"+result[i].fileName+"</span></div>";  
	        			  }
		        	  }
	        	  }
	        	  html+="</div>";
	        	  */
	        	  
	        	  var html='<div style="height: 3px;width: 100%;">';
	        	  html += '<div id="progress1" style="height: 3px; width: 0; background: #C61D22;"></div>';
	        	  html += '</div>';
	        	  
	        	  html += "<div id='pic_list_1' class='scroll_horizontal' style='width:720px;'>";
	        	  html += '<div class="box"> <ul class="list gallery">';
	        	  if(result.length==0){
	        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
	        	  }else{
	        		  for(var i=0;i<result.length;i++){
	        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
	        				  html+="<li style='text-align:center;'><a href='/images/timg.jpg' type='"+result[i].fileType+"' url='"+result[i].filePath+"'><img src='/images/timg.jpg' alt='' style='height:100px; max-width:200px;'></a><div>"+result[i].fileName+"</div></li>"; 
	        			  }else{
	        				  html+="<li style='text-align:center;'><a href='"+result[i].filePath+"' type='"+result[i].fileType+"'><img src='"+result[i].filePath+"' alt='' style='height:100px; max-width:200px;' ></a><div>"+result[i].fileName+"</div></li>";  
	        			  }
		        	  }
	        	  }
	        	  html+="</ul></div>";
	        	  html+="</div>";
	        	  
	        	  $("#mediaDiv").html(html);
	        	  
	        	  $("#pic_list_1").cxScroll();
	        	  
	        	  
	        	  zoomOpen('#pic_list_1 .gallery a');
	          }  
	     });
	}
	
	function loadSelectDiv(){
		$.get("${basePath }/common/codeList?type=educationCode",function(data){
			var html = '<option value="">全部</option>';
			for(var i=0; i<data.length; i++){
				html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
			}
			$('#educationCode').html(html);
		},"JSON");
	}
	
	
	function showMember(flag,id,thisfamilyNo){
		if(flag=="insert"){
			$.get("${basePath }/paMInfo/familyMemberInfo",function(data){
				var objArry=data.data;
				var html = '<input type="hidden" name="familyNo" value="'+familyNo+'">';
				html+='<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian\').click();"><img src="/img/defPhoto.png" id="photoImgm" style="width:100px;height:100px;"/></a><input type="hidden" id="photom" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				for(var i=0; i<objArry.length; i++){
					if(objArry[i].dataInputType=="img"){//过滤【用户照片】
						continue;
					}
					if(objArry[i].colENName=="age"){
						continue;
					}
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
					if(objArry[i].dataInputType=="text"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"/>';
					}else if(objArry[i].dataInputType=="select"){
						html+= '<select class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
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
						        	  for(var i=0; i<data.length; i++){
											html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
										} 
						          }  
						     });
						}
						html+='</select>';
					}else if(objArry[i].dataInputType=="textArea"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"></input>';
					}else if(objArry[i].dataInputType=="radio"){
						if('workAbility'==objArry[i].colENName){
							html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>有';
							html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">无</div>';
						}else{
							html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
							html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
						}
						 
					}else{
						html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
					}
					html+='</div>';
				}
				html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
				$("#showForm2").html(html);
				$("#myModalLabel2").html("添加");
				$('#myModal2').modal();
				
				// 修改证件类型时，将证件号码设置焦点，用于校验
				$("#showForm2 select[name='certificateTypeCode']").change(function(){
					$("#showForm2 input[name='certificateNo']").focus().blur();
				});
				
				$('#tupian').fileupload({
					url : '/pafb/upload',
//			        dataType: 'json',
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
			        	var obj=data.result.data;
			        	$("#photom").val(obj.filePath);;
			        	$("#photoImgm").attr("src", obj.filePath);
//			            $.each(data.result.files, function (index, file) {
//			                $('<p/>').text(file.name).appendTo(document.body);
//			            });
			        }
			    });
			},"JSON");
		}else if(flag=="update"){
			$.get("${basePath }/paMInfo/familyMemberInfo?id="+id,function(data){
				var objArry=data.data;
				var relationshipCode='';
				var html = '<input type="hidden" name="familyNo" value="'+thisfamilyNo+'"><input type="hidden" name="id" value="'+id+'"/>';
				html+='<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian\').click();"><img src="/img/defPhoto.png" id="photoImgm" style="width:100px;height:100px;"/></a><input type="hidden" id="photom" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				var photoImgSrc='';
				for(var i=0; i<objArry.length; i++){
					 if(objArry[i].dataInputType=="img"){//过滤【用户照片】
						 photoImgSrc=objArry[i].value;
					 	continue;
					}
					 if(objArry[i].colENName=="age"){
							continue;
						}
					 if(objArry[i].colENName=='relationshipCode'){
							relationshipCode=objArry[i].value;
						}
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
					if(objArry[i].dataInputType=="text"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null?"":objArry[i].value)+'"/>';
					}else if(objArry[i].dataInputType=="select"){
						html+= '<select class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
						if(objArry[i].colENName=="gender"){
							if(objArry[i].value=='女'){
								html += '<option value="' + '0' + '" selected = "selected">' + '女' + '</option>';
								html += '<option value="' + '1' + '">' + '男' + '</option>';
							}else{
								html += '<option value="' + '0' + '">' + '女' + '</option>';
								html += '<option value="' + '1' + '" selected = "selected">' + '男' + '</option>';
							}
							
						}else{
							var objVal=objArry[i].value;
							$.ajax({  
						          type : "post",  
						          url : "${basePath }/common/codeList",  
						          data : {type:objArry[i].colENName},
						          dataType:"JSON",
						          async : false,  
						          success : function(data){  
						        	  for(var i=0; i<data.length; i++){
						        		  if(objVal==data[i].name){
						        			  html += '<option value="' + data[i].code + '" selected = "selected">' + data[i].name + '</option>'; 
						        		  }else{
						        			  html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
						        		  }
										} 
						          }  
						     });
						}
						html+='</select>';
					}else if(objArry[i].dataInputType=="textArea"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'" />';
					}else if(objArry[i].dataInputType=="radio"){
						if('workAbility'==objArry[i].colENName){
							if(objArry[i].value=="是"){
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>有';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">无</div>';
							}else{
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1">有';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0" checked>无</div>';
							}
						}else{
							if(objArry[i].value=="是"){
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
							}else{
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1">是';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0" checked>否</div>';
							}
						}
					}else{
						html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
					}
					html+='</div>';
				}
				html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
				$("#showForm2").html(html);
				$("#myModalLabel2").html("编辑");
				$('#myModal2').modal();
				
				if(relationshipCode=='本人'){
					$("#showForm2 select[name='relationshipCode']").attr("disabled", "<%=disString %>");
					$("#showForm2 input[name='memberName']").attr("disabled","<%=disString %>");
					$("#showForm2 input[name='certificateNo']").attr("disabled","<%=disString %>");
					$("#showForm2 select[name='certificateTypeCode']").attr("disabled","<%=disString %>");
				}
				// 修改证件类型时，将证件号码设置焦点，用于校验
				$("#showForm2 select[name='certificateTypeCode']").change(function(){
					$("#showForm2 input[name='certificateNo']").focus().blur();
				});
				
				$('#tupian').fileupload({
					url : '/pafb/upload',
//			        dataType: 'json',
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
			        	var obj=data.result.data;
			        	$("#photom").val(obj.filePath);;
			        	$("#photoImgm").attr("src", obj.filePath);
//			            $.each(data.result.files, function (index, file) {
//			                $('<p/>').text(file.name).appendTo(document.body);
//			            });
			        }
			    });
				$("#photom").val(photoImgSrc);
				if(photoImgSrc!=null&&photoImgSrc!=""){
					$("#photoImgm").attr("src", photoImgSrc);
				}
	        	
			},"JSON");
		}else{
			$.get("${basePath }/paMInfo/familyMemberInfo?id="+id,function(data){
				var objArry=data.data;
				var html = '';
				var photo='<div class="input-group" style="width:760px;"><img src="/img/defPhoto.png" id="photoImgm" style="width:100px;height:100px;"/><input type="hidden" id="photom" name="photo"/><input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				var photoImgSrc='';
				for(var i=0; i<objArry.length; i++){
					if(objArry[i].colENName=='photo'){
						photoImgSrc=objArry[i].value;
						continue;
					}
					/* if('workAbility'==objArry[i].colENName){
						if(objArry[i].value=="是"){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">有</span></div>';
						}else{
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">无</span></div>';
						}
					}else{
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
					} */
					
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
				}
				$("#showForm2").html(photo+html);
				$("#myModalLabel2").html("查看详情");
				$('#myModal2').modal();
				$("#photom").val(photoImgSrc);
				if(photoImgSrc!=null&&photoImgSrc!=""){
					$("#photoImgm").attr("src", photoImgSrc);
				}
			},"JSON");
		}
	}
	function submitForm2(){
		if(!$("#showForm2").valid()){
			return false;
		}
		$("#myModal2").modal('hide');
		$.ajax({  
	          type : "post",  
	          url : "${basePath }/paMInfo/checkFamilyMemberInfo",  
	          data : $("#showForm2").serialize(),
	          dataType:"JSON",
	          success : function(data){ 
	        	  if(data.success==true){
	        		  $.ajax({  
		    	          type : "post",  
		    	          url : "${basePath }/paMInfo/saveFamilyMemberInfo",  
		    	          data : $("#showForm2").serialize(),
		    	          dataType:"JSON",
		    	          success : function(data){  
		    	        	  alert("保存成功");
		    	        	  //$('#table').bootstrapTable("refresh",{query: {offset:0}});
		    	        	  $('#table').bootstrapTable("refresh");
		    	          }  
		    	     });
	        	  }else{
	        		  alert("家庭成员只能有一个户主！");
	        	  }
	        	  
	          }  
	     });
	}
	function deleteById(id){
		if(confirm("确认删除？")){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/paMInfo/deleteById",  
		          data : {id:id},
		          dataType:"JSON",
		          success : function(data){  
		        	  //alert("删除成功");
		        	  $('#table').bootstrapTable("refresh");
		          }  
		     });
		}
		
	}
	function submit8(){
		var poorCase8=$("#poorCase8").val();
		var plan8=$("#plan8").val();
		if(poorCase8==''&&plan8==''){
			alert("没有填写数据不能保存！");
		}else{
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/pcap/savePoorCaseAndPlan",  
		          data : $("#form8").serialize(),
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("保存成功");
		          }  
		     });
		}
		
	}
	function showTab8(){
		$.ajax({  
	          type : "post",  
	          url : "${basePath }/pcap/queryPoorCaseAndPlan",  
	          data : {familyNo:familyNo},
	          dataType:"JSON",
	          success : function(data){  
	        	  var result=data.data;
	        	  $("#poorCase8").text(result.poorCase);
	        	  $("#plan8").text(result.plan);
	          }  
	     });
	}
	
	</script>
	
	<!-- 加载生产生活情况js -->
	<script type="text/javascript" src="/js/family/familyData/familyProductLifeInfo.js"></script>
	<!-- 加载帮扶责任人js -->
	<script type="text/javascript" src="/js/family/familyData/helpPerson.js"></script>
	<!-- 加载帮扶措施与成效  js -->
	<script type="text/javascript" src="/js/family/familyData/familyHelpPlan.js"></script>
	<!-- 加载脱贫评估  js -->
	<script type="text/javascript" src="/js/family/familyData/familyAssessmentInfo.js"></script>
	
	<!-- 加载 问题反馈  js -->
	<script type="text/javascript" src="/js/family/familyData/feedback.js"></script>
	
	<!-- 自我发展成效 js -->
	<script type="text/javascript" src="/js/family/familyData/selfDevelopmentEffect.js"></script>
	
	<!-- 家庭主要社会关系js -->
	<script type="text/javascript" src="/js/family/familyData/familyMajorSocialRelations.js"></script>
	
	<!-- 加载  帮扶成效  js -->
	<script type="text/javascript" src="/js/family/familyData/familyHelpResult.js"></script>
	
</body>

<script id="templ3" type="text/html">
<form class="bs-example bs-example-form" role="form">
<div class="btn-group-vertical">
<div id="mediaDiv3" class="input-group" style="margin-left:50px;margin-bottom:10px;"></div>	
<div class="btn-group-vertical">
<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia3(1);">图片</span>
<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia3(2);">音频</span>
<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia3(3);">视频</span>
{{if btnShow}}
<span class="btn btn-primary btn-sm fr" onclick="javascript:$('#media3').click();">上传</span>
{{/if}}
<input name="media" id="media3"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>
{{each data as item i}}
	{{if item.isWrite == 0}}	
		<div class="input-group" style="width:100%; clear: both;">
			<span class="input-group-addon" style="font-size: 17px;">{{item.showName}}</span>
		</div>
	{{else}}
		<div class="input-group my-item" style="padding-left: 15px;">
			<span class="input-group-addon" style="font-weight: 600; font-size: 15px;">
				{{item.showName}}
			</span>
			<span class="form-control" style="{{isCheckBox item.dataInputType item.indexCode}}">
				{{isRadio item.dataInputType item.value item.indexCode '是' '否'}}
				{{item.indexUnit}}
			</span>
		</div>
	{{/if}}
{{/each}}
</form>
</script>

<script id="templ3_edit" type="text/html">

{{each data as item i}}
{{if item.isWrite == 0}}	
		<div class="input-group" style="width:100%">
			<span class="input-group-addon" style="font-size: 17px;">{{item.showName}}</span>
		</div>
	{{else}}
		<div class="input-group my-item" style="padding-left: 15px;">
			<span class="input-group-addon" style="font-weight: 600; font-size: 15px;">
				{{item.showName}}
			</span>
				{{if item.dataInputType == 'date'}}
					<input name="{{item.indexCode}}" class="form-control" value="{{item.indexValue}}" type="text" onFocus="WdatePicker()"/>
				{{/if}}
				{{if item.dataInputType == 'text'}}
					<input type="text" class="form-control" name="{{item.indexCode}}" value="{{item.indexValue}}" />
					<span class="my-item-span-me"> {{item.indexUnit}} </span>
				{{/if}}
				{{if item.dataInputType == 'textArea'}}
					<input type="textArea" class="form-control" name="{{item.indexCode}}" value="{{item.indexValue}}" />
					<span class="my-item-span-me"> {{item.indexUnit}} </span>
				{{/if}}
				{{if item.dataInputType == 'radio'}}
					{{if item.isCode == 1}}
						<!-- 嵌套循环 -->
						{{each item.codeList as codeValue i}}
							<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="{{codeValue.code}}" {{isChecked codeValue.code item.indexValue}} /> {{codeValue.name}}
      				    	</label>
						{{/each}}
					{{else}}
						{{if item.indexValue == 0}}
							<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="1" /> 是
      				   	 	</label>
								<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="0" checked /> 否
      				   	 	</label>
						{{else}}
							<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="1" checked /> 是
      				   	 	</label>
								<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="0" /> 否
      				   	 	</label>
						{{/if}}
					{{/if}}
				{{/if}}
				{{if item.dataInputType == 'checkbox'}}
					{{if item.isCode == 1}}
						<!-- 嵌套循环 -->
						{{each item.codeList as codeValue i}}
							<label class="checkbox-inline">
          						<input type="checkbox" name="{{item.indexCode}}" value="{{codeValue.code}}" {{isChecked codeValue.code item.indexValue}} /> {{codeValue.name}}
      				    	</label>
						{{/each}}
					{{/if}}
				{{/if}}
				


		</div>
	{{/if}}
{{/each}}
</script>

<script id="template_6" type="text/html">

<div class="input-group" > 
	<span class="input-group-addon">收入情况年份：</span>
	<input type="hidden" name="lastYear" value="{{selectYear}}" />
	<select class="form-control" style="width:120px;" name="year">
		{{if selectYear}}
			<option value="{{selectYear}}" selected>{{selectYear}}</option>
		{{/if}}
		{{each yearList as value i}}
			<option value="{{value}}">{{value}}</option>
		{{/each}}
	</select>
</div>
{{each data as item i}}
	<div class="input-group input-group-me" > 
		<span class="input-group-addon" style="">{{item.showName}}</span>
		<input type="text" class="form-control" name="{{item.indexCode}}" value="{{item.indexValue}}" />
		<span class="input-group-span-me"> {{item.indexUnit}} </span>
	</div>
{{/each}}
<span class="btn btn-primary fr" onclick="submitForm6();">保存</span>
</script>


</html>