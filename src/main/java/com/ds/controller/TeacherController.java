package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ds.service.LectureService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/teacher/*")
@PreAuthorize("hasRole('ROLE_TEACHER')")
public class TeacherController {
	@Setter(onMethod_ = { @Autowired }) // 혹은 위에 //@AllArgsConstructor 붙이든지
	private LectureService lecureService;

	@GetMapping("/main")
	public void main() {
	}
	@GetMapping("/lecture")
	public void lecture(Model model) {
		model.addAttribute("lectureInfo", lecureService.lectureInfo(1l));
	}

}
