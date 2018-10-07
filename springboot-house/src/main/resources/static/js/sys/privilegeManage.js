$(function(){
	
	
	loadPrivilegeTable();
	
//	loadSelectOperator3();
	
	$("#search3").click(function(){
//		$('#table3').bootstrapTable("refresh",{query: {offset:0}});
		$('#table3').bootstrapTable("refresh");
	});
	
	
	
	$("#privilegeForm3").validate({
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
				required: true
			},
			menu : {
//				required: true
			},
			url : {
				required: true
//			},
//			operator : {
//				required: true
			}
		}
	});
	
});


function loadPrivilegeTable(){
	$('#table3').bootstrapTable({
		url: basepath + "/user/getPrivileges",
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
	            sort: params.sort,
	            sortOrder: params.order,
	            name : $("#name3").val(),
	            url : $("#url3").val(),
	    		menu : $("#menu3").val(),
	    		operator : ''
	    		//operator : $("#operator3").val()
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		clickToSelect: true,
		columns: [
			{
				field: 'name',
				title: '权限名称',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'url',
				title: '可访问地址',
				align: 'center',
				valign: 'middle'
			},{
				field: 'menu',
				title: '菜单权限',
				align: 'center',
				valign: 'middle'
//			},{
//				field: 'operatorValue',
//				title: '操作权限',
//				align: 'center',
//				valign: 'middle'
			},{
				title: '<button class="btn btn-success" onclick="privilegeModel(\'insert\')">添加</button>&nbsp;&nbsp;'
						+'<button class="btn btn-danger dn" onclick="deleteById()">删除</button>',
				align: 'center',
				valign: 'middle',
				formatter : function(value, row, index){
					return '<button class="btn btn-info btn-sm" '
					+ 'onclick="privilegeModel(\'update\',\'' + row.id + '\',\''+row.name+'\',\''+row.menu+'\',\''+row.url+'\')">编辑</button>'
					+ '&nbsp;<button class="btn btn-info btn-sm" '
						+ 'onclick="privilegeModel(\'show\',\'' + row.id + '\',\''+row.name+'\',\''+row.menu+'\',\''+row.url+'\')">详情</button>';
				}
			}]
		});
}

template.helper('radioChecked', function (v1, v2) {
	if(v2 == ""){
		return "";
	}
	if(v2 == v1){
		return "checked";
	}
	return "";
});

//function loadSelectOperator3(){
//	$.get(basepath + "/common/codeList?type=operator",function(data){
//		var html = '<option value="">全部</option>';
//		for(var i=0; i<data.length; i++){
//			html += '<option value="' + data[i].code + '">' + data[i].name + '</option>';
//		}
//		$('#operator3').html(html);
//	},"JSON");
//}

function privilegeModel(type, id, name, menu, url, operator, operatorValue){
	if(type == 'show'){
		
		var json = {
				type : "show",
				data : [{
					showName : "权限名称",
					indexValue : name
				},{
					showName : "访问地址",
					indexValue : url
				},{
					showName : "菜单",
					indexValue : menu
				}
//				,{
//					showName : "操作权限",
//					indexValue : operatorValue
//				}
				]
		};
		
//		var html = '';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">权限名称</span><span class="form-control" style="width:250px;">'+formatNull(name)+'</span></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">访问地址</span><span class="form-control" style="width:250px;">'+formatNull(url)+'</span></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">菜单</span><span class="form-control" style="width:250px;">'+formatNull(menu)+'</span></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">操作权限</span><span class="form-control" style="width:250px;">'+formatNull(operatorValue)+'</span></div>';
		var html = template('privilegeTemplate', json);
		$("#privilegeForm3").html(html);
		$("#priviModalLabel3").html("查看详情");
		$('#priviModal3').modal();
	}else if(type == 'insert'){
//		var html = '';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">权限名称</span><input name="name"  type="text" class="form-control" style="width:250px;"></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">访问地址</span><input name="url"  type="text"  class="form-control" style="width:250px;"></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">菜单</span><input name="menu"  type="text"  class="form-control" style="width:250px;"></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">操作权限</span><input name="operator"  type="text"  class="form-control" style="width:250px;"></input></div>';
//		html+='<span class="btn btn-primary fr" onclick="submitPriviForm3();">保存</span>';
		
		$.get(basepath + "/common/codeList?type=operator",function(data){

			var json = {
					type : "insert",
					data : [{
						showName : "权限名称",
						indexCode : "name"
					},{
						showName : "访问地址",
						indexCode : "url"
					},{
						showName : "菜单",
						indexCode : "menu"
//					},{
//						showName : "操作权限",
//						indexCode : "operator",
//						operatorList : data
					}
					]
			};
			var html = template('privilegeTemplate', json);
			$("#privilegeForm3").html(html);
			$("#priviModalLabel3").html("添加");
			$('#priviModal3').modal({backdrop: 'static', keyboard: false});
			
		},"JSON");
		
		
		
	}else if(type == 'update'){
//		var html = '';
//		html+='<input type="hidden" name="id" value="'+id+'">';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">权限名称</span><input name="name"  type="text" class="form-control" style="width:250px;" value="'+formatNull(name)+'"></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">访问地址</span><input name="url"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(url)+'" ></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">菜单</span><input name="menu"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(menu)+'"></input></div>';
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">操作权限</span><input name="operator"  type="text"  class="form-control" style="width:250px;" value="'+formatNull(operator)+'"></input></div>';
//		html+='<span class="btn btn-primary fr" onclick="submitPriviForm3();">保存</span>';
		
		$.get(basepath + "/common/codeList?type=operator",function(data){
			
			var json = {
					type : "update",
					id : id,
					data : [{
						showName : "权限名称",
						indexCode : "name",
						indexValue : name
					},{
						showName : "访问地址",
						indexCode : "url",
						indexValue : url
					},{
						showName : "菜单",
						indexCode : "menu",
						indexValue : menu
//					},{
//						showName : "操作权限",
//						indexCode : "operator",
//						indexValue : operator,
//						operatorList : data
					}
					]
			};
			
			var html = template('privilegeTemplate', json);
			$("#privilegeForm3").html(html);
			$("#priviModalLabel3").html("编辑");
			$('#priviModal3').modal({backdrop: 'static', keyboard: false});
		},"JSON");
		
		
	}
}


function submitPriviForm3(){
	
	if(!$("#privilegeForm3").valid()){
		return false;
	}
	$.ajax({  
        type : "post",  
        url : basepath+"/user/savePrivilege",  
        data : $("#privilegeForm3").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
      	  $("#priviModal3").modal('hide');
      	  
      	  $('#table3').bootstrapTable("refresh");
//      	  $('#table3').bootstrapTable("refresh",{query: {offset:0}});
//      	  var options = $('#table3').bootstrapTable("getOptions");
//      	  options.pageNumber = 1;
//      	  $('#table3').bootstrapTable("refreshOptions", options);
        }  
   });
}
