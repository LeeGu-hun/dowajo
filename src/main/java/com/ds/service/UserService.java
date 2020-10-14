package com.ds.service;

import java.util.List;

import com.ds.domain.LectureVO;
	
public interface UserService {
	
	public List<LectureVO> lecutureList(Long user_no);
	
	

}