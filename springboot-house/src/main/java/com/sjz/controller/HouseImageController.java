package com.sjz.controller;

import com.google.common.collect.Lists;
import com.sjz.entity.RentImages;
import com.sjz.service.HouseImageService;
import com.sjz.vo.json.JsonData;
import com.sjz.vo.json.JsonTable;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * Created by ZSX on 2018/3/13.
 *
 * @author ZSX
 */
@RequestMapping("/houseimg")
@Controller
public class HouseImageController {

    @Autowired
    private HouseImageService houseImageService;

    @ApiOperation(value = "获取房屋相关图片列表", notes = "", httpMethod = "GET")
    @GetMapping("/lists")
    @ResponseBody
    public JsonTable getHouseList(
            @ApiParam(value = "houseId") @RequestParam(value = "houseId", required = true, defaultValue = "0") Long houseId
    ) {
        if (houseId != 0L) {
            List<RentImages> houseImageList = houseImageService.getHouseImageList(houseId);
            if (CollectionUtils.isNotEmpty(houseImageList)) {
                return JsonTable.toTable(Long.valueOf(String.valueOf(houseImageList.size())), houseImageList);
            }
        }
        return JsonTable.toTable(0L, null);
    }


    @ApiOperation(value = "对房屋图片进行排序", notes = "", httpMethod = "POST")
    @PostMapping("/sortHouseImages")
    @ResponseBody
    public JsonData sortHouseImages(
            @ApiParam(value = "ids") @RequestParam(value = "ids") String ids
    ) {
        List<RentImages> rentImagesList = Lists.newArrayList();
        if (StringUtils.isNotBlank(ids)){
            RentImages rentImages;
            String[] split = ids.split(",");
            for (int i = 0; i < split.length; i++) {
                rentImages = new RentImages();
                rentImages.setId(Long.valueOf(split[i]));
                rentImages.setSort(i+1);
                rentImages.setUpdateTime(new Date());

                rentImagesList.add(rentImages);
            }
        }
        if (CollectionUtils.isNotEmpty(rentImagesList)){
            return houseImageService.updateRentImagesSort(rentImagesList);
        }
        return JsonData.fail("保存失败");
    }

    @ApiOperation(value = "删除房屋图片", notes = "", httpMethod = "POST")
    @PostMapping("/delHouseImages")
    @ResponseBody
    public JsonData delHouseImages(
            @ApiParam(value = "id") @RequestParam(value = "id") Long id
    ) {
        RentImages rentImages = new RentImages();
        rentImages.setId(id);
        rentImages.setDel(1);
        rentImages.setUpdateTime(new Date());
        return houseImageService.delRentImages(rentImages);
    }
}
