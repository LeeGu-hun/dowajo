package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class TeacherQuestionsVO {
	
	private Long tqa_no;
	private String tqa_writer;
	private String tqa_teacher;
	private String tqa_student;
	private String tqa_title;
	private String tqa_content;	
	private Date tqa_date;
	
}
