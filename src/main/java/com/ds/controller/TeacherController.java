package com.ds.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.TeacherVO;
import com.ds.domain.UserVO;
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
	private TeacherService teacherService;

	@GetMapping("/teacher_main")
	public void teacher_main(/* Criteria cri, */Model model) {
		log.info("teachergetList.....");
		// int total = TeacherService.getTotal(cri);
		List<TeacherVO> list = teacherService.getList();// cri넣기
		System.out.println("list : " + list);
		model.addAttribute("list", list);
		// model.addAttribute("pageMaker", new PageDTO(cri,total));

	}

	@GetMapping("/teacher_check")
	public void teacher_check(@RequestParam("lecture_no") int lecture_no, Model model) {
		List<TeacherVO> cancel = teacherService.cancel(lecture_no);// cri넣기
		System.out.println("cancel : " + cancel);
		model.addAttribute("cancel", cancel);

		List<TeacherVO> sign_up = teacherService.sign_up(lecture_no);// cri넣기
		System.out.println("sign_up : " + sign_up);// get2 문자열에 써놓은게 mapper.xml에
		model.addAttribute("sign_up", sign_up);// <c:forEach items="${get2}" var="teacher">동일해야함
		model.addAttribute("lecture_no", lecture_no);
		// List<TeacherVO> refresh = TeacherService.refresh();
	}

	@PostMapping(value = "/joinup", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> teacher_joinup(@RequestParam("lecture_no") int lecture_no,
			@RequestParam("checkArr[]") String[] checkArr, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		log.info("컨트롤러확인용:" + Arrays.toString(checkArr));

		return new ResponseEntity(teacherService.refresh(checkArr, lecture_no), HttpStatus.OK);
	}
	@PostMapping(value = "/cancel", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> teacher_cancel(@RequestParam("lecture_no") int lecture_no,
			@RequestParam("checkArr[]") String[] checkArr, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		log.info("컨트롤러확인용:" + Arrays.toString(checkArr));

		return new ResponseEntity(teacherService.cancelrefresh(checkArr, lecture_no), HttpStatus.OK);
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
	
	@GetMapping({"/myPage", "/myPage_modify"})
	public void getUser(@RequestParam("user_id") String user_id, Model model){
		model.addAttribute("user", teacherService.user_read(user_id));
	}
	
	@PostMapping("/myPage_modify")
	public String user_modify(UserVO vo, RedirectAttributes rttr) {		
		if(teacherService.user_modify(vo))
			rttr.addAttribute("result", "success");
		return "redirect:/myPage_modify?user_id=" + vo.getUser_id();
	}
	
	@PostMapping("/user_delete")
	public String user_delete(@RequestParam("user_no") Long user_no, RedirectAttributes rttr) {		
		if(teacherService.user_delete(user_no))
			rttr.addAttribute("result", "success");
		return "redirect:/customLogin";
	}

}
