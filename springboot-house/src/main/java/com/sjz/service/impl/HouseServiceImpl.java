package com.sjz.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.base.Function;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.sjz.dao.RentDistrictMapper;
import com.sjz.dao.RentFavoriteMapper;
import com.sjz.dao.RentHouseDetailsMapper;
import com.sjz.dao.RentHouseMapper;
import com.sjz.entity.*;
import com.sjz.service.HouseImageService;
import com.sjz.service.HouseService;
import com.sjz.util.HouseStatusEnum;
import com.sjz.util.PageData;
import com.sjz.vo.HouseVO;
import com.sjz.vo.app.HouseList;
import com.sjz.vo.json.JsonData;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by highness on 2018/3/10 0010.
 */
@Service
public class HouseServiceImpl implements HouseService {

    private static final Logger logger = LoggerFactory.getLogger(HouseServiceImpl.class);

    @Autowired
    private RentHouseMapper rentHouseMapper;
    @Autowired
    private RentHouseDetailsMapper rentHouseDetailsMapper;
    @Autowired
    private HouseImageService houseImageService;
    @Autowired
    private RentDistrictMapper rentDistrictMapper;
    @Autowired
    private RentFavoriteMapper rentFavoriteMapper;


    @Override
    public PageData<HouseList> getRentHousePageList(Map<String, Object> search, Integer pageNum, Integer pageSize) {
        List<RentHouse> pageList = null;
        if (search.get("lng") != null && search.get("lat") != null) {
            PageHelper.startPage(pageNum, pageSize);
            pageList = rentHouseMapper.selectListByParams(search);
        } else {
            if (search.get("orderBy") != null) {
                PageHelper.startPage(pageNum, pageSize, (String) search.get("orderBy"));
            } else {
                PageHelper.startPage(pageNum, pageSize);
            }
            pageList = rentHouseMapper.selectByParams(search);
        }

        if (CollectionUtils.isEmpty(pageList)) {
            return new PageData(0, 0, Lists.newArrayList());
        }
        PageInfo pageInfo = new PageInfo(pageList);

        ArrayList<HouseList> houseLists = Lists.newArrayList();
        HashSet<Long> districtSet = Sets.newHashSet();
        for (RentHouse rentHouse : pageList) {
            HouseList houseList = new HouseList();

            houseList.setHouseId(rentHouse.getId());
            houseList.setSummary(rentHouse.getSummary());
            houseList.setVillage(rentHouse.getVillage());
            houseList.setRental(rentHouse.getRental());
            houseList.setDistrictId(rentHouse.getDistrictId());

            districtSet.add(rentHouse.getDistrictId());

            houseLists.add(houseList);
        }

        ArrayList<Long> districtIds = Lists.newArrayList();
        for (Long id : districtSet) {
            districtIds.add(id);
        }
        HashMap<Long, String> districtMap = this.getDistrictMap(districtIds);

        for (HouseList houseList : houseLists) {
            RentImages houseImageUrl = houseImageService.getHouseImageUrl(houseList.getHouseId());
            if (houseImageUrl != null) {
                houseList.setImgUrl(houseImageUrl.getImgUrl());
            }
            String districtName = districtMap.get(houseList.getDistrictId());
            if (StringUtils.isNotBlank(districtName)) {
                houseList.setDistrictName(districtName);
            }
        }
        PageData pageData = new PageData(pageInfo.getTotal(), pageInfo.getPages(), houseLists);
        pageData.setPageNum(pageInfo.getPageNum());
        pageData.setPageSize(pageInfo.getPageSize());
        return pageData;
    }


    private HashMap<Long, String> getDistrictMap(List<Long> ids) {
        HashMap<Long, String> districtMap = Maps.newHashMap();
        Map<String, Object> params = Maps.newHashMap();
        params.put("ids", ids);
        List<RentDistrict> list = rentDistrictMapper.selectByParams(params);
        if (CollectionUtils.isNotEmpty(list)) {
            for (RentDistrict rentDistrict : list) {
                districtMap.put(rentDistrict.getId(), rentDistrict.getDistrictName());
            }
        }
        return districtMap;
    }


