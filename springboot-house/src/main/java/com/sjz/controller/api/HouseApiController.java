package com.sjz.controller.api;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.sjz.service.HouseService;
import com.sjz.util.HouseStatusEnum;
import com.sjz.util.HttpUtil;
import com.sjz.util.PageData;
import com.sjz.vo.HouseVO;
import com.sjz.vo.app.HouseList;
import com.sjz.vo.json.JsonData;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;

/**
 * 给小程序提供的api
 */
@Api(description = "小程序房屋接口")
@RequestMapping(path = "/api/house")
@RestController
public class HouseApiController {

    /**
     * 配置文件中的配置
     */
    @Value("${miniapp.appId}")
    private String appId;
    @Value("${miniapp.appsecret}")
    private String appsecret;

    @Autowired
    private HouseService houseService;

    @ApiOperation(value = "获取房屋列表", notes = "供小程序调用", httpMethod = "GET")
    @GetMapping("/lists")
    public PageData getUserList(
            @ApiParam(value = "区域id") @RequestParam(value = "districtId", defaultValue = "") String districtId,
            @ApiParam(value = "模糊查询文本") @RequestParam(value = "searchText", required = false) String searchText,
            @ApiParam("租金范围") @RequestParam(value = "rentalRange", required = false) String rentalRange,
            @ApiParam("其它条件，1：最近发布，2：距离由近到远，3：租金由低到高，4：租金由高到低") @RequestParam(value = "filter", required = false) String filter,
            @ApiParam("当选择距离由近到远时，该值为纬度") @RequestParam(value = "lng", required = false) String lng,
            @ApiParam("当选择距离由近到远时，该值为经度") @RequestParam(value = "lat", required = false) String lat,
            @ApiParam("页码") @RequestParam(defaultValue = "1") Integer pageNum,
            @ApiParam("条数") @RequestParam(defaultValue = "10") Integer pageSize
    ) {
        HashMap<String, Object> search = Maps.newHashMap();
        search.put("areaCode", 311);
        search.put("status", HouseStatusEnum.PUBLISHING.getCode());
        if (StringUtils.isNotBlank(districtId)) {
            search.put("districtId", districtId);
        }
        if (StringUtils.isNotBlank(searchText)) {
            search.put("searchText", searchText);
        }
        if (StringUtils.isNotBlank(rentalRange)) {
            String[] split = rentalRange.split("-");
            if (split.length == 2) {
                String start = split[0];
                String end = split[1];
                if (!"0".equals(start)) {
                    search.put("rentalStart", new BigDecimal(start));
                }
                if (!"max".equals(end)) {
                    search.put("rentalEnd", new BigDecimal(end));
                }
            }
        }
        if (StringUtils.isNotBlank(filter)) {
            if ("1".equals(filter)) {
//                最近发布
                search.put("orderBy", "update_time desc");
            } else if ("2".equals(filter)) {
//                距离由近到远
                search.put("lng", lng);
                search.put("lat", lat);
            } else if ("3".equals(filter)) {
//                租金由低到高
                search.put("orderBy", "rental");
            } else if ("4".equals(filter)) {
//                租金由高到低
                search.put("orderBy", "rental desc");
            }
        }
        PageData<HouseList> pageData = houseService.getRentHousePageList(search, pageNum, pageSize);
        return pageData;
    }


    @ApiOperation(value = "根据id获取房屋数据", notes = "", httpMethod = "GET")
    @GetMapping("/houseDetail")
    public JsonData houseDetail(
            @ApiParam(value = "openid") @RequestParam(value = "openid") String openid,
            @ApiParam(value = "id") @RequestParam(value = "id", defaultValue = "0") Long id
    ) {
        if (id != null && id != 0L) {
            HouseVO houseVO = houseService.getRentHouseDetail(openid, id);
            if (houseVO != null) {
//              更新pv
                houseService.updateHouseLookNum(id);
                return JsonData.returnObject(houseVO);
            }
        }
        return JsonData.fail("查询房间信息失败");
    }


    @ApiOperation(value = "获取小程序用户openid", notes = "", httpMethod = "GET")
    @GetMapping("/getOpenId")
    public JsonData getOpenId(
            @ApiParam(value = "code") @RequestParam(value = "code") String code
    ) {
        try {
            String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" +
                    appId + "&secret=" +
                    appsecret + "&js_code=" +
                    code + "&grant_type=authorization_code";
            String str = HttpUtil.httpGet(url);
            JSONObject object = JSONObject.parseObject(str);
            String openid = object.getString("openid");
            return JsonData.returnObject(openid);
        } catch (Exception e) {
            return JsonData.fail("获取openid失败");
        }
    }


    @ApiOperation(value = "我的收藏接口", notes = "", httpMethod = "GET")
    @GetMapping("getFavorite")
    public PageData getFavorite(
            @ApiParam(value = "openid") @RequestParam(value = "openid") String openid,
            @ApiParam("页码") @RequestParam(defaultValue = "1") Integer pageNum,
            @ApiParam("条数") @RequestParam(defaultValue = "10") Integer pageSize
    ) {
        return houseService.getMyFavorite(openid, pageNum, pageSize);
    }


    @ApiOperation(value = "添加收藏接口", notes = "", httpMethod = "POST")
    @PostMapping("addFavorite")
    public JsonData addFavorite(
            @ApiParam(value = "用户openid") @RequestParam(value = "openid") String openid,
            @ApiParam(value = "房屋id") @RequestParam(value = "houseId") Long houseId
    ) {
        return houseService.addMyFavorite(openid, houseId);
    }

    @ApiOperation(value = "取消收藏接口", notes = "", httpMethod = "POST")
    @PostMapping("delFavorite")
    public JsonData delFavorite(
            @ApiParam(value = "用户openid") @RequestParam(value = "openid") String openid,
            @ApiParam(value = "房屋id") @RequestParam(value = "houseId") Long houseId
    ) {
        return houseService.delMyFavorite(openid, houseId);
    }
}
