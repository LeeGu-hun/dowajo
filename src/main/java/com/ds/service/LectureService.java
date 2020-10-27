package com.ds.service;

import java.util.List;

import com.ds.domain.LectureVO;
import com.ds.domain.UserVO;

public interface LectureService {
	
	public LectureVO lectureInfo(Long lecture_no);
	public List<UserVO> lectureUser(Long lecture_no);
	
	public void fileState(boolean file_status, Long lecture_no);	

}