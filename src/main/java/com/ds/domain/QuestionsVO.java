package com.ds.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionsVO {
	
	private Long qa_no;
	private String qa_writer;
	private String qa_title;
	private String qa_content;	
	private Date qa_date;
	private String qa_replyer;
	private String qa_reply;
	private Date qa_replydate;
	private int qa_status;
	private int qa_hit;
}
