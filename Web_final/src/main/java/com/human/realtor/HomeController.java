package com.human.realtor;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.VO.BoardVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@RequestMapping(value = "/inputBoard", method = RequestMethod.GET)
	public String inputBoard(Locale locale, Model model) {
		return "input_board";
	}
	
	@RequestMapping(value = "/inputBoardSave", method = RequestMethod.POST)
	public String inputBoardSave(Locale locale, Model model,
			@ModelAttribute("") BoardVO bvo) {
		// board insert
		return "input_board";
	}
}
