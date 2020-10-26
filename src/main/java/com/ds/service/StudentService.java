package com.ds.service;

import java.util.List;

import com.ds.domain.Criteria;

import com.ds.domain.LectureVO;
	
public interface StudentService {
	
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureConfirmList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	public List<LectureVO> lectureInfo(String lecture_name);
	public int getTotal(Criteria cri);
	
	

}