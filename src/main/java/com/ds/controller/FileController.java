package com.ds.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

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
			result=uploadFileName;
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
	

	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,	String fileName) {
		log.info("download file: " + fileName);
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		
		String uploadFolder = "C:\\upload";
		File uploadPath = new File(uploadFolder);
		
		log.info("resource: " + resource);
		
		// 추가
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		log.info("resourceName: " + resourceName);
		// 추가) remove UUID
		//String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		// 수정
		try {
			//msie : 마이크로소프트인터넷익스플로러, trident : ie브라우저의 엔진 이름(ie11처리)
			
			//이 아래는 ie면urlencoding(%ED%95%9C%EA%B8%80.jpg)된게 들어가고 아니면 그냥 ISO-8859-1 타입으로 받는거인거 같음;
			boolean checkIE = (userAgent.indexOf("MSIE")>-1 || userAgent.indexOf("Trident")>-1);
			String downloadName = null;
			//downloadName= (checkIE)?URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " "):new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			downloadName= (checkIE)?URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " "):new String(resourceName.getBytes("UTF-8"), "ISO-8859-1");
			log.info("downloadName: " + downloadName);
			headers.add("Content-Disposition", "attachment; fileName=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

}
