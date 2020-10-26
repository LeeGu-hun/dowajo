package com.ds.service;

import com.ds.domain.UserVO;

public interface UserService {
	
	public void user_register(UserVO vo);
	public String twin_check(String User_id);
}