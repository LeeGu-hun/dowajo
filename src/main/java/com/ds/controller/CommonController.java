package com.ds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.UserVO;
import com.ds.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	@Setter(onMethod_ = {@Autowired})
	private UserService service;
	
	@GetMapping("/user_register")
	public void user_regGet() {
		log.info("User_Reg Get...");
	}
	
	@PostMapping("/user_register")
	public String user_regPost(UserVO vo, RedirectAttributes rttr) {
		log.info("User_Reg Post...");
		service.user_register(vo);
		rttr.addFlashAttribute("result", vo.getUser_id());
		return "redirect:/student/main";
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account"); 
		}
		
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}

	@GetMapping(value="/twin_check", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String twin_chk(String user_id) {
		return service.twin_check(user_id);
	}
	
	@GetMapping({"/myPage", "/myPageModify"})
	public void getUser(@RequestParam("user_id") String user_id, Model model){
		model.addAttribute("user", service.user_read(user_id));
	}

}