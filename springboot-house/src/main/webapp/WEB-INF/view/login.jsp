<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>   
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="/css/login.css"/>

<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />

<style type="text/css">
.yanzh_inp {
  margin-left: 53px;
}
</style>
<script type="text/javascript">

var hh = document.getElementsByClassName("logintext")[0].innerHTML;
var ua = navigator.userAgent.toLowerCase();
if(/msie/.test(ua)&&!/opera/.test(ua)){
	document.getElementsByClassName("logintext")[0].innerHTML = hh + '是ie';
	
	var a= ua.indexOf("msie");
	if(a<0){
		document.getElementsByClassName("logintext")[0].innerHTML = hh + '0';
	}else{
		document.getElementsByClassName("logintext")[0].innerHTML = hh + 
			parseFloat(ua.substring(a+5,ua.indexOf(";",a)));
	}
}

</script>
</head>
<body>
	
<div id="wrapper">
	<div class="s-container"></div>
	<div class="header">
		<div class="w1200">
	        <a href="#" class="headleft"></a>
	        <div class="headright">
	        	<!-- <a target="_blank" href="#">登录</a>
	        	<a target="_blank" href="#">|</a>
	        	<a target="_blank" href="/register">注册</a> -->
	        </div>
	    </div>
	</div>    
    <div class="s-Main">
	    <div class="s-login">
	    	
	    	<div class="s-loginM w1200">
				<div class="loginImg">
					<img src="img/logo_co.png"/>
				</div>
				<div class="loginpotion"> 
					<div class="logintext">用户登录</div>
					<div class="login_infor">
						<input type="text" placeholder="请输入用户名" id="loginId"/>
						<input type="password" placeholder="请输入密码" id="password"/>
						<div class="yanzh_inp">
							<input type="text" class="yanzh" placeholder="验证码" style="float: left;" id="checkCode"/>
							<span style=" display:block; float: left; margin: 3px 12px 0 12px;">
								<img style="cursor:pointer;" id="checkCodeImg" title="看不清楚?点击换一张" src="${basePath }/validatecode" width="60" height="33"/>
							</span>
							<a href="javascript:reloadCode();" style="float: left; line-height: 36px;" class="changcolor">看不清</a>
						</div>
						<div class="logbtn">
							<button id="sub" class="logbtn">登录</button>
						</div>
					</div>
				</div>
				
			</div>
				
		</div>		
	 </div>
	<div class="footer">
		建设单位：三亚市农业局；技术支持单位：三亚市信投公司
	</div>
</div>	
	
	
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
	<script type="text/javascript" src="/js/respond.js"></script>
	
	
<script type="text/javascript">

$(function(){
	$("#sub").click(function(){login();});
});

$(document).keyup(function (e) {
    if (e.keyCode == 13)
    	$("#sub").trigger("click");
});

var reloadCode = function() {
	$("#checkCodeImg").attr("src","${basePath }/validatecode?d="+new Date().getTime()); // .fadeIn();
};
$("#checkCodeImg").click(function() {
	reloadCode();
});

function login(){
	if ($.trim($("#loginId").val()) == '') {
		$.alert({
		    title: false,
		    content: '<font color="red">登录名不能为空！</font>',
		    confirmButton: '确认',
		    confirmKeys:[13],
		    keyboardEnabled:true,
		    onOpen:function(){
		    	$("#sub").unbind("click");
		    },
		    confirm:function(){
		    	$("#sub").click(function(){login();});
		    }
		});
		$("#loginId").focus();
		return;
	}
	if ($.trim($("#password").val()) == '') {
		$.alert({
		    title: false,
		    content: '<font color="red">密码不能为空！</font>',
		    confirmButton: '确认',
		    confirmKeys:[13],
		    keyboardEnabled:true,
		    onOpen:function(){
		    	$("#sub").unbind("click");
		    },
		    confirm:function(){
		    	$("#sub").click(function(){login();});
		    }
		});
		$("#password").focus();
		return;
	}
	if ($.trim($("#checkCode").val()) == '') {
		$.alert({
		    title: false,
		    content: '<font color="red">验证码不能为空！</font>',
		    confirmButton: '确认',
		    confirmKeys:[13],
		    keyboardEnabled:true,
		    onOpen:function(){
		    	$("#sub").unbind("click");
		    },
		    confirm:function(){
		    	$("#sub").click(function(){login();});
		    }
		});
		$("#checkCode").focus();
		return;
	}
	var name = $("#loginId").val();
	var pwd = $("#password").val();
	var code = $("#checkCode").val();
	$.ajax({
		url : "${basePath }/loginAction",
		type:'POST',
		data : {
			username : name,
			password : pwd,
			checkcode : code
		},
		success:function(data,status,xhr){
            if(data.success){
            		
            	var urlList = ',' + data.data + ',';
            	if(urlList.indexOf(",/pafam/familyInfoList,") != -1){
            		location.href = '${basePath }/pafam/familyInfoList';
            	}else if(urlList.indexOf(",/helper/paHelpPersonPage,") != -1){
            		location.href = '${basePath }/helper/paHelpPersonPage';
            	}else if(urlList.indexOf(",/examine/examineFamilyList,") != -1){
            		location.href = '${basePath }/examine/examineFamilyList';
            	}else if(urlList.indexOf(",/analysis/analysis,") != -1){
            		location.href = '${basePath }/analysis/analysis';
            	}else if(urlList.indexOf(",/sys/userManage,") != -1){
            		location.href = '${basePath }/sys/userManage';
            	}
						
			}else{
				$.alert({
				    title: false,
				    content: data.msg,
				    confirmButton: '确认',
				    confirmKeys:[13],
				    keyboardEnabled:true,
				    confirm:function(){
				    	reloadCode();
						$("#checkCode").val("");
						$("#checkCode").focus();
						$("#sub").click(function(){login();});
				    },
				    onOpen:function(){
				    	$("#sub").unbind("click");
				    }
				});
				
			}
        },
        error:function(xhr,errorText,errorType){
        	$("#password").val("");
			$("#checkCode").val("");
			reloadCode();
        },
        dataType : "JSON"
	});
	
}
</script>
</body>
</html>