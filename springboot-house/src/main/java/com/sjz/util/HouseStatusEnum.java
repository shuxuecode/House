package com.sjz.util;

/**
 * 房屋状态：0：未发布  1：发布中  2：已出租  3：删除
 * Created by ZSX on 2018/3/21.
 *
 * @author ZSX
 */
public enum HouseStatusEnum {
    UNPUBLISH(0, "未发布"),
    PUBLISHING(1, "发布中"),
    RENTING(2, "已出租"),
    DELETE(3, "删除"),;


    private int code;
    private String desc;

    HouseStatusEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static HouseStatusEnum fromCode(int code) {
        for (HouseStatusEnum houseStatusEnum : HouseStatusEnum.values()) {
            if (houseStatusEnum.code == code) {
                return houseStatusEnum;
            }
        }
        return null;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
