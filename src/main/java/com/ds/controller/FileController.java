package com.ds.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ds.domain.FileVO;
import com.ds.service.LectureService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/file/*")
@PreAuthorize("isAuthenticated()")
public class FileController {
	
	@Setter(onMethod_ = { @Autowired })
	private LectureService lectureService;
	
	
	@PostMapping(value="/uploadAjaxAction/{lectureNo}/{userNo}", produces="application/text;charset=utf-8")
	@ResponseBody
	public String uploadAjaxPost(MultipartFile[] uploadFile, @PathVariable Long lectureNo, @PathVariable Long userNo) {
		
		String result=null;
		
		String uploadFolder = "C:\\upload\\"+lectureNo;
		
		List<FileVO> fileVo=lectureService.fileListAll(lectureNo);
		

		File uploadPath = new File(uploadFolder);
		log.info("upload path: " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
			String uploadFileName = multipartFile.getOriginalFilename();
			log.info("uploadFileName: " + uploadFileName);
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			String savingFileName=lectureNo.toString()+"_"+userNo.toString()+"_"+uploadFileName;
			log.info("savingFileName: " + savingFileName);
			
			for(int i=0;i<fileVo.size();i++) {
				if(fileVo.get(i).getFile_name().equals(savingFileName)) {
					
				}
			}
			
			FileVO vo=new FileVO();
			vo.setLecture_no(lectureNo);
			vo.setUser_no(userNo);
			vo.setFile_name(savingFileName);
			try {
				lectureService.fileSave(vo);
			} catch (Exception e) {
				return savingFileName+"(기존 파일에 덮어씌워짐)";
			}
			
			
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
		
		/////////////////////////////////////////////////파일삭제 시작
		
		// Calendar 객체 생성
		Calendar cal = Calendar.getInstance() ;
		long todayMil = cal.getTimeInMillis() ;     // 현재 시간(밀리 세컨드)
		long oneDayMil = 24*60*60*1000 ;            // 일 단위
		 
		Calendar fileCal = Calendar.getInstance() ;
		Date fileDate = null ;
		 
		 
		File path = new File("c:\\upload\\"+lectureNo) ;
		File[] list = path.listFiles() ;            // 파일 리스트 가져오기
		 
		 
		for(int j=0 ; j < list.length; j++){
		                     
		                     
		    // 파일의 마지막 수정시간 가져오기
		    fileDate = new Date(list[j].lastModified()) ;
		     
		    // 현재시간과 파일 수정시간 시간차 계산(단위 : 밀리 세컨드)
		    fileCal.setTime(fileDate);
		    long diffMil = todayMil - fileCal.getTimeInMillis() ;
		     
		    //날짜로 계산
		    int diffDay = (int)(diffMil/oneDayMil) ;
		 
		     
		    // 3일이 지난 파일 삭제
		    if(diffDay > 3 && list[j].exists()){
		        list[j].delete() ;
		        System.out.println(list[j].getName() + " 파일을 삭제했습니다.");
		    }
		     
		}
		
		/////////////////////////////////////////////////파일삭제 끝
		
		
		
		
		
		//log.info("download file: " + fileName);
		//Resource resource = new FileSystemResource("c:\\upload\\1\\" + fileName);
		//Resource resource = new FileSystemResource("c:\\upload\\1\\*");
		
		log.info("lectureNo: " + lectureNo);
		
		
		
		String zipFile = "C:/upload/"+lectureNo+"/assignment.zip";

		List<String> sourceFiles = new ArrayList<String>();
		
		
		
		List<FileVO> fileVo=lectureService.fileListAll(Long.parseLong(lectureNo));
		for(int i=0; i<fileVo.size();i++) {
			String voFileName=fileVo.get(i).getFile_name();
			log.info("fileName : " + voFileName);
			sourceFiles.add("C:/upload/"+lectureNo+"/"+voFileName);
		}
		lectureService.fileDeleteAll(Long.parseLong(lectureNo));
		
		
		
//		for(int i=0; i<fileName.length;i++) {
//			if(!fileName[i].equals("")) {
//				log.info("fileName : " + fileName[i]);
//				sourceFiles.add("C:/upload/"+lectureNo+"/"+fileName[i]);
//			}
//		}
		//sourceFiles.add("C:/upload/1/dream02.png");
		FileOutputStream fout = new FileOutputStream(zipFile);
	    ZipOutputStream zout = new ZipOutputStream(fout);

	    for(int i=0; i < sourceFiles.size(); i++){
	    	String sourceName=new File(sourceFiles.get(i)).getName();
	    	int idx = sourceName.indexOf("_");
	    	String beforeRealName = sourceName.substring(idx+1);
	    	int idx2 = beforeRealName.indexOf("_");
	    	String realName = beforeRealName.substring(idx2+1);
	    	
	        //본래 파일명 유지, 경로제외 파일압축을 위해 new File로 
	        //ZipEntry zipEntry = new ZipEntry(new File(sourceFiles.get(i)).getName());
	        ZipEntry zipEntry = new ZipEntry(beforeRealName);
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
	
	
	@PostMapping("/fileState")
	@ResponseBody
	public String fileState(boolean file_status, Long lecture_no) {
	    log.info("file_state: " + file_status);
	    log.info("lecture_no: " + lecture_no);
	    lectureService.fileState(file_status, lecture_no);
	    
	    
	    
	    return "file_status changed successfully";
	}
	

}
