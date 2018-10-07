<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.golden.util.UserAuthUtil" %> 
<%
	String showName = "管理员";

	Object nickname = session.getAttribute("nickName");
	Object username = session.getAttribute("userName");
	if(nickname == null){
		if(username != null){
			showName = username.toString();
		}
	}else{
		showName = nickname.toString();
	}
	// 避免溢出
	showName = (showName.length() > 6) ? showName.substring(0, 6) : showName;
	 
%>    
    
    <script type="text/javascript">
    	/* 此处为修改jquery的源码所用 */
    	var timeout_status = 601;
    	var timeout_login = function(status){
    		if(timeout_status == status){
    			$.alert({
    	    	    title: false,
    	    	    content: "登录超时，请重新登录！",
    	    	    confirmButton: '确认',
    	    	    theme: 'white',
    	    	    confirm: function(){
    	    	    	location.href = "/login";
    	    	    }
    	    	});
    		}
    	}
    </script>
    <script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    <!-- <script type="text/javascript" src="/js/jquery-1.9.1.js"></script> -->
    
    
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />

    <script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
    
    <!-- 适用360兼容模式 -->
    <script type="text/javascript" src="/js/respond.js"></script>
<style>
.jq-conf-alert-cls {
	top : 100px;
}

.jconfirm .jconfirm-box{
	top: -200px;
}
</style>
<script type="text/javascript">
// 重写alert样式
    window.alert = function(msg){
    	if(msg == '') return false;
    	$.alert({
    	    title: false,
    	    content: msg,
    	    confirmButton: '确认'
    	    // columnClass: 'jq-conf-alert-cls'
    	});
    };
</script>
<style>
body{
	background-color: #f5f5f5;
	margin-bottom: 100px;
}

.navbar-default .navbar-nav>.active>a, 
.navbar-default .navbar-nav>.active>a:hover, 
.navbar-default .navbar-nav>.active>a:focus
.navbar-nav>li>a {
  color: #fff;
  background-color: #a60f12;
}

.navbar-default .navbar-nav>li>a {
    color: #fff;
}

.bg-me{
	background: url(/img/logoL.png) no-repeat center;
	width: 492px;
}

#logout{
	 cursor: pointer;
}


/* 验证提示样式 */
.tooltip-div {
	bottom: 54px;
	display: block;
	text-align: left;
}

.tooltip-inner-me {
	text-align: left; 
	padding: 3px 10px; 
	min-width: 120px; 
	color: rgb(255, 255, 255); 
	border: 1px solid rgb(102, 153, 204); 
	border-radius: 5px; 
	background-color: rgba(51, 153, 204, 0.8);
}

/* 下拉 start */
.per_cen{
	cursor: pointer;
}
.per_cen .dropdown-menu{
	font-size: 12px;
	min-width: 90px;
}

.navbar-text a {
	color: #fff;
}

.nav-right-mr {
	margin-right: -50px !important;
}
/* 下拉 end */

/* 避免表格出现大量空白 */
.fixed-table-body {
	height: auto;
}
/* 去掉多媒体下方文字 */
.scroll_horizontal .gallery li div {
	/*display:none;*/
	width:200px;
	padding: 0 20px;
	overflow: hidden;
}


/* 站内信样式 start */
.msg-a{
	float: right;
	position: relative;
	top: 7px;
	height: 20px;
	width: 20px;
	margin-left: 5px;
	background: url(/images/msg_icon.png) no-repeat center;
}
.msg-a1{
	background-position: 0px 3px;
}
.msg-a2{
	background-position: 0px -17px;
}
.W_new_count {
	position: relative;
	top: -6px;
	left: 12px;

    min-width: 18px;
    height: 13px;
    line-height: 14px;
    text-align: center;
    /* display: inline-block; */
    display: none;
    background: #fa7d3c;
    border-radius: 3px;
}
/* 站内信样式 end */

</style>
    
<!-- 网页加载进度提示插件 -->
<link rel="stylesheet" type="text/css" href="/js/pace/pace-theme-minimal-color-ff7944.css" />
<script type="text/javascript" src="/js/pace/pace.min.js"></script>
    
