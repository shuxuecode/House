<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/com.jsp" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扶贫户信息列表</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap-3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css" />
<link rel="stylesheet" type="text/css" href="/js/datepicker/skin/WdatePicker.css" />

<link rel="stylesheet" type="text/css" href="/js/bootstrap-select/bootstrap-select.min.css" />

<style>

.nav-tabs-me>li {
    width: 20%;
    text-align: center;
   
}
.nav-tabs>li>a{
	font-size:14px;
    text-decoration: none;
    margin: 0;
    color:#555;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus{
	font-size:14px;
    text-decoration: none;
    color:#2a6496;
}

/* 重写下拉多选框的样式 start */
.bootstrap-select button .filter-option {
	font-size: 14px;
    line-height: 20px;
}

.h34px {
	height: 34px;
    width: 160px !important;
    color: #555 !important;
    background: none;
    border: 1px solid #ccc;
}
/* 重写下拉多选框的样式 end */

.main .panel{
	overflow: hidden;
    padding-bottom: 0;
}
.boxlist {
	overflow: hidden;
	padding: 20px 20px 20px 125px;
}
.boxlist ul{
	
}
.boxlist ul li{
	float:left;
	width:30%;
	padding-left:30px;
}
.boxlist .dc_btn{
	text-align: center;
	margin:20px;
}

.div_fam {
    padding-left: 30px;
    margin-top: 15px;
}

/*  */

.input-group {
    width: 24%;
}

.form-inline .input-group .input-group-addon
{
	width: 50%;
}

li .checkbox-inline input {
	margin-top: 5px;
}
</style>

<%

String roleIds = session.getAttribute("user_role_ids")==null?"":session.getAttribute("user_role_ids").toString();
String householderName = (String)request.getAttribute("householderName");
String address1 = (String)request.getAttribute("address1");
String address2 = (String)request.getAttribute("address2");
String address3 = (String)request.getAttribute("address3");
String poorAttributeCode = (String)request.getAttribute("poorAttributeCode");
String certificateNo = (String)request.getAttribute("certificateNo");

String mainPoorCauseCode = (String)request.getAttribute("mainPoorCauseCode");
String secondaryPoorCauseCode = (String)request.getAttribute("secondaryPoorCauseCode");
//String ifwf = (String)request.getAttribute("ifwf");
//String ifstbc = (String)request.getAttribute("ifstbc");


//String ifstbcp = (String)request.getAttribute("ifstbcp");
//String ifwfp = (String)request.getAttribute("ifwfp");

String address1p = (String)request.getAttribute("address1p");
String address2p = (String)request.getAttribute("address2p");
String address3p = (String)request.getAttribute("address3p");

String poorAttributeCodep = (String)request.getAttribute("poorAttributeCodep");
String mainPoorCauseCodep = (String)request.getAttribute("mainPoorCauseCodep");
String secondaryPoorCauseCodep = (String)request.getAttribute("secondaryPoorCauseCodep");


String startTime = (String)request.getAttribute("startTime");
String endTime = (String)request.getAttribute("endTime");
%>
<script type="text/javascript">
	var roleIds = '<%=roleIds %>';
	var roleLevel = '';
	if(roleIds.indexOf('1000') != -1 || roleIds.indexOf('999') != -1){
		roleLevel = 1;
	}else if(roleIds.indexOf('2000') != -1){
		roleLevel = 3;
	}else if(roleIds.indexOf('3000') != -1){
		roleLevel = 5;
	}
</script>

</head>
<body>


