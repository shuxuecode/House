<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>    
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
		    <li>当前位置：<a href="#">注册</a></li>
		    <li class="active">
		    	<c:if test="${type==1 }">普通用户</c:if>
		    	<c:if test="${type==2 }">政府用户</c:if>
		    	<c:if test="${type==3 }">企业用户</c:if>
		    </li>
		</ol>
		<div class="main">
			<div class="reg_forms">
			<a  href="/register" class="fr">返回</a>
				<ul class="nav nav-pills">
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="reg1">
						<div class="reg_form">
							<form id="formId">
							<input type="hidden" id="userType" name="userType" />
							<ul>
								<li>
									<label><font color="red">*</font>用户名：</label>
									<input type="text" name="userName" class="form-control" />
									<span>请输入您的用户名，字母、数字或者英文符号</span>
								</li>
								<li>
									<label><font color="red">*</font>密码：</label>
									<input type="password" name="password" class="form-control" />
									<span>字母、数字或者英文符号，最短6位，区分大小写</span>
								</li>
								<li>
									<label><font color="red">*</font>确认密码：</label>
									<input type="password" id="passwordSecond" name="passwordSecond" class="form-control" />
									<span>请再次输入密码</span>
								</li>
								<li class="reg_liBg">
									<label><font color="red">*</font>真实姓名：</label>
									<input type="text" name="nickName" class="form-control" />
									<span>请输入您的真实姓名</span>
								</li>
								<li class="reg_liBg">
									<label><font color="red">*</font>身份证号码：</label>
									<input type="text" name="cardNo" class="form-control" />
									<span>请输入您的身份证号码</span>
								</li>
								<li class="reg_liBg">
									<label><font color="red">*</font>联系电话：</label>
									<input type="text" name="mobile" class="form-control" />
									<span>请输入您的联系电话</span>
								</li>
								<li class="reg_liBg" id="personpositionLi">
									<label><font color="red">*</font>帮扶类别：</label>
									<select id="personposition" name="personposition" class="form-control" ></select>
									<span>请输入您的帮扶类别</span>
								</li>
								<li>
									<label><font color="red">*</font>工作单位：</label>
									<input type="text" name="workUnit" class="form-control" />
									<span>请输入您的工作单位</span>
								</li>
								<li>
									<label><font color="red">*</font>职务：</label>
									<input type="text" name="position" class="form-control" />
									<span>请输入您的职务</span>
								</li>
								<li>
									<label>邮箱：</label>
									<input type="text" name="email" class="form-control" />
									<span>请输入您的邮箱</span>
								</li>
								<li>
									<label>QQ：</label>
									<input type="text" name="QQ" class="form-control" />
									<span>请输入您的QQ号码</span>
								</li>
								<li>
									<label>微信：</label>
									<input type="text" name="weixin" class="form-control" />
									<span>请输入您的微信号码</span>
								</li>
								
							</ul>
							<div class="reg_btn">
								<button type="button" class="btn btn-success" onclick="submitForm();">注册</button>
							</div>
							
							
							</form>
						</div>
					</div>
					<!-- <div class="tab-pane" id="reg2">
						22
					</div>
					<div class="tab-pane" id="reg3">
						33
					</div>
					<div class="tab-pane" id="reg4">
						44
					</div> -->
				</div>
			
			
			</div>
			
			
			
		</div>
		
	</div>
	<!-- 主体 end -->
	<div class="footer">
		建设单位：三亚市农业局；技术支持单位：三亚市信投公司
	</div>
</div>	
<div class="dn" id="validate-tip"> 
	<div class="tooltip fade top in tooltip-div" role="tooltip">
		<div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>
		<div class="tooltip-inner tooltip-inner-me"></div>
	</div>
</div>		
	
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
    
    <script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	
	
	
