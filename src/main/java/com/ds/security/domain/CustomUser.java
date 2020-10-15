package com.ds.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.ds.domain.UserVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private static final long serialVersionUID = 1L;
	private UserVO user;

	public CustomUser(String test, String password, Collection<? extends GrantedAuthority> authorities) 
	{
		super(test, password, authorities); 
	}
	
	public CustomUser(UserVO vo) {
		super(
				vo.getUser_id(), vo.getUser_pw(),
				vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getUser_auth())).collect(Collectors.toList())
		); 
		this.user = vo;
	}
}