<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统管理</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />

<link rel="stylesheet" type="text/css" href="/js/bootstrap-select/bootstrap-select.min.css" />
<style type="text/css">
.nav-pills>li>a {
    text-decoration: none;
    font-size: 16px;
    text-align: center;
}

.row-me{
	width: 13%; 
	float: left; 
	margin: 0;
}

.tab-content-me{
	width: 82%;
    float: left;
    border-left: 1px solid #ccc;
    margin-left: 10px;
    padding-left: 10px;
}

.tab-content-me .tab-pane {
	min-height: 450px;
}
.form-ul{
	overflow: hidden;
}
.form-ul li{
	float:left;
	width:33%;
}
.form-ul li input{
	margin-top: 5px;
}

/* 重写下拉多选框的样式 start */
.bootstrap-select button .filter-option {
	font-size: 14px;
    line-height: 20px;
}

.h34px {
	height: 34px;
    width: 250px !important;
    color: #555 !important;
    background: none;
    border: 1px solid #ccc;
}
/* 重写下拉多选框的样式 end */
.roleDiv{
	overflow: hidden;
	padding:20px;
}
.roleDiv span{
	margin-right:8px;
	font-weight:600;
   	font-size: 14px;
}
.roleDiv li,.roleDiv p{
	font-size: 14px;
}
.modal-dialog{
	width:auto;
	max-width:1000px;
}


</style>
<%
String userType = session.getAttribute("userType")==null?"":session.getAttribute("userType").toString();


boolean xitong = "1".equals(userType); // 系统管理员
boolean yonghu = "8".equals(userType); // 用户管理员

// 用户管理员有用户管理和角色管理；系统管理员有组织机构管理和权限管理

%>
<script>
var basepath="${basepath}";
</script>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>

<div class="w1200 main">
	<div class="panel panel-default">
		<div class="row row-me" >
			<div class="span2">
				<ul class="nav nav-pills nav-stacked">
					<c:if test="<%=yonghu %>">
						<li class="active">
							<a href="#tab1" data-toggle="tab">用户管理</a>
						</li> 
						<li><a href="#tab3" data-toggle="tab">角色管理</a></li>
					</c:if>
					<c:if test="<%=xitong %>">
						<li class="active"><a href="#tab2" data-toggle="tab">组织机构管理</a></li>
						<li><a href="#tab4" data-toggle="tab">权限管理</a></li> 
					</c:if>
				</ul>
			</div>
		</div>
		
		<div class="tab-content tab-content-me">
		
			<div class="tab-pane fade <c:if test="<%=yonghu %>"> in active</c:if>" id="tab1">
					<div>
						<form class="form-inline" role="form">
						<div class="input-group">
								<span class="input-group-addon">用户名</span> 
								<input type="text" class="form-control names" style="width:120px" name="nickName" id="nickName1" placeholder="请输入用户名"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">登录名</span> 
								<input type="text" class="form-control" style="width:120px" name="userName" id="userName1" placeholder="请输入登录名"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">邮箱</span> 
								<input type="text" class="form-control" style="width:120px" name="email" id="email1" placeholder="请输入邮箱"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon">手机</span> 
								<input type="text" class="form-control" style="width:120px" name="mobile" id="mobile1" placeholder="请输入手机号"/>
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="search1">查询</span>
							</div>
						</form>
					</div>
					<span type="button" class="btn btn-success fr" onclick="showInsert1();">添加</span>
					<div>
						<table id="table1"></table>
					</div>
			</div>
			
			<div class="tab-pane fade <c:if test="<%=xitong %>"> in active</c:if>" id="tab2">
				<!-- 组织机构 start -->
					<div class="">
						<form class="form-inline" role="form">
							<div class="input-group">
								<span class="input-group-addon">组织机构</span> 
								<input type="text" class="form-control names" style="width:120px" name="deptname" id="deptname" placeholder=""/>
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="search4">查询</span>
							</div>
						</form>
					</div>
					<span type="button" class="btn btn-success fr" onclick="showInsert4();">添加</span>
					<div>
						<table id="table4"></table>
					</div>
				<!-- 组织机构 end -->
			</div>
			
			
			<div class="tab-pane fade" id="tab3">
					<div>
						<form class="form-inline" role="form">
						<div class="input-group">
								<span class="input-group-addon">角色名称</span> 
								<input type="text" class="form-control names" style="width:120px" name="roleName" id="roleName2" placeholder="角色名称"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon" style="display:none">登录名</span> 
								<input type="text" class="form-control"  style="width:120px;display:none" name="userName" id="userName1" placeholder="请输入登录名"/>
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="search2">查询</span>
							</div>
						</form>
					</div>
					<span type="button" class="btn btn-success fr" onclick="showInsert2();">添加</span>
					<div>
						<table id="table2"></table>
					</div>
			</div>
			
			<div class="tab-pane fade" id="tab4">
				<!-- 权限start -->
				<div>
					<form class="form-inline" role="form">
						<div class="input-group">
							<span class="input-group-addon">权限名称</span> 
							<input type="text" class="form-control" style="width:100px;" placeholder="权限名称" id="name3">
						</div>
						<div class="input-group">
							<span class="input-group-addon">访问地址</span> 
							<input type="text" class="form-control" style="width:150px;" placeholder="可访问地址" id="url3">
						</div>
						<div class="input-group">
							<span class="input-group-addon">菜单权限</span> 
							<input type="text" class="form-control" style="width:150px;" placeholder="可查看菜单" id="menu3">
						</div>
						<!-- 
						<div class="input-group">
							<span class="input-group-addon">操作权限</span>
							 <select class="form-control" id="operator3"> 
						      </select>
						</div>
						 -->
						<div class="input-group">
						    <span class="btn btn-primary" id="search3">搜索</span>
						</div>
					</form>
				</div>
				<div>
					<table id="table3"></table>
				</div>
				<!-- 权限end -->
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	
<!--  -->	
</div>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<!-- 垂直居中 -->
	<div class='modal-tb'><div class='modal-tc'>
		<div class="modal-dialog"  style="width:1000px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel1">
					</h4>
				</div>
				
		<div style="padding: 20px 50px 170px;overflow:auto;">
	    	<form class="bs-example bs-example-form" id="showForm1" role="form">
	    	</form>
		</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div></div>
	<!-- 垂直居中 -->
