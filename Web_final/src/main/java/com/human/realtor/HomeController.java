package com.human.realtor;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import com.human.VO.*;
import com.human.dao.IF_ItemAttachDAO;
import com.human.util.FileDataUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.service.IF_RealtorService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	IF_RealtorService realtorsrv;
	@Inject
	private FileDataUtil fileDataUtil;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	@RequestMapping(value = "/addItemForm", method = RequestMethod.GET)
	public String showAddItemForm(Locale locale, Model model, HttpSession session) {
		return "addItemForm";
	}
	@RequestMapping(value = "/addItem", method = RequestMethod.POST)
	public String addItem(Locale locale, Model model, HttpSession session,
						  @ModelAttribute("newItem") ItemVO ivo, MultipartFile[] file)
							throws Exception{
		ArrayList<String> fileNames = fileDataUtil.fileUpload(file);
		realtorsrv.addItem(ivo, fileNames);
		return "addItemForm";
	}
	@RequestMapping(value = "/searchItem", method = RequestMethod.GET)
	public String searchItem(Locale locale, Model model,
							 @RequestParam("searchWord") String searchWord)
							 throws Exception{
		model.addAttribute("itemList", realtorsrv.getItemList(searchWord));
		return "itemList";
	}
	@RequestMapping(value = "/itemDetail", method = RequestMethod.GET)
	public String showItemDetail(Locale locale, Model model,
							 @RequestParam("itemNo") int itemNo)
							 throws Exception{
		ItemVO ivo = realtorsrv.getItemDetail(itemNo);
		List<String> fileNames = realtorsrv.getAttachFileNames(itemNo);
		ivo.setFileName(fileNames.get(0));
		model.addAttribute("item", ivo);
		model.addAttribute("fileNames", fileNames);
		return "itemDetail";
	}
	@RequestMapping(value = "/deleteItem", method = RequestMethod.GET)
	public String deleteItem(Locale locale, Model model,
							 @RequestParam("itemNo") int itemNo)
			throws Exception{
		for(String s:realtorsrv.getAttachFileNames(itemNo))
			fileDataUtil.deleteFile(s);
		realtorsrv.deleteItem(itemNo);
		return "itemList";
	}
	@RequestMapping(value = "/modifyItemForm", method = RequestMethod.GET)
	public String getModifyItemFrom(Locale locale, Model model,
							 @RequestParam("itemNo") int itemNo)
			throws Exception{
		model.addAttribute("item", realtorsrv.getItemDetail(itemNo));
		return "modifyItemForm";
	}
	@RequestMapping(value = "/modifyItem", method = RequestMethod.POST)
	public String modifyItem(Locale locale, Model model, HttpSession session,
						  @ModelAttribute("newItem") ItemVO ivo, MultipartFile[] file)
			throws Exception{
		if( !fileDataUtil.isFileArrEmpty(file) ){
			// delete previous attachs

		}
//		realtorsrv.modifyItem(ivo, );
		return "itemList";
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
	
	@RequestMapping(value = "/detailBoard", method = RequestMethod.GET)
	public String detailBoard(Locale locale, Model model,
			@RequestParam("boardno") Integer boardNo) throws Exception{
		// 게시글 번호를 파라미터로 받아서 쿼리 실행
		// 닉네임도 받아와야 하므로 join 사용
		// 게시글 조회시 조회수 올라가야 한다.
		
		// 게시글 번호로 댓글도 조회해서 댓글도 모델만들어 보내주어야 한다.
		// 댓글은 비동기 방식으로 조회
		BoardVO bvo = realtorsrv.boardDetail(boardNo);
		model.addAttribute("boardvo",bvo);
		return "detail_board";
	}
	
	@RequestMapping(value = "/inputReply", method = RequestMethod.POST)
	@ResponseBody // 이 어노테이션을 붙임으로서 모델이 아닌 객체 자체를 response 해줄수 있다.
	public boolean inputReply(@RequestBody ReplyVO rvo) throws Exception{
		// 비동기 통신 json으로 파라미터를 받는다
//		System.out.println(rvo.getContent()); // 값 제대로 받아오는지 확인
//		System.out.println(rvo.getId());
//		System.out.println(rvo.getBoardNo());
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
	public boolean likesUpdate(@RequestBody LikesVO lvo)throws Exception {
		realtorsrv.likesFlag(lvo); // 좋아요 정보 갱신
		return true;
	}
	
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
	
}
