package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class QuestionsVO {
	
	private Long que_no;
	private String que_writer;
	private String que_title;
	private String que_content;
	private Date que_date;
	
}
