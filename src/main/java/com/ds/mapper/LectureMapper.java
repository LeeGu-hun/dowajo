package com.ds.mapper;

import java.util.List;

import com.ds.domain.LectureVO;

public interface LectureMapper {

	public LectureVO lectureInfo(Long lecture_no);
	public List<String> lectureUser(Long lecture_no);
	
	
}
