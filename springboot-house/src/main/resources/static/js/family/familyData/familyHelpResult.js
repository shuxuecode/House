$(function(){
	
	$("#showForm11").validate({
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
			helpTime : {
//				required: true
			},
			helpResult : {
//				required: true,
				minlength:1,
		        maxlength:100
			}
		}
		
	});
	
	getTableData11();
	
	$("#search11").click(function(){
		$('#table11').bootstrapTable("refresh");
	});
});


function getTableData11(){
	$('#table11').bootstrapTable({
		url: basepath + "/pafhp/familyHelpResultList",
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
	            startTime:$("#startTime11").val(),
	            endTime:$("#endTime11").val(),
	            helpResult:$("#helpResult11").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'helpTime',
				title: '帮扶时间',
				align: 'center',
				width : 100,
				formatter:function(value){
					return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd');
				},
				valign: 'middle'
			},{
				field: 'helpResult',
				title: '帮扶成效',
				align: 'center',
				valign: 'middle'
			},  {
				title: '操作',
				align: 'center',
				width : 200,
				formatter: function(value,row,index){
					var btnHtml = "";
					if(btn_8129){
						btnHtml += "<button class='btn btn-sm btn-primary "+dnClass+"' "
						+ "onclick='javascript:showUpdate11("+row.id+","+row.familyNo+",\""+row.helpTime+"\",\""+row.helpResult+"\");'>编辑</button>&nbsp;";
					}
					if(btn_8130){
						btnHtml+="<button class='btn btn-sm btn-primary' onclick='javascript:deleteById11("+row.id+");'>删除</button>&nbsp;";
					}
					btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showInfo11("+row.id+","+row.familyNo+",\""+row.helpTime+"\",\""+row.helpResult+"\");'>查看详情</button>";
					return btnHtml;
				}
			}]
		});
}




function showInsert11(){
	var html = '<input type="hidden" name="familyNo" value="'+familyNo+'">';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">时间</span>';
	html += '<input name="helpTime" class="Wdate form-control" style="width:150px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd\',maxDate:\'%y-%M-%d\'})"/>';
	html += '</div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">成效内容</span>';
	html += '<textArea class="form-control" style="width:450px;" name="helpResult"></textArea>';
	html += '</div>';
	html += '<span class="btn btn-primary fr" onclick="submitForm11();">保存</span>';
	$("#showForm11").html(html);
	$("#myModalLabel11").html("添加");
	$('#myModal11').modal();
	// 添加长度的控制
//	$("#showForm11 input[name='helpResult']").prop("maxlength", 100);
}


function showUpdate11(id,thisFamilyNo, helpTime, helpResult){
	helpTime = (new Date(Number(helpTime))).Format('yyyy-MM-dd');
	var html = '<input type="hidden" name="id" value="'+id+'">';
	
	html+='<div id="mediaDiv11" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
	html+='<div class="btn-group-vertical">'+
	'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia11(1,'+id+');">图片</span>'+
	'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia11(2,'+id+');">音频</span>'+
	'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia11(3,'+id+');">视频</span>';
	if(btn_8131){
		html+='<span class="btn btn-primary btn-sm fr" onclick="javascript:$(\'#media11\').click();">上传</span>';
	}
	html+='<input name="media" id="media11"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
	
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">时间</span>';
	html += '<input name="helpTime" class="Wdate form-control" style="width:150px;" value="'+helpTime+'" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd\',maxDate:\'%y-%M-%d\'})"/>';
	html += '</div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">成效内容</span>';
	html += '<textArea class="form-control" style="width:450px;" name="helpResult">' + helpResult + '</textArea>';
	html += '</div>';
	html += '<span class="btn btn-primary fr" onclick="submitForm11();">保存</span>';
	$("#showForm11").html(html);
	$("#myModalLabel11").html("编辑");
	$('#myModal11').modal();
	// 添加长度的控制
//	$("#showForm11 input[name='helpResult']").prop("maxlength", 100);
	
	
	queryMedia11(id,thisFamilyNo,"pa_family_help_result_info", 1);
	
	$('#media11').fileupload({
		url : '/pafb/uploadMedia',
		add: function (e, data) {
			var uploadErrors = [];
				 console.log(data.originalFiles[0]['size']) ;
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
		          data : {id:id,familyNo:thisFamilyNo,tableName:"pa_family_help_result_info",fileName:obj.fileName,filePath:obj.filePath},
		          dataType:"JSON",
		          success : function(data){  
		        	  if(obj.fileName.endsWith(".mp3")) {
		        		  queryMedia11(id,familyNo,"pa_family_help_result_info", 2);
		        	  } else if(obj.fileName.endsWith(".mp4")) {
		        		  queryMedia11(id,familyNo,"pa_family_help_result_info", 3);
		        	  }else {
		        		  queryMedia11(id,familyNo,"pa_family_help_result_info", 1);
		        	  }
		          }  
		     });
        }// 进度条
        ,progressall: function(e, data){
        	var progress = parseInt(data.loaded / data.total * 100, 10);
        	$('#progress11').css('width', progress + '%');
        	// 
        	if(progress == 100){
        		setTimeout(function(){
        			$('#progress11').css('width', '0');
        		},2000);
        	}
        }
    });
}


