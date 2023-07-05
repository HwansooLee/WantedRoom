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
	IF_RealtorService realtorsrv;
	
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Locale locale, Model model,
			HttpSession session) {
		return "myPage";
	}
	
	@RequestMapping(value = "/myBoardList", method = RequestMethod.GET)
	public String myBoardList(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") PageVO pvo) throws Exception{
		String id = (String) session.getAttribute("id");
		if(pvo.getPage() == null) pvo.setPage(1);
		pvo.setTotalCount(realtorsrv.boardCnt(pvo.getSword()));
		pvo.calPage();
		return "myBoardList";
	}
	@RequestMapping(value = "/myItemList", method = RequestMethod.GET)
	public String getMyItems(Locale locale, Model model, HttpSession session,
							  @ModelAttribute("") PageVO pvo) throws Exception{
		String id = (String) session.getAttribute("id");
		pvo.setNowUser(id);
		if( pvo.getPage() == null )
			pvo.setPage(1);
		pvo.setTotalCount( realtorsrv.getCnt(null, id) );
		pvo.calPage();
		model.addAttribute("itemList", realtorsrv.getItemList(pvo));
		model.addAttribute("pageVO", pvo);
		return "myItemList";
	}
}
