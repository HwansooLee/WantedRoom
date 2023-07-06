package com.human.realtor;

import com.human.util.CSVToOracle;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.Arrays;

@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ParseTest {
    @Test
    public void parseAndInsert() throws Exception{
        CSVToOracle parser = new CSVToOracle("data/storeData.txt");
        parser.setIndices(Arrays.asList(18, 21, 26, 27));
        parser.parse();
    }
}
