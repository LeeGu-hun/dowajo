package com.ds.service;

import java.util.List;

import com.ds.domain.LectureVO;

public interface LectureService {
	
	public LectureVO lectureInfo(Long lecture_no);
	public List<String> lectureUser(Long lecture_no);
	

}