package com.human.VO;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class ItemVO {
    private int itemNo;
    private String id;
    private String addr;
    private int deposit;
    private int rent;
    private String detail;
    private String inDate;
    private String status;
    // itemAttach
    private String fileName;
    // itemTags
    private String parking;
    private String elevator;
    private String buildingType;

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public int getDeposit() {
        return deposit;
    }

    public void setDeposit(int deposit) {
        this.deposit = deposit;
    }

    public int getRent() {
        return rent;
    }

    public void setRent(int rent) {
        this.rent = rent;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getInDate() {
        return inDate;
    }

    public void setInDate(String inDate) {
        this.inDate = inDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getParking() {
        return parking;
    }

    public void setParking(String parking) {
        this.parking = parking;
    }

    public String getElevator() {
        return elevator;
    }

    public void setElevator(String elevator) {
        this.elevator = elevator;
    }

    public String getBuildingType() {
        return buildingType;
    }

    public void setBuildingType(String buildingType) {
        this.buildingType = buildingType;
    }
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
