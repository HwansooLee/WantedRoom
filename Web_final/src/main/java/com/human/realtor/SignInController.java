package com.human.realtor;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.VO.MemberVO;
import com.human.service.IF_RealtorService;
import com.human.service.MailSendService;

@Controller
public class SignInController {
	
	@Inject
	IF_RealtorService realtorsrv;
	
	@Inject
	MailSendService mailsrv;
	
	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String signUp(Locale locale, Model model) { // 회원가입 폼으로 이동
		return "signUp";
	}
	
	@RequestMapping(value = "/nicknameChk", method = RequestMethod.POST)
	@ResponseBody
	public boolean nicknameChk(@RequestBody MemberVO mvo) throws Exception{
		return realtorsrv.nicknameChk(mvo.getNickname());
	}
	
	@RequestMapping(value = "/signUp_save", method = RequestMethod.POST)
	public String signUpSave(Locale locale, Model model,
			@ModelAttribute("") MemberVO mvo) throws Exception{
		if(mvo.getRealtorNo().isEmpty()) mvo.setRealtorNo(null);
		realtorsrv.insertMember(mvo);
		return "home";
	}
	
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
		session.setAttribute("realtorNo", mvo.getRealtorNo());
		return "home";
	}
	
	@RequestMapping(value = "/signOut", method = RequestMethod.GET)
	public String signOut(Locale locale, Model model,
			HttpSession session){
		session.invalidate();
		return "home";
	}
	
	@RequestMapping(value = "/mailChk", method = RequestMethod.POST)
	@ResponseBody
	public String mailChk(@RequestBody MemberVO mvo) throws Exception{
		// 여기서는 메일을확인하고 인증번호를 생성, 인증번호를 메일로 전송후 인증번호를 응답해준다.
		System.out.println(mvo.getId());
		return mailsrv.joinEmail(mvo.getId());
	}
}
