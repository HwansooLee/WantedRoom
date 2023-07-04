package com.human.realtor;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.VO.PageVO;
import com.human.service.IF_RealtorService;

@Controller
public class MyPageController {
	
	@Inject
	IF_RealtorService realtorservice;
	
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Locale locale, Model model,
			HttpSession session) {
		return "myPage";
	}
	
	@RequestMapping(value = "/myBoardList", method = RequestMethod.GET)
	public String myBoardList(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") PageVO pvo) {
		String id = (String) session.getAttribute("id");
		
		return "myBoardList";
	}
}
