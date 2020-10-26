package com.ds.mapper;

import java.util.List;

import com.ds.domain.Criteria;

import com.ds.domain.LectureVO;

public interface StudentMapper {
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureConfirmList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	public List<LectureVO> lectureInfo(String lecture_name);
	
	public int getTotalCount(Criteria cri);
	public int getCoCount(Long user_no);
	public int getLeCount(Long user_no);

}
