package com.ds.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FileVO {
	
	private Long lecture_no;
	private Long user_no;
	private String file_name;
	private Date regdate;
	
	private String user_name;
	
}
