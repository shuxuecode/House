<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>统计分析</title>
<link rel="stylesheet" type="text/css"
	href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<style>
.viewRe_ul {
	overflow: hidden;
	margin-top: 20px;
}

.viewRe_ul>li {
	float: left;
	width: 48%;
}

.viewRe_ul>li:nth-child(2n) {
	float: right;
}

.viewRe_ul>li em {
	display: block;
	height: 49px;
	font: 400 12px/50px "microsoft yahei";
	background: #f7f8fb;
	padding-left: 20px;
	border-top: 1px solid #E9E9E9;
}

.viewRe_ul>li {
	border: 1px solid #E0E0E0;
	margin-bottom: 20px;
}

.viewRe_tt {
	height: 49px;
	border-bottom: 1px solid #E0E0E0;
	background: #f7f8fb;
}

.viewRe_ul h2 {
	height: 49px;
	font: 400 14px/50px "microsoft yahei";
	border-bottom: 1px solid #E0E0E0;
	background: #f7f8fb;
	padding-left: 18px;
}
.ben_ttR{
	font: 400 12px/24px "microsoft yahei";
	margin: 10px 10px 0 0;
}
.ben_sle{
	width:100px;
}

.btn_group {
	text-align: center;
}
</style>
</head>

<body>
	<%@ include file="/WEB-INF/view/common/header.jsp"%>

	<div class="w1200">
		<ul class="viewRe_ul clearfix">
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">贫困状态统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g1btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g1btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g1btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g1btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g1btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<!-- <button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(1);">导出</button> -->
				</div>
				<div id="g1" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">贫困户类型统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g2btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g2btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g2btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g2btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g2btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(2);">导出</button>
				</div>
				<div id="g2" style="height: 310px;"></div>
			</li>
		</ul>
		<ul class="viewRe_ul clearfix">
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">致贫原因统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g3btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g3btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g3btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g3btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g3btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(3);">导出</button>
				</div>
				<div id="g3" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">帮扶政策类型统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g4btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g4btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g4btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g4btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g4btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<!-- <button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(4);">导出</button> -->
				</div>
				<div id="g4" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">健康状况统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g5btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g5btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g5btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g5btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g5btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(5);">导出</button>
				</div>
				<div id="g5" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">劳动能力统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g6btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g6btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g6btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g6btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g6btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(6);">导出</button>
				</div>
				<div id="g6" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">人均收入统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g7btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g7btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g7btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g7btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g7btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(7);">导出</button>
				</div>
				<div id="g7" style="height: 310px;"></div>
			</li>
			
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">年龄统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g8btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g8btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g8btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g8btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g8btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(8);">导出</button>
				</div>
				<div id="g8" style="height: 310px;"></div>
			</li>
			<li>
				<div class="viewRe_tt clearfix">
					<h2 class="fl">在校生情况统计图</h2>
				</div>
				<div class="btn_group">
					<button class="g9btn btn btn-default btn-sm btn-info">全市<input type="hidden" value=""></button>
					<button class="g9btn btn btn-default btn-sm">吉阳区<input type="hidden" value="1"></button>
					<button class="g9btn btn btn-default btn-sm">天涯区<input type="hidden" value="2"></button>
					<button class="g9btn btn btn-default btn-sm">崖州区<input type="hidden" value="3"></button>
					<button class="g9btn btn btn-default btn-sm">育才区<input type="hidden" value="4"></button>
					<button class="btn btn-default btn-sm btn-warning fr" onclick="exportData(9);">导出</button>
				</div>
				<div id="g9" style="height: 310px;"></div>
			</li>
		</ul>
	</div>
<form id="duibiForm" action="/exportDuibi" method="post" target="_blank">
	<input type="hidden" id="fileNameDuibi" name="fileName"></input>
