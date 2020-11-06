package com.ds.domain;

import java.util.Date;

import lombok.Data;

@Data
public class TeacherQuestionsVO {
	
	private Long tqa_no;
	private String tqa_writer;
	private String tqa_title;
	private String tqa_content;	
	private Date tqa_date;
	private String tqa_replyer;
	private String tqa_reply;
	private Date tqa_replydate;
	private int tqa_status;	
	
}
