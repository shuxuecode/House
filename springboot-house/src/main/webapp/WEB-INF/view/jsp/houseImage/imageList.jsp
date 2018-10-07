<%--
  Created by IntelliJ IDEA.
  User: highness
  Date: 2018/3/12 0012
  Time: 23:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/common/com.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>房屋图片列表</title>
    <link rel="stylesheet" type="text/css" href="/plugin/bootstrap-3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/plugin/bootstrap-table-1.12.1/bootstrap-table.min.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />
    <style type="text/css">
        .fixed-table-pagination .pagination-detail{
            display: none;
        }

        .dn{
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <div style="width: 49%; float: left;">
            <label class="control-label">添加图片：</label>
            <input name="tupian" id="tupian"  type="file" class="form-control" style="width:250px; display: none;" />
            <span class="btn btn-primary btn-sm" id="selectImg">请选择一张图片</span>
            <span class="btn btn-primary btn-sm dn" id="startUpload">请选择一张图片</span>
        </div>
        <div style="width: 49%; float: left; margin-top: 3%; text-align: right;">
            <button type="button" class="btn btn-primary" onclick="save()">保存</button>
            <button type="button" class="btn btn-primary" onclick="javascript:window.history.go(-1)">返回</button>
        </div>
    </div>

    <table id="table"></table>


</div>


<script type="text/javascript" src="/plugin/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-table-1.12.1/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-table-1.12.1/locale/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>

<%-- 上传组件 --%>
<script type="text/javascript" src="/plugin/jquery-fileupload/jquery.ui.widget.js"></script>
<script type="text/javascript" src="/plugin/jquery-fileupload/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="/plugin/jquery-fileupload/jquery.fileupload.js"></script>
<script type="text/javascript" src="/plugin/jquery-fileupload/jquery.fileupload-process.js"></script>
<script type="text/javascript" src="/plugin/jquery-fileupload/jquery.fileupload-validate.js"></script>

<script type="text/javascript">
    var basePath = "<%=request.getAttribute("basePath")%>";
    var $houseId = "<%=request.getAttribute("houseId")%>";

    $(function () {

        $('#table').bootstrapTable({
            // method: "post",
            url: basePath + "/houseimg/lists",
            cache: false,
            striped: true,
            pagination: true,
            pageList: [10, 20],
            pageSize: 10,
            pageNumber: 1,
            sidePagination: 'server',//设置为服务器端分页
            queryParams: function (params) { // 请求服务器数据时发送的参数，可以在这里添加额外的查询参数，返回false则终止请求
                return {
                    houseId: $houseId // 额外添加的参数
                }
            },
            uniqueId: 'id',
            columns: [
                {
                    field: 'imgUrl', // 返回json数据中的name
                    title: '图片链接', // 表格表头显示文字
                    align: 'center', // 左右居中
                    valign: 'middle', // 上下居中
                    visible: false // 是否显示，默认为true
                }, {
                    field: 'imgUrl',
                    title: '图片链接',
                    align: 'center',
                    valign: 'middle',
                    formatter: function (value, row, index) { // 单元格格式化函数
                        if (value == '') {
                            return "图片加载失败";
                        }
                        return '<img src="' + value + '" style="width:100px;" />';
                    }
                }, {
                    title: "操作",
                    align: 'center',
                    valign: 'middle',
                    // width: 160, // 定义列的宽度，单位为像素px
                    formatter: function (value, row, index) {
                        var cls = "btn btn-primary btn-sm";
                        var btn = '<button class="' + cls + '" onclick="sort(\'' + row.id + '\', ' + index + ', 1)">上移</button>';
                        btn += '<button class="' + cls + '" onclick="sort(\'' + row.id + '\', ' + index + ', 2)">下移</button>';
                        btn += '<button class="' + cls + '" onclick="del(\'' + row.id + '\')">删除</button>';
                        return btn;
                    }
                }
            ],
            onLoadSuccess: function () {  //加载成功时执行
                console.info("加载成功");
            },
            onLoadError: function () {  //加载失败时执行
                console.info("加载数据失败");
            }
        });

        $("#selectImg").click(function(){
            $("#tupian").click();
        });


        $('#tupian').fileupload({
            url : basePath + '/upload/addImage',
            dataType: 'json',
            formData:{houseId:$houseId},
            add: function (e, data) {
                var uploadErrors = [];
                // console.log(data.originalFiles[0]['size']) ;
                /* if (data.originalFiles[0]['size'] > 1*1024*1024) {
                      uploadErrors.push('上传文件不能超过1M');
                    } */
                var acceptFileTypes = /(\.|\/)(jpe?g|png)$/i;
                if(!acceptFileTypes.test(data.originalFiles[0]['name'])) {
                    uploadErrors.push('文件类型不正确(jpg|jpeg|png)！');
                }
                /*
                var reader = new FileReader();
                reader.onload = function(e) {
                    console.log('123')
                    console.log(this)
                    //加载图片获取图片真实宽度和高度
                    var image = new Image();
                    image.onload=function(){
                        var width = image.width;
                        var height = image.height;
                        console.log(image)
                        console.log(width)
                        console.log(height)
                        if(true){
                            alert('请选择宽高比为4:3的图片');
                            data.abort();
                        }
                    }
                    image.src= e.target.result;
                }
                reader.readAsDataURL(data.files[0])
                */
                if(uploadErrors.length > 0) {
                    alert(uploadErrors.join("\n"));
                } else {
                        $("#selectImg").hide();
                        $("#startUpload").text("上传");
                        $("#startUpload").show();
                        $("#startUpload").click(function(){

                            $("#startUpload").text("上传中...");
                            // 触发上传
                            data.submit();
                            $('#startUpload').unbind('click'); // 立即解绑，避免重复绑定事件
                        });
                }
            },
            done: function (e, data) {
                if(data.result.code == 200){
                    var obj=data.result.data;
                    $('#table').bootstrapTable('insertRow', {
                        index: 10,
                        row: obj
                    });
                }else{
                    alert("上传失败")
                }
                console.log(data)
                $("#selectImg").show();
                // $("#startUpload").text("请选择一种图片");
                $("#startUpload").text("上传");
                $("#startUpload").hide();
            }
            // 进度条
            ,progressall: function(e, data){
                // var progress = parseInt(data.loaded / data.total * 100, 10);
                // $('#progress1').css('width', progress + '%');
                // //
                // if(progress == 100){
                //     setTimeout(function(){
                //         $('#progress1').css('width', '0');
                //     },2000);
                // }
            }
        });
    });

    //                            $('#table').bootstrapTable("refresh");
    function sort(id, index, type) {

        var $tb = $('#table');
        var data = $tb.bootstrapTable('getRowByUniqueId', id);
        if (type == 1) {
            index = index - 1;
        } else {
            index = index + 1;
        }
        $tb.bootstrapTable('removeByUniqueId', id);
        $tb.bootstrapTable('insertRow', {
            index: index,
            row: data
        });
    }

    function save() {
        var $tb = $('#table');
        var data = $tb.bootstrapTable('getData');
//        console.log(data);
        var arr = new Array();
        for(var i=0,len=data.length; i<len; i++){
            arr.push(data[i].id)
        }
        // console.log(arr)
        // console.log(arr.join(","))
        $.ajax({
            type : "post",
            url : basePath + "/houseimg/sortHouseImages",
            data : {ids:arr.join(",")},
            dataType:"JSON",
            async : false,
            success : function(data){
                console.log(data)
                if (data.code == 200) {
                    $.alert({
                        title: false,
                        content: data.message,
                        confirmButton: '确认'
                    });
                    // $('#table').bootstrapTable("refresh");
                }
            }
        });

    }

    function del(id) {
        $.ajax({
            type : "post",
            url : basePath + "/houseimg/delHouseImages",
            data : {id:id},
            dataType:"JSON",
            async : false,
            success : function(data){
                if (data.code == 200) {
                    $.alert({
                        title: false,
                        content: data.message,
                        confirmButton: '确认'
                    });
                    $('#table').bootstrapTable("refresh");
                }
            }
        });
    }
</script>
</body>
</html>
