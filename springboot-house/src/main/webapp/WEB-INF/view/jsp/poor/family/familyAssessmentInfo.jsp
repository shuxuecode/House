<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<style type="text/css">
th, td{
	text-align: center; 
	vertical-align: middle; 
}
th{
	font-size: 15px;
}
</style>
</head>
<body>
	
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
	
	


	
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			loadData();
			
		});
		
		var zhao = '';
		
		function loadData(){
			$.post("${basePath }/paInfo/familyAssessmentInfo",
					{familyNo : 1},
					function(data){
						console.log(data);
						zhao = data;
						
						var years = data.data.year;
						var yearL = years.length;
						
						var html = '<tr>';
						html += '<th>统计项目</th>';
						html += '<th>单位</th>';
						for(var i=0; i<yearL; i++){
							html += '<th>' + years[i].year + '年</th>';
						}
						html += '</tr>';
						$("#th").html(html);
						
						
						
						html = '';
						var indexs = data.data.index;
						for(var i=0; i<indexs.length; i++){
							html += '<tr>';
							html += '<td>';
							html += '' + indexs[i].showName;
							html += '</td>';
							html += '<td>';
							html += '' + indexs[i].indexUnit;
							html += '</td>';
							
							for(var j=0; j<yearL; j++){
								html += '<td>';
								var key = years[j].year + '_' + indexs[i].indexCode;
								
								var value = data.data.object[key];
								if(value){
									html += value;
								}else{
									html += '';
								}
								html += '</td>';
							}
							
							html += '</tr>';
						}
						$("#tb").html(html);
						
						html = '';
						var main = data.data.main;
						for(var i=0; i<main.length; i++){
							html += '' + main[i].showName;
							html += '' + main[i].value;
						}
						// $('table').after(html);
			},"JSON");
		}
	</script>

</body>
</html>