

$(function(){
	
	
	
	$("#showForm1").validate({
		
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
			userName : {
				required: true,
				minlength:1,
		        maxlength:20
			},
			email : {
				required: true,
				mail:true
			},
			mobile : {
				required: true,
				tm:true
			},
			remark : {
				required: true,
				minlength:1,
		        maxlength:120
			},
			nickName : {
				required: true,
				minlength:1,
		        maxlength:20
			},
			register : {
				required: true
			},
			helpTypeCode : {
				required: true
			},
			userType : {
				required: true
			}
		}
		
	});
})

$(function(){
	$('#table1').bootstrapTable({
		url: basepath + "/user/userList",
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
	            nickName:$("#nickName1").val(),
	            userName:$("#userName1").val(),
	            email:$("#email1").val(),
	            mobile:$("#mobile1").val()
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'nickName',
				title: '用户名',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'userName',
				title: '登录名',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'email',
				title: '邮箱',
				width : 180,
				align: 'center',
				valign: 'middle'
			}, {
				field: 'mobile',
				title: '手机',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'register',
				title: '注册时间',
				align: 'center',
				valign: 'middle',
				width : 150,
				formatter:function(value,row,index){
					return value==undefined?"-":(new Date(value)).Format('yyyy-MM-dd hh:mm:ss');
				}
			}, {
				field: 'remark',
				title: '备注',
				align: 'center',
				valign: 'middle'
			}, {
				title: '操作',
				align: 'center',
				valign: 'middle',
				width : 300,
				formatter: function(value,row,index){
//					return "<button class='btn btn-sm btn-primary' href='javascript:showModel4(\"update\","+row.id+","+row.familyNo+");'>编辑</button>&nbsp;"+
//					"<button class='btn btn-sm btn-primary' href='javascript:deleteById4("+row.id+");'>删除</button>&nbsp;"+
					return	"<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate1("+JSON.stringify(row)+");'>编辑</button>"
					+ "&nbsp;<button class='btn btn-sm btn-primary' onclick='javascript:showQuery1("+JSON.stringify(row)+");'>查看详情</button>"
					+ "&nbsp;<button class='btn btn-sm btn-primary' onclick='javascript:setRoles("+JSON.stringify(row)+");'>分配角色</button>"
					+ "&nbsp;<button class='btn btn-sm btn-primary' onclick='javascript:resetPassword("+row.id+");'>重置密码</button>";
				}
			}]
		});
	
	
	$("#search1").click(function(){
		$('#table1').bootstrapTable("refresh",{query: {offset:0}});
	});
//	$('#table1').on("click-row.bs.table",function(e,row){
//		console.log(row);
//	});
	
	$(document).on("change","select[name='userType']",function(){
		if($(this).val()==5||$(this).val()==7){
			var ptype = ($(this).val()==7)? '7' : '1,2,3,4,5,6';
			var html='<option value="">未选择</option>';
			$.ajax({  
		          type : "post",  
		          url : basepath+"/pahp/query",
		          data : {personposition: ptype},
		          dataType:"JSON",
		          async : false,  
		          success : function(data){
		        	  var data=data.data;
		        	  for(var i=0; i<data.length; i++){
							html += '<option value="' + data[i].id + '">' + '<span>'+data[i].name+'</span>&nbsp;&nbsp;&nbsp;'+'[&nbsp;<span style=\'float:right;\'>'+data[i].personpositionValue+'</span>&nbsp;]' + '</option>';
						} 
		          }  
		     });
			
			$("select[name='personid']").html(html);
		}else{
			$("select[name='personid']").html('<option value="">未选择</option>');
		}
		
		$('#add_personid').selectpicker('refresh');
		$('#personid').selectpicker('refresh');
		
		/*
		 * 1、有过滤条件的 ：  区各部门   市各部门   
		 * 2、查全部的：  帮扶责任人     督导人员    帮扶企业
		 * 3、不显示部门的
		 */
		if($(this).val()==2||$(this).val()==3||$(this).val()==4||$(this).val()==5||$(this).val()==6||$(this).val()==7){
			var deptType=-1;
			if($(this).val()==3){
				deptType=0;
			}
			if($(this).val()==4){
				deptType=1;
			}
			if($(this).val()==2){
				deptType=2;
			}
			var html='<option value="">未选择</option>';
			$.ajax({  
		          type : "post",  
		          url : basepath+"/user/queryDept",  
		          data : {deptType:deptType},
		          dataType:"JSON",
		          async : false,  
		          success : function(data){
		        	  var data=data.data;
		        	  for(var i=0; i<data.length; i++){
							html += '<option value="' + data[i].id + '">' +data[i].deptname + '</option>';
						} 
		          }  
		     });
			
			$("select[name='deptId']").html(html);
		}else{
			$("select[name='deptId']").html('<option value="">未选择</option>');
		}
	});
	
});

