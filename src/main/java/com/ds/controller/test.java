package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ds.domain.AttendanceVO;
import com.ds.service.LectureService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/test/*")
public class test {
	
	@Setter(onMethod_ = { @Autowired })
	private LectureService lectureService;
	
	
	@GetMapping("tests")
	public void tests() {
		AttendanceVO vo=new AttendanceVO();
    	vo.setLecture_no(1l);
    	vo.setUser_no(3l);
    	vo.setAttendance_state("test");
    	System.out.println("testVO"+vo);
    	lectureService.setAttend(vo);
    	new SetAttend().start();
	}
	
	class SetAttend extends Thread{
    	
    	public void run() {

        	AttendanceVO vo=new AttendanceVO();
        	vo.setLecture_no(1l);
        	vo.setUser_no(3l);
        	vo.setAttendance_state("absent");
        	System.out.println("쓰레드VO"+vo);
        	lectureService.setAttend(vo);
        	return;
    	}
    	
    }
	
	
	
	

}
