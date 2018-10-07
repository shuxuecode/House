<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>    

<%

String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
String  url  =  "http://"  +  request.getServerName()  +  ":"  +  request.getServerPort()  +  
request.getContextPath()+request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);  


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="/css/login.css"/>
<link rel="stylesheet" type="text/css" href="/css/register.css"/>

<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />

<style type="text/css">
.footer {
	position: fixed;
}
</style>

</head>
<body>
	
<div id="wrapper">
	<div class="s-container"></div>
	<div class="header">
		<div class="w1200">
	        <a href="#" class="headleft"></a>
	        <div class="headright">
	        	<a target="_blank" href="/login">登录</a>
	        	<!-- <a target="_blank" href="#">|</a>
	        	<a target="_blank" href="#l">注册</a> -->
	        </div>
	    </div>
	</div>    
	<!-- 主体 start -->
	<div class="w1200">
		<ol class="breadcrumb">
		    <li>当前位置：注册</li>
		</ol>
		<div class="main">
			<div class="regist_one">
				<p>请选择注册的账号类型</p>
				<div class="clearfix">
					<dl class="mr20 active_2_" type="1">
						<dt><img src="img/register/reg01.png"/></dt>
						<dd>普通用户</dd>
					</dl>
					<dl type="2">
						<dt><img src="img/register/reg02.png"/></dt>
						<dd>政府用户</dd>
					</dl>
					<dl type="3">
						<dt><img src="img/register/reg03.png"/></dt>
						<dd>企业用户</dd>
					</dl>
				</div>
				
			</div>
		</div>
	</div>
	<!-- 主体 end -->
	<div class="footer">
		建设单位：三亚市农业局；技术支持单位：三亚市信投公司
	</div>
</div>	
	
	
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
	
	
	
<script type="text/javascript">
$(function(){
	/* 
	$(".regist_one dl").click(function(){
		$(".regist_one dl").removeClass("active");
		$(this).addClass("active");
	});
	 */
	
	$(".regist_one dl").on("mouseover mouseout", function(){
		// $(".regist_one dl").removeClass("active");
		// $(this).addClass("active");
		$(this).toggleClass("active");
	});
	 
	$(".regist_one dl").click(function(){
		var type = $(this).attr("type");
		location.href = "${basePath }/register?step=2&type=" + type;
	});
	 
});

</script>
</body>
</html>