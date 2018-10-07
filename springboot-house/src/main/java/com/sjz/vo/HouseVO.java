package com.sjz.vo;

import com.sjz.entity.RentHouse;

import java.io.Serializable;
import java.util.List;

/**
 * Created by highness on 2018/3/10 0010.
 */
public class HouseVO extends RentHouse implements Serializable{

    /*
     * 房屋详细信息
     */
    private String houseType;

    private String houseArea;

    private String houseFloor;

    private String direction;

    private String decoration;

    private String payMode;

    private String address;

    private String furnitures;

    private String detail;

    private String publishDate;

    /*
     * 显示图片
     */
    private String imgUrl;

    private List<String> imgUrlList;

    /*
     * 是否已被用户收藏（默认为0，没有收藏；如果为1表示已收藏）
     */
    private Integer favorite = 0;

    public String getHouseType() {
        return houseType;
    }

    public void setHouseType(String houseType) {
        this.houseType = houseType;
    }

    public String getHouseArea() {
        return houseArea;
    }

    public void setHouseArea(String houseArea) {
        this.houseArea = houseArea;
    }

    public String getHouseFloor() {
        return houseFloor;
    }

    public void setHouseFloor(String houseFloor) {
        this.houseFloor = houseFloor;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getDecoration() {
        return decoration;
    }

    public void setDecoration(String decoration) {
        this.decoration = decoration;
    }

    public String getPayMode() {
        return payMode;
    }

    public void setPayMode(String payMode) {
        this.payMode = payMode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFurnitures() {
        return furnitures;
    }

    public void setFurnitures(String furnitures) {
        this.furnitures = furnitures;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public List<String> getImgUrlList() {
        return imgUrlList;
    }

    public void setImgUrlList(List<String> imgUrlList) {
        this.imgUrlList = imgUrlList;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public Integer getFavorite() {
        return favorite;
    }

    public void setFavorite(Integer favorite) {
        this.favorite = favorite;
    }
}
