package com.ds.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ds.domain.LectureVO;
import com.ds.domain.MLectureVO;
import com.ds.domain.UserVO;
import com.ds.mapper.UserMapper;
import com.ds.service.StudentService;
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

	@PostMapping(value="/twin_check", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String twin_chk(String user_id) {
		return service.twin_check(user_id);
	}
	
	@GetMapping({"/myPage", "/myPage_modify"})
	public void getUser(@RequestParam("user_id") String user_id, Model model){
		model.addAttribute("user", service.user_read(user_id));
	}
	
	@PostMapping("/myPage_modify")
	public String user_modify(UserVO vo, RedirectAttributes rttr) {		
		if(service.user_modify(vo))
			rttr.addAttribute("result", "success");
		return "redirect:/myPage_modify?user_id=" + vo.getUser_id();
	}
	
	@PostMapping("/user_delete")
	public String user_delete(@RequestParam("user_no") Long user_no, RedirectAttributes rttr) {		
		if(service.user_delete(user_no))
			rttr.addAttribute("result", "success");
		return "redirect:/customLogin";
	}
	
	
	
	
	@Setter(onMethod_ = {@Autowired})
	private UserMapper userMapper;
	
	@Setter(onMethod_ = { @Autowired })
	private StudentService studentService;
	
	@Setter(onMethod_ = {@Autowired})	
	private PasswordEncoder pwencoder;
	
	@ResponseBody
	@PostMapping({"/mlogin"})
	public Long mlogin(String userId, String userPw){
		System.out.println("userPw : "+userPw);
		UserVO uvo = userMapper.checkLogin(userId);
		
		boolean passMatch = pwencoder.matches(userPw, uvo.getUser_pw());
		if(uvo==null || !passMatch) {
			return null;
		}
		else {
			Long user_no=uvo.getUser_no();
			return user_no;
		}
	}
	
	@ResponseBody
	@GetMapping({"/mlist"})
	public List<MLectureVO> mlist(Long user_no){
		List<LectureVO> lvo=studentService.lectureConfirmList(user_no);
		List<MLectureVO> mlvo = new ArrayList<MLectureVO>();
		for(int i=0;i<lvo.size();i++) {
			MLectureVO vo=new MLectureVO();
			vo.setNumber(lvo.get(i).getLecture_no().toString());
			vo.setName(lvo.get(i).getLecture_name().toString());
			vo.setAfid(lvo.get(i).getLecture_afreecaid().toString());
			mlvo.add(vo);
		}
		
		return mlvo;
	}
}