package com.sjz.dao;

import com.sjz.entity.RentImages;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RentImagesMapper extends BaseDao<RentImages> {

    /**
     * 获取房屋的第一张图片
     * @param search
     * @return
     */
    List<RentImages> getHouseImage(@Param("search") Object search);
}