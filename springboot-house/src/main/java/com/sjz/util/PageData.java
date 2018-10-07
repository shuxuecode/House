package com.sjz.util;

import java.util.List;

/**
 * Created by highness on 2018/3/10 0010.
 */
public class PageData<E> {

    private int pageNum;
    private int pageSize;
    private long total;
    private int pages;

    private List<E> list;


    public PageData(long total, int pages, List<E> list) {
        this.total = total;
        this.pages = pages;
        this.list = list;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public List<E> getList() {
        return list;
    }

    public void setList(List<E> list) {
        this.list = list;
    }
}
