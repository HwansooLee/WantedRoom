package com.human.util;

import com.human.VO.StoreVO;
import com.human.dao.IF_StoreDAO;
import com.human.dao.StoreImpl;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//@Controller
public class CSVToOracle {
//    @Inject
//    private IF_StoreDAO storeDao;

    private String filePath;
    private List<List<String>> parsedResult;
    private List<Integer> indices;

    private Connection conn=null;
    // connection resource variable
    private final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private final String USERNAME = "final";
    private final String PWD = "1111";
    // variable for query
    private PreparedStatement psmt = null;

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

    private void insert(StoreVO svo){
        String sql = "insert into store values (?, ?, ?, ?)";
        if( getConnection() ){
            try{
                psmt = conn.prepareStatement(sql);
                psmt.setString(1, svo.getAddr());
                psmt.setString(2, svo.getName());
                psmt.setDouble(3, svo.getCoordX());
                psmt.setDouble(4, svo.getCoordY());
                psmt.execute();
            }catch (Exception e){
                e.printStackTrace();
            }
            closeConnection();
        }
    }
    public CSVToOracle(String csvFilePath){
        this.filePath = csvFilePath;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public List<List<String>> getParsedResult() {
        return parsedResult;
    }

    public List<Integer> getIndices() {
        return indices;
    }

    public void setIndices(List<Integer> indices) {
        if( this.indices == null )
            this.indices = new ArrayList<>();
        this.indices = indices;
    }

    public void setParsedResult(List<List<String>> parsedResult) {
        this.parsedResult = parsedResult;
    }

    public void parse() throws Exception{
        parsedResult = new ArrayList<>();
        try(BufferedReader br = new BufferedReader(new FileReader(filePath))){
            String line;
            while( (line = br.readLine()) != null ){
                String[] values = line.split("\t");
                parsedResult.add(Arrays.asList(values));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        for(List<String> store : parsedResult.subList(1, parsedResult.size()) ){
            List<String> storeInfo = new ArrayList<>();
            for(int idx:indices)
                if( store.size() > idx )
                    storeInfo.add( store.get(idx) );
            if( !storeInfo.get(0).equals("") && !storeInfo.get(1).equals("")
                    && storeInfo.size() == 4 && !storeInfo.get(2).equals("") ){
                storeInfo.set(0, storeInfo.get(0).replace("\"", ""));
                storeInfo.set(1, storeInfo.get(1).replace("\"", ""));
                StoreVO svo = new StoreVO( storeInfo.get(0), storeInfo.get(1),
                                            storeInfo.get(2), storeInfo.get(3));
                System.out.println( svo.getAddr() + " / " + svo.getName() + " / "
                                    + svo.getCoordX() + " / " + svo.getCoordY() );
//                storeDao.insertStore(svo);
                insert(svo);
            }
        }
    }
    public void parseAndConvert(){
        parsedResult = new ArrayList<>();
        try(BufferedReader br = new BufferedReader(new FileReader(filePath))){
            String line;
            while( (line = br.readLine()) != null ){
                String[] values = line.split("\t");
                parsedResult.add(Arrays.asList(values));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
//        for(List<String> store : parsedResult.subList(1, parsedResult.size()) ){
//            List<String> storeInfo = new ArrayList<>();
//            for(int idx:indices)
//                if( store.size() > idx )
//                    storeInfo.add( store.get(idx) );
//            if( !storeInfo.get(0).equals("") && !storeInfo.get(1).equals("") ){
//                storeInfo.set(0, storeInfo.get(0).replace("\"", ""));
//                storeInfo.set(1, storeInfo.get(1).replace("\"", ""));
//                StoreVO svo = new StoreVO( storeInfo.get(0), storeInfo.get(1),
//                        storeInfo.get(2), storeInfo.get(3));
//            }
//        }
    }
}
