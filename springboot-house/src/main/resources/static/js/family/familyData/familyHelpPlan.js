$(function(){
	$("#showForm5").validate({
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
			projectTypeCode : {
				required: true
			},
			startTime : {
				required: true
			},
			endTime : {
				required: true
			},
			institutionName : {
				required: true,
				minlength:1,
		        maxlength:50
			},
			supportMoney : {
				required: true,
				number:true
			},
			selfRaise : {
				required: true,
				number:true
			},
			helpContent : {
//				required: true,
				minlength:1,
		        maxlength:100
			},
			helpResult : {
//				required: true,
				minlength:1,
		        maxlength:100
			}
//			,
//			helpPersonId:{
//				required: true
//			}
		}
		
	});
	
	getTableData5();
	loadSelectDiv5();
})


function getTableData5(){
	/*$.get(basepath + "/pafhp/familyHelpPlanList?familyNo=1",function(data){
		var objArray=data.obj;
		var objColumns=new Array();
		for(var i=0;i<objArray.length;i++){
			objColumns.push(eval("({field:'"+objArray[i].colENName+"',title:'"+objArray[i].showName+"',align:'center'})"));
		}
		objColumns.push(eval("({title:'操作',align:'center',formatter: function(value,row,index){return \"<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate5(\"+row.id+\",\"+row.familyNo+\");'>编辑</button>&nbsp;<button class='btn btn-sm btn-primary' onclick='javascript:deleteById5(\"+row.id+\");'>删除</button>&nbsp;<button class='btn btn-sm btn-primary' onclick='javascript:showInfo5(\"+row.id+\");'>查看详情</button>\"}})"));
		loadGrid5(data.data,objColumns);
	},"JSON");*/
	
	
	$('#table5').bootstrapTable({
		url: basepath + "/pafhp/familyHelpPlanList",
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
	            projectTypeCode:$("#projectTypeCode5").val(),
	            institutionName:$("#institutionName5").val(),
	            helpContent:$("#helpContent5").val(),
	            helpResult:$("#helpResult5").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'projectTypeCode',
				title: '项目类型',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'startTime',
				title: '帮扶时间',
				align: 'center',
				valign: 'middle',
				width : 100,
				formatter:function(value){
					return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd');
				}
			}, 
//			{
//				field: 'endTime',
//				title: '结束时间',
//				align: 'center',
//				formatter:function(value){
//					return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd hh:mm:ss');
//				}
//			}, 
			{
				field: 'institutionName',
				title: '帮扶单位',
				align: 'center',
				valign: 'middle'
			},
//			{
//			field: 'supportMoney',
//			title: '扶持资金',
//			align: 'center'
//		},{
//			field: 'selfRaise',
//			title: '农户自筹',
//			align: 'center'
//		},
		{
			field: 'helpContent',
			title: '帮扶内容及成本',
			align: 'center',
			valign: 'middle'
//		},{
//			field: 'helpResult',
//			title: '帮扶成效',
//			align: 'center'
		},  {
				title: '操作',
				align: 'center',
				valign: 'middle',
				width : 200,
				formatter: function(value,row,index){
					var btnHtml = "";
					if(btn_8109){
						btnHtml += "<button class='btn btn-sm btn-primary "+dnClass+"' onclick='javascript:showUpdate5("+row.id+","+row.familyNo+");'>编辑</button>&nbsp;";
					}
					if(btn_8124){
						btnHtml+="<button class='btn btn-sm btn-primary' onclick='javascript:deleteById5("+row.id+");'>删除</button>&nbsp;";
					}
					btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showInfo5("+row.id+","+row.familyNo+");'>查看详情</button>";
					return btnHtml;
				}
			}]
		});
	$("#search5").click(function(){
//		$('#table5').bootstrapTable("refresh",{query: {offset:0}});
		$('#table5').bootstrapTable("refresh");
	});
	
}

