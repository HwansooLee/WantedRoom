package com.human.realtor;

import com.human.util.CSVToOracle;
import org.junit.Test;

public class ParseTest {
    @Test
    public void parseTest(){
        CSVToOracle parser = new CSVToOracle("data/storeData.csv");
        parser.parse();
    }
}
