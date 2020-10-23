package com.ds.domain;


import lombok.Data;

@Data
public class AuthVO {

  
	private String user_no;
	private String user_auth;
  
	public AuthVO(String string) {
		this.user_auth=string;
	}
  
}
