package com.human.util;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.*;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.nio.charset.StandardCharsets;

@Controller
@PropertySource("resources/config/config.properties")
public class TextProcess {
    @Value("${config.naverKey}")
    private String naverKey;

    private final RestTemplate rest = new RestTemplate();
    private final HttpHeaders headers = new HttpHeaders();
    private final String id = "u3z9ta6u8w";
    private final String rawURI = "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/analyze";
    private boolean haveInit = false;

    public TextProcess(){}

    public void init(){
        this.headers.setContentType(MediaType.APPLICATION_JSON);
        this.headers.set("X-NCP-APIGW-API-KEY-ID", id);
        this.headers.set("X-NCP-APIGW-API-KEY", naverKey);
        rest.getMessageConverters()
                .add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }
    
    @SuppressWarnings("all")
    public String getEmotion(String text) throws Exception{
        if( !haveInit ){
            init();
            haveInit = true;
        }
        URI uri = new URI(rawURI);
        JSONObject dataObj = new JSONObject();
        dataObj.put("content", text);
        HttpEntity<String> entity = new HttpEntity<String>(dataObj.toString(), headers);
        ResponseEntity<String> res = rest.postForEntity(uri, entity, String.class);
        JSONParser jsonParser = new JSONParser();
        JSONObject body = (JSONObject) jsonParser.parse(res.getBody());
        String emotion = null;
        if( !body.isEmpty() ){
            JSONObject docu = (JSONObject)body.get("document");
            emotion = (String)docu.get("sentiment");
        }
        return emotion;
    }
}
