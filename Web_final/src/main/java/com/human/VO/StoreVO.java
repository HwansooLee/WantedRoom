package com.human.VO;

public class StoreVO {
    private String addr;
    private String name;
    private double coordX;
    private double coordY;
    private double lat;
    private double lon;

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

    public double getCoordX() {
        return coordX;
    }

    public void setCoordX(float coordX) {
        this.coordX = coordX;
    }

    public double getCoordY() {
        return coordY;
    }

    public void setCoordY(float coordY) {
        this.coordY = coordY;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLon() {
        return lon;
    }

    public void setLon(double lon) {
        this.lon = lon;
    }
}