<!--  -->   
	<div class="header">
	<nav class="navbar w1200" role="navigation">
		<!-- <div class="container-fluid" > -->
		<div class="" >
			<div class="navbar-header bg-me mt10" >
				<a class="navbar-brand" href="#"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<%  boolean menu_1 = UserAuthUtil.hasUrl(request, "/pafam/familyInfoList"); %>
					<c:if test="<%=menu_1 %>">
					<li id="nav1"><a href="${basePath }/pafam/familyInfoList">扶贫信息管理</a></li>
					</c:if>
					
					<% boolean menu_2 = UserAuthUtil.hasUrl(request, "/helper/paHelpPersonPage"); %>
					<c:if test="<%=menu_2 %>">
					<li id="nav2"><a href="${basePath }/helper/paHelpPersonPage">责任人管理</a></li>
					</c:if>
					
					<% boolean menu_3 = UserAuthUtil.hasUrl(request, "/examine/examineFamilyList"); %>
					<c:if test="<%=menu_3 %>">
					<li id="nav3"><a href="${basePath }/examine/examineFamilyList">审核管理</a></li>
					</c:if>
					
					<%  boolean menu_4 = UserAuthUtil.hasUrl(request, "/analysis/analysis"); %>
					<c:if test="<%=menu_4 %>">
					<li id="nav4"><a href="${basePath }/analysis/analysis">统计分析</a></li>
					</c:if>
					
					
					<% boolean menu_5 = UserAuthUtil.hasUrl(request, "/sys/userManage"); %>
					<c:if test="<%=menu_5 %>">
					<li class="dropdown" id="nav5">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							系统管理
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="${basePath }/sys/userManage">用户管理</a></li>
						</ul>
					</li>
					</c:if>
					
					
				</ul>
				<a id="logout" class="navbar-text navbar-right nav-right-mr">安全退出</a>
				<div class="navbar-text navbar-right dropdown per_cen">您好！
					  <a data-toggle="dropdown"><%=showName %>
					    	<span class="caret"></span>
					  </a>
					  <!-- 站内信 -->
	          		  <a href="/message/messagePage" target="_blank" class="msg-a msg-a1">
			  				<em class="W_new_count"></em>
			  		  </a>
			  		  
					  <ul class="dropdown-menu">
						    <li><a href="/sys/updatePwd">修改密码</a></li>
						    <!-- 
						    <li><a href="#">个人中心</a></li>
						    <li><a href="#">安全退出</a></li>
						     -->
					  </ul>
				</div>
				
				
			</div>
		</div>
	</nav>
	</div>


<!-- 面包屑 -->

<ol class="breadcrumb w1200">
	<li style="  visibility: hidden;">当前位置：扶贫信息管理</li>
    <!-- <li><a href="#">扶贫信息管理</a></li> -->
    <!-- <li class="active">扶贫户信息列表</li> -->
</ol>

<%
String showMenu = request.getParameter("showMenu") == null ? "" : request.getParameter("showMenu");
String breadcrumb = request.getParameter("breadcrumb") == null ? "" : request.getParameter("breadcrumb");
%>


<script>
	
	var showMenu = '${showMenu}';
	var breadcrumb = '${breadcrumb}';


	$(function(){
		// class="active"
		if(showMenu != ""){
			if(showMenu == 1){
				$("#nav1").addClass("active");
			}else if(showMenu == 2){
				$("#nav2").addClass("active");
			}else if(showMenu == 3){
				$("#nav3").addClass("active");
			}else if(showMenu == 4){
				$("#nav4").addClass("active");
			}else if(showMenu == 5){
				$("#nav5").addClass("active");
			}
		}
		
		
		if(breadcrumb != ""){
			var breadcrumbs = breadcrumb.split(",");
			var blength = breadcrumbs.length;
			if(blength > 1){
				var h = '<li>当前位置：' + breadcrumbs[0] + '</li>';
				for(var i=1, len=blength-1; i<len; i++){
					h += '<li>' + breadcrumbs[i] + '</li>';
				}
				h += '<li class="active">' + breadcrumbs[blength - 1] + '</li>';
				$(".breadcrumb").html(h);
			}
			
		}
		
		
		/*
		*
		*/
		$(".msg-a").on('mouseover mouseout', function(){
			$(this).toggleClass("msg-a2");
		});
		
		$.get("/message/unSawCount",function(data){
        	        if(data.success){
        	        	$(".W_new_count").html(data.data);
        	        	$(".W_new_count").css({"display": "inline-block"});
        	        }
        	    }
        );
		
		
		
		$("#logout").click(function(){
			$.confirm({
			    title: '提示!',
			    content: '确定要安全退出吗?',
			    confirmButton: '退出',
			    cancelButton: '取消',
			    confirm: function(){
			        //$.alert('Confirmed!');
			    	$.get("/logout",
			        		function(data, state){
			        	        //这里显示从服务器返回的数据
			        	        //console.info(data);
			        	        //这里显示返回的状态
			        	        //console.info(state);
			        	        if(state){
			        	        	location.replace("/login");
			        	        }
			        	    }
			        );
			    },
			    cancel: function(){
			        // $.alert('Canceled!')
			    }
			});
		});
		
		
		
		//为所有摸态框model外面加两层div，做居中显示
		$(".modal-dialog").wrap("<div class='modal-tb'><div class='modal-tc'></div></div>");
		
		/* 
		function longPolling2(){
            $.get('/checklogin', function(data){
                console.log(data);
                if(data == 'out'){
                	location.replace("/login");
                }else{
                	//longPolling2();
                }
            });
        }
        longPolling2();
         */
        
	});
</script>

