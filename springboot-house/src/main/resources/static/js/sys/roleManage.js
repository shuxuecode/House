$(function(){
	$("#showForm2").validate({
		
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
			rolename : {
				required: true,
				minlength:1,
		        maxlength:20
			},
			privilegeids : {
				required: true
			}
		}
		
	});
})

$(function(){
	$('#table2').bootstrapTable({
		url: basepath + "/user/roleList",
		cache: false,
		pagination: true,
		pageList: [10,20],
		pageSize:10,
		pageNumber:1,
		sidePagination:'server',//设置为服务器端分页
		queryParams: function (params) {
			console.log(params);
	        return {
	            pageSize: params.limit,
	            offset: params.offset,
	            sortOrder: params.order,
	            roleName:$("#roleName2").val()
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'rolename',
				title: '角色名称',
				align: 'center',
				valign: 'middle'
			}, {
				field: 'rolePrivilege',
				title: '角色权限',
				align: 'center',
				valign: 'middle'
			}, {
				title: '操作',
				width: 145,
				align: 'center',
				valign: 'middle',
				formatter: function(value,row,index){
//					return "<button class='btn btn-sm btn-primary' href='javascript:showModel4(\"update\","+row.id+","+row.familyNo+");'>编辑</button>&nbsp;"+
//					"<button class='btn btn-sm btn-primary' href='javascript:deleteById4("+row.id+");'>删除</button>&nbsp;"+
					return	"<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate2("+JSON.stringify(row)+");'>编辑</button>&nbsp;"+
					"<button class='btn btn-sm btn-primary' onclick='javascript:showQuery2("+JSON.stringify(row)+");'>查看详情</button>";
				}
			}]
		});
	
	
	$("#search2").click(function(){
		$('#table2').bootstrapTable("refresh",{query: {offset:0}});
	});
//	$('#table1').on("click-row.bs.table",function(e,row){
//		console.log(row);
//	});
});
function showInsert2(){
	$.ajax({  
        type : "post",  
        url : basepath+"/user/showRoleOperator",  
        dataType:"JSON",
        success : function(data){
        	var allPrivileges=data.data.allPrivileges;
        	var html = '';
        	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">角色名称</span><input class="form-control" style="width:250px;" name="rolename"></input></div>';
        	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">选择权限</span>';
        	html+='<ul class="form-control form-ul" style="width:700px;height:auto;">'
        	for(var i=0;i<allPrivileges.length;i++){
        		if(i==0){
        			html += '<li><label class="checkbox-inline"><input type="checkbox" name="privilegeids" value="'+allPrivileges[i].id+'" checked>'+allPrivileges[i].name+'</label></li>';
        		}else{
        			html += '<li><label class="checkbox-inline"><input type="checkbox" name="privilegeids" value="'+allPrivileges[i].id+'">'+allPrivileges[i].name+'</label></li>';
        		}
        		
        	}
        	html+='</ul></div>';
        	html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
        	$("#showForm2").html(html);
        	$("#myModalLabel2").html("添加");
        	$('#myModal2').modal();
        }  
   });
}
function showUpdate2(jsonrow){
	$.ajax({  
        type : "post",  
        url : basepath+"/user/showRoleOperator", 
        data:{id:jsonrow.id},
        dataType:"JSON",
        success : function(data){
        	var allPrivileges=data.data.allPrivileges;
        	var rolePrivilege=data.data.rolePrivilege;
        	var rolePrivileges=rolePrivilege.split(",");
        	var html = '<input type="hidden" name="id" value="'+jsonrow.id+'"></input>';
        	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">角色名称</span><input class="form-control" style="width:250px;" name="rolename" value="'+formatNull(jsonrow.rolename)+'"></input></div>';
        	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">选择权限</span>';
        	html+='<ul class="form-control form-ul" style="width:700px;height:auto;">'
        	for(var i=0;i<allPrivileges.length;i++){
        		var flag=true;
        		for(var j=0;j<rolePrivileges.length;j++)
        		if(rolePrivileges[j]==allPrivileges[i].name){
        			html += '<li><label class="checkbox-inline"><input type="checkbox" name="privilegeids" value="'+allPrivileges[i].id+'" checked>'+allPrivileges[i].name+'</label></li>';
        			flag=false;
        		}
        		if(flag){
        			html += '<li><label class="checkbox-inline"><input type="checkbox" name="privilegeids" value="'+allPrivileges[i].id+'">'+allPrivileges[i].name+'</label></li>';
        		}
        		
        	}
        	html+='</ul></div>';
        	html+='<span class="btn btn-primary fr" onclick="submitForm2();">保存</span>';
        	$("#showForm2").html(html);
        	$("#myModalLabel2").html("编辑");
        	$('#myModal2').modal();
        }  
   });
}
function submitForm2(){
	if(!$("#showForm2").valid()){
		return false;
	}
	$.ajax({  
        type : "post",  
        url : basepath+"/user/saveRole",  
        data : $("#showForm2").serialize(),
        dataType:"JSON",
        success : function(data){  
      	  alert("保存成功");
      	  $("#myModal2").modal('hide');
      	  $('#table2').bootstrapTable("refresh",{query: {offset:0}});
        }  
   });
}
function showQuery2(jsonrow){
	var html = '';
//	html += '<div class="input-group"><span class="input-group-addon" style="width:97px;">角色名程</span><span class="form-control" style="width:340px;">'+formatNull(jsonrow.rolename)+'</span></div>';
//	var rolePrivilegeArr=jsonrow.rolePrivilege.split(',');
//	for(var i=0;i<rolePrivilegeArr.length;i++){
//		html += '<div class="input-group"><span class="input-group-addon" style="width:97px;">权限名称'+(i+1)+'</span><span class="form-control" style="width:340px;">'+formatNull(rolePrivilegeArr[i])+'</span></div>';
//	}
	
	html += '<div class="clearfix"><span class="fl">角色名程：</span><p  class="fl">'+formatNull(jsonrow.rolename)+'</p></div>';
	html += '<div class="clearfix"><span class="fl">权限名称：</span><ul class="fl">';
	var rolePrivilegeArr=jsonrow.rolePrivilege.split(',');
	for(var i=0;i<rolePrivilegeArr.length;i++){
		html += '<li>'+formatNull(rolePrivilegeArr[i])+'</li>';
	}
	html += '</ul></div>';
	$("#showForm2").html(html);
	$("#myModalLabel2").html("查看详情");
	$('#myModal2').modal();
}



function formatNull(value){
	if(value==null){
		return "-";
	}else{
		return value;
	}
}
