package com.sjz.dao;

import com.sjz.entity.RentCity;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentCityMapper {
    int deleteByPrimaryKey(Long id);

    int insert(RentCity record);

    int insertSelective(RentCity record);

    RentCity selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(RentCity record);

    int updateByPrimaryKey(RentCity record);
}