//扩展验证规则


jQuery.validator.addMethod("xmltab", function (value, element) {
	return (!(value.indexOf("<")>=0))&&(!(value.indexOf(">")>=0));
}, "文本含有特殊字符（<、>）");
jQuery.validator.addMethod("income", function (value, element) {
	var income = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	return this.optional(element) || (income.test(value));
}, "金额格式不对");
jQuery.validator.addMethod("mail", function (value, element) {
	var mail = /^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$/;
	return this.optional(element) || (mail.test(value));
}, "邮箱格式不对");
jQuery.validator.addMethod("QQ", function (value, element) {
	var mail = /^[1-9][0-9]{4,14}$/;
	return this.optional(element) || (mail.test(value));
}, "QQ格式不对");
jQuery.validator.addMethod("weixin", function (value, element) {
	var mail = /^[a-zA-Z\d_]{5,}$/;
	return this.optional(element) || (mail.test(value));
}, "微信号格式不对");
jQuery.validator.addMethod("trimStringNotEmpty", function (value, element) {
	return value.trim()!='';
}, "数据格式不对");

//电话验证规则
jQuery.validator.addMethod("phone", function (value, element) {
    var phone = /^0\d{2,3}-\d{7,8}$/;
    return this.optional(element) || (phone.test(value));
}, "电话格式如：0371-68787027");

//区号验证规则  
jQuery.validator.addMethod("ac", function (value, element) {
    var ac = /^0\d{2,3}$/;
    return this.optional(element) || (ac.test(value));
}, "区号如：010或0371");

//无区号电话验证规则  
jQuery.validator.addMethod("noactel", function (value, element) {
    var noactel = /^\d{7,8}$/;
    return this.optional(element) || (noactel.test(value));
}, "电话格式如：68787027");

//手机验证规则  
jQuery.validator.addMethod("mobile", function (value, element) {
    var mobile = /^1[3|4|5|6|7|8|9]\d{9}$/;
	return this.optional(element) || (mobile.test(value));
}, "手机格式不对");

//邮箱或手机验证规则  
jQuery.validator.addMethod("mm", function (value, element) {
    var mm = /^[a-z0-9._%-]+@([a-z0-9-]+\.)+[a-z]{2,4}$|^1[3|4|5|7|8]\d{9}$/;
	return this.optional(element) || (mm.test(value));
}, "格式不对");

//电话或手机验证规则  
jQuery.validator.addMethod("tm", function (value, element) {
    var tm=/(^1[3|4|5|7|8]\d{9}$)|(^\d{3,4}-\d{7,8}$)|(^\d{7,8}$)|(^\d{3,4}-\d{7,8}-\d{1,4}$)|(^\d{7,8}-\d{1,4}$)/;
    return this.optional(element) || (tm.test(value));
}, "格式不对");

//年龄 表单验证规则
jQuery.validator.addMethod("age", function(value, element) {   
	var age = /^(?:[1-9][0-9]?|1[01][0-9]|120)$/;
	if(value==0){
		return true;
	}else{
		return this.optional(element) || (age.test(value));
	}
}, "不能超过120岁"); 
///// 20-60   /^([2-5]\d)|60$/

//传真
jQuery.validator.addMethod("fax",function(value,element){
    var fax = /^(\d{3,4})?[-]?\d{7,8}$/;
    return this.optional(element) || (fax.test(value));
},"传真格式如：0371-68787027");

//验证当前值和目标val的值相等 相等返回为 false
jQuery.validator.addMethod("equalTo2",function(value, element){
    var returnVal = true;
    var id = $(element).attr("data-rule-equalto2");
    var targetVal = $(id).val();
    if(value === targetVal){
        returnVal = false;
    }
    return returnVal;
},"不能和原始密码相同");

jQuery.validator.addMethod("equalToPassword",function(value, element){
    var returnVal = false;
    var id = $("input[name='password']");
    var targetVal = $(id).val();
    if(value === targetVal){
        returnVal = true;
    }
    return returnVal;
},"两次输入密码不一致");

jQuery.validator.addMethod("equalToOldPassword",function(value, element){
    var returnVal = true;
    var id = $("input[name='oldPassword']");
    var targetVal = $(id).val();
    if(value === targetVal){
        returnVal = false;
    }
    return returnVal;
},"新密码与原始密码重复");
//大于指定数
jQuery.validator.addMethod("gt",function(value, element){
    var returnVal = false;
    var gt = $(element).data("gt");
    if(value > gt && value != ""){
        returnVal = true;
    }
    return returnVal;
},"不能小于0 或空");

//汉字
jQuery.validator.addMethod("chinese", function (value, element) {
    var chinese = /^[\u4E00-\u9FFF]+$/;
    return this.optional(element) || (chinese.test(value));
}, "格式不对");

//指定数字的整数倍
jQuery.validator.addMethod("times", function (value, element) {
    var returnVal = true;
    var base=$(element).attr('data-rule-times');
    if(value%base!=0){
        returnVal=false;
    }
    return returnVal;
}, "必须是发布赏金的整数倍");

