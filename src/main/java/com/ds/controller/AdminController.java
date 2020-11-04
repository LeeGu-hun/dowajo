package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.Criteria;
import com.ds.domain.PageDTO;
import com.ds.domain.QuestionsVO;
import com.ds.domain.UserVO;
import com.ds.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class AdminController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminService service;
	
	@GetMapping("/main")
	public void main(Criteria cri, Model model) {
		int total = service.getTotal2(cri);
		model.addAttribute("questions", service.getList2(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	@GetMapping("/main_regist")
	public void main_registGet() {
		
	}
	
	@PostMapping("/main_regist")
	public String main_registPost(QuestionsVO vo, RedirectAttributes rttr) {
		service.main_regist(vo);
		rttr.addFlashAttribute("result", vo.getQa_writer());	
		return "redirect:/admin/main";
	}
	
	@GetMapping("/admin_regist")
	public void admin_registGet() {
		
	}
	
	@PostMapping("/admin_regist")
	public String admin_registPost(UserVO vo, RedirectAttributes rttr) {
		service.admin_regist(vo);
		rttr.addFlashAttribute("result", vo.getUser_id());			
		return "redirect:/admin/main";
	}
	
	@GetMapping("/teacher_regist")
	public void teacher_regist() {
		
	}
	
	@PostMapping("/teacher_regist")
	public String teacher_registPost(UserVO vo, RedirectAttributes rttr) {
		service.teacher_regist(vo);
		rttr.addFlashAttribute("result", vo.getUser_id());			
		return "redirect:/admin/main";
	}
	
	@GetMapping("/questions")
	public void questions(Criteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("questions", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping(value = "/duplicateId", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String duplicateId(String user_id) {
		return service.duplicateId(user_id);
	}
	
	@GetMapping("/userTypeList")
	public void userList(Criteria cri, String user_auth, Model model) {
		int total = service.getUserTypeTotal(cri);
		model.addAttribute("userTypeList", service.getUserTypeList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("user_auth", user_auth);
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("user_no") int user_no, Model model, @ModelAttribute("cri") Criteria cri) {
		System.out.println("UserVO : "+service.get(user_no));
		model.addAttribute("user", service.get(user_no));
	}
	
	@PostMapping("/get")
	public String get(RedirectAttributes rttr,UserVO vo, @ModelAttribute("cri") Criteria cri) {
		rttr.addAttribute("user_auth", cri.getUser_auth());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/get?user_no="+vo.getUser_no() ;
	}
	
	@GetMapping("/main_get")
	public void main_get(@RequestParam("qa_no") int qa_no, Model model, @ModelAttribute("cri") Criteria cri) {
		System.out.println("QuestionsVO : "+service.get(qa_no));
		model.addAttribute("user", service.main_get(qa_no));
	}
	
	@PostMapping("/main_get")
	public String main_get(RedirectAttributes rttr, QuestionsVO vo, @ModelAttribute("cri") Criteria cri) {
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/admin/main_get?qa_no="+vo.getQa_no() ;
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("user_no") int user_no, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("remove...cri" + user_no+"/"+cri);
		
		if (service.remove(user_no)) rttr.addFlashAttribute("result", "success");
		int total = service.getUserTypeTotal(cri);
		if (total % 10 == 0) cri.setPageNum(cri.getPageNum() - 1);
		if (total == 0) cri.setPageNum(1);
		return "redirect:/admin/userTypeList"+cri.getListLink();
	}
	@PostMapping("/main_remove")
	public String main_remove(@RequestParam("qa_no") int qa_no, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("remove...cri" + qa_no+"/"+cri);
		if (service.main_remove(qa_no)) rttr.addFlashAttribute("result", "success");
		return "redirect:/admin/main"+cri.getListLink();
	}
	
	@GetMapping({"/myPage", "/myPage_modify"})
	public void getUser(@RequestParam("user_id") String user_id, Model model){
		model.addAttribute("user", service.user_read(user_id));
	}
	
	@PostMapping("/myPage_modify")
	public String user_modify(UserVO vo, RedirectAttributes rttr) {		
		if(service.user_modify(vo))
			rttr.addAttribute("result", "success");
		return "redirect:/admin/myPage_modify?user_id=" + vo.getUser_id();
	}
	
	@PostMapping("/user_delete")
	public String user_delete(@RequestParam("user_no") Long user_no, RedirectAttributes rttr) {		
		if(service.user_delete(user_no))
			rttr.addAttribute("result", "success");
		return "redirect:/customLogin";
	}
}
