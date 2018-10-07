<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" />
</head>
<body>
<div class="container">

	<form class="form-horizontal" role="form">
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label> 
			<div class="col-sm-10">
				<input type="text" class="form-control" id="firstname" 
				   	placeholder="请输入名字">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label> 
			<div class="col-sm-5">
				<input type="text" class="form-control" id="firstname" 
				   	placeholder="请输入名字">
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label> 
			<div class="input-append date form_datetime">
			    <input class="span2" size="16" type="text" value="" readonly>
			    <span class="add-on"><i class="icon-remove"></i></span>
			    <span class="add-on"><i class="icon-th"></i></span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label> 
			<div class="col-sm-3">
				<select class="form-control">
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label>
			<div class="col-sm-3">
				<label class="checkbox-inline">
				    <input type="checkbox" value="">选项 2
				  </label>
				  <label class="checkbox-inline">
				    <input type="checkbox" value="">选项 2
				  </label>
				  <label class="checkbox-inline">
				    <input type="checkbox" value="">选项 2
				  </label>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label>
			<div class="col-sm-3">
				<label class="radio-inline">
				    <input type="radio" name="radios" value="">选项 2
				  </label>
				  <label class="radio-inline">
				    <input type="radio" name="radios" value="">选项 2
				  </label>
				  <label class="radio-inline">
				    <input type="radio" name="radios" value="">选项 2
				  </label>
			</div>
		</div>
		<div class="form-group">
			<!-- <p class="help-block">这里是块级帮助文本的实例。</p> -->
		</div>
		<div class="checkbox">
			<label> <input type="checkbox">请打勾
			</label>
		</div>
		<button type="submit" class="btn btn-default">提交</button>
	</form>





</div>
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script type="text/javascript">
	$(function(){
		/* $('#datetimepicker').datetimepicker({
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			pickDate: true,
	        pickTime: false
		    
		}); */
		
		$(".form_datetime").datetimepicker({
			minView: "month",//选择日期后，不会再跳转去选择时分秒
			language:  'zh-CN',
			//startView : 3,
	        autoclose: true,//选择日期后自动关闭
	        todayBtn: true,
	        //pickerPosition: "bottom-left",
	        pickDate: true,
	        pickTime: false,
	        format: 'yyyy-mm-dd'
	    });
		
	});
		
	</script>
</body>
</html>