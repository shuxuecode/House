$(function(){
	$("#showForm99").validate({
		
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
			startTime : {
				required: true
			},
//			endTime : {
//				required: true
//			},
			content : {
				required: true,
				xmltab:true,
				maxlength:1000
			}
		}
		
	});
})
$(function(){
	
	var tableColumn = new Array();
	tableColumn.push({
		field: 'startTime',
		title: '时间',
		width: 110,
		align: 'center',
		valign: 'middle',
		formatter:function(value){
			return value==null?"-":new Date(value).Format("yyyy-MM-dd");
		}
	});
	tableColumn.push({
		field: 'content',
		title: '成效内容',
		align: 'center',
		valign: 'middle',
		formatter: function(value, row, index){
			if(value==null){
				return "-";
			}else{
				var dots='';
				if(value.length>90){
					dots='...';
				}
				return "<span  data-toggle='tooltip' title='"+value+"'>"+(value==null?"-":(value.substring(0,90)+dots))+"</span>";
			}
		}
	});
	tableColumn.push({
		title: '操作',
		align: 'center',
		valign: 'middle',
		width:200,
		formatter: function(value,row,index){
			var btnHtml = '';
			if(btn_8120){
				btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate9("+JSON.stringify(row)+");'>编辑</button>&nbsp;";
			}
			if(btn_8121){
				btnHtml+="<button class='btn btn-sm btn-primary' onclick='javascript:deleteById9("+row.id+");'>删除</button>&nbsp;";
			}
			btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showQuery9("+JSON.stringify(row)+");'>查看详情</button>";
			return btnHtml;
		}
	});
	
	$('#table9').bootstrapTable({
		url: basepath + "/psde/paSelfDevelopmentEffectList",
		cache: false,
		pagination: true,
		pageList: [10,20],
		pageSize:10,
		pageNumber:1,
		sidePagination:'server',//设置为服务器端分页
		queryParams: function (params) {
			
	        return {
	            pageSize: params.limit,
	            offset: params.offset,
	            sortOrder: params.order,
	            familyNo: familyNo,
	            startTime:$("#startTime9").val(),
	            endTime:$("#endTime9").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: tableColumn
	});
	
	
	$("#search9").click(function(){
		$('#table9').bootstrapTable("refresh");
	});
	 
});
function deleteById9(id){
	if(confirm("确认删除？")){
		$.ajax({  
	          type : "post",  
	          url : basepath+"/psde/deleteById",  
	          data : {id:id},
	          dataType:"JSON",
	          success : function(data){  
	        	  $('#table9').bootstrapTable("refresh");
	          }  
	     });
	}
}
function showInsert9(){
	var html='';
	html+='<input type="hidden" name="id" id="id99"><input type="hidden" name="familyNo" id="familyNo99">';
	html+='<div class="input-group input-group-me" ><span class="input-group-addon" style="width:150px;">时间</span><input id="startTime99" name="startTime" class="Wdate form-control" type="text" value="" /></div>';
//	html+='<div class="input-group input-group-me" ><span class="input-group-addon" style="width:150px;">结束时间</span><input id="endTime99" name="endTime" class="Wdate form-control" type="text" value="" /></div>';	
	html+='<div class="input-group" ><span class="input-group-addon" style="width:150px;">成效内容</span><textarea rows=5 class="form-control" cols=95 name="content" id="content99"></textarea></div>';
	html+='<span class="btn btn-primary fr" onclick="submitForm99();">保存</span>';
	$("#showForm99").html(html);
	
	$("#startTime99").attr("onFocus", "WdatePicker({dateFmt:\'yyyy-MM-dd\',onpicked:function(){},maxDate:'%y-%M-%d'})");
//	$("#startTime99").attr("onFocus", "var endTime99=$dp.$('endTime99');WdatePicker({dateFmt:\'yyyy-MM-dd\',onpicked:function(){endTime99.focus();},maxDate:'#F{$dp.$D(\\'endTime99\\')}'})");
//	$("#endTime99").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'startTime99\\')}',dateFmt:\'yyyy-MM-dd\'})");
		
	$("#familyNo99").val(familyNo);
	$("#startTime99").val("");
//	$("#endTime99").val("");
	$("#content99").text("");
	$("#myModalLabel99").html("添加");
	$('#myModal99').modal();
}
function showUpdate9(jsonrow){
	var html='';
	html+='<input type="hidden" name="id" id="id99"><input type="hidden" name="familyNo" id="familyNo99">';
	html+='<div class="input-group input-group-me" ><span class="input-group-addon" style="width:150px;">时间</span><input id="startTime99" name="startTime" class="Wdate form-control" type="text" value="" /></div>';
//	html+='<div class="input-group input-group-me" ><span class="input-group-addon" style="width:150px;">结束时间</span><input id="endTime99" name="endTime" class="Wdate form-control" type="text" value="" /></div>';	
	html+='<div class="input-group" ><span class="input-group-addon" style="width:150px;">成效内容</span><textarea rows=5 class="form-control" cols=95 name="content" id="content99"></textarea></div>';
	html+='<span class="btn btn-primary fr" onclick="submitForm99();">保存</span>';
	$("#showForm99").html(html);
	
	$("#startTime99").attr("onFocus", "WdatePicker({dateFmt:\'yyyy-MM-dd\',onpicked:function(){},maxDate:'%y-%M-%d'})");
//	$("#startTime99").attr("onFocus", "var endTime99=$dp.$('endTime99');WdatePicker({dateFmt:\'yyyy-MM-dd\',onpicked:function(){endTime99.focus();},maxDate:'#F{$dp.$D(\\'endTime99\\')}'})");
//	$("#endTime99").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'startTime99\\')}',dateFmt:\'yyyy-MM-dd\'})");
	
	$("#id99").val(jsonrow.id);
	$("#familyNo99").val(familyNo);
	$("#startTime99").val(formatNull((jsonrow.startTime==undefined?"-":(new Date(jsonrow.startTime)).Format('yyyy-MM-dd'))));
//	$("#endTime99").val(formatNull((jsonrow.endTime==undefined?"-":(new Date(jsonrow.endTime)).Format('yyyy-MM-dd'))));
	$("#content99").text(formatNull(jsonrow.content));
	$("#myModalLabel99").html("编辑");
	$('#myModal99').modal();
}
function showQuery9(jsonrow){
	
	var html = '';
	html += '<div class="input-group input-group-me"><span class="input-group-addon" style="width:150px;">时间</span><span class="form-control">'+formatNull((jsonrow.startTime==undefined?"-":(new Date(jsonrow.startTime)).Format('yyyy-MM-dd')))+'</span></div>';
//	html += '<div class="input-group input-group-me"><span class="input-group-addon" style="width:150px;">结束时间</span><span class="form-control">'+formatNull((jsonrow.endTime==undefined?"-":(new Date(jsonrow.endTime)).Format('yyyy-MM-dd')))+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">成效内容</span><textarea rows=5 disabled="disabled" class="form-control" cols=95>'+formatNull(jsonrow.content)+'</textarea></div>';
	$("#showForm99").html(html);
	$("#myModalLabel99").html("查看详情");
	$('#myModal99').modal();
}

function submitForm99(){
	if(!$("#showForm99").valid()){
		return false;
	}
	$("#myModal99").modal('hide');
	$.ajax({  
        type : "post",  
        url : basepath+"/psde/saveSelfDevelopmentEffect",  
        data : $("#showForm99").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
      	  $('#table9').bootstrapTable("refresh");
      	  
        }  
   });
}

function formatNull(value){
	if(value==null){
		return "-";
	}else{
		return value;
	}
}
//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.Format = function(fmt)   
{ //author: meizz   
var o = {   
"M+" : this.getMonth()+1,                 //月份   
"d+" : this.getDate(),                    //日   
"h+" : this.getHours(),                   //小时   
"m+" : this.getMinutes(),                 //分   
"s+" : this.getSeconds(),                 //秒   
"q+" : Math.floor((this.getMonth()+3)/3), //季度   
"S"  : this.getMilliseconds()             //毫秒   
};   
if(/(y+)/.test(fmt))   
fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
for(var k in o)   
if(new RegExp("("+ k +")").test(fmt))   
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
return fmt;   
}