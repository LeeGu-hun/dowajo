package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ds.domain.UserVO;
import com.ds.service.LectureService;
import com.ds.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/student/*")
@PreAuthorize("hasRole('ROLE_STUDENT')")
public class StudentController {
	@Setter(onMethod_ = { @Autowired })
	private LectureService lecureService;
	
	@Setter(onMethod_ = { @Autowired })
	private UserService userService;

	@GetMapping("/main")
	public void main() {
	}
	
	@GetMapping("/lecture")
	public void lecture(Model model) {
		model.addAttribute("lectureInfo", lecureService.lectureInfo(1l));
	}
	
	@GetMapping("/lecturelist")
	public void lecturelist(@RequestParam("user_no") Long user_no, Model model) {	
		log.info("check controller");
		model.addAttribute("leLi",userService.lecutureList(user_no));
	}

}
