$(function(){
	$("#showForm7").validate({
		
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
			feedback : {
				required: true
			}
		}
		
	});
})



$(function(){
	getTableData();
});
function getTableData(){
	$('#table7').bootstrapTable({
		url: basepath + "/fb/feedbackList",
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
	            startTime:$("#startTime7").val(),
	            endTime:$("#endTime7").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'feedback',
				title: '督导记录',
				align: 'center',
				valign: 'middle',
				formatter: function(value, row, index){
					if(value==null){
						return "-";
					}else{
						var dots='';
						if(value.length>176){
							dots='...';
						}
						return "<span  data-toggle='tooltip' title='"+value+"'>"+(value==null?"-":(value.substring(0,176)+dots))+"</span>";
					}
				}
			}, {
				field: 'feedbackTime',
				title: '督导时间',
				align: 'center',
				valign: 'middle',
				width : 140,
				formatter:function(value){
					return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd hh:mm:ss');
				}
			},{
				title: '操作',
				align: 'center',
				valign: 'middle',
				width : 150,
				formatter: function(value,row,index){
					var btnHtml = "";
					if(btn_8113){
						btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate7("+row.id+","+row.familyNo+");'>编辑</button>&nbsp;";
					}
//					"<button class='btn btn-sm btn-primary' onclick='javascript:deleteById5("+row.id+");'>删除</button>&nbsp;"+
					btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showInfo7("+row.id+","+row.familyNo+");'>查看详情</button>";
					return btnHtml;
				}
			}]
		});
	$("#search7").click(function(){
//		$('#table5').bootstrapTable("refresh",{query: {offset:0}});
		$('#table7').bootstrapTable("refresh");
	});
	
}
//function queryMedia7(pkId,familyNo,tableName){
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
//        	  $("#mediaDiv7").html(html);
//        	  
//        	  $('#mediaDiv7 .slick').slick({
//      	        dots: true,
//      	        slidesToShow:4,
//      	        autoplay:true
//      	    });
//        	  $.museum($('.slick .slick-list .slick-track .slick-slide a img'));
//          }  
//     });
//}
//function queryMedia77(pkId,familyNo,tableName){
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
//        	  $("#mediaDiv77").html(html);
//        	  
//        	  $('#mediaDiv77 .slick').slick({
//      	        dots: true,
//      	        slidesToShow:4,
//      	        autoplay:true
//      	    });
//        	  $.museum($('.slick .slick-list .slick-track .slick-slide a img'));
//          }  
//     });
//}

function turnMedia7(turnMediaFlag,thisid){
	queryMedia7(thisid,familyNo,"pa_family_feedback_info",turnMediaFlag);
}

