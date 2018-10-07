package com.sjz.controller;

import com.google.common.collect.Maps;
import com.sjz.service.HouseService;
import com.sjz.util.PageData;
import com.sjz.vo.HouseVO;
import com.sjz.vo.json.JsonData;
import com.sjz.vo.json.JsonTable;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by highness on 2018/3/10 0010.
 */
@Api(description = "房屋接口")
@RequestMapping(path = "/house")
@Controller
public class HouseController {

    @Autowired
    private HouseService houseService;

    @ApiOperation(value = "获取房屋列表", notes = "", httpMethod = "POST")
    @PostMapping("/lists")
    @ResponseBody
    public JsonTable getHouseList(
            @ApiParam(value = "区域id") @RequestParam(value = "districtId", defaultValue = "") String districtId,
            @ApiParam("简介，支持模糊") @RequestParam(value = "summary", defaultValue = "") String summary,
            @ApiParam("小区名称，支持模糊") @RequestParam(value = "village", defaultValue = "") String village,
            @ApiParam("房屋状态：0：未发布  1：发布中  2：已出租  3：删除") @RequestParam(value = "status", defaultValue = "1") Integer status,
            @ApiParam("排序字段") @RequestParam("sort") String sort,
            @ApiParam("排序规则") @RequestParam("sortOrder") String sortOrder,
            @ApiParam("页码") @RequestParam(defaultValue = "1") Integer pageNum,
            @ApiParam("条数") @RequestParam(defaultValue = "10") Integer pageSize
    ) {
        HashMap<String, Object> search = Maps.newHashMap();
        search.put("areaCode", 311);
        if (StringUtils.isNotBlank(districtId)) {
            search.put("districtId", Long.valueOf(districtId));
        }
        if (StringUtils.isNotBlank(summary)) {
            search.put("summary", summary);
        }
        if (StringUtils.isNotBlank(village)) {
            search.put("village", village);
        }
        search.put("status", status);
        if (StringUtils.isNotBlank(sort) && StringUtils.isNotBlank(sortOrder)){
            search.put("orderBy", sort + " " + sortOrder);
        }

        PageData<HouseVO> pageData = houseService.getHousePageList(search, pageNum, pageSize);
        JsonTable jsonTable = JsonTable.toTable(pageData.getTotal(), pageData.getList());
        return jsonTable;
    }

    @ApiOperation(value = "添加房屋数据(id不为空时为修改)", notes = "", httpMethod = "POST")
    @PostMapping("/addHouse")
    @ResponseBody
    public JsonData addHouse(
            @ApiParam(value = "id") @RequestParam(value = "id", required = false, defaultValue = "0") Long id,
            @ApiParam(value = "区号") @RequestParam(value = "areaCode") Integer areaCode,
            @ApiParam(value = "区域id") @RequestParam(value = "districtId") Long districtId,
            @ApiParam("简介") @RequestParam(value = "summary", required = true) String summary,
            @ApiParam("小区名称") @RequestParam(value = "village") String village,
            @ApiParam("租金") @RequestParam(value = "rental") String rental,
            @ApiParam("联系人姓名") @RequestParam(value = "personName") String personName,
            @ApiParam("电话，11位") @RequestParam(value = "telephone") String telephone,
            @ApiParam("微信号") @RequestParam(value = "wechatId") String wechatId,
            @ApiParam("微信二维码图片地址") @RequestParam(value = "wechatImage") String wechatImage,
//            详细信息
            @ApiParam("户型，2室1厅1卫") @RequestParam(value = "houseType") String houseType,
            @ApiParam("面积，100m2") @RequestParam(value = "houseArea") String houseArea,
            @ApiParam("楼层 3/18层") @RequestParam(value = "houseFloor") String houseFloor,
            @ApiParam("朝向 南北 、 东西") @RequestParam(value = "direction") String direction,
            @ApiParam("装修  精装修  毛坯") @RequestParam(value = "decoration") String decoration,
            @ApiParam("付款方式  押一付三  ") @RequestParam(value = "payMode") String payMode,
            @ApiParam("详细地址") @RequestParam(value = "address") String address,
            @ApiParam("详细描述，思考换行符") @RequestParam(value = "detail") String detail
    ) {
        HouseVO houseVO = new HouseVO();
        houseVO.setId(id);
        houseVO.setAreaCode(areaCode);
        houseVO.setDistrictId(districtId);
        houseVO.setSummary(summary);
        houseVO.setVillage(village);
        houseVO.setRental(new BigDecimal(rental));
//        houseVO.setLongitude(longitude);
//        houseVO.setLatitude(latitude);
        houseVO.setPersonName(personName);
        houseVO.setTelephone(telephone);
        houseVO.setWechatId(wechatId);
        houseVO.setWechatImage(wechatImage);
        houseVO.setStatus(0);// 未发布
        houseVO.setLookNum(0);
        houseVO.setCreateTime(new Date());
        houseVO.setUpdateTime(new Date());
        houseVO.setCreatorId("");
        houseVO.setCreatorName("");
        houseVO.setUpdaterId("");
        houseVO.setUpdaterName("");
//      详细信息，注意houseId的值
        houseVO.setHouseType(houseType);
        houseVO.setHouseArea(houseArea);
        houseVO.setHouseFloor(houseFloor);
        houseVO.setDirection(direction);
        houseVO.setDecoration(decoration);
        houseVO.setPayMode(payMode);
        houseVO.setAddress(address);
        houseVO.setDetail(detail);
        houseVO.setFurnitures("");

        JsonData jsonData = houseService.saveHouse(houseVO);
        return jsonData;
    }

    @ApiOperation(value = "根据id获取房屋数据", notes = "", httpMethod = "GET")
    @GetMapping("/getHouse")
    @ResponseBody
    public JsonData getHouse(
            @ApiParam(value = "id") @RequestParam(value = "id", defaultValue = "0") Long id
    ) {
        if (id != null && id != 0L) {
            HouseVO houseVO = houseService.getRentHouseDetail(null, id);
            if (houseVO != null) {
                return JsonData.returnObject(houseVO);
            }
        }
        return JsonData.fail("查询房间信息失败");
    }

    @ApiOperation(value = "设置房屋状态", notes = "", httpMethod = "GET")
    @GetMapping("/setHouseStatus")
    @ResponseBody
    public JsonData setHouseStatus(
            @ApiParam(value = "id") @RequestParam(value = "id") Long id,
            @ApiParam(value = "status") @RequestParam(value = "status") Integer status
    ) {
        if (id == null || status == null){
            return JsonData.fail("参数有误，请检查");
        }
        return houseService.updateHouseStatus(id, status);
    }

    @ApiOperation(value = "设置房屋坐标", notes = "", httpMethod = "POST")
    @PostMapping("/setLngLat")
    @ResponseBody
    public JsonData setLngLat(
            @ApiParam(value = "房屋id") @RequestParam(value = "id") Long id,
            @ApiParam("经度") @RequestParam(value = "longitude") String longitude,
            @ApiParam("纬度") @RequestParam(value = "latitude") String latitude
    ) {
        HouseVO houseVO = new HouseVO();
        houseVO.setId(id);
        houseVO.setLongitude(longitude);
        houseVO.setLatitude(latitude);
        houseVO.setUpdateTime(new Date());
        houseVO.setUpdaterId("");
        houseVO.setUpdaterName("");

        return houseService.updateHouseCoordinate(houseVO);
    }
}
