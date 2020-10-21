package com.ds.mapper;

import java.util.List;

import com.ds.domain.Criteria;

import com.ds.domain.LectureVO;

public interface StudentMapper {
	public List<LectureVO> lectureList(Long user_no);
	public List<LectureVO> lectureAllList(Criteria cri);
	
	public int getTotalCount(Criteria cri);

}
