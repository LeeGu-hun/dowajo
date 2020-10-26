package com.ds.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class LectureVO {
	
	private Long lecture_no;
	private String lecture_name;
	private String lecture_description;
	private String lecture_afreecaid;
	private Date regdate;
	private List<ClassListVO> classList;
	
}