<%@ include file="/WEB-INF/view/common/header.jsp" %>
<div class="w1200 main">
		<div class="panel panel-default">
			<div>
				<form class="form-inline"  id="chooseForm">
					<div class="input-group">
						<span class="input-group-addon">户主姓名</span> 
						<span class="form-control"><%=householderName %></span> 
					</div>
					
					<div class="input-group">
						<span class="input-group-addon">区/乡/镇</span> 
						<span class="form-control"><%=address1 %></span> 
					</div>
					
					
					<div class="input-group">
						<span class="input-group-addon">村委会</span> 
						<span class="form-control"><%=address2 %></span> 
					</div>
					
					<div class="input-group">
						<span class="input-group-addon">村民小组</span> 
						<span class="form-control"><%=address3 %></span> 
					</div>
					
					<div class="input-group">
						<span class="input-group-addon">贫困户属性</span> 
						<span class="form-control"><%=poorAttributeCode %></span> 
					</div>
					
					<div class="input-group">
						<span class="input-group-addon">主要致贫原因</span> 
						<span class="form-control"><%=mainPoorCauseCode %></span> 
					</div>
					
					<div class="input-group" style="width: 563px;">
						<span class="input-group-addon" style="width:138px">证件号码</span> 
						<span class="form-control"><%=certificateNo %></span> 
						
					</div>
					
					<div class="input-group" style="width:49%">
						<span class="input-group-addon" style="width:138px">督导时间</span> 
						<span class="form-control"><%=startTime %></span> 
						<span class="input-group-addon" style="width:44px">至</span> 
						<span class="form-control"><%=endTime %></span>
					</div>
					
					
					<div class="input-group" style="width:48.4%">
						<span class="input-group-addon" style="width:136px">次要致贫原因</span> 
						<span class="form-control"><%=secondaryPoorCauseCode %></span> 
					</div>
					<%--
					<div class="input-group">
						<span class="input-group-addon">是否危房</span> 
						<span ><%=ifwf %></span> 
					</div>
					
					<div class="input-group">
						<span class="input-group-addon">是否生态补偿</span> 
						<span ><%=ifstbc %></span> 
					</div> --%>
				</form>
			</div>
			<input name="name" id="name" type="hidden" value="<%=householderName %>" />
			<%-- <input name="ifstbcp" id="ifstbcp" type="hidden" value="<%=ifstbcp %>" />
			<input name="ifwfp" id="ifwfp" type="hidden" value="<%=ifwfp %>" /> --%>
			<input name="address1p" id="address1p" type="hidden" value="<%=address1p %>" />
			<input name="address2p" id="address2p" type="hidden" value="<%=address2p %>" />
			<input name="address3p" id="address3p" type="hidden" value="<%=address3p %>" />
			
			<input name="poorAttributeCodep" id="poorAttributeCodep" type="hidden" value="<%=poorAttributeCodep %>" />
			<input name="certificateNo" id="certificateNo" type="hidden" value="<%=certificateNo %>" />
			<input name="secondaryPoorCauseCodep" id="secondaryPoorCauseCodep" type="hidden" value="<%=secondaryPoorCauseCodep %>" /> 
			<input name="mainPoorCauseCodep" id="mainPoorCauseCodep" type="hidden" value="<%=mainPoorCauseCodep %>" /> 
			
			
			<input name="startTime" id="startTime" type="hidden" value="<%=startTime %>" />
			<input name="endTime" id="endTime" type="hidden" value="<%=endTime %>" />
			
			<div></div>
	    </div>
		<div class="boxlist">
			<div style="margin-bottom:20px">
				<input type="button" id="chooseall" class="btn btn-warning btn-sm" onclick="allSelect()" value="全选" /> 
				<input type="button" id="encheckall" class="btn btn-warning btn-sm" onclick="otherSelect()" value="取消全选" /> 
			</div>
   			<ul>
				<li>
					<input name="v" id="chk_list_1" type="checkbox" value="1" onclick="return   false;" checked="checked" disabled/>序号 
				</li>
				<li><input name="v" id="chk_list_2" type="checkbox" value="2" onclick="return   false;" checked="checked" disabled/>省（自治区、直辖市） </li>
				<li><input name="v" id="chk_list_3" type="checkbox" value="3" onclick="return   false;" checked="checked" disabled/>市（盟、州）</li>
				<li><input name="v" id="chk_list_4" type="checkbox" value="4" onclick="return   false;" checked="checked" disabled/>县(市、区、旗) </li>
				<li><input name="v" id="chk_list_5" type="checkbox" value="5" onclick="return   false;" checked="checked" disabled/>行政村 </li>
				<li><input name="v" id="chk_list_6" type="checkbox" value="6" onclick="return   false;" checked="checked" disabled/>姓名</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="7" />性别 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="8" />证件号码  
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="9" />人数 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="10" />与户主关系 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="11" />民族 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="12" />文化程度
    				</label>
				 </li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="13" />在校生状况 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="14" />健康状况 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="15" />有无劳动能力 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="16" />是否计划生育户  
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="17" />是否参加新农合 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="18" />是否参加新农保
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="19" />是否享受低保 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="20" />脱贫属性 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="21" />贫困户属性 
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="22" />主要致贫原因
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="23" />人均纯收入
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="24" />联系电话
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="25" />开户银行名称
    				</label>
				</li>
				<li>
					<label class="checkbox-inline">
						<input name="checkname" type="checkbox" value="26" />银行卡号
    				</label>
				</li>
				
			</ul>
			<div style="clear:both;"></div>
			<div class="div_fam">
				<!-- <span >包含家庭成员</span>
				 <select  id="all" class="form-control">
				 	<option value="0" selected="selected">否</option> 
				 	<option value="1">是</option> 
			     </select> -->
			     <label class="checkbox-inline" style="font-size: 14px;font-weight: 800;">
     					<input type="checkbox" name="checkname" id="all" style="margin-top: 5px;" /> 包含家庭成员
    			 </label>
			</div>
			<div class="dc_btn">
				<button class="btn btn-warning" onclick="openNewWindow()">导出</button>
			</div>
		</div>

