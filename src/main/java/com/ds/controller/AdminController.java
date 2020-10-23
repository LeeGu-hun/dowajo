package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.UserVO;
import com.ds.mapper.AdminMapper;
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
	public void questions() {
		
	}
	
	@GetMapping(value = "/duplicateId", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String duplicateId(String user_id) {
		return service.duplicateId(user_id);
	}

}
