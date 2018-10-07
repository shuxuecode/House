$(function(){
	$("#showForm4").validate({
		
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
			name : {
				required: true,
				minlength:1,
		        maxlength:20
			},
			institutionName : {
				required: true,
				minlength:1,
		        maxlength:50
			},
			postCode : {
				required: true
			},
			telNo : {
				// required: true,
				tm:true
			},
			helpStartTime : {
				required: true
			},
			helpEndTime : {
				required: true
			},
			helpTypeCode : {
				required: true
			},
			personposition : {
				required: true
//			},
//			x : {
//				required: true
			}
		}
		
	});
})
$(function(){
	
	var tableColumn = new Array();
	tableColumn.push({
		field: 'name',
		title: '姓名',
		align: 'center',
		valign: 'middle'
	});
	tableColumn.push({
		field: 'personpositionValue',
		title: '类别',
		align: 'center',
		valign: 'middle'
	});
	tableColumn.push({
		field: 'institutionName',
		title: '工作单位',
		align: 'center',
		valign: 'middle'
	});
	tableColumn.push({
		field: 'postCode',
		title: '职务',
		width : 300,
		align: 'center',
		valign: 'middle'
	});
	if(roleType == 5){
		tableColumn.push({
			field: 'telNo',
			title: '联系电话',
			align: 'center',
			valign: 'middle'
		});
	}
	/*tableColumn.push({
		field: 'helpStartTime',
		title: '帮扶开始时间',
		align: 'center',
		formatter:function(value){
			return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd hh:mm:ss');
		}
	});
	tableColumn.push({
		field: 'helpEndTime',
		title: '帮扶结束时间',
		align: 'center',
		formatter:function(value){
			return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd hh:mm:ss');
		}
	});
	tableColumn.push({
		field: 'helpTypeCodeValue',
		title: '帮扶方式',
		align: 'center'
	});*/
	tableColumn.push({
		title: '操作',
		width : 200,
		align: 'center',
		valign: 'middle',
		formatter: function(value,row,index){
			var btnHtml = '';
			if(btn_8107){
				btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showModel4(\"update\","+row.id+","+row.helpPersonId+","+row.familyNo+");'>编辑</button>&nbsp;";
			}
			if(btn_8123){
				btnHtml+="<button class='btn btn-sm btn-primary' onclick='javascript:deleteById4("+row.id+");'>删除</button>&nbsp;";
			}
			btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showModel4(\"query\","+row.id+","+row.helpPersonId+");'>查看详情</button>";
			return btnHtml;
		}
	});
	
	$('#table4').bootstrapTable({
		url: basepath + "/pahp/paHelpPersonList",
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
	            name:$("#name4").val(),
	            personposition:$("#personposition4").val(),
	            institutionName:$("#institutionName4").val(),
	            postCode:$("#postCode4").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: tableColumn
	});
	
	
	$("#search4").click(function(){
//		$('#table4').bootstrapTable("refresh",{query: {offset:0}});
		$('#table4').bootstrapTable("refresh");
	});
	loadSelectDiv4();
	 
});

function loadSelectDiv4(){
	$.get(basepath+"/common/codeList?type=personposition",function(data){
		var html = '<option value="">全部</option>';
		for(var i=0; i<data.length; i++){
			html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
		}
		$('#personposition4').html(html);
	},"JSON");
}
function showModel4(flag,id, hpId, thisFamilyNo){
	if(flag=='insert'){
		$.get(basepath+"/pahp/paHelpPersonInfo",function(data){
			var objArry=data.data;
			var html = '<input type="hidden" name="familyNo" value="'+familyNo+'"><input type="hidden" name="id" id="idModel">';
			for(var i=0; i<objArry.length; i++){
//				if(objArry[i].colENName == 'institutionName' || objArry[i].colENName == 'telNo' || 
//						objArry[i].colENName == 'helpStartTime' || objArry[i].colENName == 'helpEndTime' || objArry[i].colENName == 'helpTypeCode' ){
//					continue;
//				}
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
				if(objArry[i].dataInputType=="text"){
					html +='<input type="text" class="form-control" style="width:250px;" id="'+objArry[i].colENName+'Model" name="'+objArry[i].colENName+'" />';
				}else if(objArry[i].dataInputType=="select"){
					html+= '<select class="form-control" style="width:250px;" id="'+objArry[i].colENName+'Model" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
					if(objArry[i].colENName=="gender"){
						html += '<option value="' + '0' + '">' + '女' + '</option>';
						html += '<option value="' + '1' + '">' + '男' + '</option>';
					}else{
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objArry[i].colENName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  for(var i=0; i<data.length; i++){
										html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
									} 
					          }  
					     });
					}
					html+='</select>';
				}else if(objArry[i].dataInputType=="textArea"){
					html +='<input type="textArea" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"></input>';
				}else if(objArry[i].dataInputType=="radio"){
					html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
					html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
					 
				}else if(objArry[i].dataInputType=="date"){
					html+='<input id="'+objArry[i].colENName+'"  name="'+objArry[i].colENName+'" class="form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})"/>';
				}else if(objArry[i].dataInputType=="checkbox"){
					var objEnName=objArry[i].colENName;
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objEnName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:250px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  if(i==0){
					        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>'; 
					        		  }else{
					        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>'; 
					        		  }
										
									} 
					        	  html+='</div>';
					          }  
					     });
				}else{
					html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
				}
				html+='</div>';
			}
			
