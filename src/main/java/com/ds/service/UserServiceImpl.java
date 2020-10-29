package com.ds.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ds.domain.AuthVO;
import com.ds.domain.UserVO;
import com.ds.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

	@Setter(onMethod_ = {@Autowired})
	private UserMapper mapper;
	@Setter(onMethod_ = {@Autowired})	
	private PasswordEncoder pwencoder;

	@Override
	public void user_register(UserVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		List<AuthVO> list = new ArrayList<AuthVO>();
		list.add(new AuthVO("ROLE_STUDENT"));
		vo.setAuthList(list);
		
		mapper.user_register(vo);
		
		vo.getAuthList().forEach(auth ->{
			log.info("-------" + vo.getUser_no());
			auth.setUser_no(String.valueOf(vo.getUser_no()));
			log.info(" + 권한 확인 : " + auth);
			mapper.user_regAuth(auth);;
		});
	}

	@Override
	public String twin_check(String user_id) {
		return mapper.twin_check(user_id);		
	}
	
	@Override
	public UserVO user_read(String user_id) {
		return mapper.user_read(user_id);				
	}

	@Override
	public boolean user_modify(UserVO vo) {
		vo.setUser_pw(pwencoder.encode(vo.getUser_pw()));
		boolean modifyResult = mapper.user_update(vo) == 1;
		return modifyResult;		
	}

	@Override
	public boolean user_delete(String user_id) {
		
		return mapper.user_delete(user_id) == 1;
	}
	
	
}