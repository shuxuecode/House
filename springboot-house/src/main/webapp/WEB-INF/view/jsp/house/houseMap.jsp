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
    <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=CEPgQbctbox2EeTjn2Dzly1B"></script>
    <link rel="stylesheet" type="text/css" href="/plugin/bootstrap-3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-confirm/jquery-confirm.min.css" />
    <style>
        body, html {
            width: 100%;
            height: 100%;
            margin: 0;
            font-family: "微软雅黑";
            font-size: 14px;
        }

        #allmap {
            width: 50%;
            height: 500px;
        }

        .btn-my {
            float: right;
            margin-right: 10%;
            margin-top: 5%;
        }

        .btn-my2 {
            float: right;
            margin-right: 1%;
            margin-top: 5%;
        }
    </style>
</head>
<body>
<div style="margin-top:1%; margin-left: 1%;">
    <div id="r-result">输入地址进行搜索:<input type="text" id="suggestId" size="20" value="" style="width:80%;"/></div>
    <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
    <div id="allmap"></div>
    <div>
        点击地图获取坐标
        <span class="btn btn-primary btn-my" id="goback">返回</span>
        <span class="btn btn-primary btn-my2" onclick="setPoint()">保存坐标并返回</span>
    </div>
    <p> 经度：</span><input type="text" id="lng" readonly/></p>
    <p> 纬度：</span><input type="text" id="lat" readonly/></p>

</div>


<script type="text/javascript" src="/plugin/jquery.min.js"></script>
<script type="text/javascript" src="/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/jquery-confirm/jquery-confirm.min.js"></script>
<script type="text/javascript">
    var basePath = "<%=request.getAttribute("basePath")%>";
    var longitude = "<%=request.getAttribute("longitude")%>";
    var latitude = "<%=request.getAttribute("latitude")%>";

    var $houseId = "<%=request.getAttribute("houseId")%>";

    var w = window.innerWidth;
    var h = window.innerHeight;

    $(function () {

        $("#allmap").height(h * 0.75)
        $("#allmap").width(w * 0.9)

        $("#goback").click(function () {
            window.history.go(-1)
        });
    });


    // 百度地图API功能
    function G(id) {
        return document.getElementById(id);
    }

    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var a = 114.463756;
    var b = 38.032937;
    if(longitude != '' && latitude != ''){
        a = longitude;
        b = latitude;

        $("#lng").val(longitude);
        $("#lat").val(latitude);
    }

    var point = new BMap.Point(a, b);
    map.centerAndZoom(point, 15); // 初始化地图,设置中心点坐标和地图级别

    if(longitude != '' && latitude != ''){
        var marker = new BMap.Marker(point);// 创建标注
        map.addOverlay(marker);
    }

    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
    var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
    map.addControl(top_left_control);
    map.addControl(top_left_navigation);

    var geoc = new BMap.Geocoder();

    map.addEventListener("click", function (e) {
        var pt = e.point;
        // console.log(pt)
        // console.log(pt.lng)
        // console.log(pt.lat)

        $("#lng").val(pt.lng);
        $("#lat").val(pt.lat);

        //geoc.getLocation(pt, function(rs){
        //	var addComp = rs.addressComponents;
        //	alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
        //});

        map.clearOverlays();  // 清除覆盖物
//		var myPoint = new BMap.Point(116.400244,39.92556);
//		map.centerAndZoom(pt, 15);
        var marker = new BMap.Marker(pt);// 创建标注
        map.addOverlay(marker);             // 将标注添加到地图中
        // marker.disableDragging();

    });


    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
        {
            "input": "suggestId"
            , "location": map
        });

    ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
        var str = "";
        var _value = e.fromitem.value;
        var value = "";
        if (e.fromitem.index > -1) {
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {
            _value = e.toitem.value;
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }
        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
        G("searchResultPanel").innerHTML = str;
    });

    var myValue;
    ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
        var _value = e.item.value;
        myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
        G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

        setPlace();
    });

    function setPlace() {
        map.clearOverlays();    //清除地图上所有覆盖物
        function myFun() {
            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 18);
            map.addOverlay(new BMap.Marker(pp));    //添加标注
        }

        var local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: myFun
        });
        local.search(myValue);
    }






    function setPoint() {

        var lng = $("#lng").val();
        var lat = $("#lat").val();
        if (lng == '' || lat == '') {
            $.alert({
                title: false,
                content: "没有设置坐标点，请点击地图选取坐标点",
                confirmButton: '确认'
            });
            return false;
        }

        $.ajax({
            type: "post",
            url: basePath + "/house/setLngLat",
            data: {
                id: $houseId,
                longitude: lng,
                latitude: lat,
            },
            dataType: "JSON",
            success: function (data) {
                console.log(data)
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
        });

    }

</script>
</body>
</html>
