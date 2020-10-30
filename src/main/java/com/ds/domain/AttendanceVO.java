package com.ds.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AttendanceVO {
	private Long lecture_no;
	private Long user_no;
	private String attendance_state;
	private Date regdate;
	
	
}
