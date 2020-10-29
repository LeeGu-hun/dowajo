package com.ds.service;

import com.ds.domain.UserVO;

public interface UserService {
	
	public String twin_check(String user_id);	//아이디 중복검사
	public void user_register(UserVO vo);		//사용자 등록
	public UserVO user_read(String user_id);	//사용자 마이페이지
	public boolean user_modify(UserVO vo);		//사용자 정보 수정
	public boolean user_delete(Long user_no);	//사용자 삭제
	
}