function queryMedia7(pkId,familyNo,tableName,turnMediaFlag){
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
        	  html += '<div id="progress7" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_7' class='scroll_horizontal' style='width:650px;'>";
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
        	  
        	  $("#mediaDiv7").html(html);
        	  
        	  $("#pic_list_7").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_7 .gallery a');
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

function turnMedia77(turnMediaFlag,thisid){
	queryMedia77(thisid,familyNo,"pa_family_feedback_info",turnMediaFlag);
}

function queryMedia77(pkId,familyNo,tableName,turnMediaFlag){
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
        	  html += '<div id="progress77" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_77' class='scroll_horizontal' style='width:650px;'>";
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
        	  
        	  $("#mediaDiv77").html(html);
        	  
        	  $("#pic_list_77").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_77 .gallery a');
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
function showInsert7(){
	$.get(basepath+"/fb/feedbackInfo",function(data){
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
			}else if(objArry[i].dataInputType=="textarea"){
				html +='<textArea  class="form-control" style="width:760px;" name="'+objArry[i].colENName+'"></textArea>';
			}else if(objArry[i].dataInputType=="radio"){
				html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
				html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
				 
			}else if(objArry[i].dataInputType=="date"){
				html+='<input id="'+objArry[i].colENName+'" name="'+objArry[i].colENName+'" class="form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})"/>';
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
		html+='<span class="btn btn-primary fr" onclick="submitForm7();">保存</span>';
		$("#showForm7").html(html);
		$("#myModalLabel7").html("添加");
		$('#myModal7').modal();
		
	},"JSON");

	
}
function showUpdate7(id,thisFamilyNo){
	$.get(basepath+"/fb/feedbackInfo?id="+id,function(data){
		var objArry=data.data;
		var html = '<input type="hidden" name="familyNo" value="'+thisFamilyNo+'"><input type="hidden" name="id" value="'+id+'">';
		html+='<div id="mediaDiv7" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
		html+='<div class="btn-group-vertical">'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia7(1,'+id+');">图片</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia7(2,'+id+');">音频</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia7(3,'+id+');">视频</span>';
		
		if(btn_8117){
			html+='<span class="btn btn-primary btn-sm fr" onclick="javascript:$(\'#media7\').click();">上传</span>';
		}
		html+='<input name="media" id="media7"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
		for(var i=0; i<objArry.length; i++){
			html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
			if(objArry[i].dataInputType=="text"){
				html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'"/>';
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
			}else if(objArry[i].dataInputType=="textarea"){
				html +='<textArea class="form-control" style="width:760px;" name="'+objArry[i].colENName+'">'+objArry[i].value+'</textArea>';
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
		html+='<span class="btn btn-primary fr" onclick="submitForm7();">保存</span>';
		$("#showForm7").html(html);
		$("#myModalLabel7").html("编辑");
		$('#myModal7').modal();
		
		queryMedia7(id,thisFamilyNo,"pa_family_feedback_info", 1);
    	
    	$('#media7').fileupload({
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
			          data : {id:id,familyNo:thisFamilyNo,tableName:"pa_family_feedback_info",fileName:obj.fileName,filePath:obj.filePath},
			          dataType:"JSON",
			          success : function(data){  
			        	  if(obj.fileName.endsWith(".mp3")) {
			        		  queryMedia7(id,familyNo,"pa_family_feedback_info", 2);
			        	  } else if(obj.fileName.endsWith(".mp4")) {
			        		  queryMedia7(id,familyNo,"pa_family_feedback_info", 3);
			        	  }else {
			        		  queryMedia7(id,familyNo,"pa_family_feedback_info", 1);
			        	  }
			          }  
			     });
	        }// 进度条
	        ,progressall: function(e, data){
	        	var progress = parseInt(data.loaded / data.total * 100, 10);
	        	$('#progress7').css('width', progress + '%');
	        	// 
	        	if(progress == 100){
	        		setTimeout(function(){
	        			$('#progress7').css('width', '0');
	        		},2000);
	        	}
	        }	
	    });
		
	},"JSON");

	
}
function showInfo7(id,thisFamilyNo){
	$.get(basepath+"/fb/feedbackInfo?id="+id,function(data){
		var objArry=data.data;
		var html = '';
		html+='<div id="mediaDiv77" class="input-group" style="margin-left:100px;margin-bottom:10px;"></div>';
		html+='<div class="btn-group-vertical">'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia77(1,'+id+');">图片</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia77(2,'+id+');">音频</span>'+
		'<span class="btn btn-primary btn-sm fr" onclick="javascript:turnMedia77(3,'+id+');">视频</span>';
		if(btn_8117){
			html+='<span class="btn btn-primary btn-sm fr hide" onclick="javascript:$(\'#media77\').click();">上传</span>';
		}
		html+='<input name="media" id="media77"  type="file" class="form-control" style="width:250px; display:none;" multiple></div>';
		for(var i=0; i<objArry.length; i++){
			if(objArry[i].dataInputType=='date'){
				var dateValue=(objArry[i].value==undefined?"-":(new Date(objArry[i].value)).Format('yyyy-MM-dd hh:mm:ss'));
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+dateValue+'</span></div>';
			}else if(objArry[i].colENName=='feedback'){
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><textarea disabled="disabled" class="form-control" style="width:660px;">'+objArry[i].value+'</textarea></div>';
			}else if(objArry[i].colENName=='projectTypeCode'){
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:660px;">'+objArry[i].value+'</span></div>';
			}else{
				html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+objArry[i].value+'</span></div>';
			}
		}
		$("#showForm7").html(html);
		$("#myModalLabel7").html("查看详情");
		$('#myModal7').modal();
		
		queryMedia77(id,thisFamilyNo,"pa_family_feedback_info", 1);
    	
    	$('#media77').fileupload({
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
			          data : {id:id,familyNo:thisFamilyNo,tableName:"pa_family_feedback_info",fileName:obj.fileName,filePath:obj.filePath},
			          dataType:"JSON",
			          success : function(data){  
			        	  if(obj.fileName.endsWith(".mp3")) {
			        		  queryMedia77(id,familyNo,"pa_family_feedback_info", 2);
			        	  } else if(obj.fileName.endsWith(".mp4")) {
			        		  queryMedia77(id,familyNo,"pa_family_feedback_info", 3);
			        	  }else {
			        		  queryMedia77(id,familyNo,"pa_family_feedback_info", 1);
			        	  }
			          }  
			     });
	        }// 进度条
	        ,progressall: function(e, data){
	        	var progress = parseInt(data.loaded / data.total * 100, 10);
	        	$('#progress77').css('width', progress + '%');
	        	// 
	        	if(progress == 100){
	        		setTimeout(function(){
	        			$('#progress77').css('width', '0');
	        		},2000);
	        	}
	        }
	    });
	},"JSON");
}

function submitForm7(){
	if(!$("#showForm7").valid()){
		return false;
	}
	$("#myModal7").modal('hide');
	$.ajax({  
        type : "post",  
        url : basepath+"/fb/saveFeedbackInfo",  
        data : $("#showForm7").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
//      	  getTableData();
//      	  $('#table5').bootstrapTable("refresh",{query: {offset:0}});
      	  $('#table7').bootstrapTable("refresh");
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