package com.ds.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ds.domain.Criteria;
import com.ds.domain.TeacherVO;
import com.ds.service.LectureService;
import com.ds.service.TeacherService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/teacher/*")
@PreAuthorize("hasRole('ROLE_TEACHER')")
public class TeacherController {
	@Setter(onMethod_ = { @Autowired })
	private LectureService lecureService;
	
	@Setter(onMethod_ = { @Autowired })
	private TeacherService TeacherService;

	@GetMapping("/teacher_main")
	public void teacher_main(/*Criteria cri,*/Model model) {
		log.info("teachergetList.....");
		//int total = TeacherService.getTotal(cri);
		List<TeacherVO> list = TeacherService.getList();//cri넣기
		System.out.println("list : "+list);
		model.addAttribute("list",list);
		//model.addAttribute("pageMaker", new PageDTO(cri,total));
		
	}
	@GetMapping("/teacher_check")
	public void teacher_check(@RequestParam("lecture_no") int lecture_no, Model model) {
		List<TeacherVO> cancel = TeacherService.cancel();//cri넣기
		System.out.println("cancel : "+cancel);
		model.addAttribute("cancel",cancel);
		
		List<TeacherVO> sign_up = TeacherService.sign_up();//cri넣기
		System.out.println("sign_up : "+sign_up);//get2 문자열에 써놓은게 mapper.xml에 
		model.addAttribute("sign_up",sign_up);//<c:forEach items="${get2}" var="teacher">동일해야함
		
		model.addAttribute("lc_no",TeacherService.call_no(lecture_no));
		//List<TeacherVO> refresh = TeacherService.refresh();
	}
	@PostMapping("/test")
	@ResponseBody
	public List<TeacherVO> teacher_test(@RequestParam("checkArr[]") List<String>checkArr, Model model) {
		log.info("controller:::");	
		//log.info("controller:::lecture_no"+lecture_no);
		log.info("컨트롤러확인용"+checkArr);
		//log.info("ajax model: " + model);
		List<TeacherVO> refresh = TeacherService.refresh(checkArr);
		return refresh;
		
	}
	@GetMapping("/teacher_reg")
	public void teacher_reg() {
		
	}
	@GetMapping("/main")
	public void main() {
	}
	@GetMapping("/lecture")
	public void lecture(Model model) {
		model.addAttribute("lectureInfo", lecureService.lectureInfo(1l));
		model.addAttribute("lectureUser", lecureService.lectureUser(1l));
	}

}
