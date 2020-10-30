package com.ds.controller;

import java.util.List;

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
	public void main() {
		
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
	
	@GetMapping("/admin_list")
	public void admin_list(Criteria cri, Model model) {
		int total = service.getlistTotal(cri);
		model.addAttribute("admin_list", service.admin_list(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/teacher_list")
	public void teacher_list(Criteria cri, Model model) {
		int total = service.getlistTotal(cri);
		model.addAttribute("teacher_list", service.teacher_list(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/student_list")
	public void student_list(Criteria cri, Model model) {
		int total = service.getlistTotal(cri);
		model.addAttribute("student_list", service.student_list(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("user_no") int user_no, Model model, @ModelAttribute("cri") Criteria cri) {
		model.addAttribute("user", service.get(user_no));
	}
	
	@PostMapping("/get")
	public String modify(RedirectAttributes rttr,UserVO vo, @ModelAttribute("cri") Criteria cri) {
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/get?user_no="+vo.getUser_no() ;
	}
	
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("user_no") int user_no, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("remove..." + user_no);
		
		if (service.remove(user_no)) {
			rttr.addFlashAttribute("result", "success");
		}

		int total = service.getlistTotal(cri);
		if (total % 10 == 0) {
			cri.setPageNum(cri.getPageNum() - 1);
		}
		
		if (total == 0) {
			cri.setPageNum(1);
		}
		return "redirect:/admin/admin_list"+cri.getListLink();
	}
	
}
