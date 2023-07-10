package com.human.util;

import org.springframework.http.HttpMethod;

import java.net.URLEncoder;

public class KakaoRestApiTest {
    private static KakaoRestApiHelper apiHelper = new KakaoRestApiHelper();

    public void testApi() throws Exception{
        // access token 지정
        apiHelper.setAccessToken("4d9d4774ee40ad2b0685876427970545");

        // 푸시 알림이나 유저 아이디 리스트가 필요할 때 설정 합니다.
        // (디벨로퍼스 내에 앱설정 메뉴를 가시면 있습니다)
        apiHelper.setAdminKey("794cf8d819dc6b10375238d6419e6a6b");

//        AddrToCooord converter = new AddrToCooord();
//        converter.convert();

        String addr = "대구광역시 북구 검단로 97 (산격동)";
        String encode = URLEncoder.encode(addr, "UTF-8");
        apiHelper.request(KakaoRestApiHelper.HttpMethodType.GET, "https://dapi.kakao.com/v2/local/search/address.json?query=", encode);

//        testUserManagement();
//        testKakaoStory();
//        testKakaoTalk();
//        testPush();
    }
}