function showInsert1(){
	$.get(basepath + "/user/getAllRoles",function(data){
		
		var roleList = data.data;
		
		var html = '';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户名</span><input name="nickName"  type="text" class="form-control" style="width:250px;"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">登录名</span><input name="userName"  type="text"  class="form-control" style="width:250px;"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">邮箱</span><input name="email"  type="text"  class="form-control" style="width:250px;"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">手机</span><input name="mobile"  type="text"  class="form-control" style="width:250px;"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">注册时间</span><input name="register" class="Wdate form-control" style="width:250px;" type="text" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})"/></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">备注</span><input name="remark"  type="text"  class="form-control" style="width:250px;"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户类型</span><select name="userType" class="form-control" style="width:250px;"><option value="">未选择</option>';
		$.ajax({  
	          type : "post",  
	          url : basepath+"/common/codeList",  
	          data : {type:"userType"},
	          dataType:"JSON",
	          async : false,  
	          success : function(data){  
	        	  for(var i=0; i<data.length; i++){
						html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
					} 
	          }  
	     });
		html+="</select></div>";
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">关联人员</span>';
		html += '<select name="personid" id="add_personid" class="form-control" data-size="6" data-live-search="true" style="width:250px;"><option value="">未选择</option>';
		html+="</select></div>";
		//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">分配角色</span>';
//		for(var i=0, len=roleList.length; i<len; i++){
//    		html += '<label class="checkbox-inline"><input type="checkbox" name="roleIds" value="'+roleList[i].id+'">'+roleList[i].name+'</label>';
//    	}
		html += '<div class="input-group">';
		html += '<span class="input-group-addon" style="width:150px;">组织机构</span>';
		html += '<select name="deptId" class="form-control" style="width:250px;">';
		html += "</select></div>";
		html+='<span class="btn btn-primary fr" onclick="submitForm1();">保存</span>';
		$("#showForm1").html(html);
		$("#myModalLabel1").html("添加");
		$('#myModal1').modal();
		
		$('#add_personid').selectpicker({
			style : "h34px"
		});
		// 主要和次要致贫原因
//		$.get("${basePath }/common/codeList?type=poorCauseCode",function(data){
//			var html = '<option value="">未选择</option>';
//			for(var i=0; i<data.length; i++){
//				html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
//			}
//			$('#add_personid').html(html);
//			
//			
//			
//		},"JSON");
		
	},"JSON");
}
	
