package com.ds.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		List<TeacherVO> list = TeacherService.getList();//cri�ֱ�
		System.out.println("list : "+list);
		model.addAttribute("list",list);
		//model.addAttribute("pageMaker", new PageDTO(cri,total));
		
	}
	@GetMapping("/teacher_check")
	public void teacher_check(Model model) {
		List<TeacherVO> cancel = TeacherService.cancel();//cri�ֱ�
		System.out.println("cancel : "+cancel);
		model.addAttribute("cancel",cancel);
		
		List<TeacherVO> sign_up = TeacherService.sign_up();//cri�ֱ�
		System.out.println("sign_up : "+sign_up);//get2 ���ڿ��� ������� mapper.xml�� 
		model.addAttribute("sign_up",sign_up);//<c:forEach items="${get2}" var="teacher">�����ؾ���
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
