$(function(){
	$("#showForm10").validate({
		
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
			memberName : {
				minlength:1,
		        maxlength:20
			},
			relationshipCode : {
			},
			gender : {
			},
			nationCode : {
			},
			educationCode : {
			},
			collegeInfo : {
				minlength:1,
		        maxlength:100
			},
			workAbility : {
			},
			healthInfo : {
				minlength:1,
		        maxlength:100
			},
			certificateNo : {
				idCardRequireNew:true
			},
			certificateTypeCode : {
				required: true
			},
			isfamilyPlanning : {
			},
			isFarmCooperation : {
			},
			isFarmSecurity : {
			},
			isIncomeSupport : {
			},
			age : {
				age:true
			},
			profession : {
			},
			income : {
				number:true
			},
			livingTimeYear : {
				maxlength:4
			}
		}
		
	});
	
	$('#table10').bootstrapTable({
		url: basepath+"/pamsr/familyMemberList",
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
	            familyNo:familyNo,
	            memberName:$("#memberName10").val(),
	            gender:$("#gender10").val(),
	            educationCode:$("#educationCode10").val(),
	            profession:$("#profession10").val()
	            
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'memberName',
				title: '姓名',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'relationshipCodeName',
				title: '与户主关系',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'genderName',
				title: '性别',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'age',
				title: '年龄',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'profession',
				title: '职业',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'income',
				title: '收入(元)',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'educationCodeName',
				title: '文化程度',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'healthInfo',
				title: '健康状况或疾病类型',
				align: 'center',
				valign: 'middle'
			}, {
				title: '操作',
				align: 'center',
				valign: 'middle',
				width: '280px',
				formatter: function(value, row, index){
					var btnHtml = '';
					if(btn_8126){
						var disabled = (row.relationshipCode == '1') ? "disabled" : "";
						if(isDisabled == '') disabled = "";
						btnHtml += "<button class='btn btn-sm btn-primary "+disabled+"' onclick='javascript:showMember10(\"update\","+row.id+","+row.familyNo+");'>编辑</button>&nbsp;";
					}
					if(btn_8127){
						var disabled = (row.relationshipCode == '1') ? "disabled" : "";
						if(isDisabled == '') disabled = "";
						btnHtml+="<button class='btn btn-sm btn-primary "+disabled+"' onclick='javascript:deleteById10("+row.id+");'>删除</button>&nbsp;";
					}
					btnHtml += "<button class='btn btn-sm btn-primary' onclick='javascript:showMember10(\"query\","+row.id+");'>查看详情</button>";
					return btnHtml;
				}
			}]
		});
	
	loadSelectDiv10();
	
	$("#search10").click(function(){
//		$('#table').bootstrapTable("refresh",{query: {offset:0}});
		$('#table10').bootstrapTable("refresh");
	});
})
function loadSelectDiv10(){
		$.get(basepath+"/common/codeList?type=educationCode",function(data){
			var html = '<option value="">全部</option>';
			for(var i=0; i<data.length; i++){
				html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
			}
			$('#educationCode10').html(html);
		},"JSON");
	}
