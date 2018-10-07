<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrapValidator.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<script>
var basepath="${basepath}";
</script>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>

<div class="w1200 main">
	<div class="panel panel-default">
		
		<div class="tab-content tab-content-me">
			<div class="tab-pane fade in active" id="tab1">
					<div>
						<form role="form" id="form1">
						<div class="input-group">
								<span class="input-group-addon" style="width:120px">原始密码</span> 
								<input type="password" class="form-control" style="width:460px" name="oldPassword" id="oldPassword" placeholder="原始密码"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon" style="width:120px">新密码</span> 
								<input type="password" class="form-control" style="width:460px" name="password" id="password" placeholder="新密码"/>
							</div>
							<div class="input-group">
								<span class="input-group-addon" style="width:120px">确认新密码</span> 
								<input type="password" class="form-control" style="width:460px" name="password2" id="password2" placeholder="确认新密码"/>
							</div>
							<div class="input-group">
							    <span class="btn btn-primary" id="sumbitForm">保存</span>
							</div>
						</form>
					</div>
			</div>
			
		</div>
		<div style="clear:both;"></div>
	</div>
	
<!--  -->	
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
	
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/messages_zh.min.js"></script>
	<script type="text/javascript" src="/js/jquery-validate/jquery.validate.rules.js"></script>
	
<script>
	$(function(){
		$("#form1").validate({
			
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
				oldPassword : {
					required: true,
					stringCheck:true
				},
				password : {
					required: true,
					minlength:6,
					stringCheck:true,
					equalToOldPassword:true
				},
				password2:{
					required: true,
					stringCheck:true,
					equalToPassword:true
				}
			}
			
		});
		
		$("#sumbitForm").click(function(){
			if(!$("#form1").valid()){
				return false;
			}
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/user/checkOldPassword",  
		          data : $("#form1").serialize(),
		          dataType:"JSON",
		          success : function(data){ 
		        	  if(data.success==true){
		        		  $.ajax({  
			    	          type : "post",  
			    	          url : "${basePath }/user/savePassword",  
			    	          data : $("#form1").serialize(),
			    	          dataType:"JSON",
			    	          success : function(data){  
			    	        	  alert("保存成功");
			    	        	  $("#form1 .form-control").val('');
			    	          }  
			    	     });
		        	  }else{
		        		  alert("原始密码不正确，请重新输入！");
		        	  }
		        	  
		          }  
		     });
		});
	});
</script>	
</body>
</html>