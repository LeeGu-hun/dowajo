package com.ds.controller;

import java.util.List;

import com.ds.domain.Criteria;
import com.ds.domain.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;
import com.ds.service.LectureService;
import com.ds.service.StudentService;
import com.ds.service.UserService;
import com.ds.domain.Criteria;

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
	private StudentService studentService;

	@GetMapping("/main")
	public void main() {
	}
	
	@GetMapping("/lecture")
	public void lecture(Model model) {
		model.addAttribute("lectureInfo", lecureService.lectureInfo(1l));
	}
	
	@GetMapping("/lecturelist")	
	@Transactional
	public void lecturelist(@RequestParam("user_no")Long user_no, Model model, @ModelAttribute("cri") Criteria cri) {		
		List<LectureVO> list = studentService.lectureAllList(cri);
		model.addAttribute("leLi",studentService.lectureList(user_no));
		model.addAttribute("leAL", list);		
	}
	
	@GetMapping("/lectureSearch")
	public void lectureSearch(Criteria cri, Model model) {
		int total=studentService.getTotal(cri);
		List<LectureVO> list = studentService.lectureAllList(cri);
		model.addAttribute("leAL", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}
