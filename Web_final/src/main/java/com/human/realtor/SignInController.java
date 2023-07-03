package com.human.realtor;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.human.VO.MemberVO;
import com.human.service.IF_RealtorService;

@Controller
public class SignInController {
	
	@Inject
	IF_RealtorService realtorsrv;
	
	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String signIn(Locale locale, Model model){
		return "signIn";
	}
	
	@RequestMapping(value = "/signInChk", method = RequestMethod.POST)
	public String signInChk(Locale locale, Model model,
			HttpSession session,
			@ModelAttribute("") MemberVO mvo) throws Exception{
		// 회원인지 체크
		mvo = realtorsrv.idChk(mvo.getId());
		if(mvo == null) { // 회원이 아님
			model.addAttribute("wrongInfo","잘못된 아이디,비밀번호 입니다.");
			return "signIn";
		}
		// 회원임
		session.setAttribute("id", mvo.getId());
		session.setAttribute("nickname", mvo.getNickname());
		return "home";
	}
	
	@RequestMapping(value = "/signOut", method = RequestMethod.GET)
	public String signOut(Locale locale, Model model,
			HttpSession session){
		session.invalidate();
		return "home";
	}
}
