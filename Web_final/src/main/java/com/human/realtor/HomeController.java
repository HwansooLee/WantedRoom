package com.human.realtor;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.VO.BoardVO;
import com.human.VO.PageVO;
import com.human.service.IF_RealtorService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	IF_RealtorService realtorsrv;
	
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
			@ModelAttribute("") BoardVO bvo) throws Exception{	
		// board insert
		realtorsrv.addBoard(bvo);
		return "redirect:/boardList"; // redirect 걸 예정
	}
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,
			@ModelAttribute("") PageVO pvo) throws Exception{
		if(pvo.getPage() == null) pvo.setPage(1);
		pvo.setTotalCount(realtorsrv.boardCnt(pvo.getSword()));
		pvo.calPage();
		
		List<BoardVO> blist = realtorsrv.listAll(pvo);
		model.addAttribute("pagevo",pvo);
		model.addAttribute("blist",blist);		
		
		return "list_board";
	}
	
		
	@RequestMapping(value = "/addItem", method = RequestMethod.GET)
	public String input_s(Locale locale, Model model, HttpSession session) {
		return "addItem";
	}
}
