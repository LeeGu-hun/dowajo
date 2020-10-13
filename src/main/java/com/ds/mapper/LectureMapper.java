package com.ds.mapper;

import java.util.List;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface LectureMapper {

	public LectureVO lectureInfo(Long lecture_no);
	public List<UserVO> lectureUser(Long lecture_no);
	
	
}
