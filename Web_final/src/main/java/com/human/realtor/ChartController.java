package com.human.realtor;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.VO.ItemVO;
import com.human.service.IF_RealtorService;

@Controller
public class ChartController {
	
	@Inject
	IF_RealtorService realtorsrv;
    
	
	@RequestMapping(value = "/getChartData")
	@ResponseBody
    public JSONObject chartData(@RequestBody ItemVO ivo) throws Exception{
        return realtorsrv.getChartData(ivo.getItemNo());
    }
	
	
}
