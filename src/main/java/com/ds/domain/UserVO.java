package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
	private Long user_no;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_depart;
	private String user_mobile;
	private String user_email;
	private Date regdate;
	private List<AuthVO> authList;
	
}