//			TODO
//			html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">帮扶内容</span>';
//			html += '<input type="text" class="form-control" style="width:660px;height:80px;" id="" name="x" />';
//			html += '</div>';
			
			html+='<span class="btn btn-primary fr" onclick="submitForm4();">保存</span>';
			$("#showForm4").html(html);
			$("#myModalLabel4").html("添加");
			$('#myModal4').modal();
			
			
			$("#nameModel").attr("autocomplete","off");
			$("#nameModel").autocomplete("/pahp/query.do", {
		        minChars: 0,
		        delay:10,
		        width: 250,
		        height: 200,
		        matchContains: false,
		        autoFill: false,
		        multiple: true,
		        multipleSeparator: ",",
		        // 多选时候的分隔符 默认为“，”
		        dataType: "json",
		        scroll: true,
		        // 返回的结果集为JSON数据
		        parse: function (data) {
		            return $.map(data.data, function (row) {
		                return {
		                    data: row,
		                    value: row.name,
		                    result: row.name
		                };
		            });
		        },
		        formatItem: function (row, i, max) {
		            // 显示下拉列表的内容
		            return "<span>"+row.name+"</span>"+"<span style='float:right;'>"+(row.personpositionValue==null?"":row.personpositionValue)+"</span>";
		        },
		        formatResult: function (row) {
		            return row.name;
		        }
		    }).result(function (e, item) {
		        // 将结果同时输入到
		    	$("#idModel").val(item.id);
		        $("#nameModel").val(item.name);
		        $("#personpositionModel").val(item.personposition);
		        $("#personpositionModel").attr("disabled","disabled");
		        $("#institutionNameModel").val(item.institutionName);
		        $("#postCodeModel").val(item.postCode);
		        $("#telNoModel").val(item.telNo);
		    });
			
			$("#helpStartTime").attr("onFocus", "var helpEndTime=$dp.$('helpEndTime');WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',onpicked:function(){helpEndTime.focus();},maxDate:'#F{$dp.$D(\\'helpEndTime\\')}'})");
			$("#helpEndTime").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'helpStartTime\\')}',dateFmt:\'yyyy-MM-dd HH:mm:ss\'})");
		},"JSON");
	}else if(flag=="update"){
		$.get(basepath+"/pahp/paHelpPersonInfo?id="+id+"&hpId="+hpId,function(data){
			var objArry=data.data;
			var html = '<input type="hidden" name="familyNo" value="'+thisFamilyNo+'"><input type="hidden" name="id" id="idModel" value="'+hpId+'">';
			for(var i=0; i<objArry.length; i++){
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
				if(objArry[i].dataInputType=="text"){
					html +='<input type="text" class="form-control" style="width:250px;" id="'+objArry[i].colENName+'Model" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null?"":objArry[i].value)+'"/>';
				}else if(objArry[i].dataInputType=="select"){
					html+= '<select class="form-control" style="width:250px;" id="'+objArry[i].colENName+'Model" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
					if(objArry[i].colENName=="gender"){
						if(objArry[i].value=='女'){
							html += '<option value="' + '0' + '" selected = "selected">' + '女' + '</option>';
							html += '<option value="' + '1' + '">' + '男' + '</option>';
						}else{
							html += '<option value="' + '0' + '">' + '女' + '</option>';
							html += '<option value="' + '1' + '" selected = "selected">' + '男' + '</option>';
						}
						
					}else{
						var objVal=objArry[i].value;
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objArry[i].colENName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  for(var i=0; i<data.length; i++){
					        		  if(objVal==data[i].name){
					        			  html += '<option value="' + data[i].code + '" selected = "selected">' + data[i].name + '</option>'; 
					        		  }else{
					        			  html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
					        		  }
									} 
					          }  
					     });
					}
					html+='</select>';
				}else if(objArry[i].dataInputType=="textArea"){
					html +='<input type="textArea" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'"></input>';
				}else if(objArry[i].dataInputType=="radio"){
					var objEnName=objArry[i].colENName;
					var val=objArry[i].value;
					if(objEnName=="mainPoorCauseCode"){
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:"poorCauseCode"},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:760px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  if(val.trim()==data[i].name.trim()){
					        			  html += '<input type="radio" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name;
					        		  }else{
					        			  html += '<input type="radio" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name;
					        		  }
										
									} 
					        	  html+='</div>';
					          }  
					     });
					}else{
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objEnName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:760px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  if(val.trim()==data[i].name.trim()){
					        			  html += '<input type="radio" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name;
					        		  }else{
					        			  html += '<input type="radio" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name;
					        		  }
										
									} 
					        	  html+='</div>';
					          }  
					     });
					}
					 
				}else if(objArry[i].dataInputType=="date"){
					html+='<input id="'+objArry[i].colENName+'" name="'+objArry[i].colENName+'" class="form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})" value="'+(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format('yyyy-MM-dd hh:mm:ss'))+'"/>';
				}else if(objArry[i].dataInputType=="checkbox"){
					var objEnName=objArry[i].colENName;
					var val=objArry[i].value;
					var valArr=val.split(",");
					if(objEnName=="secondaryPoorCauseCode"){
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:"poorCauseCode"},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:760px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  var flag=true;
					        		  for(var j=0;j<valArr.length;j++){
					        			  if(valArr[j].trim()==data[i].name.trim()){
					        				  flag=false;
						        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>';
					        			  }
					        		  }
					        		  if(flag){
					        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>';
					        		  }
					        		 
									} 
					        	  html+='</div>';
					          }  
					     });
					}else{
						$.ajax({  
					          type : "post",  
					          url : basepath+"/common/codeList",  
					          data : {type:objEnName},
					          dataType:"JSON",
					          async : false,  
					          success : function(data){  
					        	  html+='<div class="form-control" style="width:250px;">';
					        	  for(var i=0; i<data.length; i++){
					        		  var flag=true;
					        		  for(var j=0;j<valArr.length;j++){
					        			  if(valArr[j].trim()==data[i].name.trim()){
					        				  flag=false;
						        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>';
					        			  }
					        		  }
					        		  if(flag){
					        			  html += '<label class="checkbox-inline"><input type="checkbox" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>';
					        		  }
					        		 
									} 
					        	  html+='</div>';
					          }  
					     });
					}
				}else{
					html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
				}
				html+='</div>';
			}
			html+='<span class="btn btn-primary fr" onclick="submitForm4();">保存</span>';
			$("#showForm4").html(html);
			$("#myModalLabel4").html("编辑");
			$('#myModal4').modal();
			
			$("#nameModel").attr("autocomplete","off");
			$("#nameModel").autocomplete("/pahp/query.do", {
		        minChars: 0,
		        delay:10,
		        width: 250,
		        height: 200,
		        matchContains: false,
		        autoFill: false,
		        multiple: true,
		        multipleSeparator: ",",
		        // 多选时候的分隔符 默认为“，”
		        dataType: "json",
		        scroll: true,
		        // 返回的结果集为JSON数据
		        parse: function (data) {
		            return $.map(data.data, function (row) {
		                return {
		                    data: row,
		                    value: row.name,
		                    result: row.name
		                };
		            });
		        },
		        formatItem: function (row, i, max) {
		            // 显示下拉列表的内容
		            return "<span>"+row.name+"</span>"+"<span style='float:right;'>"+(row.personpositionValue==null?"":row.personpositionValue)+"</span>";
		        },
		        formatResult: function (row) {
		            return row.name;
		        }
		    }).result(function (e, item) {
		        // 将结果同时输入到
		    	$("#idModel").val(item.id);
		        $("#nameModel").val(item.name);
		        $("#personpositionModel").val(item.personposition);
		        $("#personpositionModel").attr("disabled","disabled");
		        $("#institutionNameModel").val(item.institutionName);
		        $("#postCodeModel").val(item.postCode);
		        $("#telNoModel").val(item.telNo);
		        
		        
		    });
			$("#helpStartTime").attr("onFocus", "var helpEndTime=$dp.$('helpEndTime');WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',onpicked:function(){helpEndTime.focus();},maxDate:'#F{$dp.$D(\\'helpEndTime\\')}'})");
			$("#helpEndTime").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'helpStartTime\\')}',dateFmt:\'yyyy-MM-dd HH:mm:ss\'})");
		},"JSON");
	}else{
		$.get(basepath+"/pahp/paHelpPersonInfo?id="+id+"&hpId="+hpId,function(data){
			var objArry=data.data;
			var html = '';
			for(var i=0; i<objArry.length; i++){
				if(objArry[i].dataInputType=='date'){
					var dateValue=(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format('yyyy-MM-dd hh:mm:ss'));
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+dateValue+'</span></div>';
				}else{
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'</span></div>';
				}
				
			}
			$("#showForm4").html(html);
			$("#myModalLabel4").html("查看详情");
			$('#myModal4').modal();
		},"JSON");
	}
	
}

