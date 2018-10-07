package com.sjz.dao;

import com.sjz.entity.RentHouseDetails;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentHouseDetailsMapper extends BaseDao<RentHouseDetails> {

    /**
     * 根据房屋id获取房屋详细信息
     *
     * @param houseId
     * @return
     */
    RentHouseDetails selectByHouseId(Long houseId);

}