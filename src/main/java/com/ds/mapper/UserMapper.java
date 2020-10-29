package com.ds.mapper;

import com.ds.domain.AuthVO;
import com.ds.domain.UserVO;

public interface UserMapper {

	public UserVO checkLogin(String id);		//로그인 체크
	public void user_register(UserVO vo);		//사용자 등록
	public void user_regAuth(AuthVO auth);		//사용자 권한 등록
	public String twin_check(String user_id);	//아이디 중복검사	
	public UserVO user_read(String user_id);	//사용자 정보보기
	public int user_update(UserVO vo);			//회원정보 업데이트
	public int user_delete(String user_id);		//사용자 삭제
}
