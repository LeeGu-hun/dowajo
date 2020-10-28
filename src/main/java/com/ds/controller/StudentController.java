package com.ds.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.domain.PageDTO;
import com.ds.service.LectureService;
import com.ds.service.StudentService;

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
	public void lecturelist(@RequestParam("user_no")Long user_no, Model model) {		
		model.addAttribute("leCo",studentService.lectureConfirmList(user_no));
		model.addAttribute("leLi",studentService.lectureList(user_no));		
	}
	
	
	@GetMapping("/lectureSearch")
	public void lectureSearch(Criteria cri, Model model) {
		int total=studentService.getTotal(cri);
		List<LectureVO> list = studentService.lectureAllList(cri);		
		model.addAttribute("leAL", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/lectureInfo")
	public void lectureInfo(@RequestParam("lecture_name")String lecture_name, Model model, @ModelAttribute("cri") Criteria cri) {
		List<LectureVO> list = studentService.lectureInfo(lecture_name);
		LectureVO vo = (LectureVO) list.get(0);
		log.info(">>>>>"+vo.getLecture_name()+"///////////"+lecture_name);
		model.addAttribute("leIn", vo);
	}
	
	@PostMapping("/lectureInfo")
	public String lectureInfo(@RequestParam("lecture_no")Long lecture_no,
			@RequestParam("user_no")Long user_no, RedirectAttributes rttr) {
		ClassListVO vo = new ClassListVO();		
		vo.setLecture_no(lecture_no);
		vo.setUser_no(user_no);		
		studentService.applyClass(vo);		
		rttr.addAttribute("user_no", user_no);		
		return "redirect:/student/lecturelist";
		
	}
	
}