//身份证
jQuery.validator.addMethod("idCard", function (value, element) {
    var isIDCard1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;//(15位)
    var isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;//(18位)

    return this.optional(element) || (isIDCard1.test(value)) || (isIDCard2.test(value));
}, "格式不对");

//身份证加残疾证
/*残疾人证号以全国公民身份证号码和残疾类别、残疾等级代码为基础，实行全国统一编码，编码格式一律实行20位编码，由18位公民身份证号加1位残疾类别代码和1位残疾等级代码组成。
如：36012119701121001343，（360121197011210013）-18位公民身份证号码，右边数第二个数字4-残疾类别代码，右边数第一个数字3-残疾等级代码。 
残疾类别代码： 视力残疾：1 ； 听力残疾：2 ； 言语残疾：3 ； 肢体残疾：4 ； 智力残疾：5 ； 精神残疾：6； 多重残疾：7； 残疾等级代码： 一级：1 ； 二级：2 ； 三级：3 ； 四级：4。 */
jQuery.validator.addMethod("idCardNew", function (value, element) {
    var isIDCard1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;//(15位)身份证
    var isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;//(18位)身份证
    var isIDCard3=/^([1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3})[1-7][1-4]$/;//(17位)残疾证
    var isIDCard4=/^([1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X))[1-7][1-4]$/;//(20位)残疾证

    return this.optional(element) || (isIDCard1.test(value)) || (isIDCard2.test(value))|| (isIDCard3.test(value))|| (isIDCard4.test(value));
}, "格式不对");

/**
 * 1	中华人民共和国居民身份证
 * 18	残疾人证
 * 20	未上户口
 */
jQuery.validator.addMethod("idCardRequireNew", function (value, element) {
	var certificateTypeCode= $("select[name='certificateTypeCode']").val();
	if(certificateTypeCode==20){
		return true;
	}else{
		if(value==null||""==value.trim()){
			return false;
		}else{
			if(certificateTypeCode==1){
				var isIDCard1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;//(15位)身份证
			    var isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;//(18位)身份证
				
				return this.optional(element) || (isIDCard1.test(value)) || (isIDCard2.test(value));
			}else if(certificateTypeCode==18){
			    var isIDCard3=/^([1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3})[1-7][1-4]$/;//(17位)残疾证
			    var isIDCard4=/^([1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X))[1-7][1-4]$/;//(20位)残疾证
				
				return this.optional(element) || (isIDCard3.test(value)) || (isIDCard4.test(value));
			}
			return true;
		}
	}
}, "证件号码不能为空或格式不正确！");


// 字符验证       
jQuery.validator.addMethod("stringCheck", function(value, element) {       
    return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);       
 }, "只能包括中文字、英文字母、数字和下划线");   

 // 中文字两个字节       
jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {       
   var length = value.length;       
   for(var i = 0; i < value.length; i++){       
        if(value.charCodeAt(i) > 127){       
         length++;       
         }       
   }       
    return this.optional(element) || ( length >= param[0] && length <= param[1] );       
 }, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");   

// 身份证号码验证       
jQuery.validator.addMethod("isIdCardNo", function(value, element) {       
     return this.optional(element) || isIdCardNo(value);       
}, "请正确输入您的身份证号码");

// 手机号码验证       
jQuery.validator.addMethod("isMobile", function(value, element) {       
     var length = value.length;   
      var mobile =/^[1][3-8]+\\d{9}/;   
   return this.optional(element) || (length == 11 && mobile.test(value));       
}, "请正确填写您的手机号码");       

 // 电话号码验证       
jQuery.validator.addMethod("isTel", function(value, element) {       
     var tel = /^\d{3,4}-?\d{7,9}$/;    //电话号码格式010-12345678   
    return this.optional(element) || (tel.test(value));       
}, "请正确填写您的电话号码");   

// 联系电话(手机/电话皆可)验证   
jQuery.validator.addMethod("isPhone", function(value,element) {   
    var length = value.length;   
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
     var tel = /^\d{3,4}-?\d{7,9}$/;   
    return this.optional(element) || (tel.test(value) || mobile.test(value));   
 
}, "请正确填写您的联系电话");   

// 邮政编码验证       
jQuery.validator.addMethod("isZipCode", function(value, element) {       

	var tel = /^[0-9]{6}$/;       
    return this.optional(element) || (tel.test(value));       
 }, "请正确填写您的邮政编码");    

// 正整数   验证  
jQuery.validator.addMethod("isInteger", function(value, element) {       
     var v = /^[0-9]*[1-9][0-9]*$/;    //  
    return this.optional(element) || (v.test(value));       
}, "请填写一个正整数(不能包含数字0)"); 

// 非负整数验证    （正整数   +   0）   
jQuery.validator.addMethod("isNonNegativeNumber", function(value, element) {       
     var num = /^\d+$/;    //  
    return this.optional(element) || (num.test(value));       
}, "请填写一个正整数");  
