package com.ds.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/file/*")
@PreAuthorize("isAuthenticated()")
public class FileController {
	
	
	
	@PostMapping(value="/uploadAjaxAction/{lectureNo}/{userNo}", produces="application/text;charset=utf-8")
	@ResponseBody
	public String uploadAjaxPost(MultipartFile[] uploadFile, @PathVariable Long lectureNo, @PathVariable Long userNo) {
		
		String result=null;
		
		String uploadFolder = "C:\\upload\\"+lectureNo;
		

		File uploadPath = new File(uploadFolder);
		log.info("upload path: " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("uploadFileName: " + uploadFileName);
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			String savingFileName=userNo.toString()+"_"+uploadFileName;
			log.info("savingFileName: " + savingFileName);
			result=savingFileName;
			try {
				File saveFile = new File(uploadPath, savingFileName);
				multipartFile.transferTo(saveFile);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		log.info("result: " + result);
		return result;
	}
	

	
	@PostMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestParam("fileName") String[] fileName, @RequestParam("lectureNo") String lectureNo) throws IOException {
		//log.info("download file: " + fileName);
		//Resource resource = new FileSystemResource("c:\\upload\\1\\" + fileName);
		//Resource resource = new FileSystemResource("c:\\upload\\1\\*");
		
		log.info("lectureNo: " + lectureNo);
		
		
		
		String zipFile = "C:/upload/"+lectureNo+"/assignment.zip";

		List<String> sourceFiles = new ArrayList<String>();
		
		for(int i=0; i<fileName.length;i++) {
			if(!fileName[i].equals("")) {
				log.info("fileName : " + fileName[i]);
				sourceFiles.add("C:/upload/"+lectureNo+"/"+fileName[i]);
			}
		}
		//sourceFiles.add("C:/upload/1/dream02.png");
		FileOutputStream fout = new FileOutputStream(zipFile);
	    ZipOutputStream zout = new ZipOutputStream(fout);

	    for(int i=0; i < sourceFiles.size(); i++){

	        //본래 파일명 유지, 경로제외 파일압축을 위해 new File로 
	        ZipEntry zipEntry = new ZipEntry(new File(sourceFiles.get(i)).getName());
	        zout.putNextEntry(zipEntry);

	        //경로포함 압축
	        //zout.putNextEntry(new ZipEntry(sourceFiles.get(i)));

	        FileInputStream fin = new FileInputStream(sourceFiles.get(i));
	        byte[] buffer = new byte[1024];
	        int length;

	        // input file을 1024바이트로 읽음, zip stream에 읽은 바이트를 씀
	        while((length = fin.read(buffer)) > 0){
	            zout.write(buffer, 0, length);
	        }

	        zout.closeEntry();
	        fin.close();
	    }

	    zout.close();
	    Resource resource = new FileSystemResource("c:\\upload\\"+lectureNo+"\\assignment.zip");
	    
		log.info("resource: " + resource);
		
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		log.info("resourceName: " + resourceName);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; fileName=" + resourceName);
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	

}
