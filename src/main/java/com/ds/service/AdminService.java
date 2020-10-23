package com.ds.service;

import java.util.List;

import com.ds.domain.UserVO;

import com.ds.domain.LectureVO;
	
public interface AdminService {
	
	//admin
	public void admin_regist(UserVO vo);
	public void teacher_regist(UserVO vo);
	
	public String duplicateId(String user_id);
}