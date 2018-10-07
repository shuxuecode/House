package com.sjz.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class RentHouse implements Serializable {
    private Long id;

    private Integer areaCode;

    private Long districtId;

    private String summary;

    private String village;

    private BigDecimal rental;

    private String longitude;

    private String latitude;

    private Integer status;

    private String personName;

    private String telephone;

    private String wechatId;

    private String wechatImage;

    private Integer lookNum;

    private Date createTime;

    private Date updateTime;

    private String creatorId;

    private String creatorName;

    private String updaterId;

    private String updaterName;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Long districtId) {
        this.districtId = districtId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public String getVillage() {
        return village;
    }

    public void setVillage(String village) {
        this.village = village == null ? null : village.trim();
    }

    public BigDecimal getRental() {
        return rental;
    }

    public void setRental(BigDecimal rental) {
        this.rental = rental;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude == null ? null : longitude.trim();
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude == null ? null : latitude.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName == null ? null : personName.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public String getWechatId() {
        return wechatId;
    }

    public void setWechatId(String wechatId) {
        this.wechatId = wechatId == null ? null : wechatId.trim();
    }

    public String getWechatImage() {
        return wechatImage;
    }

    public void setWechatImage(String wechatImage) {
        this.wechatImage = wechatImage == null ? null : wechatImage.trim();
    }

    public Integer getLookNum() {
        return lookNum;
    }

    public void setLookNum(Integer lookNum) {
        this.lookNum = lookNum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId == null ? null : creatorId.trim();
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName == null ? null : creatorName.trim();
    }

    public String getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(String updaterId) {
        this.updaterId = updaterId == null ? null : updaterId.trim();
    }

    public String getUpdaterName() {
        return updaterName;
    }

    public void setUpdaterName(String updaterName) {
        this.updaterName = updaterName == null ? null : updaterName.trim();
    }

    public Integer getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(Integer areaCode) {
        this.areaCode = areaCode;
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", districtId=").append(districtId);
        sb.append(", summary=").append(summary);
        sb.append(", village=").append(village);
        sb.append(", rental=").append(rental);
        sb.append(", longitude=").append(longitude);
        sb.append(", latitude=").append(latitude);
        sb.append(", status=").append(status);
        sb.append(", personName=").append(personName);
        sb.append(", telephone=").append(telephone);
        sb.append(", wechatId=").append(wechatId);
        sb.append(", wechatImage=").append(wechatImage);
        sb.append(", lookNum=").append(lookNum);
        sb.append(", createTime=").append(createTime);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", creatorId=").append(creatorId);
        sb.append(", creatorName=").append(creatorName);
        sb.append(", updaterId=").append(updaterId);
        sb.append(", updaterName=").append(updaterName);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}