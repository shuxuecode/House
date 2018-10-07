package com.sjz.service.impl;

import com.github.pagehelper.PageHelper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.sjz.dao.RentImagesMapper;
import com.sjz.entity.RentImages;
import com.sjz.service.HouseImageService;
import com.sjz.vo.json.JsonData;
import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by highness on 2018/3/10 0010.
 */
@Service
public class HouseImageServiceImpl implements HouseImageService {

    private static final Logger logger = LoggerFactory.getLogger(HouseImageServiceImpl.class);

    @Autowired
    private RentImagesMapper rentImagesMapper;

    @Override
    public RentImages getHouseImageUrl(Long houseId) {
        Map<String, Object> params = Maps.newHashMap();
        params.put("houseId", houseId);
        PageHelper.startPage(1, 1, "sort");
        List<RentImages> rentImages = rentImagesMapper.selectByParams(params);
        if (CollectionUtils.isNotEmpty(rentImages)) {
            return rentImages.get(0);
        }
        return null;
    }

    @Override
    public List<RentImages> getHouseImageList(Long houseId) {
        Map<String, Object> params = Maps.newHashMap();
        params.put("houseId", houseId);
        params.put("del", 0);
        PageHelper.startPage(1, 8, "sort");
        List<RentImages> rentImages = rentImagesMapper.selectByParams(params);
        if (CollectionUtils.isNotEmpty(rentImages)) {
            return rentImages;
        }
        return Lists.newArrayList();
    }

    @Override
    public RentImages saveRentImages(RentImages rentImages) {
        int i = rentImagesMapper.insertSelective(rentImages);
        if (i == 1){
            return rentImages;
        }
        return null;
    }

    @Override
    public JsonData updateRentImagesSort(List<RentImages> rentImagesList) {
        for (RentImages rentImages : rentImagesList) {
            rentImagesMapper.updateByPrimaryKeySelective(rentImages);
        }
        return JsonData.success("保存成功");
    }

    @Override
    public JsonData delRentImages(RentImages rentImages) {
        rentImagesMapper.updateByPrimaryKeySelective(rentImages);
        return JsonData.success("删除成功");
    }
}
