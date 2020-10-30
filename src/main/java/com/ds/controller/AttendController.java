package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	    log.info("getLecture_no : " + vo.getLecture_no());
	    log.info("getUser_no : " + vo.getUser_no());
	    log.info("getAttendance_state : " + vo.getAttendance_state());
	    
	    lectureService.setAttend(vo);
	    
	    return "attend_success";
	}
	
	
	
	

}
