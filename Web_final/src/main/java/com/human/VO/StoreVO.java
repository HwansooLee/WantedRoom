package com.human.VO;

public class StoreVO {
    private String addr;
    private String name;
    private float coordX;
    private float coordY;

    public StoreVO(){

    }

    public StoreVO(String addr, String name, String coordX, String coordY){
        this.addr = addr;
        this.name = name;
        this.coordX = Float.parseFloat(coordX);
        this.coordY = Float.parseFloat(coordY);
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getCoordX() {
        return coordX;
    }

    public void setCoordX(float coordX) {
        this.coordX = coordX;
    }

    public float getCoordY() {
        return coordY;
    }

    public void setCoordY(float coordY) {
        this.coordY = coordY;
    }
}
