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
    <title>房屋编辑</title>
    <link rel="stylesheet" type="text/css" href="/plugin/bootstrap-3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />
    <style type="text/css">
        /* 验证提示样式 */
        .tooltip-div {
            bottom: 54px;
            display: block;
            text-align: left;
        }

        .tooltip-inner-me {
            text-align: left;
            padding: 3px 10px;
            min-width: 120px;
            color: rgb(255, 255, 255);
            border: 1px solid rgb(102, 153, 204);
            border-radius: 5px;
            background-color: rgba(51, 153, 204, 0.8);
        }
    </style>
</head>
<body>
<div class="container">
    <div>
        <form class="form-horizontal" role="form" id="myForm">
            <div class="form-group">
                <label for="districtIdDiv" class="col-sm-2 control-label">选择区域：</label>
                <div class="col-sm-10" id="districtIdDiv">
                    <%--
                    <label class="radio-inline">
                        <input type="radio" name="districtId" id="districtId1" value="101" checked> 选项 1
                    </label>
                    --%>
                </div>

            </div>
            <div class="form-group">
                <label for="summary" class="col-sm-2 control-label">房屋标题：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="summary" name="summary" placeholder="请输入简介">
                    <p class="help-block">房间的简要介绍，例如：(单间出租)新火车站对面水晶郦城温馨主卧 三室一厅 地点好 交通便利</p>
                </div>
            </div>
            <div class="form-group">
                <label for="village" class="col-sm-2 control-label">小区名称：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="village" name="village" placeholder="请输入小区名称">
                    <%--<p class="help-block">这里是块级帮助文本的实例。</p>--%>
                </div>
            </div>
            <div class="form-group">
                <label for="rental" class="col-sm-2 control-label">租金：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="rental" name="rental" placeholder="请输入租金">
                    <p class="help-block">房屋每个月的租金，输入金额，单位是元，支持小数点后两位</p>
                </div>
            </div>
            <div class="form-group">
                <label for="personName" class="col-sm-2 control-label">联系人姓名：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="personName" name="personName" placeholder="请输入联系人姓名">
                    <p class="help-block">电话或者微信联系人的姓名，也可以填写王先生，张女士等</p>
                </div>
            </div>
            <div class="form-group">
                <label for="telephone" class="col-sm-2 control-label">电话：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="telephone" name="telephone" placeholder="请输入电话">
                    <p class="help-block">填写正确的11位手机号</p>
                </div>
            </div>

            <%--@ApiParam("微信号") @RequestParam(value = "wechatId") String wechatId,--%>
            <%--@ApiParam("微信二维码图片地址") @RequestParam(value = "wechatImage") String wechatImage,--%>


            <div class="form-group">
                <label for="houseType" class="col-sm-2 control-label">户型：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="houseType" name="houseType" placeholder="请输入户型，例如：2室1厅1卫">
                </div>
            </div>
            <div class="form-group">
                <label for="houseArea" class="col-sm-2 control-label">面积：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="houseArea" name="houseArea" placeholder="请输入面积，例如：100平">
                </div>
            </div>
            <div class="form-group">
                <label for="houseFloor" class="col-sm-2 control-label">楼层：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="houseFloor" name="houseFloor" placeholder="请输入楼层，例如：6/18层">
                </div>
            </div>
            <div class="form-group">
                <label for="direction" class="col-sm-2 control-label">朝向：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="direction" name="direction" placeholder="请输入朝向，例如：朝南，向阳">
                </div>
            </div>
            <div class="form-group">
                <label for="decoration" class="col-sm-2 control-label">装修：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="decoration" name="decoration" placeholder="请输入装修级别">
                    <p class="help-block">装修级别：简装、普通装修、中档装修、高档装修、豪华装修、精装修、毛坯</p>
                </div>
            </div>
            <div class="form-group">
                <label for="payMode" class="col-sm-2 control-label">付款方式：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="payMode" name="payMode" placeholder="请输入付款方式，例如：押一付三、押一付一">
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="col-sm-2 control-label">详细地址：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="address" name="address" placeholder="请输入详细地址">
                </div>
            </div>
            <div class="form-group">
                <label for="detail" class="col-sm-2 control-label">详细描述：</label>
                <div class="col-sm-10">
                    <textarea class="form-control" id="detail" name="detail" rows="3"></textarea>
                    <p class="help-block">这里房屋的详细描述</p>
                </div>
            </div>
            <input type="hidden" name="areaCode" value="311"/>
            <input type="hidden" name="houseId" />
            <input type="hidden" name="wechatId" />
            <input type="hidden" name="wechatImage" />
        </form>
        <button class="btn btn-primary" onclick="save()">保存</button>
        <button class="btn btn-primary" id="goback">返回</button>
    </div>

</div>

<%-- 验证提示 --%>
<div style="display: none" id="validate-tip">
    <div class="tooltip fade top in tooltip-div" role="tooltip" data-placement="right">
        <div class="tooltip-arrow" style="border-top-color: #6BB5DA;"></div>
        <div class="tooltip-inner tooltip-inner-me"></div>
    </div>
</div>

<script type="text/javascript" src="/plugin/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<%-- 验证插件 --%>
<script type="text/javascript" src="/plugin/jquery-validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="/plugin/jquery-validate/messages_zh.min.js"></script>
<script type="text/javascript" src="/plugin/jquery-validate/jquery.validate.rules.js"></script>

