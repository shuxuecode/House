
// 林地面积 的 确权面积 要等于  林果面积 的 确权面积
jQuery.validator.addMethod("areaEqual",function(value, element){
    var v1 = $("#form3_edit input[name='woodland_right_area']").val();
	var v2 = $("#form3_edit input[name='fruit_right_area']").val();
    var id = $(element).attr("data-rule-equalto2");
    return v1 == v2;
},"林地确权面积需和林果确权面积相等");

$(function(){
			
	loadData3();
	$("#form3_edit").validate({
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
			/*验证规则 start*/
			farmland_area : { // 耕地面积 --- farmland_area
				
			},
			farmland_right_area : { // 确权面积 --- farmland_right_area	
				number : true
			},
			farmland_fact_area : { // 实际面积 --- farmland_fact_area	
				number : true
			},
			farmland_irrigate_area : { // 有效灌溉面积 --- farmland_irrigate_area	
				number : true
			},
			farmland_dry_area : { // 耕地旱田面积	farmland_dry_area
				number : true
			},
			farmland_paddy_area : { // 耕地水田面积	farmland_paddy_area
				number : true
			},
			woodland_area : { // 林地面积 --- woodland_area	
				
			},
			woodland_right_area : { // 确权面积 --- woodland_right_area	
				number : true
//				,
//				areaEqual : true
			},
			woodland_fact_area : { // 实际面积 --- woodland_fact_area	
				number : true
			},
			return_to_forest_area : { // 退耕还林面积 --- return_to_forest_area	
				number : true
			},
			fruit_right_area : { // 林果确权面积	fruit_right_area
				number : true
//				,
//				areaEqual : true
			},
			fruit_fact_area : { // 林果实际面积	fruit_fact_area
				number : true
			},
			water_right_area : { // 水面确权面积	water_right_area
				number : true
			},
			water_fact_area : { // 水面实际面积	water_fact_area
				number : true
			},
			grassland_area : { // 牧草地面积 --- grassland_area	
				
			},
			grassland_right_area : { // 确权面积 --- grassland_right_area	
				number : true
			},
			grassland_fact_area : { // 实际面积 --- grassland_fact_area	
				number : true
			},
			
			breed_info : { // 养殖情况 --- breed_info	
				
			},
			bread_bee_info : { // 养蜂 --- bread_bee_info	
				isNonNegativeNumber : true
			},
			bread_chicken_info : { // 养鸡 --- bread_chicken_info	
				isNonNegativeNumber : true
			},
			bread_duck_info : { // 养鸭 --- bread_duck_info	
				isNonNegativeNumber : true
			},
			bread_goose_info : { // 养鹅 --- bread_goose_info	
				isNonNegativeNumber : true
			},
			bread_sheep_info : { // 养羊 --- bread_sheep_info	
				isNonNegativeNumber : true
			},
			bread_cow_info : { // 养牛 --- bread_cow_info	
				isNonNegativeNumber : true
			},
			bread_pig_info : { // 养猪 --- bread_pig_info	
				isNonNegativeNumber : true
			},
			bread_other_info : { // 其他 --- bread_other_info	
				
			},
			plant_info : { // 种植情况 --- plant_info	
				
			},
			plant_rubber_info : { // 橡胶 --- plant_rubber_info	
				isNonNegativeNumber : true
			},
			plant_tapped_info : { // 开割 --- plant_tapped_info	
				isNonNegativeNumber : true
			},
			plant_betel_info : { // 槟榔 --- plant_betel_info	
				isNonNegativeNumber : true
			},
			plant_bear_info : { // 挂果 --- plant_bear_info	
				isNonNegativeNumber : true
			},
			plant_puzzle_fruit_info : { // 益智 --- plant_puzzle_fruit_info	
				number : true
			},
			plant_green_orange_info : { // 绿橙 --- plant_green_orange_info	
				number : true
			},
			plant_silkworm_info : { // 桑蚕 --- plant_silkworm_info	
				number : true
			},
			plant_rice_fish_info : { // 稻鱼共生 --- plant_rice_fish_info	
				number : true
			},
			plant_other_info : { // 其他 --- plant_other_info	
				
			},
			work_info : { // 务工情况 --- work_info	
				
			},
			work_place_info : { // 务工地点 --- work_place_info	
				
			},
			work_kind_info : { // 工种 --- work_kind_info	
				
			},
			work_salary_info : { // 平均月工资 --- work_salary_info	
				number : true
			},
			work_time_info : { // 年累计时间 --- work_time_info	
				number : true
			},
			work_stable_info : { // 是否稳定 --- work_stable_info	
				required : true
			},
			other_info : { // 其他家庭情况 --- other_info	
				
			},
			electricity_info : { // 是否通电 --- electricity_info	
				required : true
			},
			broadcasting_info : { // 是否同广播电视 --- broadcasting_info	
				required : true
			},
			drinking_water_safety_info : { // 是否饮水安全 --- drinking_water_safety_info	
				required : true
			},
			join_cooperative_info : { // 是否参加农民专业合作社 --- join_cooperative_info	
				required : true
			},
			disability_info : { // 是否残疾户 --- disability_info	
				required : true
			},
			housing_area_info : { // 住房面积 --- housing_area_info	
				number : true
			},
			danger_house_info : { // 是否危房 --- danger_house_info	
				required : true
			},
			danger_house_level : { // 危房级别 --- danger_house_level	
				required : true
			},
			toilet_info : { // 有无厕所 --- toilet_info	
				required : true
			},
			fuel_type : { // 燃料类别 --- fuel_type	
				required : true
			},
			durable_consumable_info : { // 拥有耐用消费品情况 --- durable_consumable_info	
				// number : true
			}
			
			/*验证规则end*/
		}
	});

				
});


