$(function(){
	loadData6();
	$("#showForm6").validate({
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
			family_disposable_income : {
				number : true
			}, 
			wage_income : {
				number : true
			}, 
			product_operate_income : {
				number : true
			}, 
			property_net_income : {
				number : true
			}, 
			transfer_net_income : {
				number : true
			}, 
			benefit_farm_subsidy : {
				number : true
			}, 
			outworker_send : {
				number : true
			}, 
			subsistence_fund : {
				number : true
			}, 
			five_guarantee_fund : {
				number : true
			}, 
			endowment_insurance_fund : {
				number : true
			}, 
			ecological_compensation_fund : {
				number : true
			}, 
			life_subsidy : {
				number : true
			}, 
			other_transfer_income : {
				number : true
			}, 
			disposable_income_per_person : {
				number : true
			}
		}
	});
	
	$("#showForm9").validate({
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
			isCardcastleTurn : {
				required: true
			}, 
			allowanceSum : {
				required: true,
				number : true
			}, 
			paYear : {
				required: true
			}
		}
	});
	
});

var yearsArray = new Array();
//脱贫年份数组
var yearArr = new Array();

/**
 * 得到年份数组
 */
function getYearList(years){
	var yearStr = "";
	for(var i=0, len = years.length; i<len; i++){
		yearStr += years[i].year + ',';
	}
	//var curYear = new Date().getFullYear();
	//var year1 = curYear - 4; // 
	//var year2 = curYear + 2; // 
	
	var year1 = 2015; // 
	var year2 = 2020; // 
	
	yearsArray = new Array();
	for(var i=year2; year1<i; i--){
		if(yearStr.indexOf(i+",") == -1){
			yearsArray.push(i);
		}
	}
	// 脱贫年份数组
	yearArr = new Array();
	for(var i=year2; year1<i; i--){
		yearArr.push(i);
	}
	
}

function loadData6(){
	$.post(basepath + "/paInfo/familyAssessmentInfo",
			{familyNo : familyNo},
			function(data){
//				console.log(data);
				
				var years = data.data.year;
				var yearL = years.length;
				
				var html = '<tr>';
				var html2 = '<tr>';
				html += '<th rowspan=2 colspan=2>统计项目</th>';
				html += '<th rowspan=2 style="border-left: 1px solid #ccc; border-right: 1px solid #ccc;">单位</th>';
				html += '<th colspan=' + yearL + ' style="border-bottom: 1px solid #ccc; padding:5px">年度收入情况';
				if(btn_8110){
					html += '<a class="btn" onclick="showModel6(\'insert\');" style="text-decoration: none;">添加</a>';
				}
				html += '</th>';
				for(var i=0; i<yearL; i++){
					html2 += '<th><p style="font-size:14px">' + years[i].year + '年</p>';
					if(btn_8111){
						html2 += '<a class="" style="padding:0px 6px" onclick="showModel6(\'update\', \'' + years[i].year + '\')">修改</a>';
					}
					// html2 += '<a class="" style="padding:0px 6px" onclick="deleteData6(\'' + years[i].year + '\')">删除</a>';
					html2 += '</th>';
				}
				html += '</tr>';
				html2 += '</tr>';
				$("#th").html(html + html2);
				
				
				
				html = '';
				var indexs = data.data.index;
				for(var i=0; i<indexs.length; i++){
					html += '<tr>';
					
					// 优化样式，仿真实表格样式
					if(i === 0){
						html += '<td rowspan=' + indexs.length + ' style="width: 30px; vertical-align: middle;">家庭收入评估</td>';
					}
					
					html += '<td style="text-align: left; padding-left: 70px; width: 300px;">';
					html += '' + indexs[i].showName;
					html += '</td>';
					html += '<td>';
					html += '' + indexs[i].indexUnit;
					html += '</td>';
					
					for(var j=0; j<yearL; j++){
						html += '<td>';
						var key = years[j].year + '_' + indexs[i].indexCode;
						
						var value = data.data.object[key];
						if(value){
							html += value;
						}else{
							html += '';
						}
						html += '</td>';
					}
					if(yearL === 0){
						html += '<td></td>';
					}
					
					html += '</tr>';
				}
				$("#tb").html(html);
				
				html = '<tr>';
				var main = data.data.main;
				for(var i=0; i<main.length; i++){
					if(main[i].showName == "是否完成危房改造"){
						html += '<td style="font-weight:600">' + main[i].showName + '</td>';
						if(main[i].value == 1){
							html += '<td>是</td>';
						}else{
							html += '<td>否</td>';
						}
					}else{
						html += '<td style="font-weight:600">' + main[i].showName + '</td>';
						html += '<td>' + (main[i].value == undefined ? "无数据" : main[i].value) + '</td>';
					}
					
					if(main[i].colENName == 'isCardcastleTurn'){
						if(main[i].value == 1){
							$("#isCardcastleTurn1").removeAttr("checked");
							$("#isCardcastleTurn2").removeAttr("checked");
							$("#isCardcastleTurn1").prop("checked", true);
						}else{
							$("#isCardcastleTurn1").removeAttr("checked");
							$("#isCardcastleTurn2").removeAttr("checked");
							$("#isCardcastleTurn2").prop("checked", true);
						}
					}else if(main[i].colENName == 'allowanceSum'){
						$("#allowanceSum3").val(main[i].value == undefined ? "0" : main[i].value);
					}else if(main[i].colENName == 'paYear'){
						$("#cur_paYear4").val(main[i].value == undefined ? "" : main[i].value);
					}
				}
				html += '</tr>';
				$('#tb2').html(html);
				
				//
				getYearList(data.data.year);
				
	},"JSON");
}