function showMember10(flag,id,thisfamilyNo){
		if(flag=="insert"){
			$.get(basepath+"/pamsr/familyMemberInfo",function(data){
				var objArry=data.data;
				var html = '<input type="hidden" name="familyNo" value="'+familyNo+'">';
				html+='<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian10\').click();"><img src="/img/defPhoto.png" id="photoImgm10" style="width:100px;height:100px;"/></a><input type="hidden" id="photom10" name="photo"/><input name="tupian" id="tupian10"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				for(var i=0; i<objArry.length; i++){
					if(objArry[i].dataInputType=="img"){//过滤【用户照片】
						continue;
					}
					if(objArry[i].colENName=="age"){
						continue;
					}
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
					if(objArry[i].dataInputType=="text"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"/>';
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
					}else if(objArry[i].dataInputType=="textArea"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'"></input>';
					}else if(objArry[i].dataInputType=="radio"){
						if('workAbility'==objArry[i].colENName){
							html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>有';
							html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">无</div>';
						}else{
							html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
							html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
						}
						 
					}else{
						html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
					}
					html+='</div>';
				}
				html+='<span class="btn btn-primary fr" onclick="submitForm10();">保存</span>';
				$("#showForm10").html(html);
				$("#myModalLabel10").html("添加");
				$('#myModal10').modal();
				
				$('#tupian10').fileupload({
					url : '/pafb/upload',
//			        dataType: 'json',
					add: function (e, data) {
						var uploadErrors = [];
 						 console.log(data.originalFiles[0]['size']) ;
  					if (data.originalFiles[0]['size'] > 1*1024*1024) {
     						 uploadErrors.push('上传文件不能超过1M');
  						}
 						 if(uploadErrors.length > 0) {
      				alert(uploadErrors.join("\n"));
  					} else {
    					  data.submit();
 						 }
			        },
			        done: function (e, data) {
			        	var obj=data.result.data;
			        	$("#photom10").val(obj.filePath);;
			        	$("#photoImgm10").attr("src", obj.filePath);
//			            $.each(data.result.files, function (index, file) {
//			                $('<p/>').text(file.name).appendTo(document.body);
//			            });
			        }
			    });
			},"JSON");
		}else if(flag=="update"){
			$.get(basepath+"/pamsr/familyMemberInfo?id="+id,function(data){
				var objArry=data.data;
				var relationshipCode='';
				var html = '<input type="hidden" name="familyNo" value="'+thisfamilyNo+'"><input type="hidden" name="id" value="'+id+'"/>';
				html+='<div class="input-group" style="width:760px;"><a href="javascript:;" onclick="javascript:$(\'#tupian10\').click();"><img src="/img/defPhoto.png" id="photoImgm10" style="width:100px;height:100px;"/></a><input type="hidden" id="photom10" name="photo"/><input name="tupian" id="tupian10"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				var photoImgSrc='';
				for(var i=0; i<objArry.length; i++){
					 if(objArry[i].dataInputType=="img"){//过滤【用户照片】
						 photoImgSrc=objArry[i].value;
					 	continue;
					}
					 if(objArry[i].colENName=="age"){
							continue;
						}
					 if(objArry[i].colENName=='relationshipCode'){
							relationshipCode=objArry[i].value;
						}
					html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span>';
					if(objArry[i].dataInputType=="text"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+(objArry[i].value==null?"":objArry[i].value)+'"/>';
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
					}else if(objArry[i].dataInputType=="textArea"){
						html +='<input type="text" class="form-control" style="width:250px;" name="'+objArry[i].colENName+'" value="'+objArry[i].value+'" />';
					}else if(objArry[i].dataInputType=="radio"){
						if('workAbility'==objArry[i].colENName){
							if(objArry[i].value=="是"){
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>有';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">无</div>';
							}else{
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1">有';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0" checked>无</div>';
							}
						}else{
							if(objArry[i].value=="是"){
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1" checked>是';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0">否</div>';
							}else{
								html+='<div class="form-control" style="width:250px;"><input type="radio" name="'+objArry[i].colENName+'" value="1">是';
								html+='<input type="radio" name="'+objArry[i].colENName+'" value="0" checked>否</div>';
							}
						}
					}else{
						html +='<span class="form-control" style="width:250px;">'+objArry[i].value+'</span>';
					}
					html+='</div>';
				}
				html+='<span class="btn btn-primary fr" onclick="submitForm10();">保存</span>';
				$("#showForm10").html(html);
				$("#myModalLabel10").html("编辑");
				$('#myModal10').modal();
				
				if(relationshipCode=='本人'){
					$("#showForm10 select[name='relationshipCode']").attr("disabled", isDisabled);
					$("#showForm10 input[name='memberName']").attr("disabled",isDisabled);
					$("#showForm10 input[name='certificateNo']").attr("disabled",isDisabled);
					$("#showForm10 select[name='certificateTypeCode']").attr("disabled",isDisabled);
				}
				
				$('#tupian10').fileupload({
					url : '/pafb/upload',
//			        dataType: 'json',
					add: function (e, data) {
						var uploadErrors = [];
 						 console.log(data.originalFiles[0]['size']) ;
  					if (data.originalFiles[0]['size'] > 1*1024*1024) {
     						 uploadErrors.push('上传文件不能超过1M');
  						}
 						 if(uploadErrors.length > 0) {
      				alert(uploadErrors.join("\n"));
  					} else {
    					  data.submit();
 						 }
			        },
			        done: function (e, data) {
			        	var obj=data.result.data;
			        	$("#photom10").val(obj.filePath);;
			        	$("#photoImgm10").attr("src", obj.filePath);
//			            $.each(data.result.files, function (index, file) {
//			                $('<p/>').text(file.name).appendTo(document.body);
//			            });
			        }
			    });
				$("#photom10").val(photoImgSrc);
				if(photoImgSrc!=null&&photoImgSrc!=""){
					$("#photoImgm10").attr("src", photoImgSrc);
				}
	        	
			},"JSON");
		}else{
			$.get(basepath+"/pamsr/familyMemberInfo?id="+id,function(data){
				var objArry=data.data;
				var html = '';
				var photo='<div class="input-group" style="width:760px;"><img src="/img/defPhoto.png" id="photoImgm10" style="width:100px;height:100px;"/><input type="hidden" id="photom10" name="photo"/><input name="tupian" id="tupian10"  type="file" class="form-control" style="width:250px; display:none;" multiple accept="image/*"></div>';
				var photoImgSrc='';
				for(var i=0; i<objArry.length; i++){
					if(objArry[i].colENName=='photo'){
						photoImgSrc=objArry[i].value;
						continue;
					}
					if('workAbility'==objArry[i].colENName){
						if(objArry[i].value=="是"){
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">有</span></div>';
						}else{
							html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">无</span></div>';
						}
					}else{
						html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">'+objArry[i].colCNName+'</span><span class="form-control" style="width:250px;">'+(objArry[i].value==null?"":objArry[i].value)+'</span></div>';
					}
				}
				$("#showForm10").html(photo+html);
				$("#myModalLabel10").html("查看详情");
				$('#myModal10').modal();
				$("#photom10").val(photoImgSrc);
				if(photoImgSrc!=null&&photoImgSrc!=""){
					$("#photoImgm10").attr("src", photoImgSrc);
				}
			},"JSON");
		}
	}
	function submitForm10(){
		if(!$("#showForm10").valid()){
			return false;
		}
		$("#myModal10").modal('hide');
		$.ajax({  
	          type : "post",  
	          url : basepath+"/pamsr/checkFamilyMemberInfo",  
	          data : $("#showForm10").serialize(),
	          dataType:"JSON",
	          success : function(data){ 
	        	  if(data.success==true){
	        		  $.ajax({  
		    	          type : "post",  
		    	          url : basepath+"/pamsr/saveFamilyMemberInfo",  
		    	          data : $("#showForm10").serialize(),
		    	          dataType:"JSON",
		    	          success : function(data){  
		    	        	  alert("保存成功");
		    	        	  //$('#table').bootstrapTable("refresh",{query: {offset:0}});
		    	        	  $('#table10').bootstrapTable("refresh");
		    	          }  
		    	     });
	        	  }else{
	        		  alert("家庭主要社会关系只能有一个户主！");
	        	  }
	        	  
	          }  
	     });
	}
	function deleteById10(id){
		if(confirm("确认删除？")){
			$.ajax({  
		          type : "post",  
		          url : basepath+"/pamsr/deleteById",  
		          data : {id:id},
		          dataType:"JSON",
		          success : function(data){  
		        	  //alert("删除成功");
		        	  $('#table10').bootstrapTable("refresh");
		          }  
		     });
		}
		
	}