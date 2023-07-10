package com.human.realtor;

import com.human.util.AddrToCooord;
import com.human.util.KakaoRestApiTest;
import org.junit.Test;

public class ConvertTest {
    @Test
    public void convertTest() throws Exception {
//        KakaoRestApiTest test = new KakaoRestApiTest();
//        test.testApi();
        AddrToCooord converter = new AddrToCooord();
//        String input_coord = "TM";
//        String output_coord = "WGS84";
//        double x = 344912.3589;
//        double y = 268253.8303;
//        double[] latlon = converter.convert(x, y, input_coord, output_coord);
////        converter.insert(latlon);
        converter.convertCoord();
    }
}
