package com.human.realtor;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;

import com.human.VO.ItemVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@RequestMapping(value = "/addItemForm", method = RequestMethod.GET)
	public String showAddItemForm(Locale locale, Model model, HttpSession session) {
		return "addItemForm";
	}
	@RequestMapping(value = "/addItem", method = RequestMethod.POST)
	public String addItem(Locale locale, Model model, HttpSession session,
						  @ModelAttribute("newItem") ItemVO ivo, MultipartFile[] file) {
		System.out.println(ivo.getAddr());
		System.out.println(ivo.getDeposit());
		System.out.println(ivo.getRent());
		System.out.println(ivo.getDetail());
//		System.out.println("in ivo,");
//		for(String s:ivo.getFileName())
//			System.out.println(s);
		System.out.println("in files,");
		if( file == null )
			System.out.println("files are empty");
		else{
			System.out.println(file.length);
			for(MultipartFile f:file)
				System.out.println(f.getOriginalFilename());
		}


		return "addItemForm";
	}
	@RequestMapping(value = "/fileUpload/post") //ajax에서 호출하는 부분
	@ResponseBody
	public String upload(MultipartHttpServletRequest multipartRequest) { //Multipart로 받는다.

		Iterator<String> itr =  multipartRequest.getFileNames();

		String filePath = "C:/test"; //설정파일로 뺀다.

		while (itr.hasNext()) { //받은 파일들을 모두 돌린다.

            /* 기존 주석처리
            MultipartFile mpf = multipartRequest.getFile(itr.next());
            String originFileName = mpf.getOriginalFilename();
            System.out.println("FILE_INFO: "+originFileName); //받은 파일 리스트 출력'
            */

			MultipartFile mpf = multipartRequest.getFile(itr.next());

			String originalFilename = mpf.getOriginalFilename(); //파일명

			String fileFullPath = filePath+"/"+originalFilename; //파일 전체 경로

			try {
				//파일 저장
				mpf.transferTo(new File(fileFullPath)); //파일저장 실제로는 service에서 처리

				System.out.println("originalFilename => "+originalFilename);
				System.out.println("fileFullPath => "+fileFullPath);

			} catch (Exception e) {
				System.out.println("postTempFile_ERROR======>"+fileFullPath);
				e.printStackTrace();
			}

		}
		return "success";
	}
}