function showModel6(type, year){
	if(type == 'insert'){
		$.post(basepath + "/paInfo/familyAssessmentInfoField",
				{familyNo : familyNo, year : 0},
				function(data){
					// 如果所有年份都已添加，则不允许再添加数据
					if(yearsArray.length === 0){
						alert("指定年份都已添加，暂时无法添加其它年份的数据！");
						return false;
					}
					data.yearList = yearsArray;
					var html = template('template_6', data);
					$("#showForm6").html(html);
					$("#myModalLabel6").html("添加");
					$("#myModal6").modal();
		},"JSON");
	}else if(type == 'update'){
		$.post(basepath + "/paInfo/familyAssessmentInfoField",
				{familyNo : familyNo, year : year},
				function(data){
					data.yearList = yearsArray;
					data.selectYear = year;
					var html = template('template_6', data);
					$("#showForm6").html(html);
					$("#myModalLabel6").html("修改");
					$("#myModal6").modal();
		},"JSON");
	}
	
	
}


function submitForm6(){
	if(!$("#showForm6").valid()){
		return false;
	}
	var formData = $("#showForm6").serializeArray();
	formData.push({ name : "familyNo", value : familyNo });
//	formData.push({ name : "year", value : $("#year6").val() });
	$.post(basepath + "/paInfo/saveFamilyAssessmentInfo",
			formData,
			function(data){
				alert("保存成功");	
		      	$("#myModal6").modal('hide');
		      	loadData6();
	});
}

function deleteData6(year){
	if(confirm("确认删除？")){
		$.ajax({  
	          type : "post",  
	          url : basepath+"/paInfo/deleteFamilyAssessmentInfo",  
	          data : {familyNo : familyNo, year : year},
	          dataType:"JSON",
	          success : function(data){
	        	  alert("删除成功");
	        	  loadData6();
	          }  
	     });
	}
}



function showModel9(){
	
	var cur_year = $("#cur_paYear4").val();
	
	$("#paYear4").empty();
	var html = '';
	for(var i=0, len=yearArr.length; i<len; i++){
		if(cur_year == yearArr[i]){
			html += '<option value="' + yearArr[i] + '" selected>' + yearArr[i] + '年</option>';
		}else{
			html += '<option value="' + yearArr[i] + '">' + yearArr[i] + '年</option>';
		}
	}
	$("#paYear4").html(html);
	
	$("#myModalLabel9").html("编辑");
	$("#myModal9").modal();
}


function submitForm9(){
	if(!$("#showForm9").valid()){
		return false;
	}
	$("#myModal9").modal('hide');
	var formData = $("#showForm9").serializeArray();
	formData.push({ name : "familyNo", value : familyNo });
	$.post(basepath + "/paInfo/saveFamilyAssessmentMainInfo",
			formData,
			function(data){
				alert("保存成功");	
		      	loadData6();
	});
}




