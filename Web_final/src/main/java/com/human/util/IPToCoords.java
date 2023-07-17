package com.human.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@PropertySource("resources/config/config.properties")
public class IPToCoords {
	/*
	 * 클라이언트에서 비동기 방식으로 요청을 보냄
	 * 파라미터로 넘기는 값(ip)
	 * 컨트롤러로 부터 받는 인자 : ip, api key
	 * 이곳에서는 받아온 ip와 key값으로 api 요청을 보낸후
	 * jsonObject로 받아온뒤
	 * x좌표와 y좌표를 컨트롤러로 리턴하고
	 * 컨트롤러에선 view로 다시 좌표로 리턴해준다.
	 */
	@Value("${config.locationKey}")
	private String locationKey;
	
	private final String ipstackURI = "http://api.ipstack.com/";
	
	private double[] getCoords(String IP) throws Exception{
		String query = IP + "?access_key=" + locationKey + "&output=json";
		URL url = new URL(ipstackURI + query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		StringBuilder sb = new StringBuilder();
		String getValue = in.readLine();
		while(getValue != null && !getValue.isEmpty()) { // EOF
			sb.append(getValue);
			getValue = in.readLine();
		}
		in.close();
		conn.disconnect();
//		System.out.print(sb); // 요청이 정상적으로 이루어져 제대로된 값을 받아왔는가 확인
		JSONParser jsonParser = new JSONParser();
		JSONObject resultData = (JSONObject) jsonParser.parse(sb.toString());
		double lat = (Double)resultData.get("latitude");
        double lon = (Double)resultData.get("longitude");
		return new double[] {lat, lon};
	}
	
	@RequestMapping(value = "/getIPToCoords")
	@ResponseBody
    public double[] chartData(@RequestParam("IP") String IP) throws Exception{ // 비동기 통신		
        return getCoords(IP);
    }

}
