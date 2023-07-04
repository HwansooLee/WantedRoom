package com.human.realtor;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.VO.BoardVO;
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
		pvo.setTotalCount(realtorsrv.myBoardCnt(id)); // id를 통해 totalCnt를 가져와야 한다.
		pvo.calPage(); // page 계산
		// 리스트를 만들어 보내주어야 한다
		pvo.setNowUser(id);
		List<BoardVO> blist = realtorsrv.myList(pvo);
		model.addAttribute("blist",blist);
		model.addAttribute("pagevo",pvo);
		return "myBoardList";
	}
}