function showInfo11(id,thisFamilyNo, helpTime, helpResult){
	helpTime = (new Date(Number(helpTime))).Format('yyyy-MM-dd');
	
	var html = '';
	html+='<div id="mediaDiv_11" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
	html+='<div class="btn-group-vertical">'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia_11(1,'+id+');">图片</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia_11(2,'+id+');">音频</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia_11(3,'+id+');">视频</span>';
	if(btn_8131){
		html+='<span class="btn btn-primary btn-sm fr hide" onclick="javascript:$(\'#media_11\').click();">上传</span>';
	}
	html+='<input name="media" id="media_11"  type="file" class="form-control" style="width:250px; display:none;"></div>';
	
	
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">时间</span>';
	html += '<span class="form-control" style="width:150px;" >'+helpTime+'</span>';
	html += '</div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">成效内容</span>';
	html += '<span class="form-control" style="width:450px; height:auto"  >'+helpResult+'</span>';
	html += '</div>';
	$("#showForm11").html(html);
	$("#myModalLabel11").html("详情");
	$('#myModal11').modal();
	
	
	queryMedia_11(id, thisFamilyNo,"pa_family_help_result_info", 1);
}


function submitForm11(){
	if(!$("#showForm11").valid()){
		return false;
	}
	$("#myModal11").modal('hide');
	$.ajax({  
        type : "post",
        url : basepath+"/pafhp/saveFamilyHelpResultInfo",  
        data : $("#showForm11").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
      	  $('#table11').bootstrapTable("refresh");
        }  
   });
}


function deleteById11(id){
	$.confirm({
	    title: '警告',
	    content: '确认删除？',
	    confirmButton: '确认',
	    cancelButton: '取消',
	    confirm: function(){
	    	$.ajax({  
		          type : "post",  
		          url : basepath+"/pafhp/delFamilyHelpResultInfo",  
		          data : {id:id},
		          dataType:"JSON",
		          success : function(data){  
		        	  alert("删除成功！");
		        	  $('#table11').bootstrapTable("refresh");
		          }  
		     });
	    },
	    cancel: function(){}
	});
}


function turnMedia11(turnMediaFlag,thisid){
	queryMedia11(thisid,familyNo,"pa_family_help_result_info",turnMediaFlag);
}

function queryMedia11(pkId,familyNo,tableName,turnMediaFlag){
	$.ajax({  
          type : "post",  
          url : basepath+"/pafb/queryMedia",  
          data : {pkId:pkId,familyNo:familyNo,tableName:tableName,turnMediaFlag:turnMediaFlag},
          dataType:"JSON",
          success : function(data){  
        	  var result=data.data;
        	  var html='<div style="height: 3px;width: 100%;">';
        	  html += '<div id="progress11" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_11' class='scroll_horizontal' style='width:650px;'>";
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
        	  
        	  $("#mediaDiv11").html(html);
        	  
        	  $("#pic_list_11").cxScroll();
        	  
        	  zoomOpen('#pic_list_11 .gallery a');
          }  
     });
}

function turnMedia_11(turnMediaFlag,thisid){
	queryMedia_11(thisid,familyNo,"pa_family_help_result_info",turnMediaFlag);
}

function queryMedia_11(pkId,familyNo,tableName,turnMediaFlag){
	$.ajax({  
          type : "post",  
          url : basepath+"/pafb/queryMedia",  
          data : {pkId:pkId,familyNo:familyNo,tableName:tableName,turnMediaFlag:turnMediaFlag},
          dataType:"JSON",
          success : function(data){  
        	  var result=data.data;
        	  var html='<div style="height: 3px;width: 100%;">';
        	  html += '<div id="progress_11" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_1111' class='scroll_horizontal' style='width:650px;'>";
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
        	  
        	  $("#mediaDiv_11").html(html);
        	  
        	  $("#pic_list_1111").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_1111 .gallery a');
          }  
     });
}