</div>

<!-- 分配角色操作start -->
<div class="modal fade" id="setRoleModal" tabindex="-1" role="dialog" 
		aria-labelledby="setRoleModalLabel" aria-hidden="true" style="">
	<!-- 垂直居中 -->
	<div class='modal-tb'><div class='modal-tc'>
		<div class="modal-dialog"  style="width:1000px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="setRoleModalLabel">
					</h4>
				</div>
				
		<div style="padding: 40px 50px 20px;overflow:auto;">
	    	<form class="bs-example bs-example-form" id="setRoleForm" role="form">
	    	</form>
		</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div></div>
	<!-- 垂直居中 -->
</div>
<!-- 分配角色操作 end -->

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true" style="top: 2%;">
	<!-- 垂直居中 -->
	<div class='modal-tb'><div class='modal-tc'>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel2">
					</h4>
				</div>
				
		<div class="roleDiv">
	    	<form class="bs-example bs-example-form" id="showForm2" role="form">
	    	</form>
		</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div></div>
	<!-- 垂直居中 -->
</div>


<!-- 权限管理 -->
<div class="modal fade" id="priviModal3" tabindex="-1" role="dialog"
		aria-labelledby="priviModalLabel3" aria-hidden="true" style="top: 2%;">
	<!-- 垂直居中 -->
	<div class='modal-tb'><div class='modal-tc'>
		<div class="modal-dialog"  style="width:1000px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="priviModalLabel3">
					</h4>
				</div>
				
				<div style="padding: 40px 50px 20px;overflow:auto;">
			    	<form class="bs-example bs-example-form" id="privilegeForm3" role="form">
			    	</form>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div></div>
	<!-- 垂直居中 -->
</div>


<!-- 组织机构管理 -->
<div class="modal fade" id="deptModal" tabindex="-1" role="dialog"
		aria-labelledby="deptModalLabel" aria-hidden="true" style="">
	<!-- 垂直居中 -->
	<div class='modal-tb'><div class='modal-tc'>
		<div class="modal-dialog"  style="width:1000px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="deptModalLabel">
					</h4>
				</div>
				
				<div style="padding: 40px 50px 20px;overflow:auto;">
			    	<form class="bs-example bs-example-form" id="deptForm" role="form">
			    	</form>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div></div>
	<!-- 垂直居中 -->
</div>

<div class="dn" id="validate-tip"> 
	<div class="tooltip fade top in tooltip-div" role="tooltip">
		<div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>
		<div class="tooltip-inner tooltip-inner-me"></div>
	</div>
</div>	
<%@ include file="/WEB-INF/view/common/footer.jsp" %>


	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="/js/template.js"></script>
	
	<!-- 下拉多选 -->
	<script type="text/javascript" src="/js/bootstrap-select/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-select/defaults-zh_CN.min.js"></script>
	
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	
	<!-- 加载 用户管理 js -->
	<script type="text/javascript" src="/js/sys/userManage.js"></script>
	<!-- 加载 角色管理 js -->
	<script type="text/javascript" src="/js/sys/roleManage.js"></script>
	<!-- 加载 权限管理 js -->
	<script type="text/javascript" src="/js/sys/privilegeManage.js"></script>
	<!-- 加载 组织机构管理 js -->
	<script type="text/javascript" src="/js/sys/deptManage.js"></script>
	
</body>
<script id="templ3" type="text/html">

</script>
<script id="privilegeTemplate" type="text/html">
{{if type == 'update'}}
	<input type="hidden" name="id" value="{{id}}">
{{/if}}
{{each data as item i}}
	<div class="input-group" > 
		<span class="input-group-addon" style="width:150px;">{{item.showName}}</span>
		{{if type == 'show'}}
			<span class="form-control" style="width:250px;">{{item.indexValue}}</span>
		{{else}}
			{{if item.operatorList}}
						<!-- 嵌套循环 -->
						{{each item.operatorList as codeName i}}
							<label class="radio-inline">
          						<input type="radio" name="{{item.indexCode}}" value="{{codeName.code}}" {{radioChecked codeName.code item.indexValue}} /> {{codeName.name}}
      				    	</label>
						{{/each}}
			{{else}}
				<input type="text" class="form-control" name="{{item.indexCode}}" value="{{item.indexValue}}" style="width:250px;" />
			{{/if}}
		{{/if}}
	</div>
{{/each}}
{{if type == 'insert' || type == 'update'}}
	<span class="btn btn-primary fr" onclick="submitPriviForm3();">保存</span>
{{/if}}
</script>
</html>