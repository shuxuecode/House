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
    <title>房屋列表</title>
    <link rel="stylesheet" type="text/css" href="/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/plugin/bootstrap-3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/js/bootstrap-table/bootstrap-table.min.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />

    <style>
        .mycls .form-group {
            width: 49%;
            float: left;
        }

        .mycls .form-group .form-control {
            display: inline;
            width: 80%;
        }

        .fixed-table-body {
            height: auto;
        }

        .btn{
            margin: 2px;
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <form role="form" class="mycls">
            <div class="form-group">
                <label for="districtIdSelect">选择区域：</label>
                <select class="form-control" name="" id="districtIdSelect"></select>
            </div>
            <div class="form-group">
                <label for="summary">房屋标题：</label>
                <input type="text" class="form-control" id="summary" placeholder="支持模糊">
            </div>
            <div class="form-group">
                <label for="village">搜索小区：</label>
                <input type="text" class="form-control" id="village" placeholder="支持模糊">
            </div>
            <div class="form-group">
                <label for="status">房屋状态：</label>
                <select class="form-control" id="status">
                    <option value="1">发布中</option>
                    <option value="0">未发布</option>
                    <option value="2">已出租</option>
                    <option value="3">已删除</option>
                </select>
            </div>
            <button type="button" class="btn btn-default" id="search">查询</button>
            <button type="button" class="btn btn-primary" id="add">新增</button>
        </form>
    </div>

    <table id="table"></table>

</div>


<script type="text/javascript" src="/plugin/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<%--<script type="text/javascript" src="/plugin/bootstrap-table-1.12.1/bootstrap-table.min.js"></script>--%>
<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/js/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<script type="text/javascript">
    var basePath = "<%=request.getAttribute("basePath")%>";

    $(function () {
        initDistrictIdSelect();

        $('#table').bootstrapTable({
            method: "post",
            url: basePath + "/house/lists",
            cache: false,
            striped: true,
            pagination: true,
            pageList: [10, 20],
            pageSize: 10,
            pageNumber: 1,
            sidePagination: 'server',//设置为服务器端分页
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType: "undefined",
            queryParams: function (params) { // 请求服务器数据时发送的参数，可以在这里添加额外的查询参数，返回false则终止请求
                return {
                    pageSize: params.pageSize, // 每页要显示的数据条数
                    pageNum: params.pageNumber, // 每页显示数据的开始行号
                    sort: params.sortName, // 要排序的字段
                    sortOrder: params.sortOrder, // 排序规则
                    districtId: $("#districtIdSelect").val(), // 额外添加的参数
                    summary: $("#summary").val(),
                    village: $("#village").val(),
                    status: $("#status").val()
                }
            },
            sortName: 'id', // 要排序的字段
            sortOrder: 'desc', // 排序规则
            columns: [
                {
                    //     checkbox: true, // 显示一个勾选框
                    //     align: 'center' // 居中显示
                    // }, {
                    field: 'summary', // 返回json数据中的name
                    title: '标题', // 表格表头显示文字
                    align: 'center', // 左右居中
                    valign: 'middle' // 上下居中
                }, {
                    field: 'village',
                    title: '小区',
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'rental',
                    title: '租金(元)',
                    align: 'center',
                    valign: 'middle'
                }, {
                    field: 'status',
                    title: '状态',
                    align: 'center',
                    valign: 'middle',
                    formatter: function (value, row, index) { // 单元格格式化函数
                        var text = '-';
                        if (value == 0) {
                            text = "未发布";
                        } else if (value == 1) {
                            text = "发布中";
                        } else if (value == 2) {
                            text = "已出租";
                        } else if (value == 3) {
                            text = "已删除";
                        }
                        return text;
                    }
                }, {
                    title: "操作",
                    align: 'center',
                    valign: 'middle',
                    formatter: function (value, row, index) {
                        var cls = 'btn btn-primary btn-sm';
                        var btn_update = '<button class="' + cls + '" onclick="update(\'' + row.id + '\')">编辑</button>';
                        var btn_map = '<button class="' + cls + '" onclick="setPoint(\'' + row.id + '\')">设置坐标</button>';
                        var btn_img = '<button class="' + cls + '" onclick="setImage(\'' + row.id + '\')">房间图片</button>';
                        var btn = btn_update + btn_map + btn_img;
                        return btn;
                    }
                }, {
                    title: "设置",
                    align: 'center',
                    valign: 'middle',
                    // width: 160, // 定义列的宽度，单位为像素px
                    formatter: function (value, row, index) {
                        var cls = 'btn btn-sm';
                        var btn = "";
                        var btn_publish = '<button class="' + cls + ' btn-success" onclick="setStatus(\'' + row.id + '\', 1)">发布</button>';
                        var btn_unpublish = '<button class="' + cls + ' btn-warning" onclick="setStatus(\'' + row.id + '\', 0)">取消发布</button>';
                        var btn_rent = '<button class="' + cls + ' btn-primary" onclick="setStatus(\'' + row.id + '\', 2)">已经出租</button>';
                        var btn_del = '<button class="' + cls + ' btn-danger" onclick="setStatus(\'' + row.id + '\', 3)">删除</button>';
                        var btn_undel = '<button class="' + cls + ' btn-info" onclick="setStatus(\'' + row.id + '\', 0)">取消删除</button>';
                        if (row.status == 0) { // 未发布，显示发布和删除
                            btn += btn_publish + btn_del
                        } else if (row.status == 1) { // 发布中，显示取消发布和删除，已租
                            btn += btn_unpublish + btn_rent + btn_del
                        } else if (row.status == 2) { // 已租，显示再次发布和删除
                            btn += btn_publish + btn_del
                        } else if (row.status == 3) { // 删除，显示取消删除
                            btn += btn_undel
                        }
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

        $("#search").click(function () {
            $('#table').bootstrapTable("refresh");
        });

        $("#add").click(function () {
            update("");
        });
        
        $("#status").change(function () {
            // $(this).val();
            $('#table').bootstrapTable("refresh");
        });
    });

    function initDistrictIdSelect() {
        var html = '';
        var data = [
            {id: "", districtName: "全部"},
            {id: 101, districtName: "新华区"},
            {id: 102, districtName: "桥西区"},
            {id: 103, districtName: "长安区"},
            {id: 104, districtName: "裕华区"},
            {id: 105, districtName: "井陉矿区"},
            {id: 106, districtName: "藁城区"},
            {id: 107, districtName: "鹿泉区"},
            {id: 108, districtName: "栾城区"},
            {id: 109, districtName: "正定县"},
            {id: 110, districtName: "井陉县"}
        ];
        for (var i = 0, len = data.length; i < len; i++) {
            html += '<option value="' + data[i].id + '">';
            html += data[i].districtName;
            html += '</option>';
        }
        $('#districtIdSelect').html(html);
    }


    function update(id) {
        window.location.href = basePath + "/house/houseEditPage?houseId=" + id
    }

    function setPoint(id) {
        window.location.href = basePath + "/house/houseMapPage?houseId=" + id
    }

    function setImage(id) {
        window.location.href = basePath + "/house/imageListPage?houseId=" + id
    }

    function setStatus(id, status) {
        $.get(basePath + "/house/setHouseStatus?id=" + id + "&status=" + status, function (data) {
            if (data.code == 200) {
                $.alert({
                    title: false,
                    content: data.message,
                    confirmButton: '确认'
                });
                $('#table').bootstrapTable("refresh");
            }
        });
    }

</script>
</body>
</html>
