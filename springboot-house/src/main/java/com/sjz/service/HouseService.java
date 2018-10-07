package com.sjz.service;

import com.sjz.util.PageData;
import com.sjz.vo.HouseVO;
import com.sjz.vo.app.HouseList;
import com.sjz.vo.json.JsonData;

import java.util.List;
import java.util.Map;

/**
 * 房屋接口
 */
public interface HouseService {

    /**
     * 给小程序提供的分页查询房屋列表接口
     *
     * @param search
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageData<HouseList> getRentHousePageList(Map<String, Object> search, Integer pageNum, Integer pageSize);

    /**
     * 分页获取房屋列表
     *
     * @param search
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageData<HouseVO> getHousePageList(Map<String, Object> search, Integer pageNum, Integer pageSize);

    /**
     * 根据房屋id获取房屋详情
     *
     * @param houseId
     * @return
     */

    HouseVO getRentHouseDetail(String openid, Long houseId);

    /**
     * 根据id获取房屋坐标
     *
     * @param houseId
     * @return
     */
    List<String> getRentHouseCoordinates(Long houseId);

    /**
     * 保存房屋
     *
     * @param houseVO
     * @return
     */
    JsonData saveHouse(HouseVO houseVO);

    /**
     * 修改房屋
     *
     * @param houseVO
     * @return
     */
    JsonData updateHouse(HouseVO houseVO);

    /**
     * 更新房屋状态
     *
     * @param id
     * @param status
     * @return
     */
    JsonData updateHouseStatus(Long id, Integer status);

    /**
     * 更新房屋坐标数据
     *
     * @param houseVO
     * @return
     */
    JsonData updateHouseCoordinate(HouseVO houseVO);

    /**
     * 修改房间的浏览次数
     *
     * @param id
     * @return
     */
    JsonData updateHouseLookNum(Long id);

    /**
     * 分页获取我的收藏
     *
     * @param openid
     * @return
     */
    PageData getMyFavorite(String openid, Integer pageNum, Integer pageSize);

    /**
     * 添加我的收藏
     *
     * @param openid
     * @param houseId
     * @return
     */
    JsonData addMyFavorite(String openid, Long houseId);

    /**
     * 取消收藏接口
     * @param openid
     * @param houseId
     * @return
     */
    JsonData delMyFavorite(String openid, Long houseId);
}
