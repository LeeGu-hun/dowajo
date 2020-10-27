package com.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface LectureMapper {

	public LectureVO lectureInfo(Long lecture_no);
	public List<UserVO> lectureUser(Long lecture_no);
	
	public void fileState(@Param("file_status") boolean file_status, @Param("lecture_no") Long lecture_no);
	
}