<script type="text/javascript">
    var basePath = "<%=request.getAttribute("basePath")%>";

    var $houseId = "<%=request.getAttribute("houseId")%>";
    $(function () {
        initDistrictRadio();

        $("#goback").click(function () {
            window.history.go(-1)
        });
    });

    function initValidate() {
        $("#myForm").validate({
            errorPlacement: function (error, element) {
                var ddd = element.next("div");
                if (ddd.length == 0) {
                    var html = $("#validate-tip").html();
                    element.after(html);
                    var dd = element.next("div");
                    var d2 = dd.children().last();
                    d2.html(error.html());
                    dd.show();
                } else {
                    var dd = element.next("div");
                    var d2 = dd.children().last();
                    d2.html(error.html());
                    dd.show();
                }
            },
            success: function (label, element) {
                var dd = $(element).next("div");
                dd.hide();
            },
            rules: {
                summary: {
                    required: true,
                    minlength: 10,
                    maxlength: 36
                },
                village: {
                    required: true,
                    maxlength: 10
                },
                rental: {
                    required: true,
                    income: true
                },
                personName: {
                    required: true,
                    minlength: 1,
                    maxlength: 6
                },
                telephone: {
                    required: true,
                    mobile: true
                },
                houseType: {
                    required: true,
                    maxlength: 10
                },
                houseArea: {
                    required: true,
                    maxlength: 10
                },
                houseFloor: {
                    // required: true,
                    maxlength: 10
                },
                payMode: {
                    required: true,
                    maxlength: 10
                },
                address: {
                    required: true,
                    maxlength: 30
                },
                detail: {
                    maxlength: 300
                }
            }
        });
        //  开始加载数据
        getData($houseId);
    }

    function initDistrictRadio() {
        var html = '';
        var data = [
            {id: 101, districtName: "新华区"},
            {id: 102, districtName: "桥西区"},
            {id: 103, districtName: "长安区"},
            {id: 104, districtName: "裕华区"},
            {id: 105, districtName: "井陉矿区"},
            {id: 106, districtName: "藁城区"},
            {id: 107, districtName: "鹿泉区"},
            {id: 108, districtName: "栾城区"},
            {id: 109, districtName: "正定县"},
            {id: 110, districtName: "井陉县"},
        ];
        for (var i = 0, len = data.length; i < len; i++) {
            var checked = i == 0 ? "checked" : "";
            html += '<label class="radio-inline">';
            html += '<input type="radio" name="districtId" id="districtId' + i + '" '
                + 'value="' + data[i].id + '" ' + checked + '>' + data[i].districtName;
            html += '</label>';
        }
        $('#districtIdDiv').html(html);

        //  初始化验证
        initValidate();
    }

    function getData(id) {
        if (id != '') {
            $.get(basePath + "/house/getHouse?id=" + id, function (data) {

                if (data.code == 200) {
                    $("#myForm input[name='areaCode']").val(data.data.areaCode);
                    $("#myForm input[name='houseId']").val(id);

                    var districtIdRadio = $(":input[name='districtId']");
                    for (var i = 0, len = districtIdRadio.length; i < len; i++) {
                        if (districtIdRadio[i].value == data.data.districtId) {
                            districtIdRadio[i].checked = true;
                        }
                    }
                    $("#myForm input[name='summary']").val(data.data.summary);
                    $("#myForm input[name='village']").val(data.data.village);
                    $("#myForm input[name='rental']").val(data.data.rental);
                    $("#myForm input[name='personName']").val(data.data.personName);
                    $("#myForm input[name='telephone']").val(data.data.telephone);
                    $("#myForm input[name='wechatId']").val(data.data.wechatId);
                    $("#myForm input[name='wechatImage']").val(data.data.wechatImage);
                    $("#myForm input[name='houseType']").val(data.data.houseType);
                    $("#myForm input[name='houseArea']").val(data.data.houseArea);
                    $("#myForm input[name='houseFloor']").val(data.data.houseFloor);
                    $("#myForm input[name='direction']").val(data.data.direction);
                    $("#myForm input[name='decoration']").val(data.data.decoration);
                    $("#myForm input[name='payMode']").val(data.data.payMode);
                    $("#myForm input[name='address']").val(data.data.address);
                    $("#myForm textarea[name='detail']").val(data.data.detail);
                }else{
                    $.alert({
                        title: false,
                        content: data.message,
                        confirmButton: '确认'
                    });
                }
            });
        }
    }

    function save() {
        if (!$("#myForm").valid()) {
            return false;
        }
        var formData = $("#myForm").serialize();

        // formData = formData + "&areaCode=311" + "&wechatId=&wechatImage="
        // if ($houseId != '') {
        //     formData = formData + "&id=" + $houseId
        // }
        $.ajax({
            type: "POST",
            url: basePath + "/house/addHouse",
            data: formData,
            // dataType: "JSON",
            success: function (data) {
                if(data.code == 200){
                    $.confirm({
                        title: '提示',
                        content: data.message,
                        confirmButton: '确认并返回列表',
                        cancelButton: '确认并留在本页面',
                        confirm: function(){
                            window.history.go(-1)
                        },
                        cancel: function(){
                            //$.alert('Canceled!')
                        }
                    });
                }
            }
        });
    }



</script>
</body>
</html>