function showUpdate1(jsonrow){
	$.get(basepath + "/user/getAllRoles",function(data){
		
		var roleList = data.data;
		
		var roleIds = ',' + jsonrow.roleIds + ',';
		
		var html = '';
		html+='<input type="hidden" name="id" value="'+jsonrow.id+'">';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户名</span><input name="nickName"  type="text" class="form-control" style="width:250px;" value="'+formatNull(jsonrow.nickName)+'"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">登录名</span><input name="userName"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(jsonrow.userName)+'" ></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">邮箱</span><input name="email"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(jsonrow.email)+'"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">手机</span><input name="mobile"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(jsonrow.mobile)+'"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">注册时间</span><input name="register" class="Wdate form-control" style="width:250px;" type="text" value="'+formatNull((jsonrow.register==undefined?"-":(new Date(jsonrow.register)).Format('yyyy-MM-dd hh:mm:ss')))+'" onFocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})"/></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">备注</span><input name="remark"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(jsonrow.remark)+'"></input></div>';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户类型</span><select id="userType" name="userType" class="form-control" style="width:250px;"><option value="">未选择</option>';
		$.ajax({  
	          type : "post",  
	          url : basepath+"/common/codeList",  
	          data : {type:"userType"},
	          dataType:"JSON",
	          async : false,  
	          success : function(data){  
	        	  for(var i=0; i<data.length; i++){
						html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
					} 
	          }  
	     });
		html+="</select></div>";
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">关联人员</span>';
		html += '<select id="personid" name="personid" class="form-control" data-size="6" data-live-search="true" style="width:250px;"><option value="">未选择</option>';
		html+="</select></div>";
		
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">分配角色</span>';
//		for(var i=0, len=roleList.length; i<len; i++){
//			if(roleIds.indexOf(',' + roleList[i].id + ",") !== -1){
//				html += '<label class="checkbox-inline"><input type="checkbox" name="roleIds" value="'+roleList[i].id+'" checked>'+roleList[i].name+'</label>';
//			}else{
//				html += '<label class="checkbox-inline"><input type="checkbox" name="roleIds" value="'+roleList[i].id+'">'+roleList[i].name+'</label>';
//			}
//    	}
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织机构</span><select id="deptId" name="deptId" class="form-control" style="width:250px;"><option value="">未选择</option>';
		html+="</select></div>";
		html+='<span class="btn btn-primary fr" onclick="submitForm1();">保存</span>';
		$("#showForm1").html(html);
		$("#myModalLabel1").html("编辑");
		$('#myModal1').modal();
		
		$("#userType").val(jsonrow.userType);
		if(jsonrow.userType==5||jsonrow.userType==7){
			var html='<option value="">未选择</option>';
			$.ajax({  
		          type : "post",  
		          url : basepath+"/pahp/query",  
		          data : {},
		          dataType:"JSON",
		          async : false,  
		          success : function(data){  
		        	  var data=data.data
		        	  for(var i=0; i<data.length; i++){
		        		  html += '<option value="' + data[i].id + '">' + '<span>'+data[i].name+'</span>&nbsp;&nbsp;&nbsp;'+'[&nbsp;<span style=\'float:right;\'>'+data[i].personpositionValue+'</span>&nbsp;]' + '</option>';
						} 
		          }  
		     });
			
			$("select[name='personid']").html(html);
		}
		$("#personid").val(jsonrow.personid);
		$('#personid').selectpicker({
			style : "h34px"
		});
		
		if(jsonrow.userType==2||jsonrow.userType==3||jsonrow.userType==4||jsonrow.userType==5||jsonrow.userType==6||jsonrow.userType==7){
			var deptType=-1;
			if(jsonrow.userType==3){
				deptType=0;
			}
			if(jsonrow.userType==4){
				deptType=1;
			}
			if(jsonrow.userType==2){
				deptType=2;
			}
			var html='<option value="">未选择</option>';
			$.ajax({  
		          type : "post",  
		          url : basepath+"/user/queryDept",  
		          data : {deptType:deptType},
		          dataType:"JSON",
		          async : false,  
		          success : function(data){
		        	  var data=data.data;
		        	  for(var i=0; i<data.length; i++){
							html += '<option value="' + data[i].id + '">' +data[i].deptname + '</option>';
						} 
		          }  
		     });
			
			$("select[name='deptId']").html(html);
		}else{
			$("select[name='deptId']").html('<option value="">未选择</option>');
		}
		$("#deptId").val(jsonrow.deptId);
		
	},"JSON");
	
}
function submitForm1(){
	if(!$("#showForm1").valid()){
		return false;
	}
	$.ajax({  
        type : "post",  
        url : basepath+"/user/saveUser",  
        data : $("#showForm1").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
      	  $("#myModal1").modal('hide');
//      	  $('#table1').bootstrapTable("refresh",{query: {offset:0}});
      	  $('#table1').bootstrapTable("refresh");
        }  
   });
}
function showQuery1(jsonrow){
	var html = '';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户名</span><span class="form-control" style="width:280px;">'+formatNull(jsonrow.nickName)+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">登录名</span><span class="form-control" style="width:280px;">'+formatNull(jsonrow.userName)+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">邮箱</span><span class="form-control" style="width:280px;">'+formatNull(jsonrow.email)+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">手机</span><span class="form-control" style="width:280px;">'+formatNull(jsonrow.mobile)+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">注册时间</span><span class="form-control" style="width:280px;">'+formatNull((jsonrow.register==undefined?"-":(new Date(jsonrow.register)).Format('yyyy-MM-dd hh:mm:ss')))+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">备注</span><span class="form-control" style="width:280px;">'+formatNull(jsonrow.remark)+'</span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">用户类型</span><span class="form-control" id="userType" style="width:280px;"></span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">关联人员</span><span class="form-control" id="personid" style="width:280px;"></span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织结构</span><span class="form-control" id="deptId" style="width:280px;"></span></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">拥有角色</span><span class="form-control" style="width:720px;">'+formatNull(jsonrow.roleNames)+'</span></div>';
	
	
	$("#showForm1").html(html);
	$("#myModalLabel1").html("查看详情");
	$('#myModal1').modal();
	
	
	$.ajax({  
        type : "post",  
        url : basepath+"/common/codeList",  
        data : {type:"userType"},
        dataType:"JSON",
        async : false,  
        success : function(data){ 
        	
      	  for(var i=0; i<data.length; i++){
      		  		if(jsonrow.userType==data[i].code){
      		  			$("#userType").text(data[i].name);
      		  		}
		  } 
        }  
   });
	
	if(jsonrow.userType==5||jsonrow.userType==7){
		$.ajax({  
	          type : "post",  
	          url : basepath+"/pahp/query",  
	          data : {},
	          dataType:"JSON",
	          async : false,  
	          success : function(data){  
	        	  var data=data.data
	        	  for(var i=0; i<data.length; i++){
	        		  if(data[i].id==jsonrow.personid){
	        			  $("#personid").text(data[i].name+'   '+'[ '+data[i].personpositionValue+' ]');
	        		  }
					} 
	          }  
	     });
	}
	
	if(jsonrow.userType==2||jsonrow.userType==3||jsonrow.userType==4||jsonrow.userType==5||jsonrow.userType==6||jsonrow.userType==7){
		var deptType=-1;
		if(jsonrow.userType==3){
			deptType=0;
		}
		if(jsonrow.userType==4){
			deptType=1;
		}
		if(jsonrow.userType==2){
			deptType=2;
		}
		$.ajax({  
	          type : "post",  
	          url : basepath+"/user/queryDept",  
	          data : {deptType:deptType},
	          dataType:"JSON",
	          async : false,  
	          success : function(data){
	        	  var data=data.data;
	        	  for(var i=0; i<data.length; i++){
	        		  if(data[i].id==jsonrow.deptId){
	        			  $("#deptId").text(data[i].deptname);
	        		  }
					} 
	          }  
	     });
	}
}

