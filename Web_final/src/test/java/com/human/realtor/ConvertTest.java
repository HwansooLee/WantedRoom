package com.human.realtor;

import com.human.util.AddrToCooord;
import org.junit.Test;

public class ConvertTest {
    @Test
    public void convertTest() throws Exception {
        AddrToCooord converter = new AddrToCooord();
        converter.convertCoord();
    }
}
