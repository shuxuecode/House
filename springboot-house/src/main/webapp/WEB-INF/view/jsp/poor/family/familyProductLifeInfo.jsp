<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<style>
.my-item{
	width: 48%;
    float: left;
}
</style>
</head>
<body>
<div class="container2">

	





</div>





	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/template.js"></script>
	<script type="text/javascript">
		$(function(){
			
			loadData();
			
			
		});
		
		function loadData(){
			$.post("${basePath }/paInfo/familyProductLifeInfo",
					{familyNo : 1},
					function(data){
						console.log(data);
						var html = template('test', data);
						$(".container2").html(html);
			},"JSON");
		}
		
		

		template.helper('isRadio', function (type, value, yes, no) {
			if(type !== 'radio'){
				return value;
			}
			return value == 1 ? yes : no;
		});
	</script>
	
	
</body>
<script id="test" type="text/html">
<form class="bs-example bs-example-form" role="form">
{{each data as item i}}
	{{if item.isWrite == 0}}	
		<div class="input-group" style="width:100%">
			<span class="input-group-addon" style="font-size: 17px;">{{item.showName}}</span>
			{{if item.value}}
				<span class="form-control" style="">{{item.value}}</span>
			{{/if}}
		</div>
	{{else}}
		<div class="input-group my-item" style="padding-left: 15px;">
			<span class="input-group-addon" style="font-weight: 600; font-size: 15px;">
				{{item.showName}}
			</span>
			<span class="form-control" style="">
				{{isRadio item.dataInputType item.value '是' '否'}}
				{{item.indexUnit}}
			</span>
		</div>
	{{/if}}
{{/each}}
</form>
</script>
</html>