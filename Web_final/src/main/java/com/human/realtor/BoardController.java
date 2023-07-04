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
import com.human.VO.PageVO;
import com.human.service.IF_RealtorService;

@Controller
public class BoardController {

	@Inject
	IF_RealtorService realtorsrv;

	@RequestMapping(value = "/inputBoard", method = RequestMethod.GET)
	public String inputBoard(Locale locale, Model model,
			HttpSession session) {
		String id = (String) session.getAttribute("id");
		model.addAttribute("id",id);
		return "input_board";
	}

	@RequestMapping(value = "/inputBoardSave", method = RequestMethod.POST)
	public String inputBoardSave(Locale locale, Model model,
			@ModelAttribute("") BoardVO bvo) throws Exception {
		// board insert
		realtorsrv.addBoard(bvo);
		return "redirect:/boardList"; // redirect 걸 예정
	}

	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,
			@ModelAttribute("") PageVO pvo) throws Exception {
		if (pvo.getPage() == null)
			pvo.setPage(1);
		pvo.setTotalCount(realtorsrv.boardCnt(pvo.getSword()));
		pvo.calPage();

		List<BoardVO> blist = realtorsrv.listAll(pvo);
		model.addAttribute("pagevo", pvo);
		model.addAttribute("blist", blist);

		return "list_board";
	}

	@RequestMapping(value = "/detailBoard", method = RequestMethod.GET)
	public String detailBoard(Locale locale, Model model,
			@RequestParam("boardno") Integer boardNo) throws Exception {
		// 게시글 번호를 파라미터로 받아서 쿼리 실행
		// 닉네임도 받아와야 하므로 join 사용
		// 게시글 조회시 조회수 올라가야 한다.

		// 게시글 번호로 댓글도 조회해서 댓글도 모델만들어 보내주어야 한다.
		// 댓글은 비동기 방식으로 조회
		BoardVO bvo = realtorsrv.boardDetail(boardNo);
		model.addAttribute("boardvo", bvo);
		return "detail_board";
	}
	
	
}