function form3_add(){
	$("#div3_add").hide();
	getFamilyProductLifeInfoField("form3_btn1");
}

function getFamilyProductLifeInfoField(showBtnId){
	$.get(basepath + "/paInfo/familyProductLifeInfoField?familyNo=" + familyNo,function(data){
		
		$("#indexCode3").val(data.obj.join(","));
		
		var html = template('templ3_edit', data);
		$("#form3_edit").html(html);
		$("#div3_edit").show();
		$("#" + showBtnId).show();
		
		$("#form3_edit input[name='woodland_right_area']").prop("maxlength", 100);
		$("#form3_edit input[name='fruit_right_area']").prop("maxlength", 100);
		
		
		
	},"JSON");
}

//function queryMedia3(pkId,familyNo,tableName){
//	$.ajax({  
//          type : "post",  
//          url : basepath+"/pafb/queryMedia",  
//          data : {pkId:pkId,familyNo:familyNo,tableName:tableName},
//          dataType:"JSON",
//          success : function(data){  
//        	  var result=data.data;
//        	  var html="<div class='slick' style='width:850px;'>";
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
//        	  $("#mediaDiv3").html(html);
//        	  $('#mediaDiv3 .slick').slick({
//      	        dots: true,
//      	        slidesToShow:5,
//      	        autoplay:true
////      	        onInit:function(){
////      	        	$(this).slickPlay();
////      	      }
//      	    });
//        	  $.museum($('.slick .slick-list .slick-track .slick-slide a img'));
//          }  
//     });
//}

function turnMedia3(turnMediaFlag){
	queryMedia3(id,familyNo,"pa_family_production_life_info",turnMediaFlag);
}

function queryMedia3(pkId,familyNo,tableName,turnMediaFlag){
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
        	  html += '<div id="progress3" style="height: 3px; width: 0; background: #C61D22;"></div>';
        	  html += '</div>';
        	  
        	  html += "<div id='pic_list_3' class='scroll_horizontal' style='width:950px;'>";
        	  html += '<div class="box" style="width:800px"> <ul class="list gallery">';
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
        	  
        	  $("#mediaDiv3").html(html);
        	  
        	  $("#pic_list_3").cxScroll();
        	  
        	  
        	  zoomOpen('#pic_list_3 .gallery a');
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

function loadData3(){
	$.post(basepath + "/paInfo/familyProductLifeInfo",
			{familyNo : familyNo},
			function(data){
				if(data.code == 0){
					
					if(btn_8115) data.btnShow = 'true';
					
					var html = template('templ3', data);
					$("#div3").html(html);
					
					
					queryMedia3(id,familyNo,"pa_family_production_life_info", 1);
			    	
			    	$('#media3').fileupload({
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
						          data : {id:id,familyNo:familyNo,tableName:"pa_family_production_life_info",fileName:obj.fileName,filePath:obj.filePath},
						          dataType:"JSON",
						          success : function(data){  
						        	  if(obj.fileName.endsWith(".mp3")) {
						        		  queryMedia3(id,familyNo,"pa_family_production_life_info", 2);
						        	  } else if(obj.fileName.endsWith(".mp4")) {
						        		  queryMedia3(id,familyNo,"pa_family_production_life_info", 3);
						        	  }else {
						        		  queryMedia3(id,familyNo,"pa_family_production_life_info", 1);
						        	  }
						          }  
						     });
				        }
				        // 进度条
				        ,progressall: function(e, data){
				        	var progress = parseInt(data.loaded / data.total * 100, 10);
				        	$('#progress3').css('width', progress + '%');
				        	// 
				        	if(progress == 100){
				        		setTimeout(function(){
				        			$('#progress3').css('width', '0');
				        		},2000);
				        	}
				        }	
				    });
					
			    	
			    	
			    	
			    	
					$("#div3").show();
					$("#div3_edit").hide();
					$("#form3_btn1").hide();
					$("#form3_btn3").hide();
					$("#form3_btn2").show();
					
				}else{
					$("#div3_add").show();
				}
	},"JSON");
}



template.helper('isRadio', function (type, value,indexCode, yes, no) {
	if(type !== 'radio'){
		return value;
	}
	if(value != 1 && value != 0){
		return value;
	}
	if(indexCode=='danger_house_level'){
		return value == 1 ? 'C级' : 'D级';
	}else{
		return value == 1 ? yes : no;
	}
});

template.helper('isCheckBox', function (type, indexCode) {
	if(type == 'checkbox' && indexCode == 'durable_consumable_info'){
		return 'height: 52px;';
	}
});

template.helper('isChecked', function (v1, v2) {
	if(v2 == ""){
		return "";
	}
	var arr = v2.split(",");
	for(var i=0, len=arr.length; i<len; i++){
		if(arr[i] == v1){
			return "checked";
		}
	}
	return "";
});

function updateForm3(){
	$("#form3_btn2").hide();
	$("#div3").hide();
	getFamilyProductLifeInfoField("form3_btn3");
}


function saveForm3(type){
	if(!$("#form3_edit").valid()){
		return false;
	}
	$("#form3_btn1").addClass('disabled');
	$("#form3_btn3").addClass('disabled');
	
	var formData = $("#form3_edit").serializeArray();
	formData.push({ name : "familyNo", value : familyNo });
	formData.push({ name : "saveUpdate", value : type });
	formData.push({ name : "indexCodeFields", value : $("#indexCode3").val() });
	$.post(basepath + "/paInfo/saveFamilyProductLifeInfo",
			formData,
			function(data){
				loadData3();
				$("#form3_btn1").removeClass('disabled');
				$("#form3_btn3").removeClass('disabled');
	});
	
}