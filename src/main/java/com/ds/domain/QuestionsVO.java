package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class QuestionsVO {
	
	private Long qa_no;
	private String qa_writer;
	private String qa_title;
	private String qa_content;
	private String qa_reply;
	private Date qa_date;
	
}