function loadSelectDiv5(){
	$.get(basepath+"/common/codeList?type=projectTypeCode",function(data){
		var html = '<option value="">全部</option>';
		for(var i=0; i<data.length; i++){
			html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
		}
		$('#projectTypeCode5').html(html);
	},"JSON");
}
/*function loadGrid5(data,columns){
	$('#table5').bootstrapTable('destroy').bootstrapTable({
		cache: false,
		data:data,
		columns:columns 
	});
}*/
function showInsert5(){
	$.get(basepath+"/pafhp/familyHelpPlanInfo",function(data){
		var objArry=data.data;
		var html = '<input type="hidden" name="familyNo" value="'+familyNo+'">';
		for(var i=0; i<objArry.length; i++){
			html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
			if(objArry[i].dataInputType=="text"){
				html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" required data-bv-notempty-message="错啦"/>';
			}else if(objArry[i].dataInputType=="select"){
				html+= '<select class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
				if(objArry[i].colENName=="gender"){
					html += '<option value="' + '0' + '">' + '女' + '</option>';
					html += '<option value="' + '1' + '">' + '男' + '</option>';
				}else if(objArry[i].colENName=="helpPersonId"){
					$.ajax({  
				          type : "post",  
				          url : basepath+"/pahp/queryByParam",  
				          data : {familyNo:familyNo},
				          dataType:"JSON",
				          async : false,  
				          success : function(data){  
				        	  var data=data.data
				        	  for(var j=0; j<data.length; j++){
				        		  html += '<option value="' + data[j].id + '">' + '<span>'+data[j].name+'</span>&nbsp;&nbsp;&nbsp;'+'[&nbsp;<span style=\'float:right;\'>'+data[j].personpositionValue+'</span>&nbsp;]' + '</option>';
								} 
				          }  
				     });
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
				html +='<textArea  class="form-control" style="width:660px;" name="'+objArry[i].colENName+'"></textArea>';
			}else if(objArry[i].dataInputType=="radio"){
//				html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
//				html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
				
				var objEnName=objArry[i].colENName;
				$.ajax({  
			          type : "post",  
			          url : basepath+"/common/codeList",  
			          data : {type:objEnName},
			          dataType:"JSON",
			          async : false,  
			          success : function(data){  
			        	  html+='<div class="form-control" style="width:660px;height:50px;">';
			        	  for(var j=0; j<data.length; j++){
			        		  if(j==0){
			        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'" checked>'+data[j].name+'</label>'; 
			        		  }else{
			        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[j].code+'">'+data[j].name+'</label>'; 
			        		  }
								
							} 
			        	  html+='</div>';
			          }  
			     });
				 
			}else if(objArry[i].dataInputType=="date"){
				html+='<input id="'+objArry[i].colENName+'" name="'+objArry[i].colENName+'" class="Wdate form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd\',maxDate:\'%y-%M-%d\'})"/>';
			}else if(objArry[i].dataInputType=="checkbox"){
				var objEnName=objArry[i].colENName;
					$.ajax({  
				          type : "post",  
				          url : basepath+"/common/codeList",  
				          data : {type:objEnName},
				          dataType:"JSON",
				          async : false,  
				          success : function(data){  
				        	  html+='<div class="form-control" style="width:660px;height:50px;">';
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
		html+='<span class="btn btn-primary fr" onclick="submitForm5();">保存</span>';
		$("#showForm5").html(html);
		$("#myModalLabel5").html("添加");
		$('#myModal5').modal();
		
		// 添加长度的控制
		$("#showForm5 input[name='institutionName']").prop("maxlength", 50);
		$("#showForm5 input[name='helpContent']").prop("maxlength", 100);
		$("#showForm5 input[name='helpResult']").prop("maxlength", 100);
//		$("#startTime").attr("onFocus", "var endTime=$dp.$('endTime');WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',onpicked:function(){endTime.focus();},maxDate:'#F{$dp.$D(\\'endTime\\')}'})");
//		$("#endTime").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'startTime\\')}',dateFmt:\'yyyy-MM-dd HH:mm:ss\'})");
	},"JSON");

	
}
function showUpdate5(id,thisFamilyNo){
	$.get(basepath+"/pafhp/familyHelpPlanInfo?id="+id,function(data){
		var objArry=data.data;
		var html = '<input type="hidden" name="familyNo" value="'+thisFamilyNo+'"><input type="hidden" name="id" value="'+id+'">';
		html+='<div id="mediaDiv5" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
		html+='<div class="btn-group-vertical">'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia5(1,'+id+');">图片</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia5(2,'+id+');">音频</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia5(3,'+id+');">视频</span>';
		if(btn_8116){
			html+='<span class="btn btn-primary btn-sm fr" onclick="javascript:$(\'#media5\').click();">上传</span>';
		}
		html+='<input name="media" id="media5"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
		for(var i=0; i<objArry.length; i++){
			html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
			if(objArry[i].dataInputType=="text"){
				html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'"/>';
			}else if(objArry[i].dataInputType=="select"){
				html+= '<select class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"><option value="">未选择</option>';
				if(objArry[i].colENName=="gender"){
					if(objArry[i].value=='女'){
						html += '<option value="' + '0' + '" selected = "selected">' + '女' + '</option>';
						html += '<option value="' + '1' + '">' + '男' + '</option>';
					}else{
						html += '<option value="' + '0' + '">' + '女' + '</option>';
						html += '<option value="' + '1' + '" selected = "selected">' + '男' + '</option>';
					}
					
				}else if(objArry[i].colENName=="helpPersonId"){
					$.ajax({  
				          type : "post",  
				          url : basepath+"/pahp/queryByParam",  
				          data : {familyNo:familyNo},
				          dataType:"JSON",
				          async : false,  
				          success : function(data){  
				        	  var data=data.data
				        	  for(var j=0; j<data.length; j++){
				        		  if(objArry[i].value==data[j].id){
				        			  html += '<option value="' + data[j].id + '" selected = "selected">' + '<span>'+data[j].name+'</span>&nbsp;&nbsp;&nbsp;'+'[&nbsp;<span style=\'float:right;\'>'+data[j].personpositionValue+'</span>&nbsp;]' + '</option>'; 
				        		  }else{
				        			  html += '<option value="' + data[j].id + '">' + '<span>'+data[j].name+'</span>&nbsp;&nbsp;&nbsp;'+'[&nbsp;<span style=\'float:right;\'>'+data[j].personpositionValue+'</span>&nbsp;]' + '</option>';
				        		  }
				        		  
								} 
				          }  
				     });
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
				html +='<textArea class="form-control" style="width:660px;" name="'+objArry[i].colENName+'">'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'</textArea>';
			}else if(objArry[i].dataInputType=="radio"){
				var objEnName=objArry[i].colENName;
				var val=objArry[i].value;
				var valArr=val.split(",");
					$.ajax({  
				          type : "post",  
				          url : basepath+"/common/codeList",  
				          data : {type:objEnName},
				          dataType:"JSON",
				          async : false,  
				          success : function(data){  
				        	  html+='<div class="form-control" style="width:660px;height:50px;">';
				        	  for(var i=0; i<data.length; i++){
				        		  var flag=true;
				        		  for(var j=0;j<valArr.length;j++){
				        			  if(valArr[j].trim()==data[i].name.trim()){
				        				  flag=false;
					        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[i].code+'" checked>'+data[i].name+'</label>';
				        			  }
				        		  }
				        		  if(flag){
				        			  html += '<label class="radio-inline"><input type="radio" name="'+objEnName+'" value="'+data[i].code+'">'+data[i].name+'</label>';
				        		  }
				        		 
								} 
				        	  html+='</div>';
				          }  
				     });
				 
			}else if(objArry[i].dataInputType=="date"){
				html+='<input id="'+objArry[i].colENName+'" name="'+objArry[i].colENName+'" class="Wdate form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd\',maxDate:\'%y-%M-%d\'})" value="'+(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format('yyyy-MM-dd'))+'"/>';
			}else if(objArry[i].dataInputType=="checkbox"){
				var objEnName=objArry[i].colENName;
				var val=objArry[i].value;
				var valArr=val.split(",");
					$.ajax({  
				          type : "post",  
				          url : basepath+"/common/codeList",  
				          data : {type:objEnName},
				          dataType:"JSON",
				          async : false,  
				          success : function(data){  
				        	  html+='<div class="form-control" style="width:660px;height:50px;">';
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
				html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
			}
			html+='</div>';
		}
		html+='<span class="btn btn-primary fr" onclick="submitForm5();">保存</span>';
		$("#showForm5").html(html);
		$("#myModalLabel5").html("编辑");
		$('#myModal5').modal();
		
		// 添加长度的控制
		$("#showForm5 input[name='institutionName']").prop("maxlength", 50);
		$("#showForm5 input[name='helpContent']").prop("maxlength", 100);
		$("#showForm5 input[name='helpResult']").prop("maxlength", 100);
//		$("#startTime").attr("onFocus", "var endTime=$dp.$('endTime');WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',onpicked:function(){endTime.focus();},maxDate:'#F{$dp.$D(\\'endTime\\')}'})");
//		$("#endTime").attr("onFocus", "WdatePicker({minDate:'#F{$dp.$D(\\'startTime\\')}',dateFmt:\'yyyy-MM-dd HH:mm:ss\'})");
	
		queryMedia5(id,thisFamilyNo,"pa_family_help_plan_result_info", 1);
    	
    	$('#media5').fileupload({
			url : '/pafb/uploadMedia',
			add: function (e, data) {
				var uploadErrors = [];
					 console.log(data.originalFiles[0]['size']) ;
				/* if (data.originalFiles[0]['size'] > 1*1024*1024) {
						 uploadErrors.push('上传文件不能超过1M');
					} */
					 var acceptFileTypes = /(\.|\/)(mp3|jpe?g|png|mp4)$/i;
			        if(!acceptFileTypes.test(data.originalFiles[0]['name'])) {
			            uploadErrors.push('文件类型不正确(mp3|mp4|jpg|jpeg|png)！');
			        }
					 if(uploadErrors.length > 0) {
							alert(uploadErrors.join("\n"));
					 } else {
				  		data.submit();
					 }
	        },
	        done: function (e, data) {
	        	var obj=data.result.data;
	        	$.ajax({  
			          type : "post",  
			          url : basepath+"/pafb/saveMedia",  
			          data : {id:id,familyNo:thisFamilyNo,tableName:"pa_family_help_plan_result_info",fileName:obj.fileName,filePath:obj.filePath},
			          dataType:"JSON",
			          success : function(data){  
			        	  if(obj.fileName.endsWith(".mp3")) {
			        		  queryMedia5(id,familyNo,"pa_family_help_plan_result_info", 2);
			        	  } else if(obj.fileName.endsWith(".mp4")) {
			        		  queryMedia5(id,familyNo,"pa_family_help_plan_result_info", 3);
			        	  }else {
			        		  queryMedia5(id,familyNo,"pa_family_help_plan_result_info", 1);
			        	  }
			          }  
			     });
	        }// 进度条
	        ,progressall: function(e, data){
	        	var progress = parseInt(data.loaded / data.total * 100, 10);
	        	$('#progress5').css('width', progress + '%');
	        	// 
	        	if(progress == 100){
	        		setTimeout(function(){
	        			$('#progress5').css('width', '0');
	        		},2000);
	        	}
	        }
	    });
	},"JSON");

	
}
function showInfo5(id,thisFamilyNo){
	$.get(basepath+"/pafhp/familyHelpPlanInfo?id="+id,function(data){
		var objArry=data.data;
		var html = '';
		html+='<div id="mediaDiv55" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
		html+='<div class="btn-group-vertical">'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia55(1,'+id+');">图片</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia55(2,'+id+');">音频</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia55(3,'+id+');">视频</span>';
		if(btn_8116){
			html+='<span class="btn btn-primary btn-sm fr hide" onclick="javascript:$(\'#media55\').click();">上传</span>';
		}
		html+='<input name="media" id="media55"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
		
		for(var i=0; i<objArry.length; i++){
			if(objArry[i].dataInputType=='date'){
				var dateValue=(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format('yyyy-MM-dd'));
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+dateValue+'</span></div>';
			}else if(objArry[i].colENName=='helpContent'||objArry[i].colENName=='helpResult'||objArry[i].colENName=='institutionName'){
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><textarea disabled="disabled" class="form-control" style="width:660px;">'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'</textarea></div>';
			}else if(objArry[i].colENName=='projectTypeCode'){
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:660px;">'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'</span></div>';
			}else if(objArry[i].colENName=='helpPersonId'){
				$.ajax({  
			          type : "post",  
			          url : basepath+"/pahp/queryByParam",  
			          data : {familyNo:familyNo},
			          dataType:"JSON",
			          async : false,  
			          success : function(data){  
			        	  var data=data.data
			        	  for(var j=0; j<data.length; j++){
			        		  if(objArry[i].value==data[j].id){
			        			  html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+'<span>'+data[j].name+'</span>&nbsp;&nbsp;&nbsp;'+'<span style=\'float:right;\'>'+data[j].personpositionValue+'</span>'+'</span></div>';
			        		  }
			        	  } 
			          }  
			     });
			}else{
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+(objArry[i].value==null||objArry[i].value=="null"?"":objArry[i].value)+'</span></div>';
			}
		}
		$("#showForm5").html(html);
		$("#myModalLabel5").html("查看详情");
		$('#myModal5').modal();
		
		queryMedia55(id,thisFamilyNo,"pa_family_help_plan_result_info", 1);
    	
    	$('#media55').fileupload({
			url : '/pafb/uploadMedia',
			add: function (e, data) {
				var uploadErrors = [];
					 console.log(data.originalFiles[0]['size']) ;
				/* if (data.originalFiles[0]['size'] > 1*1024*1024) {
						 uploadErrors.push('上传文件不能超过1M');
					} */
					 var acceptFileTypes = /(\.|\/)(mp3|jpe?g|png|mp4)$/i;
			        if(!acceptFileTypes.test(data.originalFiles[0]['name'])) {
			            uploadErrors.push('文件类型不正确(mp3|mp4|jpg|jpeg|png)！');
			        }
					 if(uploadErrors.length > 0) {
							alert(uploadErrors.join("\n"));
					 } else {
				  		data.submit();
					 }
	        },
	        done: function (e, data) {
	        	var obj=data.result.data;
	        	$.ajax({  
			          type : "post",  
			          url : basepath+"/pafb/saveMedia",  
			          data : {id:id,familyNo:thisFamilyNo,tableName:"pa_family_help_plan_result_info",fileName:obj.fileName,filePath:obj.filePath},
			          dataType:"JSON",
			          success : function(data){  
			        	  if(obj.fileName.endsWith(".mp3")) {
			        		  queryMedia55(id,familyNo,"pa_family_help_plan_result_info", 2);
			        	  } else if(obj.fileName.endsWith(".mp4")) {
			        		  queryMedia55(id,familyNo,"pa_family_help_plan_result_info", 3);
			        	  }else {
			        		  queryMedia55(id,familyNo,"pa_family_help_plan_result_info", 1);
			        	  }
			          }  
			     });
	        }// 进度条
	        ,progressall: function(e, data){
	        	var progress = parseInt(data.loaded / data.total * 100, 10);
	        	$('#progress55').css('width', progress + '%');
	        	// 
	        	if(progress == 100){
	        		setTimeout(function(){
	        			$('#progress55').css('width', '0');
	        		},2000);
	        	}
	        }
	    });
	},"JSON");
}
//function queryMedia5(pkId,familyNo,tableName){
//	$.ajax({  
//          type : "post",  
//          url : basepath+"/pafb/queryMedia",  
//          data : {pkId:pkId,familyNo:familyNo,tableName:tableName},
//          dataType:"JSON",
//          success : function(data){  
//        	  var result=data.data;
//        	  var html="<div class='slick' style='width:650px;'>";
//        	  if(result.length==0){
//        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
//        	  }else{
//        		  for(var i=0;i<result.length;i++){
//        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
//        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='/images/timg.jpg' alt='' style='height:100px;' type='"+result[i].fileType+"' url='"+result[i].filePath+"'></a><span>"+result[i].fileName+"</span></div>"; 
//        			  }else{
//        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='"+result[i].filePath+"' alt='' style='height:100px;'  type='"+result[i].fileType+"'></a><span>"+result[i].fileName+"</span></div>";  
//        			  }
//	        	  }
//        	  }
//        	 html+="</div>";
//        	  $("#mediaDiv5").html(html);
//        	  
//        	  $('#mediaDiv5 .slick').slick({
//      	        dots: true,
//      	        slidesToShow:4,
//      	        autoplay:true
//      	    });
//        	  $.museum($('.slick .slick-list .slick-track .slick-slide a img'));
//          }  
//     });
//}

function turnMedia5(turnMediaFlag,thisid){
	queryMedia5(thisid,familyNo,"pa_family_help_plan_result_info",turnMediaFlag);
}

function queryMedia5(pkId,familyNo,tableName,turnMediaFlag){
	$.ajax({  
          type : "post",  
          url : basepath+"/pafb/queryMedia",  
          data : {pkId:pkId,familyNo:familyNo,tableName:tableName,turnMediaFlag:turnMediaFlag},
          dataType:"JSON",
          success : function(data){  
        	  var result=data.data;
        	  /*
        	  var html="<div class='slick' style='width:650px;'>";
        	  if(result.length==0){
        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
        	  }else{
        		  for(var i=0;i<result.length;i++){
        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='/images/timg.jpg' alt='' style='height:100px;' type='"+result[i].fileType+"' url='"+result[i].filePath+"'></a><span>"+result[i].fileName+"</span></div>"; 
        			  }else{
        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='"+result[i].filePath+"' alt='' style='height:100px;'  type='"+result[i].fileType+"'></a><span>"+result[i].fileName+"</span></div>";  
        			  }
	        	  }
        	  }
        	  html+="</div>";
        	  */
        	  var html='<div style="height: 3px;width: 100%;">';
        	  html += '<div id="progress5" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_5' class='scroll_horizontal' style='width:650px;'>";
        	  html += '<div class="box"> <ul class="list gallery">';
        	  if(result.length==0){
        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
        	  }else{
        		  for(var i=0;i<result.length;i++){
        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
        				  html+="<li style='text-align:center;'><a href='/images/timg.jpg' type='"+result[i].fileType+"' url='"+result[i].filePath+"'><img src='/images/timg.jpg' alt='' style='height:100px; max-width:200px;'></a><div>"+result[i].fileName+"</div></li>"; 
        			  }else{
        				  html+="<li style='text-align:center;'><a href='"+result[i].filePath+"' type='"+result[i].fileType+"'><img src='"+result[i].filePath+"' alt='' style='height:100px; max-width:200px;' ></a><div>"+result[i].fileName+"</div></li>";  
        			  }
	        	  }
        	  }
        	  html+="</ul></div>";
        	  html+="</div>";
        	  
        	  $("#mediaDiv5").html(html);
        	  
        	  $("#pic_list_5").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_5 .gallery a');
        	  /*
        	  $('#mediaDiv .slick').slick({
      	        dots: true,
      	        slidesToShow:4,
      	        autoplay:true
      	      });
        	  */
        	  
        	  //$.museum($('.slick .slick-list .slick-track .slick-slide a img'));
          }  
     });
}

function turnMedia55(turnMediaFlag,thisid){
	queryMedia55(thisid,familyNo,"pa_family_help_plan_result_info",turnMediaFlag);
}

function queryMedia55(pkId,familyNo,tableName,turnMediaFlag){
	$.ajax({  
          type : "post",  
          url : basepath+"/pafb/queryMedia",  
          data : {pkId:pkId,familyNo:familyNo,tableName:tableName,turnMediaFlag:turnMediaFlag},
          dataType:"JSON",
          success : function(data){  
        	  var result=data.data;
        	  /*
        	  var html="<div class='slick' style='width:650px;'>";
        	  if(result.length==0){
        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
        	  }else{
        		  for(var i=0;i<result.length;i++){
        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='/images/timg.jpg' alt='' style='height:100px;' type='"+result[i].fileType+"' url='"+result[i].filePath+"'></a><span>"+result[i].fileName+"</span></div>"; 
        			  }else{
        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='"+result[i].filePath+"' alt='' style='height:100px;'  type='"+result[i].fileType+"'></a><span>"+result[i].fileName+"</span></div>";  
        			  }
	        	  }
        	  }
        	  html+="</div>";
        	  */
        	  var html='<div style="height: 3px;width: 100%;">';
        	  html += '<div id="progress55" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_55' class='scroll_horizontal' style='width:650px;'>";
        	  html += '<div class="box"> <ul class="list gallery">';
        	  if(result.length==0){
        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
        	  }else{
        		  for(var i=0;i<result.length;i++){
        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
        				  html+="<li style='text-align:center;'><a href='/images/timg.jpg' type='"+result[i].fileType+"' url='"+result[i].filePath+"'><img src='/images/timg.jpg' alt='' style='height:100px; max-width:200px;'></a><div>"+result[i].fileName+"</div></li>"; 
        			  }else{
        				  html+="<li style='text-align:center;'><a href='"+result[i].filePath+"' type='"+result[i].fileType+"'><img src='"+result[i].filePath+"' alt='' style='height:100px; max-width:200px;' ></a><div>"+result[i].fileName+"</div></li>";  
        			  }
	        	  }
        	  }
        	  html+="</ul></div>";
        	  html+="</div>";
        	  
        	  $("#mediaDiv55").html(html);
        	  
        	  $("#pic_list_55").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_55 .gallery a');
        	  /*
        	  $('#mediaDiv .slick').slick({
      	        dots: true,
      	        slidesToShow:4,
      	        autoplay:true
      	      });
        	  */
        	  
        	  //$.museum($('.slick .slick-list .slick-track .slick-slide a img'));
          }  
     });
}

//function queryMedia55(pkId,familyNo,tableName){
//	$.ajax({  
//          type : "post",  
//          url : basepath+"/pafb/queryMedia",  
//          data : {pkId:pkId,familyNo:familyNo,tableName:tableName},
//          dataType:"JSON",
//          success : function(data){  
//        	  var result=data.data;
//        	  var html="<div class='slick' style='width:650px;'>";
//        	  if(result.length==0){
//        		  html+="<div style='visibility:hidden'><a href=''><img src='/images/1.jpg' alt='' style='height:100px;'></a></div>"; 
//        	  }else{
//        		  for(var i=0;i<result.length;i++){
//        			  if(result[i].fileType=="mp4"||result[i].fileType=="mp3"){
//        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='/images/timg.jpg' alt='' style='height:100px;' type='"+result[i].fileType+"' url='"+result[i].filePath+"'></a><span>"+result[i].fileName+"</span></div>"; 
//        			  }else{
//        				  html+="<div style='text-align:center;'><a href='javascript:;'><img src='"+result[i].filePath+"' alt='' style='height:100px;'  type='"+result[i].fileType+"'></a><span>"+result[i].fileName+"</span></div>";  
//        			  }
//	        	  }
//        	  }
//        	 html+="</div>";
//        	  $("#mediaDiv55").html(html);
//        	  
//        	  $('#mediaDiv55 .slick').slick({
//      	        dots: true,
//      	        slidesToShow:4,
//      	        autoplay:true
//      	    });
//        	  $.museum($('.slick .slick-list .slick-track .slick-slide a img'));
//          }  
//     });
//}
function deleteById5(id){
	if(confirm("确认删除？")){
		$.ajax({  
	          type : "post",  
	          url : basepath+"/pafhp/deleteHelpPlanById",  
	          data : {id:id},
	          dataType:"JSON",
	          success : function(data){  
//	        	  getTableData();
	        	  $('#table5').bootstrapTable("refresh");
	          }  
	     });
	}
}

function submitForm5(){
	if(!$("#showForm5").valid()){
		return false;
	}
	$("#myModal5").modal('hide');
	$.ajax({  
        type : "post",  
        url : basepath+"/pafhp/saveFamilyHelpPlanInfo",  
        data : $("#showForm5").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
//      	  getTableData();
//      	  $('#table5').bootstrapTable("refresh",{query: {offset:0}});
      	  $('#table5').bootstrapTable("refresh");
        }  
   });
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