<script type="text/javascript">
var type=${type};
$(function(){
	
	$("#formId").validate({
		
		errorPlacement: function(error, element) {
			/* var ddd = element.next("div");
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
			} */
			var ddd = element.next("span");
			ddd.find("i").remove();
			ddd.append('<i class="reg_error"></i>');
		},
		success: function(label, element) {
			/* var dd = $(element).next("div");
			dd.hide(); */
			var ddd = $(element).next("span");
			ddd.find("i").remove();
			ddd.append('<i class="reg_ok"></i>');
		},
		
		rules : {
			userName : {
				required: true
			},
			password : {
				required: true,
				minlength:6,
				stringCheck:true
			},
			passwordSecond:{
				required: true,
				stringCheck:true,
				equalToPassword:true
			},
			nickName:{
				required: true
			},
			cardNo:{
				required: true,
				idCard:true
			},
			mobile:{
				required: true,
				tm:true
			},
			personposition:{
				required: true
			},
			workUnit:{
				required: true
			},
			position:{
				required: true
			},
			email:{
				mail:true
			},
			QQ:{
				QQ:true
			},
			weixin:{
				weixin:true
			}
		}
		
	});
	
	
	
	
	
	
	
	$.get("${basePath }/common/codeList?type=userType",function(data){
		var html='';
		for(var i=0; i<data.length; i++){
			if(type==1){
				if(data[i].code==1){
					html+='<li><a href="#reg1" data-toggle="tab" onclick="regClick('+data[i].code+');">'+data[i].name+'</a></li>';
				}
			}else if(type==2){
				if(data[i].code==2||data[i].code==3||data[i].code==4||data[i].code==5||data[i].code==6){
					html+='<li><a href="#reg1" data-toggle="tab" onclick="regClick('+data[i].code+');">'+data[i].name+'</a></li>';
				}
			}else{
				if(data[i].code==5||data[i].code==7){
					html+='<li><a href="#reg1" data-toggle="tab" onclick="regClick('+data[i].code+');">'+data[i].name+'</a></li>';
				}
			}
		}
		$(".nav.nav-pills").html(html);
		$(".nav.nav-pills>li:first").attr("class","active");
	},"JSON");
	
	
	if(type==1){
		$("#userType").val(1);
		$("#personpositionLi").hide();
	}else if(type==2){
		$("#userType").val(2);
		$("#personpositionLi").hide();
	}else{
		$("#userType").val(5);
		$("#personpositionLi").show();
	}
	
	$.get("${basePath }/common/codeList?type=personposition",function(data){
		var html = '<option value="">全部</option>';
		for(var i=0; i<data.length; i++){
			html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
		}
		$('#personposition').html(html);
	},"JSON");
	
	$(document).on("click",".nav.nav-pills>li",function(){
		$(".nav.nav-pills>li").removeClass("active");
		$(this).addClass("active");
	});
	$(document).on("blur","input[name='cardNo']",function(){
		var obj=$(this);
		$.ajax({  
	        type : "post",  
	        url : "${basePath }/checkCardNo",  
	        data : {cardNo:obj.val()},
	        dataType:"JSON",
	        success : function(data){  
	        	var result= data.success;
	        	if(result==false){
	        		alert("该身份证号已经注册！");
	        		obj.next("span").find("i").remove();
	        		obj.next("span").append('<i class="reg_error"></i>');
	        	}else{
	        		obj.next("span").find("i").remove();
	        		obj.next("span").append('<i class="reg_ok"></i>');
	        	}
	        }  
	   });
	});
});
function regClick(code){
	$("#formId .form-control").val('');
	$("#formId .form-control").next("span").find("i").remove();
	$("#userType").val(code);
	if(code==5){
		$("#personpositionLi").show();
	}else{
		$("#personpositionLi").hide();
	}
}
function submitForm(){
	 if(!$("#formId").valid()){
		return false;
	} 
	 var flag=true;
	 $.ajax({  
	        type : "post",  
	        url : "${basePath }/checkCardNo",  
	        data : {cardNo:$("input[name='cardNo']").val()},
	        dataType:"JSON",
	        async:false,
	        success : function(data){  
	        	var result= data.success;
	        	if(result==false){
	        		alert("该身份证号已经注册！");
	        		$("input[name='cardNo']").next("span").find("i").remove();
	        		$("input[name='cardNo']").next("span").append('<i class="reg_error"></i>');
	        		flag=false;
	        	}else{
	        		$("input[name='cardNo']").next("span").find("i").remove();
	        		$("input[name='cardNo']").next("span").append('<i class="reg_ok"></i>');
	        	}
	        }  
	   });
	 if(flag==false){
		 return false;
	 }
	$.ajax({  
        type : "post",  
        url : "${basePath }/saveRegister",  
        data : $("#formId").serialize(),
        dataType:"JSON",
        async:false,
        success : function(data){  
      	  alert("注册成功");
      	  $("#formId .form-control").val('');
      	  $("#formId .form-control").next("span").find("i").remove();
        }  
   });
}
</script>
</body>
</html>