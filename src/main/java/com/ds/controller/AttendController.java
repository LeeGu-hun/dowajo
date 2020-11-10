package com.ds.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ds.domain.AttendanceVO;
import com.ds.service.LectureService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/attend/*")
@PreAuthorize("isAuthenticated()")
public class AttendController {
	
	@Setter(onMethod_ = { @Autowired })
	private LectureService lectureService;
	
	
	@PostMapping(value="/putAttendance", produces = "application/text; charset=utf8")
	@ResponseBody
	public String putAttendance(AttendanceVO vo) {
	    
	    lectureService.setAttend(vo);
	    
	    return "attend_success";
	}
	@PostMapping(value="/viewAttendance", produces = {MediaType.APPLICATION_XML_VALUE,	MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public List<AttendanceVO> viewAttendance(@RequestParam("lectureNo") Long lectureNo, @RequestParam("id") String id) {
		
		return lectureService.viewAttend(lectureNo, id);
	}
	
	
	
	

}
