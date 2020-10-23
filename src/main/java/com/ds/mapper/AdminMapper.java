package com.ds.mapper;

import java.util.List;

import com.ds.domain.AuthVO;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface AdminMapper {

	public void admin_regist(UserVO vo);
	public void admin_registAuth(AuthVO auth);
	public void teacher_regist(UserVO vo);
	public void teacher_registAuth(AuthVO auth);
	
	public String duplicateId(String user_id);
}
