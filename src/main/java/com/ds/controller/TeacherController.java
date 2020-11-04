package com.ds.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.AuthVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
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
	private LectureService lectureService;

	@Setter(onMethod_ = { @Autowired })
	private TeacherService teacherService;

	@GetMapping("/teacher_main")
	public void teacher_main(@RequestParam("user_no")Long user_no, Model model) {
		log.info("teachergetList.....");
		
		
		// int total = TeacherService.getTotal(cri);
		List<TeacherVO> list = teacherService.getList(user_no);// cri넣기
		System.out.println("list : " + list);
		model.addAttribute("list", list);
		// model.addAttribute("pageMaker", new PageDTO(cri,total));

	}

	@GetMapping("/teacher_check")
	public void teacher_check(@RequestParam("lecture_no") Long lecture_no, Model model) {
		List<TeacherVO> cancel = teacherService.cancel(lecture_no);// cri넣기
		System.out.println("cancel : " + cancel);
		model.addAttribute("cancel", cancel);
	
		List<TeacherVO> sign_up = teacherService.sign_up(lecture_no);// cri넣기
		System.out.println("sign_up : " + sign_up);// get2 문자열에 써놓은게 mapper.xml에
		model.addAttribute("sign_up", sign_up);// <c:forEach items="${get2}" var="teacher">동일해야함
		model.addAttribute("lecture_no", lecture_no);
	}
	
	
	@PostMapping(value = "/joinup", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> teacher_joinup(@RequestParam("lecture_no") Long lecture_no,
			@RequestParam("checkArr[]") String[] checkArr, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		log.info("컨트롤러확인용:" + Arrays.toString(checkArr));

		return new ResponseEntity(teacherService.refresh(checkArr, lecture_no), HttpStatus.OK);
	}
	@PostMapping(value = "/cancelclean", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> cancelclean(@RequestParam("lecture_no") Long lecture_no, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		return new ResponseEntity(teacherService.regetlist_canecl(lecture_no), HttpStatus.OK);
	}
	@PostMapping(value = "/sign_up_clean", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> sign_up_clean(@RequestParam("lecture_no") Long lecture_no, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		return new ResponseEntity(teacherService.regetlist_sign_up(lecture_no), HttpStatus.OK);
	}
	@PostMapping(value = "/cancel", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<TeacherVO>> teacher_cancel(@RequestParam("lecture_no") Long lecture_no,
			@RequestParam("checkArr[]") String[] checkArr, Model model) {
		log.info("컨트롤러확인용:" + lecture_no);
		log.info("컨트롤러확인용:" + Arrays.toString(checkArr));

		return new ResponseEntity(teacherService.cancelrefresh(checkArr, lecture_no), HttpStatus.OK);
	}

	@GetMapping("/teacher_reg")
	@PreAuthorize("isAuthenticated()")
	public void teacher_reg(@RequestParam("user_no")Long user_no) {
		log.info("get register");
	}
	
	@PostMapping("/teacher_reg")
	@PreAuthorize("isAuthenticated()")
	public String teacher_reg(LectureVO lecture,@RequestParam("user_no")Long user_no, Model model) {
		log.info("================");
		log.info("post register: " + lecture);
		log.info("post register user_no: " + user_no);
		log.info("================");

		teacherService.register(lecture);
		System.out.println("after 렉쳐번호 : "+lecture.getLecture_no());
		//Long get_no = lecture.getLecture_no();
		//log.info("get_no는?? "+get_no);
		teacherService.register_class_list(lecture,user_no);
		return "redirect:/teacher/teacher_main?user_no="+user_no;
	}

	@GetMapping("/main")
	public void main() {
	}

	@GetMapping("/lecture")
	public void lecture(@RequestParam("lecture_no") Long lecture_no, Model model) {
		model.addAttribute("lectureInfo", lectureService.lectureInfo(lecture_no));
		model.addAttribute("lectureUser", lectureService.lectureUser(lecture_no));
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
