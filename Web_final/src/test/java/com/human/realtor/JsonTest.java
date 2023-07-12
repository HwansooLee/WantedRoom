package com.human.realtor;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.junit.Test;

public class JsonTest {
	
	@SuppressWarnings("all")
	@Test
	public void test() {
		JSONObject data = new JSONObject(); // 리턴할 jsonObject
		
		JSONObject xlabel = new JSONObject();
		JSONObject ylabel = new JSONObject();
		
		JSONArray lableArr = new JSONArray();
		xlabel.put("id","");
		xlabel.put("label","평가");
		xlabel.put("pattern","");
		xlabel.put("type","string");
		ylabel.put("id","");
		ylabel.put("label","빈도수");
		ylabel.put("pattern","");
		ylabel.put("type","number");
		lableArr.add(xlabel);
		lableArr.add(ylabel);
		data.put("cols", lableArr);
		System.out.println(data);
	}
}
