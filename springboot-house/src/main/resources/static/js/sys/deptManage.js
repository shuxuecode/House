$(function(){
	$("#deptForm").validate({
		
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
			deptname : {
				required: true,
				minlength:1,
		        maxlength:20
			}
		}
		
	});
})

$(function(){
	$('#table4').bootstrapTable({
		url: basepath + "/user/deptList",
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
	            deptName:$("#deptname").val()
	        }
	    },//参数
		sortName: 'id',
	    sortOrder: 'desc',
		minimumCountColumns: 2,
		clickToSelect: true,
		smartDisplay:true,
		columns: [
			{
				field: 'deptname',
				title: '组织机构名称',
				align: 'center',
				valign: 'middle'
			},{
				field: 'depttype',
				title: '组织机构类型',
				align: 'center',
				valign: 'middle',
				formatter:function(value,row,index){
						if(value==null){
							return "-";
						}else if(value==0){
							return "区";	
						}else{
							return "市";
						}
				}
			}, {
				field: 'remark',
				title: '组织机构描述',
				align: 'center',
				valign: 'middle'
			}, {
				title: '操作',
				width: 145,
				align: 'center',
				valign: 'middle',
				formatter: function(value,row,index){
					return	"<button class='btn btn-sm btn-primary' onclick='javascript:showUpdate4("+JSON.stringify(row)+");'>编辑</button>&nbsp;"+
					"<button class='btn btn-sm btn-primary dn' onclick='javascript:showQuery4("+JSON.stringify(row)+");'>查看详情</button>";
				}
			}]
		});
	
	
	$("#search4").click(function(){
		$('#table4').bootstrapTable("refresh",{query: {offset:0}});
	});

});
function showInsert4(){
	var html = '';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织机构名称</span><input class="form-control" style="width:250px;" name="deptname"></input></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织机构描述</span>';
	html += '<input class="form-control" style="width:250px;" name="remark"></input></div>';
	
	html+='<span class="btn btn-primary fr" onclick="submitForm4();">保存</span>';
	$("#deptForm").html(html);
	$("#deptModalLabel").html("添加");
	$('#deptModal').modal();
}
function showUpdate4(jsonrow){
	var html = '<input type="hidden" name="id" value="'+jsonrow.id+'"></input>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织机构名称</span><input class="form-control" style="width:250px;" name="deptname" value="'+formatNull(jsonrow.deptname)+'"></input></div>';
	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">组织机构描述</span>';
	html += '<input class="form-control" style="width:250px;" name="remark" value="'+formatNull(jsonrow.remark)+'"></input></div>';
	
	html+='<span class="btn btn-primary fr" onclick="submitForm4();">保存</span>';
	$("#deptForm").html(html);
	$("#deptModalLabel").html("编辑");
	$('#deptModal').modal();
}
function submitForm4(){
	if(!$("#deptForm").valid()){
		return false;
	}
	$.ajax({  
        type : "post", 
        url : basepath+"/user/saveDept", 
        data : $("#deptForm").serialize(),
        dataType:"JSON",
        success : function(data){
      	  alert("保存成功");
      	  $("#deptModal").modal('hide');
      	  $('#table4').bootstrapTable("refresh",{query: {offset:0}});
        }  
   });
}

//function showQuery2(jsonrow){
//	var html = '';
//	html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">角色名程</span><span class="form-control" style="width:250px;">'+formatNull(jsonrow.rolename)+'</span></div>';
//	var rolePrivilegeArr=jsonrow.rolePrivilege.split(',');
//	for(var i=0;i<rolePrivilegeArr.length;i++){
//		html += '<div class="input-group"><span class="input-group-addon" style="width:150px;">权限名称'+(i+1)+'</span><span class="form-control" style="width:250px;">'+formatNull(rolePrivilegeArr[i])+'</span></div>';
//	}
//	$("#showForm2").html(html);
//	$("#myModalLabel2").html("查看详情");
//	$('#myModal2').modal();
//}