</div>


<%@ include file="/WEB-INF/view/common/footer.jsp" %>
<script type="text/javascript" src="/js/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

		function openNewWindow(){
			//alert($('input:checkbox[name="checkname"]:checked')); 
			// var all = $("#all").val();
			var all = $("#all").prop("checked") ? 1 : 0;
			
			var question3='';
			
			var must = $('input:checkbox[name="v"]:checked');
			must.each(function() { 
				var isCheck = this.value;
				if(question3==''){
					question3 += isCheck; 
				}else{
					question3 += ','+isCheck; 
				}
				
			});
			
			var ob = $('input:checkbox[name="checkname"]:checked');
			ob.each(function() { 
				var isCheck = this.value;
				if(question3==''){
					question3 += isCheck; 
				}else{
					question3 += ','+isCheck; 
				}
				
			});
			
			/* if(question3==''){
				alert('请选择导出项');
				return false;
			} */
			if(confirm("确定下载")){
			
			var name= $("#name").val();
			var startTime= $("#startTime").val();
			var endTime= $("#endTime").val();
			//var ifstbcp =  $("#ifstbcp").val();
			//var ifwfp =  $("#ifwfp").val();
			var address1 =  $("#address1p").val();
			var address2 =  $("#address2p").val();
			var address3 =  $("#address3p").val();
			var poorAttributeCode = $("#poorAttributeCodep").val();	
			var certificateNo =  $("#certificateNo").val();	
			var mainPoorCauseCode = $("#mainPoorCauseCodep").val();	
			var secondaryPoorCauseCode = $("#secondaryPoorCauseCodep").val();	
				var mm = '';
				//"&ifstbc="+ifstbcp+"&ifwf="+ifwfp;
				mm+="&address1="+address1+"&address2="+address2+"&address3="+address3;
				mm+="&poorAttributeCode="+poorAttributeCode+"&certificateNo="+certificateNo;
				mm+="&list="+question3;
				mm+="&mainPoorCauseCode="+mainPoorCauseCode+"&secondaryPoorCauseCode="+secondaryPoorCauseCode;
				mm+="&startTime="+startTime+"&endTime="+endTime;
				
				if(all==1){
			   		mm+="&all=1";
				}
				window.open("${basePath }/pafam/familyBaseInfoDownExcel?name="+name+mm);
				window.close();
			}
		}
		
		 //全选，全不选
        function allSelect() {
        	//$(":checkbox").prop("checked", true);
        	
        	$("input:checkbox[name='checkname']").prop("checked", true);
        }
        //反选
        function otherSelect() {
            $("input:checkbox[name='checkname']").prop("checked", false);
        }
        
</script>