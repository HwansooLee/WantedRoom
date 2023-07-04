package com.human.realtor;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.VO.LikesVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.service.IF_RealtorService;

@Controller
public class ReplyController {
	
	@Inject
	IF_RealtorService realtorsrv;
	
	@RequestMapping(value = "/inputReply", method = RequestMethod.POST)
	@ResponseBody // 이 어노테이션을 붙임으로서 모델이 아닌 객체 자체를 response 해줄수 있다.
	public boolean inputReply(@RequestBody ReplyVO rvo,
			HttpSession session) throws Exception{
		// 비동기 통신 json으로 파라미터를 받는다
		// 아이디 정보는 세션으로 받는다.
		String id = (String) session.getAttribute("id");
		rvo.setId(id);
		realtorsrv.addReply(rvo); // DB에 댓글 insert
		// 댓글 리스트를 가져와야 한다 이때 페이징을 할것인가..
		
		return true;
	}
	
	@RequestMapping(value = "/replyList", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> getReplyList(@RequestBody PageVO pvo) throws Exception {
		pvo.setTotalCount(realtorsrv.replyCnt(pvo.getBoardNo()));
		pvo.calPage();
		List<ReplyVO> rlist = realtorsrv.getReplyList(pvo);
		// map으로 리스트와 pagevo를 같이 넘겨준다.
		HashMap<String,Object> hmap = new HashMap<>();
		hmap.put("rlist", rlist);
		hmap.put("pagevo",pvo);
		return hmap;
	}
	
	@RequestMapping(value = "/likes", method = RequestMethod.POST)
	@ResponseBody
	public boolean likesUpdate(@RequestBody LikesVO lvo,
			HttpSession session)throws Exception {
		String id = (String) session.getAttribute("id");
		lvo.setId(id); // 세션에서 아이디를 받아옴
		realtorsrv.likesFlag(lvo); // 좋아요 정보 갱신
		return true;
	}
}
