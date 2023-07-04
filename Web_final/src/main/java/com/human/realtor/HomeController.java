package com.human.realtor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.service.IF_RealtorService;
import com.human.util.FileDataUtil;

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
			@ModelAttribute("newItem") ItemVO ivo, MultipartFile[] file) throws Exception{
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
	
}
