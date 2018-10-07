package com.sjz.vo.json;

/**
 * json 表格 模型 用于返回 表格展示的数据
 */
@SuppressWarnings("serial")
public class JsonTable implements java.io.Serializable {
    /**
     * 表格数据List
     */
    private Object rows = null;
    /**
     * 数据总条数
     */
    private Long total = 0L;
    /**
     * 数据总页数
     */
    private Integer totalPage = 0;
    /**
     * 其它信息
     */
    private Object obj = null;

    /**
     * 返回状态码
     */
    private Integer code = 0;

    /**
     * 提示信息
     */
    private String msg = "";

    /**
     * 请求参数（主要为android接口提供）
     */
    private Object param = null;


    public JsonTable(Integer status, String msg, Object rows, Long total, Integer totalPage) {
        this.code = status;
        this.msg = msg;
        this.rows = rows;
        this.total = total;
        this.totalPage = totalPage;
    }

    public JsonTable(Object rows, Long total) {
        this.rows = rows;
        this.total = total;
    }

    public static JsonTable toTable(Long total, Object rows) {
        return new JsonTable(rows, total);
    }

    public Object getRows() {
        return rows;
    }

    public void setRows(Object rows) {
        this.rows = rows;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Object getParam() {
        return param;
    }

    public void setParam(Object param) {
        this.param = param;
    }


}
