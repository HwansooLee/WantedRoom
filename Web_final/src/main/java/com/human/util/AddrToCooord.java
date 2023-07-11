package com.human.util;

import com.human.VO.StoreVO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AddrToCooord {
    private final RestTemplate rest = new RestTemplate();
    private final HttpHeaders headers = new HttpHeaders();
    private final String appkey = "KakaoAK 794cf8d819dc6b10375238d6419e6a6b";
    private HttpEntity<String> entity = null;
    //       x=160710.37729270622&y=-4388.879299157299&input_coord=WTM&output_coord=WGS84
    private final String rawURI = "https://dapi.kakao.com/v2/local/geo/transcoord.json?";

    private Connection conn=null;
    // connection resource variable
    private final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private final String USERNAME = "final";
    private final String PWD = "1111";
    // variable for query
    private PreparedStatement psmt = null;

    private int storeCnt = 1;

    public AddrToCooord(){
        init();
    }

    public void init(){
        this.headers.setContentType(MediaType.APPLICATION_JSON);
        this.headers.set("Authorization", appkey);
        this.entity = new HttpEntity<String>("parameters", headers);
    }

    private boolean getConnection(){
        try {
            conn = DriverManager.getConnection(URL, USERNAME, PWD);
            System.out.println("Connection established");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void closeConnection(){
        try {
            conn.close();
            System.out.println("Connection closed");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double[] convert(double x, double y, String inputCoord, String outputCoord) throws Exception{
        String query = "x=" + x + "&y=" + y + "&input_coord=" + inputCoord + "&output_coord=" + outputCoord;
        URI uri = new URI(rawURI + query);
        ResponseEntity<String> res = rest.exchange(uri, HttpMethod.GET, entity, String.class);
        JSONParser jsonParser = new JSONParser();
        JSONObject body = (JSONObject) jsonParser.parse(res.getBody());
        JSONArray docu = (JSONArray) body.get("documents");
        double lat = 0.0;
        double lon = 0.0;
        if( docu.size() != 0 ) {
            JSONObject ret = (JSONObject) docu.get(0);
            if( ret.size() != 0 ){
                lat = (Double)ret.get("y");
                lon = (Double)ret.get("x");
            }
        }
        return new double[] {lat, lon};
    }

    public void update(StoreVO svo, double[] latlon){
        System.out.print(storeCnt++ + " : ");
        if( latlon[0] == 0.0 || latlon[1] == 0.0 )
            System.out.println("Failed to get lat, lon");
        else{
            System.out.println(latlon[0] + ", " + latlon[1]);
            String sql = "update store set lat=?, lon=? where addr=?";
            try{
                psmt = conn.prepareStatement(sql);
                psmt.setDouble(1, latlon[0]);
                psmt.setDouble(2, latlon[1]);
                psmt.setString(3, svo.getAddr());
                psmt.executeUpdate();
                psmt.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    public void convertCoord(){
        final String sql = "select * from store";
        final String inputCoord = "TM";
        final String outputCoord = "WGS84";
        if( getConnection() ){
            try{
                psmt = conn.prepareStatement(sql);
                ResultSet rs = psmt.executeQuery();
                while( rs.next() ){
                    StoreVO svo = new StoreVO();
                    svo.setAddr(rs.getString("addr"));
                    svo.setName(rs.getString("name"));
                    svo.setCoordX(rs.getFloat("coordX"));
                    svo.setCoordY(rs.getFloat("coordY"));
                    double[] latlon = convert(svo.getCoordX(), svo.getCoordY(), inputCoord, outputCoord);
                    update(svo, latlon);
                }
                psmt.close();
            }catch(Exception e){
                e.printStackTrace();
            }
            closeConnection();
        }
    }
}
