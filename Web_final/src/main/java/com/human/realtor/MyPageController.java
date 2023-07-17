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
import org.springframework.web.bind.annotation.RequestParam;

import com.human.VO.BoardVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.service.IF_RealtorService;

@Controller
public class MyPageController {
	
	@Inject
	private IF_RealtorService realtorsrv;
	
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Locale locale, Model model,
			HttpSession session) {
		model.addAttribute("realtorNo",(String) session.getAttribute("realtorNo"));
		if( (String)session.getAttribute("realtorNo") == null ){
            model.addAttribute("authenticated", false);
        }else {
        	model.addAttribute("authenticated", true);
        }
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
	
	@RequestMapping(value = "/myBoardModify", method = RequestMethod.GET)
	public String myBoardMod(Locale locale, Model model,
			HttpSession session,
			@RequestParam("boardNo") Integer boardNo) throws Exception{
		model.addAttribute("boardvo",realtorsrv.getBoardOne(boardNo));
		return "modifyBoard";
	}
	
	@RequestMapping(value = "/modifyBoardSave", method = RequestMethod.POST)
	public String myBoardModSave(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") BoardVO bvo) throws Exception{
		realtorsrv.modBoard(bvo);
		return "redirect:/myBoardList";
	}
	
	@RequestMapping(value = "/myboardDel", method = RequestMethod.GET)
	public String myBoardDel(Locale locale, Model model,
			HttpSession session,
			@RequestParam("boardNo") Integer boardNo) throws Exception{
		realtorsrv.delBoard(boardNo);
		return "redirect:/myBoardList";
	}
	
	@RequestMapping(value = "/myReplyList", method = RequestMethod.GET)
	public String myReplyList(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") PageVO pvo) throws Exception{
		String id = (String) session.getAttribute("id");
		if(pvo.getPage() == null) pvo.setPage(1);
		pvo.setTotalCount(realtorsrv.myReplyCnt(id)); // id를 통해 totalCnt를 가져와야 한다.
		pvo.calPage(); // page 계산
		// 리스트를 만들어 보내주어야 한다
		pvo.setNowUser(id);
		List<ReplyVO> rlist = realtorsrv.getMyReplyList(pvo);
		model.addAttribute("rlist",rlist);
		model.addAttribute("pagevo",pvo);
		return "myReplyList";
	}
	
	@RequestMapping(value = "/myReplyDel", method = RequestMethod.GET)
	public String myReplyDel(Locale locale, Model model,
			HttpSession session,
			@RequestParam("replyNo") Integer replyNo) throws Exception{
		realtorsrv.delReply(replyNo);
		return "redirect:/myReplyList";
	}
	
	@RequestMapping(value = "/registerRealtorNo", method = RequestMethod.GET)
	public String regRealtorNo(Locale locale, Model model,
			HttpSession session) {
		if( session.getAttribute("realtorNo") != null )
			return "redirect:/";
		model.addAttribute("userName",(String)session.getAttribute("name"));
		return "regRealtorNo";
	}
	
	@RequestMapping(value = "/regRealtorSave", method = RequestMethod.POST)
	public String regRealtorSave(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") MemberVO mvo) throws Exception{
		session.setAttribute("realtorNo", mvo.getRealtorNo()); // 현재 로그인된 상태이므로 바로 세션에 등록
		mvo.setId((String) session.getAttribute("id"));
		realtorsrv.regRealtorNo(mvo);
		return "redirect:/myPage";
	}
}
