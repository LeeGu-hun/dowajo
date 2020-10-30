package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TeacherVO {
	
	private Long lecture_no;
	private Long user_no;
	private String user_name;
	private String user_mobile;
	private String lecture_name;
	private String lecture_description;
	private String lecture_afreecaid;
	private String class_status;
	private Date regdate;
	private List<ClassListVO> classList;
	private List<String> checkArr;
	
}