</form>
	<%@ include file="/WEB-INF/view/common/footer.jsp"%>
	<script type="text/javascript"
		src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/echarts/echarts-all.js"></script>
	<script>
		$(function() {
			g1(null,"povertyState","贫困状态统计图","g1","pie");
			g11(null,"poorAttributeCode","贫困户类型统计图","g2","pie");
			g1(null,"mainPoorCauseCode","致贫原因统计图","g3","bar");
			g4(null,"projectTypeCode","帮扶政策类型统计图","g4","bar");
			//健康状况
			healthInfo(null,"healthInfo","健康状况统计图","g5","pie");
			//劳动能力
			workAbility(null,"workAbility","劳动能力统计图","g6","pie");
			//人均收入
			income(null,"income","人均收入统计图","g7","bar");
			//年龄
			age(null,"age","年龄统计图","g8","pie");
			//在校生情况
			collegeInfo(null,"collegeInfo","在校生情况统计图","g9","pie");
			
			$(".g1btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				g1($(this).find("input").val(),"povertyState","贫困状态统计图","g1","pie");
			});
			$(".g2btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				g11($(this).find("input").val(),"poorAttributeCode","贫困户类型统计图","g2","pie");
			});
			$(".g3btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				g1($(this).find("input").val(),"mainPoorCauseCode","致贫原因统计图","g3","bar");
			});
			$(".g4btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				g4($(this).find("input").val(),"projectTypeCode","帮扶政策类型统计图","g4","bar");
			});
			
			$(".g5btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				healthInfo($(this).find("input").val(),"healthInfo","健康状况统计图","g5","pie");
			});
			$(".g6btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				workAbility($(this).find("input").val(),"workAbility","劳动能力统计图","g6","pie");
			});
			$(".g7btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				income($(this).find("input").val(),"income","人均收入统计图","g7","bar");
			});
			$(".g8btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				age($(this).find("input").val(),"age","年龄统计图","g8","pie");
			});
			$(".g9btn").click(function(){
				$(this).siblings("button").removeClass("btn-info");
				$(this).addClass("btn-info");
				collegeInfo($(this).find("input").val(),"collegeInfo","在校生情况统计图","g9","pie");
			});
		});
		//通用的
		function g1(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/g1", 
		          data : {address1:address1,param:param},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//比较特殊的多选
		function g11(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/g11", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//比较特殊的多选
		function g4(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/g4", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//健康状况
		function healthInfo(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/healthInfo", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//劳动能力
		function workAbility(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/workAbility", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//人均收入
		function income(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/income", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//人均收入
		function age(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/age", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		//在校生情况
		function collegeInfo(address1,param,title,id,item){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/collegeInfo", 
		          data : {address1:address1},
		          dataType:"JSON",
		          
		          success : function(data){ 
		        	  if(item=="pie"){
		        		  createPie(title,id,data.data);
		        	  }else{
		        		  createBar(title,id,data.data);
		        	  }
		        	  
		          }  
		     });
		}
		function exportData(flag){
			$.ajax({  
		          type : "post",  
		          url : "${basePath }/analysis/exportXls", 
		          data : {flag:flag},
		          dataType:"JSON",
		          success : function(data){ 
		        	  $("#fileNameDuibi").val(data.data.fileName);
			    	  $("#duibiForm").submit(); 
		          }  
		     });
		}
		//饼图
		function createPie(title,id,data){
			var titleArr=new Array();
			var dataArr=new Array();
			for(var i=0;i<data.length;i++){
				dataArr.push(eval("({name: '"+data[i].name+"',value : '"+data[i].c+"'})"));
				titleArr.push(data[i].name);
			}
			var option = {
				    title : {
				        text: title,
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:titleArr
				    },
				    calculable : true,
				    series : [
				        {
				            name:'详细信息',
				            type:'pie',
				            radius : '55%',
				            center: ['50%', '60%'],
				            data:dataArr,
				            itemStyle: {
				                normal: {
				                    label: {
				                        show: true,
				                        formatter: '{b} {c}'
				                    }
				                }
				            }
				        }
				    ]
				};
			var myChart = echarts.init(document.getElementById(id));
			myChart.setOption(option);
		}
		
		//柱图
		function createBar(title,id,data){
			var titleArr=new Array();
			var dataArr=new Array();
			for(var i=0;i<data.length;i++){
				dataArr.push(data[i].c);
				titleArr.push(data[i].name);
			}
			var option = {
				    title: {
				        x: 'center',
				        text: title
				    },
				    tooltip: {
				        trigger: 'item'
				    },
				    calculable: true,
				    grid: {
				        borderWidth: 0,
				        y: 80,
				        y2: 60
				    },
				    xAxis: [
				        {
				            type: 'category',
				            show: true,
				            data: titleArr,
				            splitLine:{
				            	show:false
				            },
				            axisLabel:{  
		                        interval:0,  
		                        rotate:45,//倾斜度 -90 至 90 默认为0  
		                        margin:2,  
		                        textStyle:{  
		                            fontWeight:"bolder",  
		                            color:"#000000"  
		                        }  
		                    }
				        }
				    ],
				    yAxis: [
				        {
				            type: 'value',
				            show: false
				        }
				    ],
				    series: [
				        {
				            name: '详细信息',
				            type: 'bar',
				            itemStyle: {
				                normal: {
				                    color: function(params) {
				                        // build a color map as your need.
				                        var colorList = [
				                          '#C1232B','#B5C334','#4C4C4C','#E87C25','#27727B',
				                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0',
				                           '#C1232B','#B5C334','#4C4C4C','#E87C25','#27727B',
				                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD'
				                        ];
				                        return colorList[params.dataIndex]
				                    },
				                    label: {
				                        show: true,
				                        position: 'top',
				                        formatter: '{c}'
				                    }
				                }
				            },
				            data: dataArr
				        }
				    ]
				};
				                    
			var myChart = echarts.init(document.getElementById(id));
			myChart.setOption(option);
		}
	</script>
</body>
</html>
