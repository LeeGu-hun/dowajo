package com.ds.service;

import java.util.List;

import com.ds.domain.LectureVO;
	
public interface UserService {
	
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureAllList();
	
	

}