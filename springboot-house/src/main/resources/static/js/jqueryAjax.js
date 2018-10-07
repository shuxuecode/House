(function($){	

	// 备份jquery的ajax方法    
    var _ajax=$.ajax;  
    
    // 重写ajax方法，先判断登录在执行success函数   
//    $.ajax=function(opt){  
//        var _success = opt && opt.success || function(a, b){};  
//        var _opt = $.extend(opt, {  
//            success:function(data, textStatus){  
//                //   
//                var json = data;
//                if ($.type(data) == 'string')
//					json = eval('(' + data + ')');
//				
//				if(json.code && json.code == 601){
//					window.location.href= json.url;  
//                    return; 
//				}
//                _success(data, textStatus);    
//            }    
//        });  
//        _ajax(_opt);  
//    }; 
	
})(jQuery);