package com.sjz.service;

import com.sjz.entity.RentImages;
import com.sjz.vo.json.JsonData;

import java.util.List;

/**
 * 房屋图片接口
 */
public interface HouseImageService {
    /**
     * 获取房屋的首张图片
     *
     * @param houseId
     * @return
     */
    RentImages getHouseImageUrl(Long houseId);

    /**
     * 获取房屋图片列表
     *
     * @param houseId
     * @return
     */
    List<RentImages> getHouseImageList(Long houseId);

    /**
     * 保存
     *
     * @param rentImages
     * @return
     */
    RentImages saveRentImages(RentImages rentImages);

    /**
     * 更新图片的顺序
     *
     * @param rentImagesList
     * @return
     */
    JsonData updateRentImagesSort(List<RentImages> rentImagesList);

    /**
     * 删除
     *
     * @param rentImages
     * @return
     */
    JsonData delRentImages(RentImages rentImages);

}
