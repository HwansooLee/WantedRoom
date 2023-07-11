package com.human.util;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.*;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class TextProcess {
    private final RestTemplate rest = new RestTemplate();
    private final HttpHeaders headers = new HttpHeaders();
    private final String id = "u3z9ta6u8w";
    private final String secret = "Bn6qEnTgvUSGWKUwVRxgAneV40SgGIntgIJXlVOY";
    private final String rawURI = "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze";

    private Connection conn=null;
    // connection resource variable
    private final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private final String USERNAME = "final";
    private final String PWD = "1111";
    // variable for query
    private PreparedStatement psmt = null;

    public TextProcess(){
        init();
    }

    public void init(){
        this.headers.setContentType(MediaType.APPLICATION_JSON);
        this.headers.set("X-NCP-APIGW-API-KEY-ID", id);
        this.headers.set("X-NCP-APIGW-API-KEY", secret);
        rest.getMessageConverters()
                .add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }

    public String getEmotion(String text) throws Exception{
        System.out.println(text);
        URI uri = new URI(rawURI);
        JSONObject dataObj = new JSONObject();
        dataObj.put("content", text);
        HttpEntity<String> entity = new HttpEntity<String>(dataObj.toString(), headers);
        ResponseEntity<String> res = rest.postForEntity(uri, entity, String.class);
        JSONParser jsonParser = new JSONParser();
        JSONObject body = (JSONObject) jsonParser.parse(res.getBody());
        String emotion = null;
        if( !body.isEmpty() ){
            System.out.println(body);
            JSONObject docu = (JSONObject)body.get("document");
            emotion = (String)docu.get("sentiment");
            System.out.println( docu.get("sentiment") );
        }
        return emotion;
    }
}
