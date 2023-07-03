package com.human.util;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

@Controller
public class FileDataUtil {
    @Resource(name="uploadPath")
    private String uploadPath;

    public ArrayList<String> fileUpload(MultipartFile[] file) throws Exception{
        ArrayList<String> saveName = new ArrayList<>();
        for (MultipartFile multipartFile : file) {
            if (!multipartFile.getOriginalFilename().equals("")) {
                String orName = multipartFile.getOriginalFilename();
                UUID uid = UUID.randomUUID(); // get random String
                // append extension to uid
                String newFileName = uid.toString() + "." + orName.split("\\.")[1];
                // can't include dot(.) in filename (except between filename and extension)

                byte[] fileData = multipartFile.getBytes(); // get file
                File target = new File(uploadPath, newFileName); // make file in path
                FileCopyUtils.copy(fileData, target); // copy bytes
                saveName.add(newFileName);
            }
        }
        return saveName;
        // save multiple files and return save multiple file names
    }
    @RequestMapping(value="/download", method= RequestMethod.GET)
    @ResponseBody // response type is not view
    public FileSystemResource download(@RequestParam("fileName") String filename,
                                       HttpServletResponse re) throws Exception {
        File file = new File(uploadPath + "/" + filename);
//        re.setContentType("application/download); utf-8");
//        re.setHeader("Content-Disposition", "attachment; filename=" + filename);
        return new FileSystemResource(file);
    }
    @SuppressWarnings("all")
    public void deleteFile(String fileName) {
        File file = new File(uploadPath + "/" + fileName);
        file.delete();
    }
    public boolean isFileArrEmpty(MultipartFile[] file){
        for(MultipartFile f:file)
            if( !f.getOriginalFilename().equals("") )
                return false;
        return true;
    }
}
