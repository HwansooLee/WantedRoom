package com.human.VO;

public class ItemAttachVO {
    private int itemNo;
    private String fileName;

    public ItemAttachVO(){}
    public ItemAttachVO(int itemNo, String fileName){
        this.itemNo = itemNo;
        this.fileName = fileName;
    }

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
