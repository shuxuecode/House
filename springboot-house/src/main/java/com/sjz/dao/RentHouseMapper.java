package com.sjz.dao;

import com.sjz.entity.RentHouse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RentHouseMapper extends BaseDao<RentHouse> {


    /**
     * 从写一个查询方法，主要是为了 距离由近到远 的排序问题
     * @param search
     * @return
     */
    List<RentHouse> selectListByParams(@Param("search") Object search);
}