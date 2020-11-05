package com.ds.controller;

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
import com.ds.domain.QuestionsVO;
import com.ds.domain.TeacherQuestionsVO;
import com.ds.domain.UserVO;
import com.ds.service.AdminService;
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
	
	@Setter(onMethod_ = { @Autowired })
	private AdminService adminService;

	@GetMapping("/main")
	public void main(Criteria cri, Model model) {		
		int total = adminService.getTotal2(cri);
		model.addAttribute("questions", adminService.getList2(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));		
	}
	
	@GetMapping("/main_get")
	public void main_get(@RequestParam("qa_no") int qa_no, Model model, @ModelAttribute("cri") Criteria cri) {		
		model.addAttribute("user", studentService.main_read(qa_no));
	}
	
	@GetMapping("/lecture")
	public void lecture(@RequestParam("lecture_no")Long lecture_no, Model model) {
		model.addAttribute("lectureInfo", lecureService.lectureInfo(lecture_no));
	}
	
	@GetMapping("/lecturelist")	
	@Transactional
	public void lecturelist(@RequestParam("user_no")Long user_no, Model model) {		
		model.addAttribute("leCo",studentService.lectureConfirmList(user_no));
		model.addAttribute("leLi",studentService.lectureList(user_no));		
	}
	
	
	@GetMapping("/lectureSearch")
	public void lectureSearch(Criteria cri, Model model, @RequestParam("user_no")Long user_no) {
		cri.setUser_no(user_no);
		int total=studentService.getTotal(cri);		
		List<LectureVO> list = studentService.lectureAllList(cri);		
		model.addAttribute("leAL", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));		
	}

	@GetMapping("/lectureInfo")
	public void lectureInfo(@RequestParam("lecture_no")Long lecture_no, Model model) {
		List<LectureVO> list = studentService.lectureInfo(lecture_no);
		LectureVO vo = (LectureVO) list.get(0);		
		model.addAttribute("leIn", vo);
	}
	
	@PostMapping("/lectureInfo")	
	public String lectureInfo(@RequestParam("lecture_no")Long lecture_no,
			@RequestParam("user_no")Long user_no, RedirectAttributes rttr) {		
		ClassListVO vo = new ClassListVO();		
		vo.setLecture_no(lecture_no);
		vo.setUser_no(user_no);		 
		studentService.applyClass(vo);		
		rttr.addFlashAttribute("result", "success");
		rttr.addAttribute("user_no", user_no);
		return "redirect:/student/lecturelist";
		}
		
	
	@GetMapping({"/myPage", "/myPage_modify"})
	public void getUser(@RequestParam("user_id") String user_id, Model model){
		model.addAttribute("user", studentService.user_read(user_id));
	}
	
	@PostMapping("/myPage_modify")
	public String user_modify(UserVO vo, RedirectAttributes rttr) {		
		if(studentService.user_modify(vo))
			rttr.addAttribute("result", "success");
		return "redirect:/student/myPage_modify?user_id=" + vo.getUser_id();
	}
	
	@PostMapping("/user_delete")
	public String user_delete(@RequestParam("user_no") Long user_no, RedirectAttributes rttr) {		
		if(studentService.user_delete(user_no))
			rttr.addAttribute("result", "success");
		return "redirect:/customLogin";
	}
	
	@GetMapping("/QnA_list")
	public void QnA_list(@RequestParam("user_no") Long user_no ,Model model) {
		log.info("QnA_list...");
		List<QuestionsVO> list = studentService.qa_list(user_no);
		model.addAttribute("list", list);
	}
	
	@GetMapping("/QnA_register")
	public void QnA_register() {		
	}
	
	@PostMapping("/QnA_register")	
	public String QnA_register(QuestionsVO vo, RedirectAttributes rttr) {		
		log.info("QnA_reg_post : " + vo);
		studentService.qa_register(vo);
		rttr.addFlashAttribute("result", vo.getQa_writer());		
		return "redirect:/student/main";
	}
	
	@GetMapping("/QnA_get")
	public void QnA_get(@RequestParam("qa_no") Long qa_no, Model model) {
		model.addAttribute("qa", studentService.qa_get(qa_no));
	}
	
	@GetMapping("/TQnA_list")
	public void TQnA_list(@RequestParam("user_no") Long user_no ,Model model) {
		log.info("TQnA_list...");
		List<TeacherQuestionsVO> list = studentService.tqa_list(user_no);
		model.addAttribute("list", list);
	}
	
	@GetMapping("/TQnA_get")
	public void TQnA_get(@RequestParam("tqa_no") Long tqa_no, Model model) {
		model.addAttribute("tqa", studentService.tqa_get(tqa_no));
	}
	
	@GetMapping("/TQnA_register")
	public void TQnA_register() {		
	}
	
	@PostMapping("/TQnA_register")	
	public String TQnA_register(TeacherQuestionsVO vo, RedirectAttributes rttr) {		
		log.info("TQnA_reg_post : " + vo);
		studentService.tqa_register(vo);
		rttr.addFlashAttribute("result", vo.getTqa_writer());		
		return "redirect:/student/main";
	}
}