function submitForm4(){
	if(!$("#showForm4").valid()){
		return false;
	}
	$("#myModal4").modal('hide');
	$.ajax({  
        type : "post",  
        url : basepath+"/pahp/checkPaHelpPersonInfo",  
        data : $("#showForm4").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  if(data.success==true){
      		$.ajax({  
                type : "post",  
                url : basepath+"/pahp/savePaHelpPersonInfo",  
//                url : basepath+"/pahp/saveX",  
                data : $("#showForm4").serialize(),
                dataType:"JSON",
                success : function(data){  
              	  alert("保存成功");
//              	  toastr.success("成功")
//              	  $('#table4').bootstrapTable("refresh",{query: {offset:0}});
              	  $('#table4').bootstrapTable("refresh");
              	  
              	  //
//              	  setTimeout("showModel4('insert')", 1500);
                }  
           });
      	  }else{
      		 // alert("此类别已有该姓名，请重新填写！"); 
      		  alert("该责任人已存在该帮扶家庭列表中，请重新填写！");
      	  }
      	  
        }  
   });
}
function deleteById4(id){
	if(confirm("确认删除？")){
		$.ajax({  
	          type : "post",  
	          url : basepath+"/pahp/deleteById",  
	          data : {id:id},
	          dataType:"JSON",
	          success : function(data){  
	        	  $('#table4').bootstrapTable("refresh");
	          }  
	     });
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