package com.neusoft.response;

public class PageInfo {
    int pageIndex;
    int pageSize;
    int pageStart;
    int userId;
    int cid;

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPageStart() {
        return pageStart;
    }



    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
        this.pageStart = this.pageSize * (this.pageIndex - 1);
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
        this.pageStart = this.pageSize * (this.pageIndex - 1);
    }
}
