package com.human.realtor;

import com.human.VO.ItemVO;
import com.human.service.IF_RealtorService;
import com.human.util.FileDataUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
public class ItemController {
    @Inject
    IF_RealtorService realtorsrv;
    @Inject
    private FileDataUtil fileDataUtil;

    @RequestMapping(value = "/addItemForm", method = RequestMethod.GET)
    public String showAddItemForm(Locale locale, Model model, HttpSession session) {
        String id = (String)session.getAttribute("id");
        System.out.println(id);
        model.addAttribute("id", id);
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
        model.addAttribute("attachs", realtorsrv.getAttachFileNames(itemNo));
        for(String s:realtorsrv.getAttachFileNames(itemNo))
            System.out.println(s);
        return "modifyItemForm";
    }
    @RequestMapping(value = "/modifyItem", method = RequestMethod.POST)
    public String modifyItem(Locale locale, Model model, HttpSession session,
                             @ModelAttribute("newItem") ItemVO ivo, MultipartFile[] file)
            throws Exception{
        ArrayList<String> fileNames = fileDataUtil.fileUpload(file);
        realtorsrv.modifyItem(ivo, fileNames);
        return "itemList";
    }
    @RequestMapping(value = "/setItemSold", method = RequestMethod.POST)
    @ResponseBody
    public void setItemSold(Locale locale, Model model, HttpSession session,
                            @ModelAttribute("itemNo") int itemNo)
            throws Exception{
        realtorsrv.setItemSold(itemNo);
    }
    @RequestMapping(value = "/deleteAttach", method = RequestMethod.POST)
    @ResponseBody
    public void deleteAttach(Locale locale, Model model, HttpSession session,
                             @ModelAttribute("attachName") String attachName)
            throws Exception{
        fileDataUtil.deleteFile(attachName);
        realtorsrv.deleteAttach(attachName);
    }
}
