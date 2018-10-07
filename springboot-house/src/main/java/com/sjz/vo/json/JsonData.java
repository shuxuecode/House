package com.sjz.vo.json;

/**
 * web接口统一返回数据格式
 * Created by ZSX on 2017/8/1.
 */
public class JsonData {

    private Integer code; // 标识码
    private String message; // 提示信息
    private Object data; // 数据

    public static final Integer SUCCESS_CODE = 200;
    public static final Integer FAIL_CODE = 400;


    public JsonData() {
    }

    public JsonData(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public JsonData(Integer code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static JsonData success(String message) {
        return new JsonData(SUCCESS_CODE, message, null);
    }

    public static JsonData success(Integer code, String message, Object data) {
        return new JsonData(code, message, data);
    }

    public static JsonData returnObject(Object object) {
        return new JsonData(SUCCESS_CODE, "success", object);
    }

    public static JsonData fail(String message) {
        return new JsonData(JsonData.FAIL_CODE, message);
    }

    public static JsonData fail(Integer code, String message) {
        return new JsonData(code, message);
    }

    public static JsonData fail(Integer code, String message, Object data) {
        return new JsonData(code, message, data);
    }

    // get set

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