function setRoles(jsonrow){
	$.get(basepath + "/user/getAllRoles",function(data){
		var roleList = data.data;
		var roleIds = ',' + jsonrow.roleIds + ',';
		var html = '';
		html+='<input type="hidden" name="id" value="'+jsonrow.id+'">';
		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">角色列表</span>';
		for(var i=0, len=roleList.length; i<len; i++){
			if(roleIds.indexOf(',' + roleList[i].id + ",") !== -1){
				html += '<label class="checkbox-inline"><input type="radio" name="roleIds" value="'+roleList[i].id+'" checked>'+roleList[i].name+'</label>';
			}else{
				html += '<label class="checkbox-inline"><input type="radio" name="roleIds" value="'+roleList[i].id+'">'+roleList[i].name+'</label>';
			}
		}
		html += '</div>';
		html+='<span class="btn btn-primary fr" onclick="saveUserRoles();">保存</span>';

		$("#setRoleForm").html(html);
		$("#setRoleModalLabel").html("分配角色");
		$('#setRoleModal').modal();
	
	},"JSON");
	
	
}

function saveUserRoles(){
	var formData = $("#setRoleForm").serialize();
	$.ajax({  
        type : "post",  
        url : basepath+"/user/allowRole",
        data : formData,
        dataType:"JSON",
        success : function(data){  
      	  alert("分配角色成功");
      	  $("#setRoleModal").modal('hide');
//      	  $('#table1').bootstrapTable("refresh",{query: {offset:0}});
      	  $('#table1').bootstrapTable("refresh");
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

function resetPassword(userId){
	$.ajax({  
        type : "post",  
        url : basepath+"/user/savePassword",  
        data : {password:'123456',userId:userId},
        dataType:"JSON",
        success : function(data){  
      	  alert("重置密码成功");
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