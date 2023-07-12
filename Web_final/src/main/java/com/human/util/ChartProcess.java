package com.human.util;

import java.util.HashSet;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.human.VO.BoardVO;

public class ChartProcess {
	@SuppressWarnings("all")
	public JSONObject getChartData(List<BoardVO> cntList) {
		JSONObject data = new JSONObject(); // 리턴할 jsonObject
		
		JSONObject xlabel = new JSONObject();
		JSONObject ylabel = new JSONObject();
		JSONArray colsArr = new JSONArray();
		
		JSONArray rowsArr = getRowsArr(cntList);
		
		xlabel.put("id","");
		xlabel.put("label","평가");
		xlabel.put("pattern","");
		xlabel.put("type","string");
		ylabel.put("id","");
		ylabel.put("label","빈도수");
		ylabel.put("pattern","");
		ylabel.put("type","number");
		colsArr.add(xlabel);
		colsArr.add(ylabel);
		data.put("cols", colsArr);
		data.put("rows", rowsArr);
		return data;
	}
	
	@SuppressWarnings("all")
	private JSONArray getRowsArr(List<BoardVO> cntList) {
		JSONArray rowsArr = new JSONArray();

		HashSet<String> sentimentType = new HashSet<>();
		sentimentType.add("positive");
		sentimentType.add("negative");
		sentimentType.add("neutral");

		for(int i = 0; i < cntList.size(); i++) { // 많아야 세번 돈다
			JSONObject nowdata = new JSONObject();
			JSONArray cArr = new JSONArray();
			JSONObject value1 = new JSONObject();
			JSONObject value2 = new JSONObject();
			value1.put("v", cntList.get(i).getSentiment());
			value2.put("v", cntList.get(i).getSentimentCnt());
			cArr.add(value1);
			cArr.add(value2);
			nowdata.put("c", cArr);
			rowsArr.add(nowdata);
			sentimentType.remove(cntList.get(i).getSentiment());
		}
		
		for(String s:sentimentType) {
			JSONObject nowdata = new JSONObject();
			JSONArray cArr = new JSONArray();
			JSONObject value1 = new JSONObject();
			JSONObject value2 = new JSONObject();
			value1.put("v", s);
			value2.put("v", 0);
			cArr.add(value1);
			cArr.add(value2);
			nowdata.put("c", cArr);
			rowsArr.add(nowdata);
		}
		
		return rowsArr;
	}

}
