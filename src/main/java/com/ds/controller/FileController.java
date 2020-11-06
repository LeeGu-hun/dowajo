package com.ds.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
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
	public ResponseEntity<Resource> downloadFile(@RequestParam("fileName") String[] fileName, @RequestParam("lectureNo") String lectureNo, HttpServletResponse response) throws IOException {
		
		
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
		lectureService.fileDeleteAll(Long.parseLong(lectureNo));//DB에서 경로삭제
		
		
		
//		for(int i=0; i<fileName.length;i++) {
//			if(!fileName[i].equals("")) {
//				log.info("fileName : " + fileName[i]);
//				sourceFiles.add("C:/upload/"+lectureNo+"/"+fileName[i]);
//			}
//		}
		//sourceFiles.add("C:/upload/1/dream02.png");
		FileOutputStream fout = new FileOutputStream(zipFile);
	    ZipOutputStream zout = new ZipOutputStream(fout);
	    if (sourceFiles.size() == 0) {
	    	response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('과제 제출학생이 없습니다.'); location.href='/teacher/lecture?lecture_no="+lectureNo+"';</script>");
			out.flush();
			return null;
		}
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
	        
	        
	        
	        File file = new File(sourceFiles.get(i));
	        file.delete(); //실제파일삭제
	        
	        
	        
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
	
	
	@PostMapping(value = "/viewFileList" , produces = {MediaType.APPLICATION_XML_VALUE,	MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<String> viewFileList(@RequestParam("lectureNo") Long lectureNo, @RequestParam("userNo") Long userNo ) {
		System.out.println("lectureNo : "+lectureNo);
		System.out.println("userNo : "+userNo);
		List<String> result=new ArrayList<String>();
		List<FileVO> fileList=lectureService.fileList(lectureNo, userNo);
		System.out.println("fileList : "+fileList);
		if(fileList!=null) {
			for(int i=0;i<fileList.size();i++) {
				result.add(fileList.get(i).getFile_name());
			}
		}
		
		return result;
	}
	
	@PostMapping(value="/deleteFile", produces = "application/text; charset=utf8")
	@ResponseBody
	public ResponseEntity<String> deleteFile(Long lectureNo, String fileName) {
	    log.info("deleteFile: " + fileName);
	    File file;
	    
	    try {
	    	lectureService.fileDelete(fileName);
	        file = new File("c:\\upload\\" +lectureNo+"\\"+ URLDecoder.decode(fileName, "UTF-8"));
	        file.delete(); 
	        
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	    }
	    
	    return new ResponseEntity<String>(fileName, HttpStatus.OK);
	}
	
	@PostMapping(value="/homeworkList", produces = {MediaType.APPLICATION_XML_VALUE,	MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<FileVO> homeworkList(Long lectureNo) {
		List<FileVO> result=new ArrayList<FileVO>();
		result=lectureService.fileListAll(lectureNo);
		
		log.info("homeworkList: " + result);
		
		
		return result;
	}
	
	@PostMapping(value="/setDeadline", produces = "application/text; charset=utf8")
	@ResponseBody
	public String setDeadline(String date, Long lectureNo) {
		
		log.info("date: " + date);
		
		java.sql.Timestamp t = java.sql.Timestamp.valueOf(date);
		System.out.println("sqldate타입 : "+t);
		lectureService.setFileDeadline(t, lectureNo);
		
		return t.toString();
	}
	

}
