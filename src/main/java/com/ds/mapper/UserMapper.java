package com.ds.mapper;

import com.ds.domain.AuthVO;
import com.ds.domain.UserVO;

public interface UserMapper {

	public UserVO checkLogin(String id);
	public void user_register(UserVO vo);
	public void user_regAuth(AuthVO auth);	
	
}
