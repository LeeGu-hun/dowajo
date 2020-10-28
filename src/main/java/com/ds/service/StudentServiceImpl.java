package com.ds.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ds.domain.ClassListVO;
import com.ds.domain.Criteria;
import com.ds.domain.LectureVO;
import com.ds.mapper.StudentMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StudentServiceImpl implements StudentService{

	private StudentMapper mapper;

	@Override
	public List<LectureVO> lectureList(Long user_no) {		
		return mapper.lectureList(user_no);
	}
	
	@Override
	public List<LectureVO> lectureAllList(Criteria cri){
		return mapper.lectureAllList(cri);		
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<LectureVO> lectureInfo(String lecture_name){
		return mapper.lectureInfo(lecture_name);
	}
	
	@Override
	public List<LectureVO> lectureConfirmList(Long user_no){
		return mapper.lectureConfirmList(user_no);
	}
		
	@Override
	public void applyClass(ClassListVO vo) {
		log.info("applyClass ::" + vo);
		mapper.applyClass(vo);
	}

}