    @Override
    public PageData<HouseVO> getHousePageList(Map<String, Object> search, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize, (String) search.get("orderBy"));
        List<RentHouse> pageList = rentHouseMapper.selectByParams(search);
        if (CollectionUtils.isEmpty(pageList)) {
            return new PageData(0, 0, Lists.newArrayList());
        }
        PageInfo pageInfo = new PageInfo(pageList);
        List<HouseVO> houseVOS = JSONArray.parseArray(JSON.toJSONString(pageList), HouseVO.class);
        return new PageData(pageInfo.getTotal(), pageInfo.getPages(), houseVOS);
    }

    @Override
    public HouseVO getRentHouseDetail(String openid, Long houseId) {
        RentHouse rentHouse = rentHouseMapper.selectByPrimaryKey(houseId);
        if (rentHouse == null) {
            return null;
        }

        HouseVO houseVO = JSONObject.parseObject(JSON.toJSONString(rentHouse), HouseVO.class);

        RentHouseDetails rentHouseDetails = rentHouseDetailsMapper.selectByHouseId(houseId);
        if (rentHouseDetails == null) {
            return null;
        }

        houseVO.setHouseType(rentHouseDetails.getHouseType());
        houseVO.setHouseArea(rentHouseDetails.getHouseArea());
        houseVO.setHouseFloor(rentHouseDetails.getHouseFloor());
        houseVO.setDirection(rentHouseDetails.getDirection());
        houseVO.setDecoration(rentHouseDetails.getDecoration());
        houseVO.setPayMode(rentHouseDetails.getPayMode());
        houseVO.setAddress(rentHouseDetails.getAddress());
//        houseVO.setFurnitures(rentHouseDetails.getFurnitures());
        houseVO.setDetail(rentHouseDetails.getDetail());
        String publishDate = new SimpleDateFormat("yyyy-MM-dd").format(rentHouseDetails.getCreateTime());
        houseVO.setPublishDate(publishDate);

        List<RentImages> houseImageList = houseImageService.getHouseImageList(houseId);
        if (CollectionUtils.isNotEmpty(houseImageList)) {
            List<String> imgUrlList = Lists.transform(houseImageList, new Function<RentImages, String>() {
                @Override
                public String apply(RentImages rentImages) {
                    return rentImages.getImgUrl();
                }
            });
            houseVO.setImgUrlList(imgUrlList);
        }
//        判断用户是否已经收藏该房屋
        if(StringUtils.isNotBlank(openid)){
            Map<String, Object> params = Maps.newHashMap();
            params.put("del", 0);
            params.put("wechatCode", openid);
            params.put("houseId", houseId);
            List<RentFavorite> rentFavorites = rentFavoriteMapper.selectByParams(params);
            if (CollectionUtils.isNotEmpty(rentFavorites)) {
                houseVO.setFavorite(1);
            }
        }
        return houseVO;
    }

    @Override
    public List<String> getRentHouseCoordinates(Long houseId) {
        ArrayList<String> list = Lists.newArrayList();
        RentHouse rentHouse = rentHouseMapper.selectByPrimaryKey(houseId);
        if (rentHouse != null) {
            list.add(rentHouse.getLongitude());
            list.add(rentHouse.getLatitude());
        }
        return list;
    }

    @Override
    public JsonData saveHouse(HouseVO houseVO) {
        if (houseVO.getId() != null && houseVO.getId() != 0L) {
            return this.updateHouse(houseVO);
        }
        RentHouse rentHouse = JSONObject.parseObject(JSON.toJSONString(houseVO), RentHouse.class);
        int i = rentHouseMapper.insertSelective(rentHouse);
        if (i == 1) {
            Long houseId = rentHouse.getId();
            RentHouseDetails rentHouseDetails = JSONObject.parseObject(JSON.toJSONString(houseVO), RentHouseDetails.class);
            rentHouseDetails.setHouseId(houseId);

            int n = rentHouseDetailsMapper.insertSelective(rentHouseDetails);
            if (n == 1) {
                return JsonData.success("保存成功");
            }
        }
        return JsonData.fail("保存失败");
    }


    @Override
    public JsonData updateHouse(HouseVO houseVO) {

        Long id = houseVO.getId();
        RentHouse rentHouse = rentHouseMapper.selectByPrimaryKey(id);
        if (rentHouse != null) {
            RentHouseDetails rentHouseDetails = rentHouseDetailsMapper.selectByHouseId(id);
            if (rentHouseDetails != null) {

                RentHouse updateRentHouse = JSONObject.parseObject(JSON.toJSONString(houseVO), RentHouse.class);
                rentHouseMapper.updateByPrimaryKeySelective(updateRentHouse);

                RentHouseDetails updateRentHouseDetails = JSONObject.parseObject(JSON.toJSONString(houseVO), RentHouseDetails.class);
                updateRentHouseDetails.setId(rentHouseDetails.getId());
                rentHouseDetailsMapper.updateByPrimaryKeySelective(updateRentHouseDetails);
                return JsonData.success("修改成功");
            }
        }
        return JsonData.fail("修改失败");
    }

    @Override
    public JsonData updateHouseStatus(Long id, Integer status) {
        RentHouse houseVO = new RentHouse();
        houseVO.setId(id);
        houseVO.setStatus(status);
        houseVO.setUpdateTime(new Date());
        rentHouseMapper.updateByPrimaryKeySelective(houseVO);
        return JsonData.success("设置成功");
    }

    @Override
    public JsonData updateHouseCoordinate(HouseVO houseVO) {
        rentHouseMapper.updateByPrimaryKeySelective(houseVO);
        return JsonData.success("保存成功");
    }

    @Override
    public JsonData updateHouseLookNum(Long id) {
        RentHouse rentHouse = rentHouseMapper.selectByPrimaryKey(id);
        if (rentHouse != null) {
            Integer lookNum = rentHouse.getLookNum();
            RentHouse updRentHouse = new RentHouse();
            updRentHouse.setId(id);
            updRentHouse.setLookNum(lookNum + 1);

            rentHouseMapper.updateByPrimaryKeySelective(updRentHouse);
        }
        return JsonData.success("更新成功");
    }

    @Override
    public PageData getMyFavorite(String openid, Integer pageNum, Integer pageSize) {
        Map<String, Object> params = Maps.newHashMap();
        params.put("del", 0);
        params.put("wechatCode", openid);

        PageHelper.startPage(pageNum, pageSize, "create_time desc");
        List<RentFavorite> rentFavorites = rentFavoriteMapper.selectByParams(params);

        if (CollectionUtils.isEmpty(rentFavorites)) {
            return new PageData(0, 0, Lists.newArrayList());
        }
        PageInfo pageInfo = new PageInfo(rentFavorites);

        List<Long> houseIds = Lists.transform(rentFavorites, new Function<RentFavorite, Long>() {
            @Override
            public Long apply(RentFavorite rentFavorite) {
                return rentFavorite.getHouseId();
            }
        });

        params.clear();
        params.put("areaCode", 311);
        params.put("ids", houseIds);
        List<RentHouse> rentHouses = rentHouseMapper.selectByParams(params);
        if (CollectionUtils.isEmpty(rentHouses)) {
            return new PageData(0, 0, Lists.newArrayList());
        }

        ArrayList<HouseList> houseLists = Lists.newArrayList();
        HashSet<Long> districtSet = Sets.newHashSet();
        HouseList houseList;
        for (RentHouse rentHouse : rentHouses) {
            houseList = new HouseList();

            houseList.setHouseId(rentHouse.getId());
            houseList.setSummary(rentHouse.getSummary());
            houseList.setVillage(rentHouse.getVillage());
            houseList.setRental(rentHouse.getRental());
            houseList.setDistrictId(rentHouse.getDistrictId());
            houseList.setStatus(rentHouse.getStatus());

            districtSet.add(rentHouse.getDistrictId());

            houseLists.add(houseList);
        }

        ArrayList<Long> districtIds = Lists.newArrayList();
        for (Long id : districtSet) {
            districtIds.add(id);
        }
        HashMap<Long, String> districtMap = this.getDistrictMap(districtIds);

        for (HouseList house : houseLists) {
            RentImages houseImageUrl = houseImageService.getHouseImageUrl(house.getHouseId());
            if (houseImageUrl != null) {
                house.setImgUrl(houseImageUrl.getImgUrl());
            }
            String districtName = districtMap.get(house.getDistrictId());
            if (StringUtils.isNotBlank(districtName)) {
                house.setDistrictName(districtName);
            }
        }

        PageData pageData = new PageData(pageInfo.getTotal(), pageInfo.getPages(), houseLists);
        pageData.setPageNum(pageInfo.getPageNum());
        pageData.setPageSize(pageInfo.getPageSize());
        return pageData;
    }

    @Override
    public JsonData addMyFavorite(String openid, Long houseId) {
        Map<String, Object> params = Maps.newHashMap();
        params.put("del", 0);
        params.put("wechatCode", openid);
        params.put("houseId", houseId);
        List<RentFavorite> rentFavorites = rentFavoriteMapper.selectByParams(params);
        if (CollectionUtils.isNotEmpty(rentFavorites)) {
            return JsonData.fail("已收藏");
        }

        RentHouse rentHouse = rentHouseMapper.selectByPrimaryKey(houseId);
        if (rentHouse == null) {
            return JsonData.fail("房间不存在");
        }
//       发布中的房屋才可以收藏
        if (HouseStatusEnum.PUBLISHING.getCode() != rentHouse.getStatus()) {
            return JsonData.fail("房间已失效");
        }

        RentFavorite rentFavorite = new RentFavorite();
        rentFavorite.setWechatCode(openid);
        rentFavorite.setHouseId(houseId);
        rentFavorite.setDel(0);
        rentFavorite.setCreateTime(new Date());
        rentFavorite.setUpdateTime(new Date());
        rentFavorite.setCreatorId("");
        rentFavorite.setCreatorName("");
        rentFavorite.setUpdaterId("");
        rentFavorite.setUpdaterName("");

        rentFavoriteMapper.insertSelective(rentFavorite);

        return JsonData.success("收藏成功");
    }

    @Override
    public JsonData delMyFavorite(String openid, Long houseId) {
        Map<String, Object> params = Maps.newHashMap();
        params.put("del", 0);
        params.put("wechatCode", openid);
        params.put("houseId", houseId);
        List<RentFavorite> rentFavorites = rentFavoriteMapper.selectByParams(params);
        if (CollectionUtils.isNotEmpty(rentFavorites)) {
            RentFavorite rentFavorite = rentFavorites.get(0);
            RentFavorite entity = new RentFavorite();
            entity.setId(rentFavorite.getId());
            entity.setDel(1);
            entity.setUpdateTime(new Date());
            rentFavoriteMapper.updateByPrimaryKeySelective(entity);
        }
        return JsonData.success("取消收藏成功");
    }
}
