package com.human.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.VO.MemberVO;

@Controller
@PropertySource("resources/config/config.properties")
public class RealtorNoProcess {
	
	@Value("${config.realtorKey}")
	private String realtorKey;
	
	private final String realtorURL = "http://openapi.nsdi.go.kr/nsdi/EstateBrkpgService/attr/getEBBrokerInfo";
	
	private JSONObject getRealtorInfo(MemberVO mvo) throws Exception{
		StringBuilder urlBuilder = new StringBuilder(realtorURL);
		urlBuilder.append("?" + URLEncoder.encode("authkey","UTF-8") + "=" + realtorKey)
		.append("&" + URLEncoder.encode("brkrNm","UTF-8") + "=" + mvo.getName())
		.append("&" + URLEncoder.encode("jurirno","UTF-8") + "=" + mvo.getRealtorNo())
		.append("&" + URLEncoder.encode("format","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();     
        conn.setRequestMethod("GET");     
        conn.setRequestProperty("Content-type", "application/json");
        BufferedReader in;     
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {     
            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));     
        } else {     
            in = new BufferedReader(new InputStreamReader(conn.getErrorStream()));     
        } 
        
        StringBuilder sb = new StringBuilder();     
        String line;     
        while ((line = in.readLine()) != null) {     
            sb.append(line);     
        }
        in.close();
        conn.disconnect();
        JSONParser jsonParser = new JSONParser();
        JSONObject resultData = (JSONObject) jsonParser.parse(sb.toString());
		return resultData;
	}
	
	@RequestMapping(value = "/getRealtorInfo")
	@ResponseBody
    public JSONObject chartData(@RequestBody MemberVO mvo) throws Exception{ // 비동기		
        return getRealtorInfo(mvo);
    }
}
