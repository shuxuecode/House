package com.sjz.vo.app;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by highness on 2018/3/10 0010.
 */
public class HouseList implements Serializable {

    private Long houseId;

    private String summary;

    private String village;

    private Long districtId;

    private String districtName;

    private BigDecimal rental;

    private String imgUrl;

    private Integer status;



    public Long getHouseId() {
        return houseId;
    }

    public void setHouseId(Long houseId) {
        this.houseId = houseId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village;
    }

    public BigDecimal getRental() {
        return rental;
    }

    public void setRental(BigDecimal rental) {
        this.rental = rental;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public Long getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Long districtId) {
        this.districtId = districtId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
