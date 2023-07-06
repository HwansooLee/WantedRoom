package com.human.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CSVToOracle {
    private String filePath;
    private List<List<String>> parsedResult;

    public  CSVToOracle(String csvFilePath){
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

    public void setParsedResult(List<List<String>> parsedResult) {
        this.parsedResult = parsedResult;
    }

    public void parse(){
        parsedResult = new ArrayList<>();
        try(BufferedReader br = new BufferedReader(new FileReader(filePath))){
            String line;
            while( (line = br.readLine()) != null ){
                String[] values = line.split(",");
                parsedResult.add(Arrays.asList(values));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        for(String s:parsedResult.get(0)){
            System.out.print(s + " ");
        }
    }
}
