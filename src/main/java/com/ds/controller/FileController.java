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
	
	
	
	@PostMapping(value="/uploadAjaxAction", produces="application/text;charset=utf-8")
	@ResponseBody
	public String uploadAjaxPost(MultipartFile[] uploadFile) {
		String result=null;
		
		String uploadFolder = "C:\\upload";
		
//		String uploadFolderPath = getFolder();  //추가
		// 년/월/일 폴더 생성
		File uploadPath = new File(uploadFolder);  //수정
		log.info("upload path: " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
//			AttachFileDTO attachDTO = new AttachFileDTO();  //추가
			
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("uploadFileName: " + uploadFileName);
			// IE 에서 filepath 삭제하고 파일명만 구하기
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("only file name: " + uploadFileName);
//			attachDTO.setFileName(uploadFileName);  //추가
			
			//아래두줄 파일 중복없애기 위해 랜덤문장을 원래 파일명 앞쪽에 붙이는거.
//			UUID uuid = UUID.randomUUID();
//			uploadFileName = uuid.toString() + "_" + uploadFileName;
			result=uploadFileName;
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile); //saveFile경로에 multipartFile저장
				
//				//추가
//				attachDTO.setUuid(uuid.toString());
//				attachDTO.setUploadPath(uploadFolderPath);
//				
//				//아래는 섬네일만드는거 thumbnailator 가 pom에 넣어서 라이브러리가 있어야 하는듯.
//				if (checkImageType(saveFile)) {
//					
//					attachDTO.setImage(true);  //추가
//					
//					FileOutputStream thumbnail = new FileOutputStream(
//							new File(uploadPath, "s_" + uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
//					
//					thumbnail.close();
//				}
//				
//				list.add(attachDTO);  //추가
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		log.info("result: " + result);
		return result;  //추가
	}
	

	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
			@RequestHeader("User-Agent") String userAgent,  //추가) 디바이스 정보를 알아냄 @RequestHeader는 헤더정보 받아서 ie인지 chrome인지 알게함.
			String fileName) 
	{
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
